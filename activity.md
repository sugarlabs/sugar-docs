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

Now you should have a basic activity running! If you want to inspect
the code, you can press ctrl+shift+I while your Activity is running.

### Keeping Sugar libraries up to date

The activity depends on libraries like
[sugar-html-graphics](http://github.com/sugarlabs/sugar-html-graphics)
and [sugar-html-core](http://github.com/sugarlabs/sugar-html-core)
that provides the Sugar API and the Sugar look & feel.

This means that if there are changes in one of the modules you have to update
your local copy. You can do this with running the following command inside the
activity directory:

    volo add -f
