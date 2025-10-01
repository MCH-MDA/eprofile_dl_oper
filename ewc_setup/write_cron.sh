#!/bin/bash
# File writing the necessary cronjobs
base_dir="$HOME"

# Define the schedules and the commands to run

# Following is not needed anymore after setup of notification
# cron_schedule_script="0,15,30,45 * * * *"
# script_path="$base_dir/eprofile_dl_oper/ewc_setup/watch_journal_log.sh"
# log_file="$base_dir/journal_watchdog.txt"

cron_schedule_restart="0 0 * * 0" # Changed to weekly, should be enough
restart_command="/sbin/shutdown -r"

cron_deletion_schedule="30 * * * *"
cron_deletion_raw="find /data/eprofile-dl-raw/ -mmin +120 -type f -delete"
log_file_deletion="$base_dir/deleted.txt"

# Write the cron jobs to a temporary file
#echo "$cron_schedule_script $script_path >> $log_file 2>&1" > mycron
echo "$cron_schedule_restart $restart_command" > mycron
echo "$cron_deletion_schedule $cron_deletion_raw >> $log_file_deletion 2>&1" >> mycron

# Install the new cron jobs from the temporary file -> needs to be root for restart !
# sudo crontab mycron
# Instead of installing the cron directly, output indication on how to do it:
echo "cron can now be installed running: sudo crontab mycron"
