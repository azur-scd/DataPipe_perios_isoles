#!/bin/sh

# PREREQUISITES:
# saxon9he.jar must be installed

# Conversion of run_saxon.bat to shell script

# USAGE:
# bash run_saxon.sh stylesheet.xsl source.xml output.xml rcr=060882103

java -jar "saxon-he-9.4.0.7.jar" -xsl:$1 -s:$2 -o:$3 rcr=$4