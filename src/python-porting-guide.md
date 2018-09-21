# Python 3 Porting Guide

Guide to porting Sugar Activities to Python 3.

## Required Skills

* application development in Python,
* Sugar activity development,
* Knowledge of differences between Python 2 and Python 3.

## How to Port an Activity to Python 3:

* Quiesce the activity source by making sure the activity works properly before porting, closing any solved issues, merging any pull requests or branches and releasing the last Python 2 version; see the [activity maintainer checklist](contributing.md#checklist---maintainer).

* Use the Python 3 version of Sugar Toolkit GTK+ 3 (currently under development, [here](https://github.com/Pro-Panda/sugar-toolkit-gtk3/tree/python3-port)).
* If the activity uses `telepathy-python`, port to PyGObject binding `TelepathyGLib`
  ```python
  import telepathy
  ```
  should change to:
  ```python
  from gi.repository import TelepathyGLib
  ```

* Port from Python 2 to Python 3.
  Start your porting with [2to3](https://docs.python.org/3.0/library/2to3.html) tool,<br>
  In the terminal, type:
  ```shell
  2to3 -w *.py
  ```
* Change `exec` value in `activity.info` from `sugar-activity` to `sugar-activity3`
* Test the activity
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


## Reporting Issues:
The Python 3 toolkit is still in development mode. Report any bugs [here](https://github.com/sugarlabs/sugar-toolkit-gtk3/pull/383)

