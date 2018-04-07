This page is a temporary place to coordinate the work pending to port
TamTam activities to Gtk3

NOTE: This is work in progress. To get a stable version of TamTam
activities use the sugar-0.94 branch

This work is based in the port done by Aaron Gordon (TamTamEdit) and
Kshitij Kumar (TamTamMini)

Objective
=========

Porting TamTam suite to Gtk3 we can add support to touch interfaces and
add a piano keyboard like in MusicKeyboard activity.

Plan
====

The first objective is port to Gtk3, without doing unneded changes on
the interface.

After that we can clean up the code, and implement changes.

TamTam use a lot of custom widgets. Use standard widgets when possible
simplify the code, and create a more standard

STATUS
======

TamTamEdit and TamTamMini start but not all the functionalities are
available.

TamTamJam starts, but need work in the canvas

PENDING TASKS
=============

-   Easy: pep8 cleaning
-   Easy: remove unused imports
-   Medium: The all the custom buttons (common/util/ThemeWidgets.py) use
    two images, almost equal but with a border to show the state. We can
    replace this by use only one image, and draw a border with cairo.
    Should be good use a testcase to check the differnt button types
    (gtn, radio btn, toggle btn). There are a lot of code duplicated
    here.
-   Medium: The vertical slider (ImageVScale) does not work.
-   Medium: Port TamTamJam
-   Medium/High: Port TamTamSynth
-   Medium: simplify code / remove unused code.
-   Easy: replace the use of Gtk.Tooltips (no longer available) by set
    the tooltip in every widget using widget.set\_tooltip\_text()
-   Easy: I don't know why, but in the code is very common the use of
    dictionaries to put and manipulate all the elements in the UI, this
    do the code over complicated and can be simplified a lot without
    loosing functionality.
-   Medium: add comments in the code
-   Medium: research commented features. Do you know TamTamMini have a
    record/play palette? I don't know if works, but there are code
    commented for that, and should be a good feature to have.

LONG TERM TASKS
===============

-   We need review functionalities, and check with the state of the art
    in modern tools. Later check how improve in low floor - high
    ceiling, and other Sugar Principies.

More information on porting activitiers to Gtk3
===============================================

<http://wiki.sugarlabs.org/go/Features/GTK3/Porting>
