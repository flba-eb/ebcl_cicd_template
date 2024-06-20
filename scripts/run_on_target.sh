#!/bin/bash -e

scp "$1" target:/tmp/test/a/b/
ssh target "cd /tmp/test/a/b && ./$(basename $1) ; ret=$? ; rm ./$(basename $1) ; exit $?"
