Improving this documentation
============================

Have you found an error in these docs, or want to improve them?
Please [contact us](contact.md.html) or directly send pull requests to
the [GitHub repository](https://github.com/sugarlabs/sugar-docs).

This documentation lives in <http://developer.sugarlabs.org>.

Contributing
------------

Inside sugar-build you will find the directory with the sources:
sugar-docs.  They are Markdown files.

Compile them running 'docs'.

<pre><code language='sh'>
docs
</code></pre>

Fire a local HTTP server to see them:

<pre><code language='sh'>
cd build/out/docs/
python -m SimpleHTTPServer
</code></pre>

Contributing images
-------------------

* Make them 600px width, or less.

* You may need to highlight parts of the image.  Use color yellow (rgb
  255, 255, 0) at 30% opacity, in a layer with Multiply mode, over the
  screenshot layer.

* Code screenshots: use gedit and default GNOME theme to make them.

Tests
-------------------

To write tests, a `tests` folder must be made inside the bundle path of your activity. Inside that directory, there can be a `unit` and a `integration` subfolders. The unit test folder is supposed to contain tests. The test files begin with `test_`, so that modules you have made for convenience testing do not get executed uselessly.
Similarly the integration test folder contains UI tests starting with `test_`

Python's inbuilt unittest module is used for unit tests and a extended
version of unittest is used for UI tests.

These tests can be executed using `./setup.py check`
setup.py also takes a optional argument of which set of tests to run
```sh
./setup.py check integration
./setup.py check unit
```
