Code style for Sugar Python development
=======================================

General
-------

* Avoid lines longer than 79 characters.

Python

* Make your code conform to pep8 and pyflakes

* Use four spaces for indentation.

Tools
-----

### </a>JPyflakes

Use Pyflakes <https://pypi.org/project/pyflakes/> to check for errors and make the
source compatible with our coding conventions. The command is provided by sugar-build.

To check JavaScript code:

    python3 -m pyflakes

Libraries
---------

* New code should be written in Python 3, using GTK+ 3, GStreamer 1.0, etc

* Use json, ...

* Use [sugargame](https://github.com/sugarlabs/sugargame) when interfacing to pygames

Conventions
-----------

* Methods documentation should be "attached" to the methods (See http://www.python.org/dev/peps/pep-0257)
