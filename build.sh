#!/bin/sh
# Joins the files in src/ into index.html, the single page GitHub Pages serves.
set -e
cd "$(dirname "$0")"
{
  printf '<!doctype html>\n<html lang="en">\n<head>\n<meta charset="utf-8">\n<meta name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover">\n<style>:root{color-scheme:light}body{margin:0}</style>\n</head>\n<body>\n'
  cat src/part1.html src/part2.html src/part3a.html src/part3b.html src/part3c.html src/part3d.html src/part3e.html src/preview-notice.html
  printf '\n</body>\n</html>\n'
} > index.html
echo "Built index.html"
