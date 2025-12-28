#!/bin/bash

SRC="producer-space-euphoric-trance-vocals"

get_code() {
  case "$1" in
    *"C minor"*) echo "cm" ;;
    *"D minor"*) echo "dm" ;;
    *"E minor"*) echo "em" ;;
    *"F minor"*) echo "fm" ;;
    *"G minor"*) echo "gm" ;;
    *"A minor"*) echo "am" ;;
    *"Eb Major"*) echo "ebj" ;;
    *"Eb minor"*) echo "ebm" ;;
  esac
}

# Ad-Libs
find "$SRC/Ad-Libs" -name "*.wav" | while read -r file; do
  code=$(get_code "$file")
  if [ -n "$code" ]; then
    dest="etv_${code}_136_adlib"
    mkdir -p "$dest"
    cp "$file" "$dest/"
  fi
done

# Phrases
find "$SRC/Phrases" -name "*.wav" | while read -r file; do
  code=$(get_code "$file")
  if [ -n "$code" ]; then
    dest="etv_${code}_136_phrase"
    mkdir -p "$dest"
    cp "$file" "$dest/"
  fi
done

# Vocals (Construction Kits)
find "$SRC/Construction Kits" -mindepth 1 -maxdepth 1 -type d | while read -r dir; do
  code=$(get_code "$dir")
  if [ -n "$code" ]; then
    src="$dir/Stems/Dry Vocal.wav"
    if [ -f "$src" ]; then
      dest="etv_${code}_136_vocal"
      mkdir -p "$dest"
      cp "$src" "$dest/"
    fi
  fi
done
