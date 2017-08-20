#!/usr/bin/env zsh
DEPENDENCES_ARCH+=( curl pygmentize@pygmentize )
DEPENDENCES_DEBIAN+=( curl pygmentize@python-pygments )

function htmlcat() {
  if [[ -z $1 ]]; then
    FILE=$(mktemp -t XXXXX.html)
    cat > $FILE
  else
    if [[ $1 == "http:"* ]] || [[ $1 == "https:"* ]] || [[ $1 == "ftp:"* ]]; then
      FILE=$(mktemp -t XXXXX.html)
      curl -L --silent "$1" > $FILE
    else
      FILE="$1"
    fi
  fi
  `whence pygmentize` -f 256 -g -l html $FILE 
}
alias xmlcat=htmlcat

function csscat() {
  if [[ -z $1 ]]; then
    FILE=$(mktemp -t XXXXX.css)
    cat > $FILE
  else
    if [[ $1 == "http:"* ]] || [[ $1 == "https:"* ]] || [[ $1 == "ftp:"* ]]; then
      FILE=$(mktemp -t XXXXX.css)
      curl -L --silent "$1" > $FILE
    else
      FILE=$1
    fi
  fi
  `whence pygmentize` -f 256 -g -l css $FILE 
}

function jscat() {
  if [[ -z $1 ]]; then
    FILE=$(mktemp -t XXXXX.js)
    cat > $FILE
  else
    if [[ $1 == "http:"* ]] || [[ $1 == "https:"* ]] || [[ $1 == "ftp:"* ]]; then
      FILE=$(mktemp -t XXXXX.js)
      curl -L --silent $1 > $FILE
    else
      FILE=$1
    fi
  fi
  `whence pygmentize` -f 256 -g -l javascript $FILE
}

function jsoncat() {
  if [[ -z $1 ]]; then
    FILE=$(mktemp -t XXXXX.json)
    cat > $FILE
  else
    if [[ $1 == "http:"* ]] || [[ $1 == "https:"* ]] || [[ $1 == "ftp:"* ]]; then
      FILE=$(mktemp -t XXXXX.json)
      curl -L --silent $1 > $FILE
    else
      FILE=$1
    fi
  fi
  prettyjson $FILE
}

DEPENDENCES_ARCH+=( astyle )
DEPENDENCES_DEBIAN+=( astyle )
function cppcat() {
  if [[ -z $1 ]]; then
    FILE=$(mktemp -t XXXXX.cpp)
    cat > $FILE
  else
    if [[ $1 == "http:"* ]] || [[ $1 == "https:"* ]] || [[ $1 == "ftp:"* ]]; then
      FILE=$(mktemp -t XXXXX.cpp)
      curl -L --silent $1 > $FILE
    else
      FILE=$1
    fi
  fi
  astyle < $FILE | `whence pygmentize` -f 256 -g c_cpp
}
alias javacat=cppcat

function hcat() {
  if [[ -z $1 ]]; then
    FILE=$(mktemp -t XXXXX)
    cat > $FILE
  else
    if [[ $1 == "http:"* ]] || [[ $1 == "https:"* ]] || [[ $1 == "ftp:"* ]]; then
      FILE=$(mktemp -t XXXXX)
      curl -L --silent $1 > $FILE
    else
      FILE=$1
    fi
  fi
  `whence pygmentize` -f 256 -g $FILE
}

DEPENDENCES_NPM+=( msee )
function mdcat() {
  if [[ -z $1 ]]; then
    FILE=$(mktemp -t XXXXX.md)
    cat > $FILE
  else
    if [[ $1 == "http:"* ]] || [[ $1 == "https:"* ]] || [[ $1 == "ftp:"* ]]; then
      FILE=$(mktemp -t XXXXX.md)
      curl -L --silent $1 > $FILE
    else
      FILE=$1
    fi
  fi
  msee "$FILE"
}
DEPENDENCES_ARCH+=( gpg@gnupg )
DEPENDENCES_DEBIAN+=( gpg@gnupg )
function gpgcat() {
  if [[ -z $1 ]]; then
    FILE=$(mktemp -t XXXXX.gpg)
    cat > $FILE
  else
    if [[ $1 == "http:"* ]] || [[ $1 == "https:"* ]] || [[ $1 == "ftp:"* ]]; then
      FILE=$(mktemp -t XXXXX.gpg)
      curl -L --silent $1 > $FILE
    else
      FILE=$1
    fi
  fi
  gpg --quiet --batch -d $FILE
}

function pdfcat() {
  if [[ $1 == "http:"* ]] || [[ $1 == "https:"* ]] || [[ $1 == "ftp:"* ]]; then
    FILE=$(mktemp -t XXXXX.pdf)
    curl -L --silent $1 > $FILE
  else
    FILE=$1
  fi
  pdftotext -eol unix -nopgbrk "$FILE" -
}

DEPENDENCES_ARCH+=( icat convert@imagemagick )
DEPENDENCES_DEBIAN+=( icat convert@imagemagick )
function imgcat() {
  if [ ! -z "$1" ]; then
    if [[ $1 == "http:"* ]] || [[ $1 == "https:"* ]] || [[ $1 == "ftp:"* ]]; then
      FILERAW=$(mktemp -t XXXXX)
      curl -L --silent $1 > $FILERAW
    else
      FILERAW="$1"
    fi
    FILESIZE=$(stat -c%s "$FILERAW")
    FILE=$(mktemp -t XXXXX.png)
    convert $FILERAW $FILE
    icat -m 24bit $FILERAW
  else
    echo "Usege: image <path-to-image>"
  fi
}
