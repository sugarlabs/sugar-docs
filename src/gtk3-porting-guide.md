Porting a GTK+ 2 activity to GTK+ 3
======================================

This is a guide to porting an existing activity from GTK+ 2 to [GTK+
3](http://developer.gnome.org/gtk3/stable/). It also shows the changes
to use the new Sugar toolkit that also now uses [GTK+
3](https://wiki.sugarlabs.org/go/Features/GTK3).

This guide uses the
[hello-world](https://github.com/sugarlabs/hello-world) activity as a
simple example.

Here are some instances of porting activities, for reference:

-   [Biorhythm](https://github.com/sugarlabs/biorhythm/commit/c16de3b70cce2cc6f8af933e2b062c844a47c144/)
-   [Peru Learns English, includes GStreamer and GST
    update](https://github.com/sugarlabs/peru-learns-english-activity/commit/caa2cde526b3823a5a1f7d200a76ad5bc3502b0e)
-   [Port of Jump
    Activity](https://github.com/sugarlabs/jump/commit/b75410d2879d9829df942726f5465b7cf5a9d98d)
-   [Port of
    I-know-Madagascar](https://github.com/sugarlabs/iknowMadagascar/commit/44ba42645ac4fcd9e06b4add7fa3b6ce2e0d9c3d)

Steps to Port an Activity to GTK+ 3
===================================

1.  Read the [Sugar Official
    Wiki](http://wiki.sugarlabs.org/go/Features/GTK3)
2.  Resolve any existing pull requests before porting to avoid conflicts
    at a later stage.
3.  Run this
    [script](http://git.gnome.org/browse/pygobject/tree/pygi-convert.sh)
    that will convert automatically things as much as it can. This is to
    avoid some stressful manually conversions that a “simple script” can
    do using *sed* :)
4.  Follow the [Code
    Guidelines](Development_Team/Code_guidelines "wikilink") during all
    the porting process
5.  Make the API changes in sugar-toolkit-gtk3
6.  Write comments on the code, by adding **\# README:**, **\# TODO:**
    and **\# FIXME:** explaining what are the problems that you are
    having with that chunk of code. Put a link if it's necessary

API changes in sugar-toolkit
----------------------------

-   The namespace is changed from `sugar` to `sugar3`, trying to reflect
    that GTK+ 3 is the underlying technology.
-   The keep button has been removed
-   The old-style toolbar has been removed
-   `set_toolbar_box` is used instead of `set_toolbox` (see in
    [Abacus](http://git.sugarlabs.org/~walter/abacus/walter-cairo/commit/6871dd340a89ade3b5361457e1bd1d58276a8efc))
-   Remove import of deprecated ActivityToolbox (see
    [hello-world](http://git.sugarlabs.org/hello-world/mainline/commit/22060a3063b2d6fd38d6b1cd8d44946170255af3))
-   Support for `service_name` and `class` tags in activity.info has
    been removed. Use `bundle_id` instead of `service_name` and `exec`
    instead of `class` (see in
    [Record](http://git.sugarlabs.org/record/mainline/commit/6e8968c71e474e2d8d86886badf5cf7d70217dc5))
-   `sugar3.activity.Activity` does not have the *window* attribute. Use
    the `.get_window()` method instead.

Port the activity from GTK+ 2 to GTK+ 3
---------------------------------------

To start, change the importing instruction for GTK from

`import gtk`

to

`import gi`\
`gi.require_version('Gtk', '3.0')`\
`from gi.repository import Gtk`

Note that `require_version` needs to called only the first time when GTK
is being imported.

Similar imports that may be used are:

    from gi.repository import Gdk, Pango, Gobject

Then you have to change each call that involves GTK, for example
creating a button will look now like this:

`button = Gtk.Button()`

A simple hello world program in GTK+ 3 looks like this:

    from gi.repository import Gtk

    def _destroy_cb(widget, data=None):
        Gtk.main_quit()

    w = Gtk.Window()
    w.connect("destroy", _destroy_cb)
    label = Gtk.Label('Hello World!')
    w.add(label)
    w.show_all()

    Gtk.main()

The changes that were needed to port the hello-world activity can be
seen in [this
commit.](https://github.com/sugarlabs/hello-world/commit/508e1c518b56cbde5508e560c8a2ff38a3518583)

#### Simple example on creating a toolbar

One of Sugar's activity most unique user interface includes the toolbar.
In order to reference the relevant modules and graphics, the sugar3
library has to be imported. These are the relevant ones that would
enable us to create a simple toolbar containing the activity button and
the stop button.

    from sugar3.activity import activity
    from sugar3.graphics.toolbarbox import ToolbarBox
    from sugar3.activity.widgets import ActivityToolbarButton
    from sugar3.activity.widgets import StopButton
    from sugar3.graphics.toolbarbox import ToolbarButton
    from sugar3.graphics import style

Since the ActivityToolbar() module has been deprecated, the toolbar can
now be called using

`ToolbarBox()`

Then, from the ToolbarBox(), include the ActivityButton and StopButton.
In order for the StopButton to be align to the right as per Sugar
activity interface, a separator has to be included as well.

    toolbar_box = ToolbarBox()

    activity_button = ActivityToolbarButton(self)
    toolbar_box.toolbar.insert(activity_button, 0)
    activity_button.show()

    separator = Gtk.SeparatorToolItem()
    separator.props.draw = False
    separator.set_expand(True)
    toolbar_box.toolbar.insert(separator, -1)
    separator.show()

    stop_button = StopButton(self)
    toolbar_box.toolbar.insert(stop_button, -1)
    stop_button.show()
    self.set_toolbar_box(toolbar_box)
    toolbar_box.show()

### Tools

There are tools to help you do the porting. There is a script in the
pygobject repository for porting called
[pygi-convert.sh](http://git.gnome.org/browse/pygobject/tree/pygi-convert.sh),
more info about the script can be found in [the PyGObject Introspection
Porting guide](http://live.gnome.org/PyGObject/IntrospectionPorting).

Here is a script to automate the rename of the imports **sugar** to
**sugar3**:
[sugar-convert.sh](http://dev.laptop.org/~manuq/sugar-convert.sh).

If you are having trouble finding how a particular GTK
class/method/constant has been named in PyGI, run
[pygi-enumerate.py](http://dev.laptop.org/~dsd/20110806/pygi-enumerate.py)
and grep the output. (this app lists all identified methods and
constants). Usage example:

    $ python pygi-enumerate.py | grep get_selection
    Gtk.AccelLabel.get_selection_bounds() (instance method)
    Gtk.Editable.get_selection_bounds() (instance method)
    Gtk.Entry.get_selection_bounds() (instance method)
    Gtk.IconView.get_selection_mode() (instance method)
    Gtk.Label.get_selection_bounds() (instance method)
    Gtk.SelectionData.get_selection() (instance method)
    Gtk.SpinButton.get_selection_bounds() (instance method)
    Gtk.TextBuffer.get_selection_bound() (instance method)
    Gtk.TextBuffer.get_selection_bounds() (instance method)
    Gtk.TreeView.get_selection() (instance method)

### Constructor considerations

With PyGI it is possible to use Python-like constructors, or “new”
functions e.g. the following are (usually) equivalent:

`label = Gtk.Button()`\
`label = Gtk.Button.new()`

However, the first form is preferred: it is more Python-like.
Internally, the difference is that Gtk.Label.new() translates to a call
to gtk\_label\_new(), whereas Gtk.Label() (the preferred form) will
directly construct an instance of GtkLabel at the GObject level.

If the constructor takes parameters, they **must** be named. The
parameters correspond to GObject properties in the API documentation
which are usually marked as “Construct”. For example, the following code
will not work:

`expander = Gtk.Expander(`“`my`` ``expander`”`)`

The (confusing) error is:

`TypeError: GObject.__init__() takes exactly 0 arguments (1 given)`

The solution is to go to the [GtkExpander API
documentation](http://developer.gnome.org/gtk3/3.2/GtkExpander.html#GtkExpander.properties)
and find the appropriate property that we wish to set. In this case it
is <b>label</b> (which is a Construct property, further increasing our
confidence of success), so the code should be:

`expander = Gtk.Expander(label=`“`my`` ``expander`”`)`

Combining the two points above, if you wish to call a construct-like
function such as gtk\_button\_new\_with\_label(), you do have the option
of calling Gtk.Button.new\_with\_label(), however if we check the
[GtkButton
properties](http://developer.gnome.org/gtk3/3.2/GtkButton.html#GtkButton.properties)
we see one called “label” which is equivalent. Therefore
gtk\_button\_new\_with\_label(“foo”) should be called as:

`button = Gtk.Button(label=`“`foo`”`)`

### HBox, VBox, pack\_start and pack\_end

GtkHBox and GtkVBox, commonly used containers in GTK+ 2 code, have
pack\_start and pack\_end methods. These take 4 parameters:

1.  The widget to pack into the container
2.  **expand**: Whether the child should receive extra space when the
    container grows (default True)
3.  **fill**: True if space given to child by the expand option is
    actually allocated to child, rather than just padding it. This
    parameter has no effect if expand is set to False. A child is always
    allocated the full height of a gtk.HBox and the full width of a
    gtk.VBox. This option affects the other dimension. (default True)
4.  **padding**: extra space in pixels to put between child and its
    neighbor (default 0)

In PyGTK, the expand, fill and padding parameters were optional: if
unspecified, the default values above were used. In PyGI, these
parameters are **not** optional: all 4 must be specified. Hence the
rules for adding in the extra parameters are:

1.  If **expand** was not set, use value True
2.  If **fill** was not set, use value True. (however, if expand is
    False, this parameter gets ignored so False is an equally acceptable
    option when expand=False)
3.  If **padding** was not set, use value 0.

These parameters can be specified either as positional arguments or as
named keyword arguments, however all 4 must always be specified. Some
developers prefer keyword arguments, arguing that the following:

    box.pack_start(widget, expand=True, fill=False, padding=4)

is much more readable than:

    box.pack_start(widget, True, False, 4)

However, these functions are called extremely often; any mildly seasoned
GTK developer will have memorized the order and meaning of the
parameters. Some developers therefore prefer to avoid the extra work of
dropping in hundreds of keyword arguments throughout the code and just
use the positional ones. This is really up to you.

If you are using pack\_start with the default values (expand=True,
fill=True and padding=0), you can avoid using pack\_start (and the
parameter pain that it brings with it) by just using .add for some added
cleanliness, e.g.

    box.pack_start(widget, True, True, 0)

can be replaced with:

    box.add(widget)

This is as far as you need to go for now. However, in GTK+ 3, GtkVBox
and GtkHBox have been deprecated, which means they might be removed in
GTK+ 3. The replacement is to use GtkBox directly, and you may wish to
make this change now. e.g.:

    vbox = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)

    hbox = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, homogeneous=True, spacing=8)

However, it must be noted that if GtkBox is used directly (instead of
using GtkHBox/GtkVBox), the default value of **expand** is now
**False**. The implications of this are:

1.  You need to check your .add() calls, as previously they would behave
    as pack\_start with expand=True, but now they will behave as
    expand=False (you need to change them to use pack\_start with
    expand=True to retain the old behaviour)
2.  Every single pack\_start call that has expand=False and padding=0
    (and any value of fill) can be converted to .add() for cleanliness

### GtkAlignment considerations

In PyGTK, the gtk.Alignment constructor takes four optional parameters:

1.  xalign: the fraction of horizontal free space to the left of the
    child widget. Ranges from 0.0 to 1.0. Default value 0.0.
2.  yalign: the fraction of vertical free space above the child widget.
    Ranges from 0.0 to 1.0. Default value 0.0.
3.  xscale: the fraction of horizontal free space that the child widget
    absorbs, from 0.0 to 1.0. Default value 0.0.
4.  yscale: the fraction of vertical free space that the child widget
    absorbs, from 0.0 to 1.0. Default value 0.0

In PyGI/GTK3, these parameters are still optional when used in the
Gtk.Alignment constructor (as keyword arguments, as explained above).
However, the default values have changed. They are now:

1.  xalign: default value 0.5
2.  yalign: default value 0.5
3.  xscale: default value 1
4.  yscale: default value 1

If your code was relying on the default value of 0 for any of these
parameters in PyGTK, you will now need to explicitly specify that in
your constructor. Similarly, if you were previously using construction
parameters to select the now-default values, those parameters can be
dropped.

Additionally, PyGTK accepted these construction parameters as positional
arguments. As explained above, they must now be converted to keyword
arguments.

### Gtk Menu Popup

The Gtk.Menu.popup function now works slightly differently. The user
supplied positioning function now takes different parameters. These are
menu, x, y, push\_in and user\_data.

### Gdk

Previously, gdk was an attribute of the GTK module, which means that it
can be called through GTK. For example, if we want to use
color\_parse():

`gtk.gdk.color_parse(color)`

However, what we have to do now is:

`from gi.repository import Gdk`

Then we can modify the code to the following:

`Gdk.color_parse(color)`

### Pango

Following the release of GTK+ 3, we should not be importing pango like
this:

`import pango`

In fact, we can now import pango as an attribute within the GTK+ 3
library:

`from gi.repository import Pango as pango`

### Gio.Settings from GConf

Any use of GConf should be ported to Gio.Settings.

### Other considerations

*self.allocation* property is no longer available. Please search your
code for “self.allocation” and replace it for “self.get\_allocation()”.

So to get the allocation size:

`self.allocation.width`\
`self.allocation.height`

should be replaced by:

`self.get_allocated_width()`\
`self.get_allocated_height()`

### Constants

Most of the constants have slightly different formats, e.g.,

gtk.STATE\_NORMAL became Gtk.StateFlags.NORMAL gtk.RESPONSE\_ACCEPT
became Gtk.ResponseType.ACCEPT gtk.JUSTIFY\_CENTER became
Gtk.Justification.CENTER gtk.RELIEF\_NONE became Gtk.ReliefStyle.NONE

### Pixbufs

The pixbuf libraries are in their own repository

`from gi.repository import GdkPixbuf`

`GdkPixbuf.Pixbuf.new_from_file()`

### Changes to the Clipboard

Two things to note:

1\. You need to specify a clipboard using get()

`   clipboard = Gtk.Clipboard.get(Gdk.SELECTION_CLIPBOARD)`

2\. You need to pass a length to set\_text()

`   clipboard.set_text(string, len(string))`

See
[1](http://python-gtk-3-tutorial.readthedocs.org/en/latest/clipboard.html)
for more details.

### Changes to Drag-and-Drop

Slightly different syntax:

`       self.drag_dest_set(Gtk.DestDefaults.ALL, [],`\
`                          Gdk.DragAction.COPY)`\
`       self.drag_dest_set_target_list(Gtk.TargetList.new([]))`\
`       self.drag_dest_add_text_targets()`\
`       self.connect('drag_data_received', self._drag_data_received)`

and:

`       data.get_text()`

or:

`       data.get_image()`

See
[2](http://python-gtk-3-tutorial.readthedocs.org/en/latest/drag_and_drop.html)
for more details.

### Going from Drawable to Cairo

GTK+ 3 does not support GTK Drawable objects, so the first step is to
get your activity running under Cairo.

    import cairo

    # From activity.Activity, you inherit a canvas.
    # Create a Cairo context from the window.
    cairo_context = self.canvas.get_window().cairo_create()

    # Create an XLib surface to be used for drawing
    xlib_surface = surface.create_similar(cairo.CONTENT_COLOR,
                                          gtk.gdk.screen_width(),
                                          gtk.gdk.screen_height())

    # You'll need a Cairo context from which you'll build a GTK Cairo context
    cairo_context = cairo.Context(xlib_surface)
    cairo_context = gtk.gdk.CairoContext(cairo_context)

    # Use this context as you would a Drawable, substituting Cairo commands
    # for gtk commands, e.g.,
    cairo_context.move_to(0, 0)
    cairo_context.line_to(100, 100)
    # Cairo uses floats from 0 to 1 for RGB values
    cairo_context.set_source_rgb(r, g, b)
    cairo_context.rectangle(x, y, w, h)
    cairo_context.fill()

    # To invalidate a region to force a refresh, use:
    self.canvas.queue_draw_area(x, y, w, h)

    # Handle the expose event
    # "expose" became "draw" for the cairo signal
    def do_expose_event(self, event):
        # Create the cairo context
        cairo_context = self.canvas.get_window().cairo_create()
        cairo_context.rectangle(event.area.x, event.area.y,
                                event.area.width, event.area.height)
        cairo_context.clip()
        cairo_context.set_source_surface(xlib_surface)
        cairo_context.paint()

Pango is a bit different when used with Cairo:

    import pango, pangocairo

    # Again, from the xlib_surface...
    cairo_context = cairo.Context(xlib_surface)

    # Create a PangoCairo context
    cairo_context = pangocairo.CairoContext(cairo_context)

    # The pango layout is created from the Cairo context
    pango_layout = cairo_context.create_layout()

    # You still use pango to set up font descriptions.
    fd = pango.FontDescription('Sans')
    fd.set_size(12 * pango.SCALE)

    # Tell your pango layout about your font description
    pango_layout.set_font_description(fd)

    # Write text to your pango layout
    pango_layout.set_text('Hello world', -1)

    # Position it within the Cairo context
    cairo_context.save()
    cairo_context.translate(x, y)
    cairo_context.rotate(pi / 3)  # You can rotate text and images in Cairo
    cairo_context.set_source_rgb(1, 0, 0)

    # Finally, draw the text
    cairo_context.update_layout(pango_layout)
    cairo_context.show_layout(pango_layout)
    cairo_context.restore()

To draw a bitmap...

    # Again, from the xlib_surface...
    cairo_context = cairo.Context(xlib_surface)

    # Create a gtk context
    cairo_context = gtk.gdk.CairoContext(cairo_context)
    cairo_context.set_source_pixbuf(pixbuf, x, y)
    cairo_context.rectangle(x, y, w, h)
    cairo_context.fill()

To read a pixel from the xlib surface...

    # create a new 1x1 cairo surface
    cairo_surface = cairo.ImageSurface(cairo.FORMAT_RGB24, 1, 1);
    cairo_context = cairo.Context(cairo_surface)
    # translate xlib_surface so that target pixel is at 0, 0
    cairo_context.set_source_surface(xlib_surface, -x, -y)
    cairo_context.rectangle(0,0,1,1)
    cairo_context.set_operator(cairo.OPERATOR_SOURCE)
    cairo_context.fill()
    cairo_surface.flush() # ensure all writing is done
    # Read the pixel
    return (ord(pixels[2]), ord(pixels[1]), ord(pixels[0]), 0)

### Going from Cairo in GTK-2 to Cairo in GTK-3

(For more detailes, see
<http://developer.gnome.org/pangomm/2.28/annotated.html>)

The Cairo/Pango interaction is a little different:

    from gi.repository import Pango, PangoCairo

    cairo_context = ...
    pango_layout = PangoCairo.create_layout(cairo_context)
    fd = Pango.FontDescription('Sans')
    fd.set_size(12 * Pango.SCALE)
    pango_layout.set_font_description(fd)
    pango_layout.set_text('Hello World', -1)
    cairo_context.set_source_rgb(1, 0, 0)
    PangoCairo.update_layout(cairo_context, pango_layout)
    PangoCairo.show_layout(cairo_context, pango_layout)

The get\_extents() method if different in PangoCairo. It calculates an
extent as a Rectangle, but doesn't return anything. There is a method,
get\_logical\_extents() that returns a Rectangle. Alas, it is not
necessarily available after v1.16. Note that Rectangle is not a list but
a class with methods for get\_x(), get\_y(), get\_width(), and
get\_height(), so you cannot iter over it.

Note that the <samp>cairo.Region</samp> will no longer work in GTK+3

#### Replacing pixmaps with Cairo

You need to replace your pixmaps with Cairo in GTK+ 3. For an example on
how this is done, see:
<http://developer.gnome.org/gtk3/3.5/ch24s02.html#idp129615008>

### Taking a screenshot and making a thumbnail

To make a screenshot of the window:

    width, height = window.get_width(), window.get_height()
    thumb_surface = Gdk.Window.create_similar_surface(window,
                                                      cairo.CONTENT_COLOR,
                                                      width, height)

    thumb_width, thumb_height = style.zoom(100), style.zoom(80)
    cairo_context = cairo.Context(thumb_surface)
    thumb_scale_w = thumb_width * 1.0 / width
    thumb_scale_h = thumb_height * 1.0 / height
    cairo_context.scale(thumb_scale_w, thumb_scale_h)
    Gdk.cairo_set_source_window(cairo_context, window, 0, 0)
    cairo_context.paint()
    thumb_surface.write_to_png(png_path_or_filelike_object)

### Creating a video widget

Some necessary changes include:

Using

`get_property('window').get_xid()`

Instead of

`window.xid`

Using

`set_double_buffered(False)`\
`set_app_paintable(True)`

Instead of

`unset_flags(gtk.DOUBLE_BUFFERED)`\
`set_flags(gtk.APP_PAINTABLE)`

Hacks to help in porting
========================

### Use the same keyboard and mouse

If you have an XO, I'm sure you want to take a look at
[this](User:Humitos/x2x "wikilink")...

### Use Extended Python debugger

**epdb** library is useful to inspect the code while the Activity is
running.

`sudo yum install python-epdb`

After that I put some trace point in the code where I can stop and make
my tests by doing this:

`import epdb;epdb.set_trace()`

Finally I run Get Books Activity from the Terminal Activity to be able
to write some code on a shell. This is the command that I use:

`sugar-launch org.laptop.sugar.GetBooksActivity`

See also [Development
Team/Debugging](Development_Team/Debugging "wikilink").

### Check logs with *multitail*

Here is a really useful command to open new logs automatically:
<User:Humitos/MultiTail>

### Use the pygobject code as example

[pygobject](https://live.gnome.org/PyGObject) is what we use to make
GTK+ 3 activities. So, it's really useful to take a look at the code
examples that are there. Even more, you can run some demo application
that show how to use something specific about the library.

-   Clone the code:

`git clone `[`git://git.gnome.org/pygobject`](git://git.gnome.org/pygobject)

-   Run an example

`cd pygobject`\
`cd demos/gtk-demo/demos`\
`python pixbuf.py`

-   Grep the code to search for something useful

`cd pygobject`\
`git grep GdkPixbuf`

### Monitoring DBus

Not sure how this command works, but it can give us an interesting
information. If you run this command and plug an USB drive you will see
useful information

`dbus-monitor --system`

Port to Python 3
================

We are migrating towards Python 3. Python 3 does not support GTK+ 2.
Hence, once the activity is ported to GTK+ 3, please consider porting
the activity from Python 2 to Python 3.

Ref: [Guide to port activities to Python
3](python-porting-guide)

Releasing activities (for maintainers)
======================================

Once an activity is ported, a new release can be made. The major version
should be greater than the existing one.

Please follow
[this](https://github.com/sugarlabs/sugar-docs/blob/master/src/contributing.md#checklist---maintainer)
guide for releasing a new version

Notes
=====

These are the changes implemented by developers while porting activities

-   `Gtk.Widget.hide_all()` does not exist anymore. We should use just
    `.hide`
    -   Ref:
        <http://developer.gnome.org/gtk3/3.5/GtkWidget.html#gtk-widget-hide>

<!-- -->

-   If the code creates some own object, and it defines some properties,
    you should use **\_\_gproperties\_\_** dictionary:
    <http://python-gtk-3-tutorial.readthedocs.org/en/latest/objects.html#GObject.GObject.__gproperties__>
-   `Gtk.ListStore` doesn't have the method **.reorder**. There is a
    [ticket](https://bugzilla.gnome.org/show_bug.cgi?id=677941) reported
    upstream about this.
-   I replaced the use of `dbus` by
    [Gio](http://developer.gnome.org/gio/unstable/pt02.html) to monitor
    the (dis)connection of pen drives
-   Migrate custom signals:
    -   If you have defined custom gtk objects with custom signal you
        should migrate them to [the new
        way](http://python-gtk-3-tutorial.readthedocs.org/en/latest/objects.html)
        to do this. You should replace this: from gobject import
        signal\_new, TYPE\_INT, TYPE\_STRING, TYPE\_BOOLEAN, \\
        TYPE\_PYOBJECT, TYPE\_NONE, SIGNAL\_RUN\_LAST
        signal\_new('extlistview-modified', gtk.TreeView,
        SIGNAL\_RUN\_LAST, TYPE\_NONE, ()) by adding the signal
        definition inside the object that you are creating using the
        `__gsignals__` dictionary like this (in this case Gtk.TreeView
        is the class that our object inherits): from gi.repository
        import GObject class ExtListView(Gtk.TreeView): \_\_gsignals\_\_
        = { 'extlistview-modified': (GObject.SignalFlags.RUN\_LAST,
        None, ()), } The last argument of the signal definition are the
        argument types that the callback will receive.
-   Change the mouse cursor
    -   Example use case: When the activity is working and we want to
        show a *work in progress* cursor.
    -   Replace this:

`self.window.set_cursor(gtk.gdk.Cursor(gtk.gdk.WATCH))`

with:

`from gi.repository import Gdk`\
`self.get_window().set_cursor(Gdk.Cursor(Gdk.CursorType.WATCH))`

Resources
=========

-   PyGI Documentation: <https://lazka.github.io/pgi-docs/>
-   PYGTK documentation
    -   GTK+ 3:
        [<http://python-gtk-3-tutorial.readthedocs.org>](http://python-gtk-3-tutorial.readthedocs.org/)
    -   GTK+ 2: <http://www.pygtk.org/docs/pygtk/>
-   Reference Manual
    -   GTK+ 3: <http://developer.gnome.org/gtk3/3.4/>
-   Gdk documentation:
    -   Gdk3: <http://developer.gnome.org/gdk/2.24/>
-   OLPC Documentation:
    <http://wiki.laptop.org/go/Activities/PortingToGTK+ 3>
-   Used to know the arguments of `GdkPixbuf.Pixbuf.save_to_bufferv`
    <https://mail.gnome.org/archives/javascript-list/2011-March/msg00001.html>

<!-- -->

-   Pango documentation: <http://developer.gnome.org/pangomm>

<!-- -->

-   Gst-1.0 documentation:
    <http://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer/html/index.html>

<!-- -->

-   Gst-1.0 porting hints:
    <https://wiki.ubuntu.com/Novacut/GStreamer1.0>

More porting examples
=====================

- [Finance](gtk3-porting-examples/Finance.md)
- [Implode](gtk3-porting-examples/Implode.md)
- [InfoSlicer](gtk3-porting-examples/InfoSlicer.md)
- [Jukebox](gtk3-porting-examples/Jukebox.md)
- [Log](gtk3-porting-examples/Log.md)
- [Record](gtk3-porting-examples/Record.md)
- [Typing_Turtle](gtk3-porting-examples/Typing_Turtle.md)
