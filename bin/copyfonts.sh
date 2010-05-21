#!/bin/bash

# copy fonts from the google hg repository to this repository. Not needed unless you want to update the fonts.
# http://code.google.com/p/googlefontdirectory/
# hg clone https://googlefontdirectory.googlecode.com/hg/ googlefontdirectory


# Set the environment variable GOOGLEFONTDIRECTORY this should point to the directory containing
# the font directories

: ${GOOGLEFONTDIRECTORY:?Please set this variable to the 'googlefontdirectory' directory. See the README.}

if [ ! -d "${GOOGLEFONTDIRECTORY}" ]; then
  echo "${GOOGLEFONTDIRECTORY} is not a directory. Abort."
  exit -1
fi

cd ${0%%copyfonts.sh}/../
pwd

for i in ${GOOGLEFONTDIRECTORY}/*; do
  if [ -d "${i}" ]; then
    fontname=${i##*/}
    fontfiledir=texmf/fonts/truetype/googlewebfonts/${fontname}
    euencfiledir=texmf/tex/latex/euenc/googlewebfonts/${fontname}
    mkdir -p $fontfiledir
    mkdir -p $euencfiledir
    touch $euencfiledir/eu2${fontname}.fd
    cp ${i}/*.ttf  ${fontfiledir}
  fi
done

