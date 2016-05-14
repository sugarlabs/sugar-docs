Write your own desktop activity
===============================

While the Sugar desktop can support acitivites written in a number of
different languages, including Smalltalk, JavaScript, et al., the
majority are written in Python and utilize the
[sugar-toolkit-gtk3](https://github.com/sugarlabs/sugar-toolkit-gtk3)
libraries. This document describes the basics for developing a Python
activity.

### Setting up the development environment

**osbuild** is the [Sugar build environment](dev-environment.md.html).
With **osbuild** you've got a full Sugar environment. It is the best
choice if you've enough knowledge to build your environment on GNU
Linux.

### Create a new activity from a template 

Once you have set up Sugar, you will have an **activities** directory
on your machine. (Where it is created depends upon how you set up
Sugar. With **osbuild**, it will be in:
directory, e.g.:

    ~/sugar-build/activities

Individual activities reside as subdirectory in the activities
directory. This is where you will build your new activity.

You can clone a copy of the Hello World activity from
[hello-world](https://github.com/manuq/hello-world.git)

    git clone https://github.com/manuq/hello-world.git activity-name.activity

Note that it is important to use the .activity suffix in the directory
name of your new activity.

### Customize

Your clone of the Hello World activity contains a file,
'activity/activity.info' that will need to be modified.

    [Activity]
    name = HelloWorld
    activity_version = 1
    bundle_id = org.sugarlabs.MyActivity.HelloWorld
    exec = sugar-activity activity.HelloWorldActivity
    icon = activity-helloworld
    licence = GPLv2+

Choose a name and unique bundle-id for your activity by editing the file.

    [Activity]
    name = MyActivityName
    activity_version = 1
    bundle_id = org.sugarlabs.MyActivity.MyActivityName
    exec = sugar-activity activity.HelloWorldActivity
    icon = activity-helloworld
    licence = GPLv2+

You'll also want to change the 'exec' field to reference the name of
the class in your 'activity.py' file, e.g., if you change Line 32:

    class HelloWorldActivity(activity.Activity):

to:

    class MyActivityActivity(activity.Activity):

then you need to change 'activity/activity.info' as follows:

    [Activity]
    name = MyActivityName
    activity_version = 1
    bundle_id = org.sugarlabs.MyActivity.MyActivityName
    exec = sugar-activity activity.MyActivityActivity
    icon = activity-helloworld
    licence = GPLv2+

You may also want to edit the Activity icon, found in
'activity/activity-helloworld.svg'.

![Activity
 Icon](https://github.com/manuq/hello-world/blob/master/activity/activity-helloworld.svg
 "Activity icon")

You can rename this file, as long as you make the corresponding edit
in the 'actvity.info' file.

Note that the Sugar Activity icon must follow the guidelines as
decribed in [The Sugar Interface:
Icons](https://wiki.sugarlabs.org/go/Human_Interface_Guidelines/The_Sugar_Interface/Icons).

There is a helper script, [Sugar
Iconify](https://wiki.sugarlabs.org/go/Sugar_iconify) that will help
you create Sugar-compliant icons.

Of course, the interesting changes will be the ones you make to the
activity itself. Below you will find some links to some resources
regarding some Activity devolepment details, but perhaps the best way
to get started is to modify an existing activity.

### Running your new activity

Launch Sugar and your new activity should be immediately available,
although since it has not been selected as a **favorite**, it will not
appear by default on the Sugar Home View. You need to select the
**List View** to see your activity's icon.

Click on the icon and, if all goes well, your activity will run!!!

Of course, there are many opportunities to make mistakes. Don't get
discouraged, as engaging in debugging is a great way to learn. One
useful tool is the Log Activity, which will show you the log files of
the system and individual activities. Alternatively, you can look at
the log files from the command line.

    ~/sugar-build/home/dotsugar/default/logs

### File structure

In your new activity, you will find the following file structure:

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

Now you are ready to go ahead and develop your activity in the html,
js and css files.

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

Before your first release, you should:

* make your activity unique in the Sugar interface by changing your
  activity icon activity/activity-icon.svg .  Or if you don't have
  graphics skills, you can ask in the community if someone can do it.

After that, on **osbuild** you can make an XO bundle and upload it to
the Sugar activities portal <http://activities.sugarlabs.org/> .

    python setup.py dist_xo

For further releases, you should update the activity_version in
`activity/activity.info`.

More details
============
You may follow this book by James Simmons on how to make Sugar
activities, available at:

    https://flossmanuals.net/make-your-own-sugar-activities/
