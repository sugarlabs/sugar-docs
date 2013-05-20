Building from sources
=====================

Getting started
---------------

Sugar is made of several modules and it often depends on libraries which has not
yet been packaged in linux distributions. To make it easier for developers to
build from sources, we developed a set of scripts that automates builds and
other common development tasks.

Only a few distributions are supported by the scripts, the most popular and
most recent. Unfortunately we can't support everything, especially older
versions, we prefer to focus on making the scripts work really well where
supported. You can choose between the 32-bit and 64-bit versions of

* Fedora 18
* Ubuntu 13.04
* Debian Jessie

First of all clone the sugar-build git repository

    git clone git://github.com/sugarlabs/sugar-build.git

Then enter the main directory and build the source code. It may take some
time, depending on your distribution, computer and network speed

    cd sugar-build
    ./osbuild build

Finally run it with

    ./osbuild run

If anything goes wrong, you can check if there are known problems with the
source code, by looking at the
[buildbot status](http://buildbot.sugarlabs.org/waterfall). If it's red
then something is wrong and hopefully developers will fix it soon. If it's
green then the issue is probably not yet known and you should report it.
You can generate useful debug information with

    ./osbuild bug-report

Developing
----------

All the sources are inside the sugar-build directory. You can make
changes using any text editor. If sugar is already running stop it, then
restart it with

    ./osbuild run

Once in a while you will want to update to the latest sugar sources, issuing
the command

    ./osbuild pull

Commands reference
------------------

You can run the commands as osbuild arguments

    ./osbuild build
    ./osbuild run

Or inside a shell

    ./osbuild

    [sugar-build $] build
    [sugar-build $] run

The following commands are available

* check-system

  Check that all the necessary dependencies are installed in your
  system.

* pull

  Pull the latest source code. All modules are pulled unless one is
  specified.

* build

  Build the source code. All the modules are built unless one is
  specified.

* run

  Run sugar.

* check

  Run tests for sugar-build and all the modules that provides them. It
  should usually be run before submitting patches or pushing changes.

* bug-report

  Generate a bug report.

* clean

  Delete the build artifacts.

* shell

  Open a shell inside the build environment.

* send-patches

  Send the modifications you made as patches, for review and
  integration into the official repository. This command must be run
  inside the shell and from the source directory of the module you
  modified. Changes must have been committed.

Preferences reference
---------------------

You can set a few options by creating a sugar-build/prefs file. For example

    OUTPUT=HDMI1
    RESOLUTION=1024x768

The following preferences are available

* RESOLUTION

  This option is only valid when running from X Window. It specifies
  the resolution of the window containing the sugar desktop in the
  form \[width\]x\[height\]. Otherwise the whole screen is used.

* OUTPUT

  This option is only valid when running from a text console. Sugar
  does not work properly on multiple video outputs, so we need to
  select one and turn off the others. By default we select the first
  output listed by RandR. You can set this variable to override that
  with any other of the connected outputs reported by the xrandr
  command, for example VGA1 if you have an external monitor.

* PROFILE

  Sugar supports multiple profiles, so that you can run multiple
  instances with the same user. You can specify the name of the
  profile with this option. A random generated one is added to the
  prefs if you are running sugar-build under sugar.


Adding a new distribution
-------------------------

To add support for other distributions you first need to add a plugin,
implementing the PackageManager and DistroInfo interfaces. It helps to take
a look at the existing implementations in devbot/plugins.

The next step is to provide distributions specific package names. To do so,
edit the config/packages/deps.json file (or the one with your system version).
The keys of the dictionary are cross distribution dependency names, which are
mapped to a list of dependency specific package names. For example

    "evince typelib": {
        "debian": [
            "gir1.2-evince-3.0"
        ], 
        "fedora": [
            "evince-libs"
        ], 
        "ubuntu": [
            "gir1.2-evince-3.0"
        ]
    } 

Add the correct package name (or names) for your distribution to each
element of the dictionary. If you are not clear on what package you need to
add, you can refer to the config/deps directory, which defines, in several
files, the cross distribution dependencies. For example

    {
        "check": "from gi.repository import EvinceDocument", 
        "checker": "python", 
        "name": "evince typelib"
    } 

You can map it to the package by looking at the check_name field. There are
different kind of checkers, which takes the check field as input.

* python

  This is just a snippet of python code which is evaluated. You should
  be looking either for a classic python library or, when importing
  from "gi.repository", for a typelib file.

* binary

  This checks if an executable file is present on the system. You
  should find the package which contains this file.

* gtkmodule

  These modules are library files which are generally installed in the
  "gtk-\[version\]/modules", inside the system lib directory.

* include

  It checks for a C header file, inside the system include directory.

* dbus

  Checks for a dbus service. The service file is generally installed
  in share directory, inside dbus-1/services. The extension is
  "service".

* metacity

  You should look for a package providing a metacity theme. They are
  normally installed under "themes" in the share system directory.

* gstreamer

  This checks for gstreamer plugins. They are library files installed
  in gstreamer-\[version\], under the system lib directory.

You should edit buildbot.json in a similar way (there is only one package
there). Finally, you should add to basesystem.json a minimal list of packages
necessary for the system work. If just these are installed it should be able
to boot, function and install new packages.

That's it! If all is configured correctly you should now be able to build
sugar on the new distribution.
