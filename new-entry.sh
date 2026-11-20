#!/usr/bin/env bash
# Create a dated notebook entry from the template and open it.
# Usage: ./new-entry.sh phase-1-linux "ssh setup"
set -euo pipefail

if [ $# -ne 2 ]; then
  echo "Usage: $0 <phase-folder> \"topic\""
  exit 1
fi

folder="$1"
topic="$2"
today=$(date +%F)
slug=$(echo "$topic" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
file="$folder/$today-$slug.md"

mkdir -p "$folder"

if [ -e "$file" ]; then
  echo "$file already exists, opening it"
else
  sed -e "s|{{TITLE}}|$topic|" -e "s|{{DATE}}|$today|" templates/entry.md > "$file"
  echo "Created $file"
fi

nano "$file"
