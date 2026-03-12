#!/bin/sh
#
# Script to stop RaspiSMS daemons
#
SCRIPT=$(readlink -f "$0")
RASPISMS_DIR=$(readlink -f "${SCRIPT%/*}/../")

# Read config from PHP
PID_DIR=$(php -r "require '$RASPISMS_DIR/descartes/load.php'; echo PWD_PID;")

DAEMON_LAUNCHER_PID_FILE="$PID_DIR/RaspiSMS Daemon Launcher.pid"

# Kill daemon launcher if available
if [ -f "$DAEMON_LAUNCHER_PID_FILE" ]; then
    printf "Stop RaspiSMS daemon Launcher..."
    PID=$(cat "$DAEMON_LAUNCHER_PID_FILE")
    if kill "$PID" 2>/dev/null; then
        rm -f "$DAEMON_LAUNCHER_PID_FILE"
        printf "success.\n"
    else
        printf "failed.\n"
        exit 1
    fi
fi

sleep 1

# Kill remaining daemons
printf "Stop RaspiSMS remaining daemons..."
for f in "$PID_DIR"/*.pid; do
    [ -f "$f" ] || continue
    printf "."
    PID=$(cat "$f")
    kill "$PID" 2>/dev/null
    rm -f "$f"
done
printf "Done.\n"

exit 0
