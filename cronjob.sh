#!/bin/sh

DIR=$(dirname $0)
HTML=$DIR/issue_votes.html

HASH=$(sha1sum $HTML)

$DIR/ohrissues.py $HTML || exit 1

NEWHASH=$(sha1sum $HTML)
if [ "$NEWHASH" = "$HASH" ]; then
    echo "No changes."
    exit
fi

lftp -e "put -O web/ohr $HTML ; exit" sftp://teeemcee:DUMMY@castleparadox.com
