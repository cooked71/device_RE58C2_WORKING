#!/system/system/bin/sh
# Continuous kernel logging with fallback

main_log() {
    echo "=== CONTINUOUS KERNEL LOG ===" > /data/boot_logs/kernel_continuous.log
    cat /proc/kmsg >> /data/boot_logs/kernel_continuous.log
}

fallback_log() {
    echo "=== FALLBACK KERNEL LOG ===" >> /dev/boot_logs/kernel_fallback.log
    cat /proc/kmsg >> /dev/boot_logs/kernel_fallback.log
}

# Try main log, fallback to tmpfs if data fails
if [ -d /data/boot_logs ]; then
    main_log
else
    fallback_log
fi