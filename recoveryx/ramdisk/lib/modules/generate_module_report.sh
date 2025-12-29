#!/bin/bash

MODULE_DIR="/home/lucoz/kernels/RE58C2_KERNEL_5-4-254_modules_ok/out/modules_build"
KERNEL="/home/lucoz/kernels/RE58C2_KERNEL_5-4-254_modules_ok/out/vmlinux"
REPORT="/home/lucoz/module_compatibility_report.txt"

echo "=== MODULE COMPATIBILITY ANALYSIS REPORT ===" > "$REPORT"
echo "Generated: $(date)" >> "$REPORT"
echo "Module directory: $MODULE_DIR" >> "$REPORT"
echo "Kernel: $KERNEL" >> "$REPORT"
echo "" >> "$REPORT"

# ===== 1. BASIC STATS =====
echo "1. MODULE INVENTORY" >> "$REPORT"
echo "===================" >> "$REPORT"
TOTAL_MODULES=$(find "$MODULE_DIR" -name "*.ko" -type f | wc -l)
echo "Total modules: $TOTAL_MODULES" >> "$REPORT"
echo "" >> "$REPORT"

# List all modules
echo "All modules:" >> "$REPORT"
find "$MODULE_DIR" -name "*.ko" -type f -exec basename {} \; | sort | column -c 80 >> "$REPORT"
echo "" >> "$REPORT"

# ===== 2. KERNEL VERSION =====
echo "2. KERNEL VERSION INFO" >> "$REPORT"
echo "======================" >> "$REPORT"
if [ -f "$KERNEL" ]; then
    KERNEL_VERSION=$(strings "$KERNEL" | grep "Linux version" | head -1)
    echo "Kernel version: $KERNEL_VERSION" >> "$REPORT"
    
    # Extract vermagic part (after "SMP preempt")
    KERNEL_VERMAGIC=$(echo "$KERNEL_VERSION" | sed 's/.*Linux version //' | sed 's/ (.*//')
    echo "Kernel vermagic base: $KERNEL_VERMAGIC" >> "$REPORT"
else
    echo "ERROR: Kernel not found at $KERNEL" >> "$REPORT"
fi
echo "" >> "$REPORT"

# ===== 3. MODULE VERMAGIC CHECK =====
echo "3. MODULE VERMAGIC COMPATIBILITY" >> "$REPORT"
echo "================================" >> "$REPORT"
echo "Checking module vermagic against kernel..." >> "$REPORT"
echo "" >> "$REPORT"

MATCH=0
MISMATCH=0
ERROR=0

