#!/system/system/bin/sh
# Migrate early logs from tmpfs to persistent storage

if [ -d /data ]; then
    mkdir -p /data/boot_logs
    cp -r /dev/boot_logs/* /data/boot_logs/ 2>/dev/null
    echo "Early logs migrated to /data" >> /data/boot_logs/migration.log
else
    echo "ERROR: /data not available for log migration" > /dev/boot_logs/migration_failed.log
fi