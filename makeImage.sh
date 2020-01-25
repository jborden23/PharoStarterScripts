#!/usr/bin/env sh
set -u
set -e
typeset overwrite=y
if [[ -s Pharo.image && -s Pharo.changes ]]; then
 for w in $*; do
  if [[ -s $w.image ]]; then
   echo "WARNING: The $w image already exists:"
   ls -l $w.image $w.changes
   echo "Do you want to overwrite these files (y/n)? "
   read overwrite
  fi
  if [[ $overwrite = *y* || $overwrite = *Y* ]]; then
   cp -pR Pharo.image $w.image
   cp -pR Pharo.changes $w.changes
   ./pharo-ui $w.image
  elif [[ $overwrite = *n* || $overwrite = *N* ]]; then
   ./pharo-ui $w.image
  fi
 done
else
 print -u2 "ERROR: This needs to be ran from the Pharo directory."
fi
################################################################################
