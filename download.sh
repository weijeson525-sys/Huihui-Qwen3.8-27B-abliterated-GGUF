#!/usr/bin/env bash
# Download GGUF weights for this model from Hugging Face.
# Weights are NOT stored in this repo (GitHub single-file limit is 100 MB).
# No token / credential is used or read anywhere in this script.
set -euo pipefail

HF_REPO="huihui-ai/Huihui-Qwen3.8-27B-abliterated-GGUF"
BASE="https://huggingface.co/$HF_REPO/resolve/main"

# quant|file|bytes|sha256 (LFS oid from the HF file tree)
read -r -d '' QUANTS <<'EOF_QUANTS' || true
GSQ-RCO-IQ3_S|Huihui-Qwen3.8-27B-abliterated-GSQ-RCO-IQ3_S.gguf|11771546208|329e01fc79dc8a49465e40adef8ed925935093b3dc8f7ee6da0c88ac7b5d3692
GSQ-RCO-IQ3_S-mtp|Huihui-Qwen3.8-27B-abliterated-GSQ-RCO-IQ3_S-mtp.gguf|12120016416|eea0638e283433e27b0edbd409b552be467a75ecc777d91c51db554c0a644c19
GSQ-RCO-IQ3_XXS|Huihui-Qwen3.8-27B-abliterated-GSQ-RCO-IQ3_XXS.gguf|10094357088|54171530e667b691ffc4b31ed42b9f6b416be57fdd231e227fa09c103dca2ebf
GSQ-RCO-IQ3_XXS-mtp|Huihui-Qwen3.8-27B-abliterated-GSQ-RCO-IQ3_XXS-mtp.gguf|10442827296|53fbcda56fae73e1bc2f3222f6939b4cf051fc52c26acc387b4c90f6da7d5c7d
Q2_K|Huihui-Qwen3.8-27B-abliterated-Q2_K.gguf|10864592160|c4a5e431ede372af5bf8f57129194bb440d3cf7914d81c63323748ff4fee2ad9
Q2_K_L|Huihui-Qwen3.8-27B-abliterated-Q2_K_L.gguf|17219597600|368f0f545100dcec8e1dd7289a2fb25f81a7be4e2d14be381865b2163a11da31
Q3_K|Huihui-Qwen3.8-27B-abliterated-Q3_K.gguf|13500736800|a82fe31ff8716377d1dd2f47e1dc1847b96566ddcfa9a3c394a1b6ecf7adc75c
Q3_K_L|Huihui-Qwen3.8-27B-abliterated-Q3_K_L.gguf|18688238880|127edb0588c80505869efd00eb42e353fcfc3065b07248757b5265eeeb963924
Q4_K|Huihui-Qwen3.8-27B-abliterated-Q4_K.gguf|16810714400|6c2c13cef89238c3604d756b07b3ef5fafebbd61095feb8553ff449c95e4c1c6
Q4_K_L|Huihui-Qwen3.8-27B-abliterated-Q4_K_L.gguf|20915090720|6d9ee93a089dff34a901a8f18613bb4f3b124856410057460f401863dd6ed2f0
Q5_K|Huihui-Qwen3.8-27B-abliterated-Q5_K.gguf|19535701280|917453854fc640903f89bda0b29eb7ea661cb13b9c5c9efd20a68f3ff2e9277f
Q5_K_L|Huihui-Qwen3.8-27B-abliterated-Q5_K_L.gguf|22869046560|03b97b83c18c4a34f3760d7e078123175915d5760ddc1d84f21e11dff37224ac
Q6_K|Huihui-Qwen3.8-27B-abliterated-Q6_K.gguf|22430999840|a5c159519d7bdba523578977d649dbfc48f2e47277ec77edd77670003b5b2492
Q6_K_L|Huihui-Qwen3.8-27B-abliterated-Q6_K_L.gguf|24945124640|20b1214a23f0f5f401b6117cbd63336cfff6c07be4df93bd6e374d8fd8d12938
Q8_0|Huihui-Qwen3.8-27B-abliterated-Q8_0.gguf|29047084320|427b9416c2aba9d21da4e90ddac50a2bc8b6d0bfef675af3580a43aa38e000c3
Q8_0_L|Huihui-Qwen3.8-27B-abliterated-Q8_0_L.gguf|38779180320|ac47d8c619aed9b08905eeb1502b1a0636208db192cdddc41eb712652395cbcf
Swift-1.5-GSQ-RCO-IQ2_S|Huihui-Qwen3.8-27B-abliterated-Swift-1.5-GSQ-RCO-IQ2_S.gguf|9259511200|6dda89090dcf713c183a4ff6ca59f832cfe015807fb77de4425c9fd785d52f4b
Swift-1.5-GSQ-RCO-IQ2_S-mtp|Huihui-Qwen3.8-27B-abliterated-Swift-1.5-GSQ-RCO-IQ2_S-mtp.gguf|9607981184|e052ad58743251aa114f397b7c41cf1e4177beeb1042b824f367f24242f05c40
Swift-1.5-GSQ-RCO-IQ2_XS|Huihui-Qwen3.8-27B-abliterated-Swift-1.5-GSQ-RCO-IQ2_XS.gguf|8422841760|1401ac507622a2b685efcbb0e44a44cb725dee326094df805b0b2de00cceeb14
Swift-1.5-GSQ-RCO-IQ2_XS-mtp|Huihui-Qwen3.8-27B-abliterated-Swift-1.5-GSQ-RCO-IQ2_XS-mtp.gguf|8762218624|c303c4a4154977eb56c2864834015ec7584c34e5aad4c404de1efaaeb3c4b557
Swift-1.5-GSQ-RCO-IQ3_S|Huihui-Qwen3.8-27B-abliterated-Swift-1.5-GSQ-RCO-IQ3_S.gguf|11771547040|1161c09c5844fdba4ca7bbda584e3d4a304e416be4e0f0589ca4b94682cda90c
Swift-1.5-GSQ-RCO-IQ3_S-mtp|Huihui-Qwen3.8-27B-abliterated-Swift-1.5-GSQ-RCO-IQ3_S-mtp.gguf|12120017024|29c1ae202c8f2c7d797335dcde6b51ae09a90a477552f853b2336ae2fac66582
Swift-1.5-GSQ-RCO-IQ3_XXS|Huihui-Qwen3.8-27B-abliterated-Swift-1.5-GSQ-RCO-IQ3_XXS.gguf|10094357920|6bd9c3c073f82d59a1887430632188691682cad34a1a922adf8f31713a2c52c0
Swift-1.5-GSQ-RCO-IQ3_XXS-mtp|Huihui-Qwen3.8-27B-abliterated-Swift-1.5-GSQ-RCO-IQ3_XXS-mtp.gguf|10442827904|a7e8962f16a84945b2277663da41824b936d40ae90d55852718ac389431c9166
Ternary-Bonsai-PQ2_0|Huihui-Qwen3.8-27B-abliterated-Ternary-Bonsai-PQ2_0.gguf|7704693216|0de67be7b5256c20971f44e514d87ec7fa81ad4f8d8fcf151644009f74f3a5cf
Ternary-Bonsai-PTQ1_0|Huihui-Qwen3.8-27B-abliterated-Ternary-Bonsai-PTQ1_0.gguf|6608603616|b27e1d4be4d93e86308a0138f6157fee89dd5a67304632ddb6032bf2719e5f6e
Ternary-Bonsai-f16|Huihui-Qwen3.8-27B-abliterated-Ternary-Bonsai-f16.gguf|53808408928|0591601db5fc20c2d398920c4b8092fc406e38eb061c7ac53bc32005fc7da395
UD-DW-IQ3_S|Huihui-Qwen3.8-27B-abliterated-UD-DW-IQ3_S.gguf|12334566304|d0eaa1e90e7630de8cefaf52510eb8913c76f85da0186d8f85a462aa6a40192c
UD-DW-IQ3_XXS|Huihui-Qwen3.8-27B-abliterated-UD-DW-IQ3_XXS.gguf|11367766944|bfc6892863eceb16f69697e59b038acdc1c709b790c1542e4612dbb0924d3568
UD-DW-Q4_K_M|Huihui-Qwen3.8-27B-abliterated-UD-DW-Q4_K_M.gguf|16551316384|0c7cfe3060493485bb9a6a51195897b0c1d347a49929206adb9a52170183ea03
UD-DW-Q4_K_S|Huihui-Qwen3.8-27B-abliterated-UD-DW-Q4_K_S.gguf|15624084384|f10c26c7d07b056bccc60e09ec427a0861a7df554519e97ffd115f5f45900176
UD-DW-Q6_K_L|Huihui-Qwen3.8-27B-abliterated-UD-DW-Q6_K_L.gguf|23945415584|72b74fbe001afb656131779d4e98ded902eacb241458917123e10a52ce432a2a
UD-DW-Q8_K_L|Huihui-Qwen3.8-27B-abliterated-UD-DW-Q8_K_L.gguf|27250826144|fb8413d0b5cec5ad7055e49630a986518ba90fdacc95a337aa535e8ff5bf0d16
UD-DW-bf16|Huihui-Qwen3.8-27B-abliterated-UD-DW-bf16.gguf|54657733920|b880f2042df16a9a493800c83f1ee16b7cd46e8ca695f193655940a1949e9097
UD-IQ2_S|Huihui-Qwen3.8-27B-abliterated-UD-IQ2_S.gguf|8424398848|b4b7bdec2e49a66542f5816295a7503f2fc52dd7bd04ca45bc370820cfe81d03
UD-IQ2_S-MTP|Huihui-Qwen3.8-27B-abliterated-UD-IQ2_S-MTP.gguf|8775408544|139e6356e22ad9a2b12dbadf29f72079ce1047f1dba84e02498f21344b6e6763
UD-IQ3_S|Huihui-Qwen3.8-27B-abliterated-UD-IQ3_S.gguf|11952901024|f785ad524b138cd53575410e07e93dfa6eff1cc92ca698264cb9c96973db6886
UD-IQ3_XXS|Huihui-Qwen3.8-27B-abliterated-UD-IQ3_XXS.gguf|11021122464|e86259c841888b06fd84750963a0263947c9aae3c3029b52cbb3faa34a554827
UD-IQ4_XS|Huihui-Qwen3.8-27B-abliterated-UD-IQ4_XS.gguf|14403496864|d83adbbbaace8acdfcfe28004f779326176b9df00b4ec99dc6c24d749723d3b9
UD-Q2_K_XL|Huihui-Qwen3.8-27B-abliterated-UD-Q2_K_XL.gguf|10011909024|3715d3c31491d706c164445246d31f7ac59822a735d3ae53560b826e248b0e73
UD-Q3_K_XL|Huihui-Qwen3.8-27B-abliterated-UD-Q3_K_XL.gguf|13326125984|c6e144d78595c4656946187c2cee42f9062b3b4fa9874bc1be3e9263396253da
UD-Q4_K_XL|Huihui-Qwen3.8-27B-abliterated-UD-Q4_K_XL.gguf|17378626464|ebbc66b45cf36bf47dc052d560337ff047a8b4eef851c8919d83d623703b6aa4
UD-Q5_K_XL|Huihui-Qwen3.8-27B-abliterated-UD-Q5_K_XL.gguf|20673612704|a6ff520853eba5cad302a2a16144b7fe683792cca7fb2830a08479e78ebe12b6
UD-Q6_K_XL|Huihui-Qwen3.8-27B-abliterated-UD-Q6_K_XL.gguf|24826588064|236d807b7577b66299120b60f3c8f7bdfb8a8ba72c08a9e57ddedbf009ce3da4
UD-Q8_K_XL|Huihui-Qwen3.8-27B-abliterated-UD-Q8_K_XL.gguf|31457991680|b4a19bbd0bb094d6a70f00b807955fd61606dd054f167a04a6599332c7827048
Underdog-Saluki-Swift-1.5-IQ2|Huihui-Qwen3.8-27B-abliterated-Underdog-Saluki-Swift-1.5-IQ2.gguf|7898369280|b1a6c9e8f2f941bd71eff32681fa751caa66ff3e71c55cbb646f7e88eb3d3999
Underdog-Saluki-Swift-1.5-IQ2-mtp|Huihui-Qwen3.8-27B-abliterated-Underdog-Saluki-Swift-1.5-IQ2-mtp.gguf|8246839488|6664b597a8927a574c14928bb02f0be10156807aaa41294ca8952220c5e8e49d
bf16|Huihui-Qwen3.8-27B-abliterated-bf16.gguf|54657733920|b880f2042df16a9a493800c83f1ee16b7cd46e8ca695f193655940a1949e9097
EOF_QUANTS

