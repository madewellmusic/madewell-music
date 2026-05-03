#!/bin/bash
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  MADEWELL 자동 푸시 설치 중..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

PLIST_SRC="/Users/madewell/Documents/Claude/Projects/MADEWELL MUSIC 리브랜딩/com.madewell.autopush.plist"
PLIST_DST="$HOME/Library/LaunchAgents/com.madewell.autopush.plist"

# autopush.sh 실행 권한 + quarantine 해제
chmod +x "/Users/madewell/Documents/Claude/Projects/MADEWELL MUSIC 리브랜딩/autopush.sh"
xattr -d com.apple.quarantine "/Users/madewell/Documents/Claude/Projects/MADEWELL MUSIC 리브랜딩/autopush.sh" 2>/dev/null

# 기존 agent 중지 (있다면)
launchctl bootout gui/$(id -u) "$PLIST_DST" 2>/dev/null
launchctl unload "$PLIST_DST" 2>/dev/null

# plist 복사
cp "$PLIST_SRC" "$PLIST_DST"
chmod 644 "$PLIST_DST"

# agent 등록 (macOS 신버전 방식)
launchctl bootstrap gui/$(id -u) "$PLIST_DST" 2>/dev/null || launchctl load "$PLIST_DST"

echo ""
echo "✅ 설치 완료!"
echo "이제 30분마다 변경사항이 자동으로 GitHub에 올라가요."
echo ""
read -p "창 닫으려면 Enter..."
