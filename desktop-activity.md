Write your own desktop activity
===============================

While the Sugar desktop can support activites written in a number of
different languages, including Smalltalk, C, and JavaScript, the
majority of activities are written in Python and utilize the
[sugar-toolkit-gtk3](https://github.com/sugarlabs/sugar-toolkit-gtk3)
libraries. This document describes the basic requirements for
developing a Python activity.

### Setting up the development environment

You should begin by setting up **osbuild**, the Sugar build
environment (See [Sugar build environment](dev-environment.md.html)).
**osbuild** provides all of the core libraries you'll need.  And you
will use it for testing your activity and packaging it for
distribution.

### Create a new activity from a template 

Once you have set up **osbuild**, locate the **activities** directory
on your machine. By default, it will be in:

    ~/sugar-build/activities

Individual activities reside in subdirectories of the `activities`
directory. This is where you will create your new activity.

A quick way to get started it to clone a copy of the Hello World
Activity from [hello-world](https://github.com/manuq/hello-world.git)

    git clone https://github.com/manuq/hello-world.git activity-name.activity

Note that you must use the `.activity` suffix in the directory name of
your new activity.

### Customize

Your clone of the Hello World Activity contains a file,
`activity/activity.info` that you will need to modify.

    [Activity]
    name = HelloWorld
    activity_version = 1
    bundle_id = org.sugarlabs.MyActivity.HelloWorld
    exec = sugar-activity activity.HelloWorldActivity
    icon = activity-helloworld
    licence = GPLv3+

Choose a name and unique bundle-id for your activity by editing the
file.

Note: Don't use punctuation in your bundle_id, e.g.,
`org.sugarlabs.my-activity-name` is not a valid bundle name. Instead, use
CamelCase, e.g., `org.sugarlabs.MyActivityName`.

    [Activity]
    name = MyActivityName
    activity_version = 1
    bundle_id = org.sugarlabs.MyActivity.MyActivityName
    exec = sugar-activity activity.HelloWorldActivity
    icon = activity-helloworld
    licence = GPLv3+

You'll also want to change the `exec` field to reference the name of
the class in your `activity.py` file, e.g., if you change Line 32:

    class HelloWorldActivity(activity.Activity):

to:

    class MyActivityActivity(activity.Activity):

then you need to change `activity/activity.info` as follows:

    [Activity]
    name = MyActivityName
    activity_version = 1
    bundle_id = org.sugarlabs.MyActivity.MyActivityName
    exec = sugar-activity activity.MyActivityActivity
    icon = activity-helloworld
    licence = GPLv3+

We recommend that you use a GPLv3+ license.

To read more about `activity.info`, see the [Activity
Bundles](https://wiki.sugarlabs.org/go/Development_Team/Almanac/Activity_Bundles)
page in our wiki.

You should make your activity's appearance unique in the Sugar
interface by changing your activity icon.  (Yoy are welcome to ask for
help from the community if you don't feel comfortable with graphic
design.)

`activity/activity-helloworld.svg`.

![Activity
 Icon](https://rawgit.com/manuq/hello-world/master/activity/activity-helloworld.svg
 "Activity icon")

You can rename this file as long as you make the corresponding edit in
the `actvity.info` file.

Note that your activity icon must follow the guidelines as decribed in
[The Sugar Interface:
Icons](https://wiki.sugarlabs.org/go/Human_Interface_Guidelines/The_Sugar_Interface/Icons).

There is a helper script, [Sugar
Iconify](https://wiki.sugarlabs.org/go/Sugar_iconify) that will help
you create Sugar-compliant icons.

Of course, the interesting changes will be the ones you make to the
activity itself. Below you will find some links to some resources
regarding some Sugar Activity devolepment details, but perhaps the
best way to get started is to modify an existing activity that has
features similar to the one you want to create.

### Running your activity

Launch Sugar and your new activity should be immediately available,
although since it has not yet been selected as a **favorite**, it will
not appear by default on the Sugar Home View. You need to select the
**List View** to see your activity's icon.

Click on your activity icon and, if all goes well, your activity will
launch.

There are many opportunities to make mistakes. Don't get discouraged,
as engaging in debugging is a great way to learn. One useful tool is
the Log Activity, which will show you the log files of the system and
individual activities. Alternatively, you can look at the log files
from the command line.

    ~/sugar-build/home/dotsugar/default/logs

### File structure

All activities follow the same basic file structure:

    my-activity/
    |-- activity/
    |   |-- activity.info
    |   `-- activity-icon.svg
    |-- activity.py
    `-- setup.py

* `activity/` contains information about your activity, including the
  name, ID, and the icon.

* `activity.py` contains an instance of the activity class, which is
  run when your activity is launched.

* `setup.py` lets you install your activity or make an installable
  bundle with it

### Translation

Since Sugar serves a global audience, it is important to enable your
activity for internationalization and localization. A [guide to best
practices](https://wiki.sugarlabs.org/go/Translation_Team/i18n_Best_Practices)
is found in our wiki.

### Revision control your code

For development you can initialize the repository as a git
repository. This will help you to track your changes. First use [git
init](https://www.kernel.org/pub/software/scm/git/docs/git-init.html)
to initialize the repository:

    git init

With [git
status](https://www.kernel.org/pub/software/scm/git/docs/git-status.html)
you can show the available files in the folder they are still
untracked. Now add all the files in the directory besides the lib
folder and commit those changes, you can use git status again to see
the current state:

    git add .
    git commit -a -m 'Initial import'
    git status

We recommend that you use [github](http://github.com) to host your
Sugar Activity.

### Ready to release

Once your activity is working, you can request to have
your activity repository hosted under the [Sugar Labs github
account](http://github.com/sugarlabs).

From **osbuild** you can make an XO bundle and upload it to
the Sugar activities portal <http://activities.sugarlabs.org/> .

    python setup.py dist_xo

For further releases, you should update the activity_version in
`activity/activity.info`.

More details
============

Documentation for `sugar-toolkit-gtk3` is available
[here](https://developer.sugarlabs.org/sugar3/).

A Python-GTK3 tutorial is available
[here](http://python-gtk-3-tutorial.readthedocs.io/en/latest/).

You may follow this book by James Simmons on how to make Sugar
activities, available at [Make Your Own Sugar Activities](https://flossmanuals.net/make-your-own-sugar-activities/).

# Coding standards

We currently use [Python Version 2.7](https://docs.python.org/2/) for
the Sugar toolkit and Sugar activity development.

We recommend [flake8](https://pypi.python.org/pypi/flake8) as a
wrapper around the [pep8](https://www.python.org/dev/peps/pep-0008/)
and [pyflakes](https://pypi.python.org/pypi/pyflakes) code checkers.
