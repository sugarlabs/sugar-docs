Code style for Sugar HTML development
=====================================
This document defines the code style guidelines for HTML-based Sugar
development. Following these conventions ensures consistency,
readability, and compatibility with Sugar’s “View Source” feature.
General
-------

* Avoid lines longer than 80 characters to improve readability,
  especially when viewing source code inside Sugar.

* Don't use any form of minification (neither in JS, HTML or CSS).
  All our source should be readable using the Sugar "View Source"
  feature.

### HTML

## HTML

* Use **two spaces** for indentation.
  HTML files are often deeply nested, and two spaces help keep lines
  under 80 characters.

* Do not minify HTML files.

### Helpful Tools
- `js-beautify` can be used to format and re-indent HTML code.

### CSS

* Use two spaces for indentation.

* Make it compliant with RECESS. [See explanation below](#recess).

### JavaScript

JavaScript code must follow the Sugar JavaScript style guide:
- [JavaScript Style Guide](./javascript-style.md)


Tools
-----

### RECESS

RECESS <https://github.com/twitter/recess> keeps the order of CSS
rules following a convention, and protects us from different mistakes.
The recess command is provided by sugar-build.

To check CSS or LESS code:

    recess css/activity.css -noIDs false -noOverqualifying false

### Karma

If you are hacking on sugar-web, run the test suite with the *karma* command inside a osbuild shell:

    karma start sugar-web/test/karma.conf.js

We encourage writing new unit tests for new features.

After you do the changes, run:

    check

It will run all the code checks and the unit tests making sure you won't break the build when your changes are pushed. 
If a test doesn't pass either your code needs to be fixed or the test need to be adapted.
