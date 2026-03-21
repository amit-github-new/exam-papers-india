#!/bin/bash
# PDF Compression Script using Ghostscript
# Compresses all PDFs in INPUT_DIR and saves to OUTPUT_DIR
# Target: /ebook quality (~150 DPI) — ideal for exam papers (text + diagrams)

INPUT_DIR="${1:-./pdfs_original}"
OUTPUT_DIR="${2:-./pdfs_compressed}"

GS=/opt/homebrew/bin/gs

# Colours
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

if [ ! -d "$INPUT_DIR" ]; then
  echo -e "${RED}Error: Input directory '$INPUT_DIR' not found.${NC}"
  echo "Usage: ./compress_pdfs.sh <input_dir> <output_dir>"
  exit 1
fi

mkdir -p "$OUTPUT_DIR"

PDF_COUNT=$(find "$INPUT_DIR" -name "*.pdf" -o -name "*.PDF" | wc -l | tr -d ' ')

if [ "$PDF_COUNT" -eq 0 ]; then
  echo -e "${RED}No PDF files found in '$INPUT_DIR'.${NC}"
  exit 1
fi

echo -e "${GREEN}Found $PDF_COUNT PDF(s) to compress.${NC}"
echo "Input:  $INPUT_DIR"
echo "Output: $OUTPUT_DIR"
echo "----------------------------------------"

TOTAL_ORIGINAL=0
TOTAL_COMPRESSED=0
SUCCESS=0
FAILED=0

find "$INPUT_DIR" -name "*.pdf" -o -name "*.PDF" | sort | while read -r INPUT_FILE; do
  FILENAME=$(basename "$INPUT_FILE")
  OUTPUT_FILE="$OUTPUT_DIR/$FILENAME"

  ORIGINAL_SIZE=$(stat -f%z "$INPUT_FILE" 2>/dev/null || stat -c%s "$INPUT_FILE")
  ORIGINAL_KB=$((ORIGINAL_SIZE / 1024))

  printf "Compressing: %-50s %6s KB  →  " "$FILENAME" "$ORIGINAL_KB"

  $GS \
    -sDEVICE=pdfwrite \
    -dCompatibilityLevel=1.4 \
    -dPDFSETTINGS=/ebook \
    -dNOPAUSE \
    -dQUIET \
    -dBATCH \
    -dDetectDuplicateImages=true \
    -dCompressFonts=true \
    -dSubsetFonts=true \
    -sOutputFile="$OUTPUT_FILE" \
    "$INPUT_FILE" 2>/dev/null

  if [ $? -eq 0 ] && [ -f "$OUTPUT_FILE" ]; then
    COMPRESSED_SIZE=$(stat -f%z "$OUTPUT_FILE" 2>/dev/null || stat -c%s "$OUTPUT_FILE")
    COMPRESSED_KB=$((COMPRESSED_SIZE / 1024))
    SAVING=$(( (ORIGINAL_SIZE - COMPRESSED_SIZE) * 100 / ORIGINAL_SIZE ))

    if [ "$COMPRESSED_SIZE" -lt "$ORIGINAL_SIZE" ]; then
      printf "${GREEN}%6s KB  (saved %s%%)${NC}\n" "$COMPRESSED_KB" "$SAVING"
    else
      # Compressed is larger — keep original
      cp "$INPUT_FILE" "$OUTPUT_FILE"
      printf "${YELLOW}%6s KB  (kept original — already optimised)${NC}\n" "$ORIGINAL_KB"
    fi
  else
    cp "$INPUT_FILE" "$OUTPUT_FILE"
    printf "${RED}FAILED — copied original${NC}\n"
  fi
done

echo "----------------------------------------"
echo -e "${GREEN}Done! Compressed PDFs saved to: $OUTPUT_DIR${NC}"
echo ""
echo "Next step: Upload all files from '$OUTPUT_DIR' to Supabase Storage,"
echo "replacing the originals (keep the same filenames)."
