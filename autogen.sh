#!/bin/sh

test -n "$srcdir" || srcdir=`dirname "$0"`
test -n "$srcdir" || srcdir=.

olddir=`pwd`
cd "$srcdir"

autoreconf --install

cd "$olddir"

"$srcdir/configure" "$@"
