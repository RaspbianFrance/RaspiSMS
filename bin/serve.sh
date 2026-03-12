#!/bin/sh
#
# Script to start a local PHP development server
#
SCRIPT=$(readlink -f "$0")
RASPISMS_DIR=$(readlink -f "${SCRIPT%/*}/../")

HOST="${1:-localhost}"
PORT="${2:-8080}"

echo "Starting RaspiSMS dev server on http://$HOST:$PORT"
php -S "$HOST:$PORT" -t "$RASPISMS_DIR"