for ko in "$MODULE_DIR"/*.ko; do
    if [ -f "$ko" ]; then
        MODULE_NAME=$(basename "$ko")
        VERMAGIC=$(modinfo "$ko" 2>/dev/null | grep "vermagic:" | cut -d: -f2 | xargs)
        
        if [ -n "$VERMAGIC" ]; then
            # Check if vermagic matches kernel pattern
            if echo "$VERMAGIC" | grep -q "$KERNEL_VERMAGIC"; then
                echo "  ✓ $MODULE_NAME: Compatible" >> "$REPORT"
                MATCH=$((MATCH + 1))
            else
                echo "  ✗ $MODULE_NAME: MISMATCH" >> "$REPORT"
                echo "    Module: $VERMAGIC" >> "$REPORT"
                echo "    Kernel: $KERNEL_VERMAGIC" >> "$REPORT"
                MISMATCH=$((MISMATCH + 1))
            fi
        else
            echo "  ? $MODULE_NAME: Could not read vermagic" >> "$REPORT"
            ERROR=$((ERROR + 1))
        fi
    fi
done
echo "" >> "$REPORT"
echo "Summary:" >> "$REPORT"
echo "  Compatible: $MATCH" >> "$REPORT"
echo "  Mismatched: $MISMATCH" >> "$REPORT"
echo "  Errors: $ERROR" >> "$REPORT"
echo "" >> "$REPORT"

# ===== 4. MODULE DEPENDENCY ANALYSIS =====
echo "4. MODULE DEPENDENCIES" >> "$REPORT"
echo "======================" >> "$REPORT"

# Group by type/category
echo "Module categories:" >> "$REPORT"
for ko in "$MODULE_DIR"/*.ko; do
    MODULE_NAME=$(basename "$ko" .ko)
    
    # Categorize by name patterns
    case "$MODULE_NAME" in
        *wlan*|*wifi*|*qca*|*qcom*)
            echo "  [WiFi/BT] $MODULE_NAME" >> "$REPORT"
            ;;
        *audio*|*snd*|*sound*|*q6*)
            echo "  [Audio] $MODULE_NAME" >> "$REPORT"
            ;;
        *camera*|*cam*)
            echo "  [Camera] $MODULE_NAME" >> "$REPORT"
            ;;
        *gpu*|*drm*|*display*)
            echo "  [GPU/Display] $MODULE_NAME" >> "$REPORT"
            ;;
        *sensor*|*input*)
            echo "  [Sensors] $MODULE_NAME" >> "$REPORT"
            ;;
        *npu*|*dsp*)
            echo "  [NPU/DSP] $MODULE_NAME" >> "$REPORT"
            ;;
        *usb*|*typec*)
            echo "  [USB] $MODULE_NAME" >> "$REPORT"
            ;;
        *power*|*battery*)
            echo "  [Power] $MODULE_NAME" >> "$REPORT"
            ;;
        *)
            echo "  [Other] $MODULE_NAME" >> "$REPORT"
            ;;
    esac
done
echo "" >> "$REPORT"

# ===== 5. LOAD ORDER RECOMMENDATION =====
echo "5. RECOMMENDED LOAD ORDER" >> "$REPORT"
echo "==========================" >> "$REPORT"
echo "Based on typical Android kernel dependencies:" >> "$REPORT"
echo "" >> "$REPORT"

LOAD_GROUPS=(
    "GROUP 1: Core Infrastructure"
    "  q6_notifier_dlkm"
    "  platform_dlkm"
    "  pinctrl_lpi_dlkm"
    "  stub_dlkm"
    ""
    "GROUP 2: Basic Drivers"
    "  apr_dlkm"
    "  adsp_loader_dlkm"
    "  native_dlkm"
    ""
    "GROUP 3: Audio Subsystem"
    "  audio_dlkm"
    "  audio_pkt_dlkm"
    "  analog_cdc_dlkm"
    "  digital_cdc_dlkm"
    "  machine_dlkm"
    ""
    "GROUP 4: Connectivity"
    "  wlan"
    "  bt_fm_slim"
    ""
    "GROUP 5: Multimedia"
    "  camera"
    "  msm_drm"
    "  msm_video"
    ""
    "GROUP 6: Sensors"
    "  sensors_ssc"
    ""
    "GROUP 7: Specialized"
    "  npu"
    "  msm_kgsl"
    "  videocodec"
)

for line in "${LOAD_GROUPS[@]}"; do
    # Check if this is a module name (not group header)
    if [[ "$line" == *"_dlkm"* ]] || [[ "$line" == *"wlan"* ]] || [[ "$line" == *"camera"* ]]; then
        if [ -f "$MODULE_DIR/$line.ko" ]; then
            echo "  [AVAILABLE] $line" >> "$REPORT"
        else
            echo "  [MISSING]   $line" >> "$REPORT"
        fi
    else
        echo "$line" >> "$REPORT"
    fi
done
echo "" >> "$REPORT"

# ===== 6. QUICK LOAD TEST =====
echo "6. QUICK LOAD TEST RESULTS" >> "$REPORT"
echo "==========================" >> "$REPORT"

# Test loading a few critical modules
TEST_MODULES=("crc32" "q6_notifier_dlkm" "platform_dlkm" "wlan")

for testmod in "${TEST_MODULES[@]}"; do
    if [ -f "$MODULE_DIR/$testmod.ko" ]; then
        echo -n "Testing $testmod... " >> "$REPORT"
        
        # Try to load (with timeout)
        timeout 2 insmod "$MODULE_DIR/$testmod.ko" 2>&1 >/dev/null
        RESULT=$?
        
        if [ $RESULT -eq 0 ]; then
            echo "✓ SUCCESS" >> "$REPORT"
            # Unload it
            rmmod "$testmod" 2>/dev/null
        elif [ $RESULT -eq 124 ]; then
            echo "⏱ TIMEOUT (may be stuck)" >> "$REPORT"
        else
            ERROR_MSG=$(dmesg | tail -1)
            echo "✗ FAILED: $ERROR_MSG" >> "$REPORT"
        fi
    else
        echo "$testmod.ko not found for testing" >> "$REPORT"
    fi
done
echo "" >> "$REPORT"

# ===== 7. ACTION PLAN =====
echo "7. ACTION PLAN" >> "$REPORT"
echo "==============" >> "$REPORT"

if [ $MISMATCH -gt 0 ]; then
    echo "ISSUE DETECTED: $MISMATCH modules have vermagic mismatch" >> "$REPORT"
    echo "" >> "$REPORT"
    echo "Steps to fix:" >> "$REPORT"
    echo "1. Rebuild mismatched modules with:" >> "$REPORT"
    echo "   make -C /home/lucoz/kernels/RE58C2_KERNEL_5-4-254 \\" >> "$REPORT"
    echo "        O=/home/lucoz/kernels/RE58C2_KERNEL_5-4-254/out \\" >> "$REPORT"
    echo "        M=/path/to/module/source \\" >> "$REPORT"
    echo "        modules" >> "$REPORT"
    echo "" >> "$REPORT"
    echo "2. Or force load with:" >> "$REPORT"
    echo "   insmod --force-vermagic module.ko" >> "$REPORT"
else
    echo "GOOD NEWS: All modules appear compatible with kernel" >> "$REPORT"
    echo "" >> "$REPORT"
    echo "Next steps:" >> "$REPORT"
    echo "1. Load modules in recommended order above" >> "$REPORT"
    echo "2. Test functionality" >> "$REPORT"
    echo "3. Create initramfs/modules.img if needed" >> "$REPORT"
fi

echo "" >> "$REPORT"
echo "=== END OF REPORT ===" >> "$REPORT"

# Display summary
echo "Report generated at: $REPORT"
echo ""
echo "QUICK SUMMARY:"
echo "Total modules: $TOTAL_MODULES"
echo "Compatible: $MATCH"
echo "Mismatched: $MISMATCH"
echo "Errors: $ERROR"
