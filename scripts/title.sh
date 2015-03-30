#!/bin/sh

TITLE=$1
if [ -z "${TITLE}" ]
then
	echo $0 title
else
	echo -n "]2;${TITLE}]1;${TITLE}"
	echo $1
fi
