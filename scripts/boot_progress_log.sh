#!/system/system/bin/sh
# Track boot progress to identify where it fails

LOG_FILE="/dev/boot_logs/boot_stages.log"
mkdir -p /dev/boot_logs

log_stage() {
    echo "$(date): $1" >> $LOG_FILE
    echo "$1" > /proc/kmsg
}

log_stage "BOOT: early-init started"

# Track key init stages
while true; do
    if [ -d /system ]; then
        log_stage "BOOT: /system mounted"
        break
    fi
    sleep 1
done

while true; do
    if [ -d /data ]; then
        log_stage "BOOT: /data mounted" 
        break
    fi
    sleep 1
done

log_stage "BOOT: post-fs-data reached"