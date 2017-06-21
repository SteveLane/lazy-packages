#!/bin/bash
# Strips libraries from .R/.r scripts and creates a text file with a list of them.
# Requires first argument as folder where scripts are stored, and second as the
# text file it is stored in.
folder=$1
inst=$2
if [ -f $inst ] ; then
    rm $inst
fi
for filename in $folder/*.R; do
    if [ -f $filename ]; then
	awk -F '[(]|[)]' '/^library|^require/{print $2;}' $filename >> $inst
    fi
done
for filename in $folder/*.r; do
    if [ -f $filename ]; then
	awk -F '[(]|[)]' '/^library|^require/{print $2;}' $filename >> $inst
    fi
done
sort < $inst > $inst.bk
uniq < $inst.bk > $inst
rm $inst.bk
