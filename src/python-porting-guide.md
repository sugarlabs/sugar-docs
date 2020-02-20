# Python 3 Porting Guide

Guide to porting Sugar Activities to Python 3.

Many activities were written in Python 2 with the PyGObject introspection library, GTK, GDK, GStreamer, and other dependencies.  Activities usually did not have test cases or test coverage.

## Required Skills

* application development in Python,
* Sugar activity development,
* knowledge of differences between Python 2 and Python 3.

## How to Port an Activity to Python 3:

* Quiesce the activity source by making sure the activity works properly before porting, closing any solved issues, merging any pull requests or branches and releasing the last Python 2 version; see the [activity maintainer checklist](contributing.md#checklist---maintainer).

* Check that a Python 3 port has not already been done; look for a _python3_ branch in the main repository, or any developer fork.

* For activities known to work with Fedora 18, create a _fedora18_ branch and push; this branch will be for any future maintenance with Python 2,

* Use Sugar Toolkit for GTK 3 version 0.115 or later, built for Python 3, and test that `/usr/bin/python3` can import it, for example;
  ```bash
  python3 -c 'import sugar3'
  ```

* Prepare a test plan to cover each feature and user interface widget, and consider [assessing coverage](python-coverage-guide.md),

* If the activity uses `telepathy-python`, test and fix collaboration, then port to PyGObject binding `TelepathyGLib`, and test again, for example;
  ```python
  import telepathy
  ```
  should change to:
  ```python
  from gi.repository import TelepathyGLib
  ```
  Use constants from `TelepathyGLib`, and minimise changes, for example;
  ```python
  from telepathy.interfaces import CHANNEL
  ```
  should change to:
  ```python
  CHANNEL = TelepathyGLib.IFACE_CHANNEL
  ```
  Replace calls to `Channel` and `Connection` classes of
  `telepathy-python` with a dictionary of `dbus.Interface()`.  Look
  through the source code for constants used by `Channel` and `Connection`
  objects as keys.  Use these constants as keys to a dictionary of the
  `dbus.Interface()` objects.  For example;
  ```python
  Channel(self._connection.requested_bus_name, channel_path,
    ready_handler=self.__text_channel_ready_cb)
  ```
  should change to (ensure adding all key-interface pairs):
  ```python
  self.text_channel = {}
  self.text_proxy = dbus.Bus().get_object(
            self._connection.requested_bus_name, channel_path)
  self.text_channel[PROPERTIES_IFACE] = dbus.Interface(
            self.text_proxy, PROPERTIES_IFACE)
  ```
  Replace all bare references to `telepathy_text_chan` and
  `telepathy_tubes_chan`
  ```python
  self.telepathy_text_chan.AddMembers(
  ```
  should change to:
  ```python
  self.telepathy_text_chan[CHANNEL].AddMembers(
  ```
  Test and fix collaboration before proceeding further.

* If the activity uses `dbus.gobject_service.ExportedGObject` (deprecated and only available for Python 2), then port to `CollabWrapper`, and test again,

* If the activity uses `dbus` directly, refer to [dbus-python Porting to Python 3](https://dbus.freedesktop.org/doc/dbus-python/PY3PORT.html), and test again,

* Port from Python 2 to Python 3.
  Start your porting with [2to3](https://docs.python.org/3.0/library/2to3.html) tool,<br>
  In the terminal, type:
  ```shell
  2to3 -w -n *.py
  ```
  and then review every change made,

* Iterate through [How to Port Python 2 code to Python 3 | Python Docs](https://docs.python.org/3/howto/pyporting.html), and [Supporting Python 3: An in-depth guide](http://python3porting.com/) changing code,

* Check for integer divisions that have become floating point,

* Check for use of binary data, especially in files, pipes, and subprocesses,

* Check for use of _Gtk.CssProvider_, and if so ensure the _load_from_data_ function is given bytes rather than unicode strings, e.g. `b"...",

* Check for use of _Rsvp.new_from_data_ for making images from SVG data, and if so ensure the function is given bytes rather than unicode strings,

* Change `exec` value in `activity.info` from `sugar-activity` to `sugar-activity3`
* Make Sugar Home View reload the bundle; by restarting Sugar or moving the bundle directory out of `~/Activities` and back again a few seconds later,
* Test the activity from Sugar, that it starts without error, that no warnings or errors are in logs, and that each user function works as before,
* Check if the activity can be built,<br>
  In the terminal, type:
  ```shell
  python3 setup.py dist_xo
  ```

Follow the [Code Guidelines](https://github.com/sugarlabs/sugar-docs/blob/master/src/contributing.md) during all porting.

Write any comments in the code, by adding **\# README:**, **\# TODO:** and **\# FIXME:** explaining what are the problems that you are having with that chunk of code. Put a link if it's necessary.

## Releasing Activities (for maintainers)

Once an activity is ported, a new release can be made. The major version
should be greater than the existing one.

Please follow
[this](contributing.md#checklist---maintainer)
guide for releasing a new version.

Avoid releasing Python 3 activities to https://activities.sugarlabs.org/ as these will not work on existing systems.

## Resources:
 - [What's new in Python 3 | Python Docs](https://docs.python.org/3.0/whatsnew/3.0.html)
 - [How to Port Python 2 code to Python 3 | Python Docs](https://docs.python.org/3/howto/pyporting.html)
 - [2to3 Documentation](https://docs.python.org/3.0/library/2to3.html)

## Porting Examples:
Here are some examples of porting activities to Python 3:
 - [Spirolaterals](https://github.com/sugarlabs/spirolaterals/pull/12/commits/d5e95a86e987e54e1dd41255c00079f21963ab92)
 - [Finance](https://github.com/sugarlabs/finance-activity/pull/16/commits/e36bdf4f5f6873e3c2f645aa218784bca90a463f)
 - [Abacus](https://github.com/sugarlabs/activity-abacus/pull/15/commits/60b264147ff401f0976cce3c24326c4f63f3621b)
 - [Write](https://github.com/sugarlabs/write-activity/pull/24/commits/4fc05b3b78a40d5631d1a7b7bda04b1d82920dd8)
 - [Log](https://github.com/sugarlabs/log-activity/pull/9/commits/c39db017968fea18ec4bf6c24c4e359ab95b49fa)
 - [CowBulls](https://github.com/sugarlabs/CowBulls-activity/commit/02a2727f8a11784dad9b711b0684ff2f2b261363)

## Common Questions

### Why does my traceback show Python 2?

Check that you have changed `exec` in `activity.info`, and that Sugar has been restarted.

### Why does "consider porting to Python 3" still appear?

Check that you have changed `exec` in `activity.info`.
