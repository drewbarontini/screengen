#!/usr/bin/env bash

## -------------------------------------
##   Functions - General
## -------------------------------------

## ----- Clean URL ----- ##
## Removes extraneous characters from URL
##
## $1 - the URL
##
## Usage: `clean_url 'google.com'`
##

function clean_url() {
  echo $1 | sed 's/\.[a-z]*$//' | tr ./_ -
}

## ----- Run ----- ##
## Runs a command a set number of times
##
## $1 - the number of times to run the command
## $2 - the command to run
##
## Usage: `run 5 some_command`
##

function run() {
  num=$1
  shift
  for i in `seq $num`
  do
    $@
  done
}

## -------------------------------------
##   Functions - Screengen
##   -> Requires: webkit2png (`brew install webkit2png`)
## -------------------------------------

## ----- Variables ----- ##

SGDIR='screengen'
SGFILE='urls.txt'

## ----- Screengen Init ----- ##
## Sets up the structure for Screengen
##
## Usage: `sg-init`
##

function sg-init() {
  mkdir $SGDIR
  cd screengen
  touch $SGFILE
  echo "Created '$SGDIR' and '$SGDIR/$SGFILE'!"
  echo
  echo "Now, add your URLs (without 'http://') in that file."
}

## ----- Generate Single Screenshot ----- ##
## Wrapper for webkit2png command
##
## $1 - URL (or height)
## $2 - width (option)
## $3 - URL (if width/height passed in)
##
## Usage: `sg google.com`, `ss 800 600 google.com`
##

function sg() {
  re='^[0-9]+$'
  page=$(clean_url $1)
  if ! [[ $1 =~ $re ]]
  then
    webkit2png -W 1440 -H 900 -F -o screenshot-$page http://$1
  else
    webkit2png -W $1 -H $2 -F -o screenshot-$page http://$3
  fi
}

## ----- Screenshots From File ----- ##
## Takes a set of screenshots from a file
##
## $1 - The file to read from
## $2 - The width
## $3 - The height
## $4 - The URL
##
## Usage: `sg-file urls.txt 800 600`
##

function sg-file() {
  i=1
  while read line
  do
    url=$line
    page=$(clean_url $url)
    webkit2png -W $2 -H $3 -F -o screenshot-$page http://$url
    let i++
  done < $1
}

## ----- Screenshot Incrementer ----- ##
## Runs over a set of incrementing URLs
## Requires: `run` function
##
## $1 - width
## $2 - height
## $2 - URL
##
## Usage: `run 10 sg-inc 1024 768 example.com/#`
##

function sg-inc() {
  webkit2png -W $1 -H $2 -F -o screenshot-$i --delay=2 http://$3/$i
}

