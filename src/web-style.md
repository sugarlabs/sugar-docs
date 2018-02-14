Code style for Sugar HTML development
=====================================

General
-------

* Avoid lines longer than 80 characters.

* Don't use any form of minification (neither in JS, HTML or CSS).
  All our source should be readable using the Sugar "View Source"
  feature.

### Javascript

* Make your code conform to JSHint. [See explanation below](#jshint).

* Use four spaces for indentation.

The js-beautify tool can be handy for the indentation part. [See
explanation below](#js-beautify).

Here is a good reading about javascript code conventions
<http://javascript.crockford.com/code.html> .

For public and private members of an object, read
<http://javascript.crockford.com/private.html>.  To make the object
available in private members, keep a private variable named **that**:

    var that = this;

### HTML

* Use two spaces for indentation.  The rationale is that HTML tends to
  be very nested, and avoiding lines longer than 80 characters becomes
  difficult.

The js-beautify tool can be handy for indenting HTML as well.

### CSS

* Use two spaces for indentation.

* Make it compliant with RECESS. [See explanation below](#recess).

Tools
-----

### </a>JSHint

Use JSHint <http://jshint.com/> to check for errors and make the
source compatible with our coding conventions.  The jshint command is
provided by sugar-build.

To check JavaScript code:

    jshint js/main.js

Add it to your editor to ease development.  There are several plugins
at <http://jshint.com/install/> .

### js-beautify

Use js-beautify <https://github.com/einars/js-beautify> to make the
sources compatible with our indentation conventions.  The js-beautify
command is provided by sugar-build.

To clean javascript code:

    js-beautify --replace --good-stuff js/main.js

Warning: the --replace option will modify your source.  But you will
be safe if you are versioning it (we use git for Sugar Web).

It can do HTML as well:

    js-beautify --type html --replace --indent-size 2 index.html

Add it to your editor to ease development.  There are several plugins
at <http://jsbeautifier.org/> .

### RECESS

RECESS <https://github.com/twitter/recess> keeps the order of CSS
rules following a convention, and protects us from different mistakes.
The recess command is provided by sugar-build.

To check CSS or LESS code:

    recess css/activity.css -noIDs false -noOverqualifying false

### Karma

If you are hacking on sugar-web, run the testsuit with the *karma* command inside a osbuild shell:

    karma start sugar-web/test/karma.conf.js

We encourage writting new unit tests for new features.

After you do the changes, run:

    check

It will run all the code checks and the unit tests making sure you won't break the build when your changes are pushed. 
If a test doesn't pass either your code needs to be fixed or the test need to be adapted.
