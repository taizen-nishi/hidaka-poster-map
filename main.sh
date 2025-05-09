#!/usr/bin/env bash
# main.sh — 日高ポスターマップ自動更新
set -euo pipefail

# スクリプト自身の場所へ移動
BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$BASE_DIR"

# ▼▼ 自分の CSV 公開 URL に置き換える ▼▼
CSV_URL="https://docs.google.com/spreadsheets/d/e/2PACX-1vTiUd6Jt7sNAJ86n9pZ3p2tOiVB7_84dmrWVg1_D5hH7X8sLeglyW2GXVBUU9ZsBgMgCTBvdrN2Oix_/pub?gid=0&single=true&output=csv"

mkdir -p public/data
curl -sL "$CSV_URL" -o public/data/all.csv

python3 csv2json_small.py              public/data/all.csv public/data
python3 summarize_progress.py          public/data/summary.json
python3 summarize_progress_absolute.py public/data/summary_absolute.json

netlify deploy --dir=public --prod --message "auto update"