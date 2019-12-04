Code style for Sugar HTML development
=====================================

General
-------

* Avoid lines longer than 80 characters.

* Don't use any form of minification (neither in JS, HTML or CSS).
  All our source should be readable using the Sugar "View Source"
  feature.

### HTML

* Use two spaces for indentation.  The rationale is that HTML tends to
  be very nested, and avoiding lines longer than 80 characters becomes
  difficult.

The js-beautify tool can be handy for indenting HTML as well.

### CSS

* Use two spaces for indentation.

* Make it compliant with RECESS. [See explanation below](#recess).

### JavaScript

* The JavaScript style guide is [here](#javascript-style.md)

Tools
-----

### RECESS

RECESS <https://github.com/twitter/recess> keeps the order of CSS
rules following a convention, and protects us from different mistakes.
The recess command is provided by sugar-build.

To check CSS or LESS code:

    recess css/activity.css -noIDs false -noOverqualifying false

### Karma

If you are hacking on sugar-web, run the testsuit with the *karma* command inside a osbuild shell:

    karma start sugar-web/test/karma.conf.js

We encourage writing new unit tests for new features.

After you do the changes, run:

    check

It will run all the code checks and the unit tests making sure you won't break the build when your changes are pushed. 
If a test doesn't pass either your code needs to be fixed or the test need to be adapted.
