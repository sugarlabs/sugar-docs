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
    make build

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
changes using any text editor. When you are done you need to install the
changes. Enter the shell and the build directory of the module you modified,
for example::

    make shell
    cd build/sugar

Install your changes::

    make install

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

build
    Build the source code.

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

    Specify the screen resolution in the form widthxheight. Note that the
    resolution needs to be in the list of available modes, as displayed
    by the xrandr command.

OUTPUT

    Sugar does not run properly on multiple video outputs, so we need to
    select one and turn off the others. By default we select the first
    output listed by RandR. You can set this variable to override that with
    any other of the connected outputs reported by xrandr command, for example
    VGA1 if you have an external monitor.

PROFILE

    Sugar supports multiple profiles, so that you can run multiple instances
    with the same user. You can specify the name of the profile with this
    option. A random generated one is added to the prefs if you are running
    sugar-build under sugar.

RUN_IN_WINDOW

    Set this variable to any value to run sugar inside a window rather
    than fullscreen.
