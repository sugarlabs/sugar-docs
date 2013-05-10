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

Now you should have a basic activity running! If you want to inspect the code,
you can press ctrl+shift+i while your Activity is running.

The activity carries a copy of [sugar-html-graphics](http://github.com/sugarlabs/sugar-html-graphics) and
[sugar-html-core](http://github.com/sugarlabs/sugar-html-core). This is done to be able
to run the activity outside of Sugar.

This means that if there are changes in one of the modules you have to update
your local copy. You can do this with running the following command inside the
activity directory:

    volo -f updates
