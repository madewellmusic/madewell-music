#!/bin/bash

# 스크립트 위치 기준으로 이동 (한글 경로 문제 방지)
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  MADEWELL MUSIC — Git Push"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📁 경로: $SCRIPT_DIR"
echo ""

# lock 파일 제거
rm -f .git/HEAD.lock .git/index.lock 2>/dev/null

# 전체 add + commit + push
git add -A
TIMESTAMP=$(date "+%Y-%m-%d %H:%M")
git commit -m "update: $TIMESTAMP" 2>/dev/null || echo "변경사항 없음"
git push origin main 2>&1 | tail -5

echo ""
echo "✅ 완료!"
echo ""
read -p "창 닫으려면 Enter..."
