Code style for Sugar HTML development
=====================================

General
-------

* Avoid lines longer than 80 characters.

* Don't use any form of minification (neither in js, html or css).
  All our source should be readable using the Sugar "View Source"
  feature.

Javascript
----------

* Make your code conform to JSHint (see Tools below).

* Use four spaces for indentation.

The js-beautify tool can be handy for the indentation part.

Here is a good reading about javascript code conventions
<http://javascript.crockford.com/code.html> .

For public and private members of an object, read
<http://javascript.crockford.com/private.html>.  To make the object
available in private members, keep a private variable named **that**:

    var that = this;


HTML and CSS
------------

* Use two spaces for indentation.  The rationale is that html tends to
  be very nested, and avoiding lines longer than 80 characters becomes
  difficult.

The js-beautify tool can be handy for indenting HTML and CSS as well.

Tools
-----

### JSHint

Use JSHint <http://jshint.com/> to check for errors and make the
source compatible with our coding conventions.

It comes as a command line tool and as an online tool as well.  The
online tool is at the homepage <http://jshint.com/> .

Install the jshint command:

    npm -g install jshint

Use the command like so:

    jshint js/main.js

Even better: add it to your editor to ease development.  There are
several plugins at <http://jshint.com/install/> .

### js-beautify

Use js-beautify <https://github.com/einars/js-beautify> to make the
sources compatible with our indentation conventions.

It comes as a command line tool and as an online tool as well.  The
online tool is at <http://jsbeautifier.org/> .

Install the js-beautify command:

    npm -g install js-beautify

Then you'll have the executable.  To clean javascript code:

    js-beautify --replace --good-stuff js/main.js

Warning: the --replace option will modify your source.  But you will
be safe if you are versioning it (we use git for Sugar HTML).

It can do HTML and CSS as well:

    js-beautify --type html --replace --indent-size 2 index.html

    js-beautify --type css --replace --indent-size 2 css/activity.css

Add it to your editor to ease development.  There are several plugins
at http://jsbeautifier.org/ .
