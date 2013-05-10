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
you can press ctrl+shift+I.
