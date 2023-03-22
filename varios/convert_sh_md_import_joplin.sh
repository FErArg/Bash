#!/bin/bash
FILES="*"
for f in $FILES
do
  echo "Processing $f file..."
  # take action on each file. $f store current file name
  touch "$f".md
  echo '```bash' >> $f.md
  cat $f >> $f.md
  echo '```' >> $f.md
done

rm 00.sh.md