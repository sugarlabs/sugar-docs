Sugar is made of several modules and depends on many other libraries.

There are several ways to set up a Sugar environment for doing Sugar
development:

* for testing or changing Sugar or a Sugar activity, install a [live
  build](#LIVE), which has all dependencies and source code included;

* for writing or changing a Sugar activity, install a [packaged Sugar
  environment](#PACKAGED), which will install dependencies
  automatically; or,

* for packaging Sugar, downstream developers create a [native Sugar
  build](#NATIVE) and install the necessary dependencies by hand.

<a name="LIVE">

Setup a development environment - live build
============================================

Sugar Live Build is a complete bootable image containing Sugar, the
toolkits, and the demonstration activities;

* can be booted from hard drive, flash drive, and optical media,
  automatically starting Sugar without persistence,

* can be installed as a virtual machine, with persistence and password
  protection,

* contains all build dependencies, configured source trees (git clones
  in `/usr/src`), and binaries (`make install`) for Sugar modules and
  the demonstration activity set.

See
[downloads](http://people.sugarlabs.org/~quozl/sugar-live-build-20170927/)
for the ISO9660 image file.

Once installed, Sugar Live Build can be used to make changes to Sugar,
the toolkits, the demonstration activities, or to write new
activities.

* changes to Sugar or the toolkits can be done by editing files in the
  module source trees in `/usr/src`, followed by `sudo make install`
  for each changed module.

* changes to demonstration activities can be done in the activity
  source trees in `/usr/src/sugar-activities`, and are immediately
  effective; just start a new instance of the activity in Sugar.

* writing new activities can be done in the `~/Activities/` directory,
  and the new activity can be started using `sugar-activity` command
  in Terminal, or by restarting Sugar so that the new
  `activity/activity.info` file is read to regenerate the [Home
  View](https://help.sugarlabs.org/en/home_view.html).

See [sugar-live-build](https://github.com/sugarlabs/sugar-live-build)
on GitHub for configuration files to make your own Sugar Live Build
using the Debian Live Build software.

<a name="PACKAGED">

Setup a development environment - packaged style
================================================

For development of activities without making changes to Sugar desktop.

Install Debian and track `stretch` or `buster`, or install Ubuntu
17.04 Artful.

Install the `sucrose` package;

    sudo apt install sucrose

Log out, then log in with the Sugar desktop selected.

Or, install `xrdp` and `rdesktop` then log in to Sugar in a window;

    sudo apt install xrdp rdesktop
    sudo adduser guest
    echo sugar | sudo tee -a /home/guest/.xsession
    rdesktop -g 1200x900 -u guest -p guest 127.0.0.1

For Ubuntu users, see also [Using Sugar on
Ubuntu](http://wiki.sugarlabs.org/go/Ubuntu).

For Debian, see also [Using Sugar on
Debian](http://wiki.sugarlabs.org/go/Debian).

For Fedora, see [Using Sugar on
Fedora](http://wiki.sugarlabs.org/go/Fedora).

<a name="NATIVE">

Setup a development environment - native style
==============================================

For experts.

Clone each of the sugar, sugar-artwork, sugar-datastore,
sugar-toolkit, and sugar-toolkit-gtk3 module repositories, then in
each;

    ./autogen.sh
    configure
    make
    sudo make install

You will need to install any dependencies by hand. There are many
dependencies. A good list of dependencies is the Fedora packaging or
Debian packaging files.
