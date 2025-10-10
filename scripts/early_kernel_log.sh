#!/system/system/bin/sh
# Early kernel logging to tmpfs (ALWAYS available)

LOG_DIR="/dev/boot_logs"
mkdir -p $LOG_DIR

echo "=== EARLY BOOT KERNEL LOG ===" > $LOG_DIR/early_kernel.log
echo "Boot time: $(date)" >> $LOG_DIR/early_kernel.log
echo "Kernel version: $(cat /proc/version)" >> $LOG_DIR/early_kernel.log

# Capture kernel messages from the VERY beginning
cat /proc/kmsg >> $LOG_DIR/early_kernel.log &
KMESG_PID=$!

# Also capture boot stages
echo "init: early-init started" >> $LOG_DIR/boot_stages.log

# Keep running until main logging takes over
sleep 25
kill $KMESG_PID 2>/dev/null