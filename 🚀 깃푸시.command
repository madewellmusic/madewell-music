#!/bin/bash
cd "/Users/madewell/Documents/Claude/Projects/MADEWELL MUSIC 리브랜딩"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  MADEWELL MUSIC — Git Push"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# lock 파일 제거
rm -f .git/HEAD.lock .git/index.lock 2>/dev/null

# 변경사항 임시 저장
git stash 2>/dev/null

# 원격 최신 가져오기
git pull origin main --rebase 2>&1 | tail -3

# 변경사항 복원
git stash pop 2>/dev/null

# 전체 add + commit + push
git add -A
TIMESTAMP=$(date "+%Y-%m-%d %H:%M")
git commit -m "update: $TIMESTAMP" 2>/dev/null || echo "변경사항 없음"
git push origin main 2>&1 | tail -5

echo ""
echo "✅ 완료!"
echo ""
read -p "창 닫으려면 Enter..."
