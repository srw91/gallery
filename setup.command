#!/usr/bin/env bash

SCRIPT_PATH=$(dirname "$0")

echo "This script uses mogrify, which you can probably get with imagemagick if you didn't have that already."

# Create a duplicate of each photo, and then minify them
if [ -n "$(uname -a | grep Linux)" -a -x "$(command -v mogrify)" ]; then
  # mogrify is available
  # low res version of image
  python $SCRIPT_PATH/tools/duplicate.py min
  mogrify -resize 1000x $SCRIPT_PATH/photos/**/*.min.jpeg &>/dev/null
  mogrify -resize 1000x $SCRIPT_PATH/photos/**/*.min.png &>/dev/null
  mogrify -resize 1000x $SCRIPT_PATH/photos/**/*.min.jpg &>/dev/null

  # placeholder image for lazy loading
  python $SCRIPT_PATH/tools/duplicate.py placeholder
  mogrify -resize 32x $SCRIPT_PATH/photos/**/*.placeholder.jpeg &>/dev/null
  mogrify -resize 32x $SCRIPT_PATH/photos/**/*.placeholder.png &>/dev/null
  mogrify -resize 32x $SCRIPT_PATH/photos/**/*.placeholder.jpg &>/dev/null
fi  

python $SCRIPT_PATH/tools/setup.py