MMPROJ_FILE="mmproj-model-bf16.gguf"
MMPROJ_SIZE=931145888
MMPROJ_SHA256="c9a09064683620bea3d3bfed5d4462e1a97a7d2fff7e5045d6862a0a85eeb5b5"

human_gb() { awk -v b="$1" 'BEGIN { printf "%.1f GB", b/1000000000 }'; }

list_quants() {
  echo "Available quantizations for $HF_REPO:"
  echo "$QUANTS" | awk -F'|' '{tot[$1]+=$3; n[$1]++} END {for (q in tot) printf "  %-55s %2d file(s)  %s\n", q, n[q], ""}' | sort
  echo "$QUANTS" | awk -F'|' '{tot[$1]+=$3} END {for (q in tot) printf "%s|%d\n", q, tot[q]}' | sort | while IFS='|' read -r q tot; do
    printf '  %-55s %s total\n' "$q" "$(human_gb "$tot")"
  done
  echo "  mmproj (vision projector, optional): $MMPROJ_FILE ($(human_gb "$MMPROJ_SIZE"))"
  echo "Default quant: Q4_K"
}

download_one() {
  local file="$1" size="$2" sha="$3"
  echo "  -> $file ($size bytes, sha256 ${sha:0:12}...)"
  curl -L --fail --retry 3 -C - -o "$file" "$BASE/$file"
  local actual; actual=$(wc -c < "$file")
  if [ "$actual" != "$size" ]; then echo "ERROR: size mismatch for $file (expected $size, got $actual)" >&2; rm -f "$file"; exit 1; fi
  local got; got=$(sha256sum "$file" | awk '{print $1}')
  if [ "$got" != "$sha" ]; then echo "ERROR: sha256 mismatch for $file" >&2; rm -f "$file"; exit 1; fi
  echo "     verified: $actual bytes, sha256 OK"
}

