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
