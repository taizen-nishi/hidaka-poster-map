#!/usr/bin/env bash
echo "===== poster-map 環境チェック ====="

# コマンド系
cmds=(brew git python3 node netlify http-server)
for c in "${cmds[@]}"; do
  if command -v "$c" >/dev/null 2>&1; then
    printf "✅ %-11s %s\n" "$c" "$($c --version 2>&1 | head -n1)"
  else
    printf "❌ %-11s not found\n" "$c"
  fi
done

# Python ライブラリ
echo "----- Python libraries -----"
python3 - <<'PY'
import importlib, pkg_resources, sys
req = ["pandas","geopandas"]
for r in req:
    try:
        v = pkg_resources.get_distribution(r).version
        print(f"✅ {r:10} {v}")
    except pkg_resources.DistributionNotFound:
        print(f"❌ {r:10} not installed")
PY
