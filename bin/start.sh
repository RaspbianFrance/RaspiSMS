#!/bin/sh
#
# Script to start RaspiSMS daemons
#
SCRIPT=$(readlink -f "$0")
RASPISMS_DIR=$(readlink -f "${SCRIPT%/*}/../")
CONSOLE_PATH="$RASPISMS_DIR/console.php"

# Read config from PHP
PID_DIR=$(php -r "require '$RASPISMS_DIR/descartes/load.php'; echo PWD_PID;")
LOG_DIR=$(php -r "require '$RASPISMS_DIR/descartes/load.php'; echo PWD_LOGS;")
LOG_FILE="$LOG_DIR/daemons.log"

# Create directories if needed
mkdir -p "$PID_DIR" "$LOG_DIR"

# Create log file if needed
[ -f "$LOG_FILE" ] || touch "$LOG_FILE"

# Run command to start daemons
php "$CONSOLE_PATH" controllers/internals/Console.php launcher
exit $?
