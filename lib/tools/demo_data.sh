#!/bin/bash
# FillUp Demo Data Tool
# Usage:
#   ./lib/tools/demo_data.sh fill     - Fill app with demo vehicles and fuel records
#   ./lib/tools/demo_data.sh reset    - Remove all vehicles and fuel records
#   ./lib/tools/demo_data.sh status   - Show database info

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

ACTION="${1:-}"
if [ "$ACTION" != "fill" ] && [ "$ACTION" != "reset" ] && [ "$ACTION" != "status" ]; then
  echo "Usage: $0 <fill|reset|status>"
  exit 1
fi

cd "$PROJECT_DIR"

VAR=""
LABEL=""
if [ "$ACTION" = "fill" ]; then
  VAR="FILL_DEMO=true"
  LABEL="Filling demo data"
elif [ "$ACTION" = "reset" ]; then
  VAR="RESET_DEMO=true"
  LABEL="Resetting demo data"
elif [ "$ACTION" = "status" ]; then
  VAR="STATUS_DEMO=true"
  LABEL="Checking status"
fi

echo "$LABEL..."
flutter run -d linux --dart-define="$VAR" -q 2>&1 | grep -E "DEMO_|Error" | head -5
