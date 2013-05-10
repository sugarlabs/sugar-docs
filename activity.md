---
layout: default
title: Write an activity
---

Write your own HTML activity
============================

After you have [built](build.html) the development environment, enter the
source directory in a sugar-build shell

    make shell
    cd source

Create an activity based on the default template

    volo create my-activity ./sugar-html-template

Install the activity for development

    cd my-activity
    python setup.py dev

Now you should have a basic activity running!

### File structure

In your new activity, you will find the following file structure:

    my-activity/
    |-- activity/
    |   |-- activity.info
    |   `-- activity-icon.svg
    |-- index.html
    |-- css/
    |   `-- activity.css
    |-- js/
    |   |-- activity.js
    |   `-- loader.js
    |-- lib/
    |-- package.json
    `-- setup.py

* `activity/` contains information about your activity, including the
  name, ID, and the icon.

* `index.html` is where the elements that compose your activity are
  defined.  The template comes with a toolbar and a canvas where you
  can place your content.

* `js/activity.js` is where the logic of your activity lives.

* `css/activity.css` is where you add the styling of your activity.

Those are the files you'll modify.  The others are:

* `js/loader.js` configures the libraries paths and loads your
  `js/activity.js`

* `lib/` contains the libraries

* `package.json` contains information about the libraries the activity
  depends

* `setup.py` lets you install your activity or make an installable
  bundle with it

### First steps

First of all, set your activity name and bundle-id in
`activity/activity.info`, and also in the title tag of `index.html` .

After that, you can go ahead and develop your activity in the html, js
and css files.

### Debugging

If you want to inspect the code, you can press ctrl+shift+I while your
Activity is running.

### Keeping Sugar libraries up to date

The activity depends on libraries like
[sugar-html-graphics](http://github.com/sugarlabs/sugar-html-graphics)
and [sugar-html-core](http://github.com/sugarlabs/sugar-html-core)
that provides the Sugar API and the Sugar look & feel.

This means that if there are changes in one of the modules you have to update
your local copy. You can do this with running the following command inside the
activity directory:

    `volo add -f`

### Ready to release

Before your first release, you should:

* make your activity unique in the Sugar interface by changing your
  activity icon activity/activity-icon.svg .  Or if you don't have
  graphics skills, you can ask in the community if someone can do it.

After that, you can make an XO bundle and upload it to the Sugar
activities market <http://activities.sugarlabs.org/> .

    `python setup.py dist_xo`

For further releases, you should update the activity_version in
`activity/activity.info`.
