#!/bin/bash -e

scp "$1" target:/tmp/test/a/b/
ssh target "cd /tmp/test/a/b && ./$(basename $1)"
