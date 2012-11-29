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

* Fedora 17
* Ubuntu 12.10
* Fedora 18 (experimental until it will be released)

First of all clone the sugar-build git repository::

    git clone git://git.sugarlabs.org/sugar-build/sugar-build

Then enter the main directory and build the source code. It may take some
time, depending on your distribution, computer and network speed::

    cd sugar-build
    make

Finally run it::

    make run

If anything goes wrong, you can check if there are known problems with the
source code, by looking at the
`buildbot status <http://buildbot.sugarlabs.org/waterfall>`_. If it's red
than something is wrong and hopefully developers will fix it soon. If it's
green than the issue is probably not yet known and you should report it.
You can generate useful debug information with::

    make bug-report

Developing
----------

All the sources are inside the sugar-build/source directory. You can make
changes using any text editor. When you are done you need to build the
changes. For example, if you made changes to the sugar module::

    make build-sugar

If you made changes to an activity you can just restart it. If you made
changes to the system, you need to restart sugar. You are now inside a
sugar-build shell, so you can run commands directly, without using the make
command. Shut down sugar and simply::

    run

Installing takes a bit of time and doing it for every change is annoying.
There is a shortcut, which is currently limited to python files of core
modules (we are planning to extend it to activities). In a separate terminal::

    make auto-install

Now whenever you make changes to the source files, they will be immediately
installed.

Commands reference
------------------

The commands can be run as make arguments::

    make build
    make run

Or inside a shell::

    make shell

    [sugar-build $] build
    [sugar-build $] run

The following commands are available

auto-install
    Automatically install source files whenever they change. Currently
    limited to python files of core modules.

check-system
    Check that all the necessary dependencies are installed in your system.

pull
    Pull the latest source code. All modules are pulled unless one is
    specified. For example with make::

      make pull-sugar

    And inside the shell::

      pull sugar

build
    Build the source code. All the modules are built unless one is specified.
    For example with make::

      make build-sugar

    And inside the shell::

      build sugar

run
    Run sugar.

test
    Run the UI tests.

bug-report
    Generate a bug report.

clean
    Delete the build artifacts.

shell
    Open a shell inside the build environment.

send-patches
    Send the modifications you made as patches, for review and integration
    into the official repository. This command must be run inside the shell
    and from the source directory of the module you modified. Changes must
    have been committed.

Preferences reference
---------------------

You can set a few options by creating a ugar-build/prefs file. For example::

    OUTPUT=HDMI1
    RESOLUTION=1024x768

The following preferences are available

RESOLUTION

    This option is only valid when running from X Window. It specifies the
    resolution of the window containing the sugar desktop in the form
    [width]x[height]. Otherwise the whole screen is used.

OUTPUT

    This option is only valid when running from a text console. Sugar does
    not work properly on multiple video outputs, so we need to select one
    and turn off the others. By default we select the first output listed
    by RandR. You can set this variable to override that with any other of
    the connected outputs reported by the xrandr command, for example VGA1
    if you have an external monitor.

PROFILE

    Sugar supports multiple profiles, so that you can run multiple instances
    with the same user. You can specify the name of the profile with this
    option. A random generated one is added to the prefs if you are running
    sugar-build under sugar.

BUILD_IN_SOURCE

    If this is option is set (to any value) all the modules will be built
    inside the source directory, even if they support out-of-source builds.

Adding a new distribution
-------------------------

To add support for other distributions you first need to add a plugin,
implementing the following classes. It helps to take a look at the existing
implementations in devbot/plugins.

.. automodule:: devbot.plugins.interfaces
   :members:

The next step is to provide distributions specific package names. To do so,
edit the config/packages/deps.json file (or the one with your system version).
The keys of the dictionary are cross distribution dependency names, which are
mapped to a list of dependency specific package names. For example::

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
files, the cross distribution dependencies. For example::

  {
      "check": "from gi.repository import EvinceDocument", 
      "checker": "python", 
      "name": "evince typelib"
  } 

You can map it to the package by looking at the check_name field. There are
different kind of checkers, which takes the check field as input.

python
    This is just a snippet of python code which is evaluated. You should be
    looking either for a classic python library or, when importing from
    "gi.repository", for a typelib file.

binary
    This checks if an executable file is present on the system. You should
    find the package which contains this file.

gtkmodule
    These modules are library files which are generally installed in the
    "gtk-[version]/modules", inside the system lib directory.

include
    It checks for a C header file, inside the system include directory.

dbus
    Checks for a dbus service. The service file is generally installed in
    share directory, inside dbus-1/services. The extension is "service".

metacity
    You should look for a package providing a metacity theme. They are
    normally installed under "themes" in the share system directory.

gstreamer
    This checks for gstreamer plugins. They are library files installed in
    gstreamer-[version], under the system lib directory. 

You should edit buildbot.json in a similar way (there is only one package
there). Finally, you should add to basesystem.json a minimal list of packages
necessary for the system work. If just these are installed it should be able
to boot, function and install new packages.

That's it! If all is configured correctly you should now be able to build
sugar on the new distribution.
