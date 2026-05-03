#!/bin/bash
DIR="/Users/madewell/Documents/Claude/Projects/MADEWELL MUSIC 리브랜딩"
LOG="$DIR/.autopush.log"
cd "$DIR"

# lock 제거
rm -f .git/HEAD.lock .git/index.lock 2>/dev/null

# 변경사항 있는지 확인
if git status --porcelain | grep -q .; then
  git stash 2>/dev/null
  git pull origin main --rebase -q 2>/dev/null
  git stash pop 2>/dev/null
  git add -A
  TIMESTAMP=$(date "+%Y-%m-%d %H:%M")
  git commit -m "auto: $TIMESTAMP" -q 2>/dev/null
  git push origin main -q 2>/dev/null
  echo "[$TIMESTAMP] pushed" >> "$LOG"
fi