download_quant() {
  local quant="$1"
  local rows; rows=$(echo "$QUANTS" | awk -F'|' -v q="$quant" '$1==q')
  if [ -z "$rows" ]; then echo "ERROR: unknown quant '$quant'. Run: ./download.sh --list" >&2; exit 1; fi
  local total; total=$(echo "$rows" | awk -F'|' '{s+=$3} END {print s}')
  echo "Downloading $quant ($total bytes = $(human_gb "$total")) from $HF_REPO"
  echo "Make sure you have at least $(human_gb "$total") free disk space."
  local avail; avail=$(df -P . | awk 'NR==2 {print $4*1024}')
  if [ "$avail" -lt "$total" ]; then echo "ERROR: not enough free disk space (need $total bytes, have $avail)" >&2; exit 1; fi
  echo "$rows" | while IFS='|' read -r _q file size sha; do download_one "$file" "$size" "$sha"; done
  echo "Done: $quant downloaded and verified."
}

download_mmproj() {
  echo "Downloading mmproj $MMPROJ_FILE ($MMPROJ_SIZE bytes = $(human_gb "$MMPROJ_SIZE"))"
  download_one "$MMPROJ_FILE" "$MMPROJ_SIZE" "$MMPROJ_SHA256"
  echo "Done: mmproj downloaded and verified."
}

case "${1:-Q4_K}" in
  --list|-l) list_quants ;;
  --mmproj) download_mmproj ;;
  -h|--help)
    echo "Usage: ./download.sh [QUANT]"
    echo "       ./download.sh --list        list all available quants and sizes"
    echo "       ./download.sh --mmproj      download the mmproj vision file only"
    echo "Default QUANT: Q4_K"
    ;;
  *) download_quant "$1" ;;
esac
