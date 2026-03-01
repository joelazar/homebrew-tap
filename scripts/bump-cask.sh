#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <version>"
  echo "Example: $0 1.0.1"
  exit 1
fi

VERSION="${1#v}"
TAG="v${VERSION}"
REPO="joelazar/alt-alt-tab"
ASSET="AltAltTab.app.zip"
CASK_FILE="$(cd "$(dirname "$0")/.." && pwd)/Casks/alt-alt-tab.rb"

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

if command -v gh >/dev/null 2>&1; then
  gh release download "$TAG" --repo "$REPO" --pattern "$ASSET" --dir "$TMP_DIR" --clobber
else
  curl -L "https://github.com/${REPO}/releases/download/${TAG}/${ASSET}" -o "$TMP_DIR/$ASSET"
fi

SHA="$(shasum -a 256 "$TMP_DIR/$ASSET" | awk '{print $1}')"

python3 - "$CASK_FILE" "$VERSION" "$SHA" <<'PY'
from pathlib import Path
import re
import sys

cask_path = Path(sys.argv[1])
version = sys.argv[2]
sha = sys.argv[3]

text = cask_path.read_text()
text = re.sub(r'(?m)^\s*version\s+"[^"]+"', f'  version "{version}"', text, count=1)
text = re.sub(r'(?m)^\s*sha256\s+"[^"]+"', f'  sha256 "{sha}"', text, count=1)
cask_path.write_text(text)
PY

echo "Updated ${CASK_FILE}"
echo "  version: ${VERSION}"
echo "  sha256:  ${SHA}"
