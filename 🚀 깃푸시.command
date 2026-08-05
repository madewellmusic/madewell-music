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

# lock 파일 제거 (autopush 멈춤의 흔한 원인)
rm -f .git/HEAD.lock .git/index.lock 2>/dev/null

# 전체 add + commit
git add -A
TIMESTAMP=$(date "+%Y-%m-%d %H:%M")
git commit -m "update: $TIMESTAMP" >/dev/null 2>&1 && echo "📝 새 커밋 생성" || echo "📝 커밋할 변경사항 없음"

# 푸시 전 상태
AHEAD=$(git rev-list --count origin/main..HEAD 2>/dev/null || echo "?")
echo "⬆️  올려야 할 커밋: ${AHEAD}개"
echo ""
echo "─── 전송 중 ───"

# 푸시 (출력 자르지 않음 + 성공/실패 판정)
PUSH_OUT=$(git push origin main 2>&1)
PUSH_CODE=$?
echo "$PUSH_OUT"
echo ""

if [ $PUSH_CODE -eq 0 ]; then
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "✅ 푸시 성공"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  git fetch origin >/dev/null 2>&1
  LEFT=$(git rev-list --count origin/main..HEAD 2>/dev/null || echo "?")
  echo "   원격 최신: $(git log origin/main --oneline -1)"
  echo "   남은 커밋: ${LEFT}개"
  echo ""
  echo "   ⏳ GitHub Pages 반영까지 1~3분 걸립니다."
  echo "      https://www.madewellmusic.co.kr"
  echo "      바뀐 게 안 보이면 강력 새로고침: Cmd + Shift + R"
else
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "❌ 푸시 실패 — 위 메시지를 확인하세요"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""
  case "$PUSH_OUT" in
    *"could not read Username"*|*"Authentication failed"*|*"Invalid username or password"*|*"403"*)
      echo "   원인: GitHub 로그인 정보 없음 또는 만료"
      echo ""
      echo "   해결 (둘 중 하나):"
      echo "   1) GitHub Desktop 설치 후 로그인 → 가장 쉬움"
      echo "      https://desktop.github.com"
      echo "   2) 토큰 재발급 후 아래 명령을 터미널에서 실행"
      echo "      github.com → Settings → Developer settings"
      echo "      → Personal access tokens (classic) → repo 권한 체크"
      echo "      발급 후:  git push origin main"
      echo "      (Username: madewellmusic / Password: 발급받은 토큰)"
      ;;
    *"rejected"*|*"non-fast-forward"*|*"fetch first"*)
      echo "   원인: 원격에 내가 모르는 커밋이 있음"
      echo "   해결:  git pull --rebase origin main   실행 후 다시 푸시"
      ;;
    *"Could not resolve host"*|*"unable to access"*|*"timed out"*)
      echo "   원인: 네트워크 연결 문제"
      echo "   해결: 인터넷 확인 후 다시 실행"
      ;;
    *)
      echo "   위 에러 메시지를 그대로 복사해서 클로드에게 보여주세요."
      ;;
  esac
fi

echo ""
read -p "창 닫으려면 Enter..."
