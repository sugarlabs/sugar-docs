Write your own Sugar desktop activity
=====================================

Most Sugar desktop activities are written in Python, using our
[GTK+ 2.0](https://github.com/sugarlabs/sugar-toolkit) or
[GTK+ 3.0](https://github.com/sugarlabs/sugar-toolkit-gtk3) libraries.
This page shows how to develop an activity using Python with GTK+ 3.0.

Some Sugar desktop activities are written in languages other than
Python, such as Smalltalk, C, and JavaScript.  For new activities to
run on both Sugar desktop and Sugarizer, please consider [Write your
own Sugar web activity](web-activity.md.html).

### Setting up a development environment

You must first [setup a development
environment](dev-environment.md.html), for testing your activity and
releasing it for distribution.

### Create a new activity from a template

Locate the activity directories.  They may include:

* `~/Activities` for native Sugar desktop, and packaged Sugar desktop on Fedora, Debian or Ubuntu;
* `/usr/share/sugar/activities` for packaged Sugar desktop; and,
* `~/sugar-build/activities` for *sugar-build* only.

Each installed activity is in a directory under the activity
directories.  This is where you will create your new activity.

Clone the Hello World activity from
[hello-world on GitHub](https://github.com/sugarlabs/hello-world-fork):

    git clone https://github.com/sugarlabs/hello-world-fork.git Name.activity

Use the `.activity` suffix in the directory name of an activity,
because that's the way an activity bundle is released.

### Customize

Your clone of the Hello World activity contains a file,
`activity/activity.info`:

    [Activity]
    name = HelloWorld
    activity_version = 1
    bundle_id = org.sugarlabs.HelloWorld
    exec = sugar-activity activity.HelloWorldActivity
    icon = activity-helloworld
    licence = GPLv3+
    repository = https://github.com/sugarlabs/hello-world-fork.git

You must set a new `name` and a unique `bundle_id` for your activity.

Avoid punctuation in your `bundle_id`, e.g.,
`org.sugarlabs.my-activity-name` is not valid. Instead, use
CamelCase, e.g., `org.sugarlabs.MyActivity`.

You should change the Activity class in your `activity.py` file, e.g., from:

    class HelloWorldActivity(activity.Activity):

to:

    class MyActivity(activity.Activity):

You must change the `exec` field as well, e.g., from:

    exec = sugar-activity activity.HelloWorldActivity

to:

    exec = sugar-activity activity.MyActivity

You should set the repository field to the URL of the git repository
of your project.

And we recommend that you use a GPLv3+ license.

Your `activity.info` file will look something like:

    [Activity]
    name = MyActivity
    activity_version = 1
    bundle_id = org.sugarlabs.MyActivity
    exec = sugar-activity activity.MyActivity
    icon = activity-helloworld
    licence = GPLv3+
    repository = https://github.com/MyGitHubAccount/MyActivityRepo.git

To read more about the `activity.info` file, see [Activity
Bundles](https://wiki.sugarlabs.org/go/Development_Team/Almanac/Activity_Bundles)
on our Wiki.

You must make your activity icon unique in the Sugar interface by
making a new one, or borrowing from another icon and making changes.
Ask for help from the community if you don't feel comfortable with
graphic design.

Here is `activity/activity-helloworld.svg`;

![Activity
 Icon](images/activity-helloworld.svg
 "Activity icon")

You should rename this file and change `icon` in the `activity.info`
file.

Your activity icon must follow the guidelines as decribed in
[The Sugar Interface:
Icons](https://wiki.sugarlabs.org/go/Human_Interface_Guidelines/The_Sugar_Interface/Icons) on our Wiki.

There is a helper script, [Sugar
Iconify](sugar-iconify.md.html) that will help
you create Sugar-compliant icons.

Of course, the interesting changes will be the ones you make to the
activity itself. Below you will find links to some resources
on Sugar Activity development, but perhaps the
best way to get started is to modify an existing activity that has
features similar to the one you want to create.

### Running your activity

Launch Sugar and your new activity should be immediately available,
although since it has not yet been selected as a favorite, it will
not appear by default on the Sugar Home View (F3). You need to either;

* type the name of your activity into the search entry and press enter; or,

* select the List View (ctrl+2) to see your activity, and click on it.

If all goes well, your activity will launch.

There are many opportunities to make mistakes. Don't get discouraged,
as debugging is a great way to learn. One useful tool is the Log
Activity, which will show you the log files of the operating system,
Sugar and activities. Alternatively, you can look at the log files
from the command line.

Log files are usually in the directory `~/.sugar/default/logs`.

Log files for *sugar-build* are in the directory `~/sugar-build/home/dotsugar/default/logs`.

Log files are named using the `bundle_id`.

You may also test interactively by starting Terminal, then `cd` to the activity directory, and type:

    sugar-activity .

### File structure

All activities should follow this file structure:

    MyActivity.activity/
    |-- activity/
    |   |-- activity.info
    |   `-- activity-icon.svg
    |-- activity.py
    `-- setup.py

* `activity/` contains information about your activity, including the
  `name`, `bundle_id`, and the `icon`.

* `activity.py` contains an instance of the activity class, which is
   run when your activity is launched.

* `setup.py` lets you install your activity or make an installable
   bundle with it.

### Translation

Sugar serves a global audience, so it is important to enable your
activity for internationalization and localization. A [guide to best
practices](https://wiki.sugarlabs.org/go/Translation_Team/i18n_Best_Practices)
is on our Wiki.

### Revision control your code

For development you can initialize the repository as a git
repository. This will help you to track your changes. First use [git
init](https://www.kernel.org/pub/software/scm/git/docs/git-init.html)
to initialize the repository:

    git init

With [git
status](https://www.kernel.org/pub/software/scm/git/docs/git-status.html)
you can show the available files in the folder they are still
untracked. Now add all the files in the directory and commit those
changes, you can use git status again to see the current state:

    git add .
    git commit -a -m 'Initial import'
    git status

We recommend that you use [github](http://github.com) to host your
activity.

### Ready to release

Once your activity is working, you can ask to have
your activity repository hosted under the [Sugar Labs github
organization](http://github.com/sugarlabs).

Make an XO bundle and upload it to
the Sugar Activity Library <http://activities.sugarlabs.org/> (ASLO).

    python setup.py dist_xo

After that, users of Sugar can download and install your activity.

For further releases, you should update the activity_version in
`activity/activity.info`.

More details
============

Documentation for our GTK+ 3.0 toolkit `sugar-toolkit-gtk3` is available
[here](https://developer.sugarlabs.org/sugar3/).

A Python GTK+ 3.0 tutorial is available
[here](http://python-gtk-3-tutorial.readthedocs.io/en/latest/).

You may read this book by James Simmons on how to make Sugar
activities, available at [Make Your Own Sugar Activities](https://flossmanuals.net/make-your-own-sugar-activities/).

# Coding standards

We currently use [Python Version 2.7](https://docs.python.org/2/) for
the Sugar toolkit and Sugar activity development.

We recommend [flake8](https://pypi.python.org/pypi/flake8) as a
wrapper around the [pep8](https://www.python.org/dev/peps/pep-0008/)
and [pyflakes](https://pypi.python.org/pypi/pyflakes) code checkers.
