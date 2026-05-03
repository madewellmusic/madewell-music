#!/bin/bash
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  MADEWELL 자동 푸시 설치 중..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

PLIST_SRC="/Users/madewell/Documents/Claude/Projects/MADEWELL MUSIC 리브랜딩/com.madewell.autopush.plist"
PLIST_DST="$HOME/Library/LaunchAgents/com.madewell.autopush.plist"

# autopush.sh 실행 권한
chmod +x "/Users/madewell/Documents/Claude/Projects/MADEWELL MUSIC 리브랜딩/autopush.sh"

# 기존 agent 중지 (있다면)
launchctl unload "$PLIST_DST" 2>/dev/null

# plist 복사
cp "$PLIST_SRC" "$PLIST_DST"

# agent 등록
launchctl load "$PLIST_DST"

echo ""
echo "✅ 설치 완료!"
echo "이제 30분마다 변경사항이 자동으로 GitHub에 올라가요."
echo ""
read -p "창 닫으려면 Enter..."
