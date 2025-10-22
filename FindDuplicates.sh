#!/bin/bash
# ---------------------------------------------------------
# Find duplicate image files in ./pics using shasum
# Compatible with macOS and Linux. Works in IntelliJ.
# ---------------------------------------------------------

# Step 1: Define where to look and where to save results
TARGET_DIR="${1:-./pics}"        # Default folder is ./pics
TODAY=$(date +%Y-%m-%d)          # Current date (used in log file name)
LOGFILE="duplicates_${TODAY}.log" # Log file for storing results

echo "🔍 Scanning $TARGET_DIR for image files..."
echo "Results saved in $LOGFILE"
echo "---------------------------------------------" > "$LOGFILE"

# Step 2: List all visible image files (ignore hidden & DS_Store)
find "$TARGET_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) \
  | grep -v '/\.' \
  | grep -v 'DS_Store' \
  > /tmp/image_list.txt

# Step 3: Prepare a temporary list to store image hashes
TMP_SUMS="/tmp/image_sums.txt"
echo "" > "$TMP_SUMS"

# Step 4: Generate SHA-1 hash for each image file
while IFS= read -r file; do
    hash=$(shasum "$file" | awk '{print $1}')      # Generate hash
    echo "$hash $file" >> "$TMP_SUMS"              # Store hash and file name
    echo "Hashed: $file"
done < /tmp/image_list.txt

# Step 5: Compare hashes to find duplicates
awk '
{
    hash=$1
    file=$2
    if (seen[hash] != "") {
        print "Duplicate found: " seen[hash] " and " file
    } else {
        seen[hash]=file
    }
}' "$TMP_SUMS" | tee -a "$LOGFILE"

echo "✅ Scan complete. Check '$LOGFILE' for duplicate results."