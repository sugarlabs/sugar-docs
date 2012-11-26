Binary snapshots
================

Building from sources takes a while and uses a lot of network bandwidth. If
you just want to test or to develop activities, it might sometimes be more
convenient to use a binary snapshot. We are building snapshots for each change
in the source tree, so what you get is built from the very latest code.

First of all download the latest snapshot for your distribution, it's important that you pick the right one, it won't work otherwise.

* `Fedora 17 (32 bit) <http://sugarlabs.org/~dnarvaez/snapshots/fedora-17-32bit/latest>`_
* `Fedora 17 (64 bit) <http://sugarlabs.org/~dnarvaez/snapshots/fedora-17-64bit/latest>`_
* `Ubuntu 12.10 (32 bit) <http://sugarlabs.org/~dnarvaez/snapshots/ubuntu-12.10-32bit/latest>`_
* `Ubuntu 12.10 (64 bit) <http://sugarlabs.org/~dnarvaez/snapshots/ubuntu-12.10-64bit/latest>`_

Then unpack it where you like (adapting the tarball path to your system and
snapshot filename)::

    tar xfJ ~/Downloads/sugar-snapshot-fedora-17-32bit-1.tar.xz

Enter the directory and run sugar::

    cd sugar-snapshot
    ./run-sugar.sh

If you are developing activities you should make sure to run setup.py and any
other command which requires the sugar environment inside a shell. You can run 
a shell inside an existing terminal with::

    ./run-shell.sh
