#!/usr/bin/env bash
# Fix common URL encoding problems in exported HTML files
set -e
if [ -z "$1" ]; then
  DIR=.
else
  DIR="$1"
fi
echo "Fixing files in $DIR"
# Replace %3F with ? in href/src and remove duplicated .html encodings
find "$DIR" -type f -name '*.html' -print0 | xargs -0 sed -i \
 -e 's/%3F/?/g' \
 -e 's/index.html\%3Fp=/index.html?p=/g' \
 -e 's/\.css%3Fver=/\.css?ver=/g' \
 -e 's/\.js%3Fver=/\.js?ver=/g' \
 -e 's/\.jpg%3Fver=/\.jpg?ver=/g' \
 -e "s/(href|src)=\"([^"]*)\%3Fver=([0-9a-zA-Z_.-]*)\"/\1=\"\2?ver=\3\"/g"
echo "Done. Check git status to review changes."
chmod +x scripts/fix-export-urls.sh
