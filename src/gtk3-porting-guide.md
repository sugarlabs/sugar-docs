# GTK+ 3 Porting Guide

Guide to porting Sugar Activities to GTK+ 3.

## GTK+

GTK+ is a library for creating graphical user interfaces.  GTK+ is written in C.  GTK+ for Python is a language binding.

* [GTK+](https://gtk.org/)

GTK+ 2 is the previous major version of GTK+.  GTK+ 2 for Python is a static binding, and is called PyGTK.  GTK+ 2 is soon to be obsolete and unavailable.

* [PyGTK](http://pygtk.org/)
* [GTK+ 2 Reference Manual](https://developer.gnome.org/gtk2/stable/)

GTK+ 3 is the current major version of GTK+.  It breaks both API and ABI compared with GTK+ 2.  GTK+ 3 for Python is a GObject Introspection binding, using PyGObject.

* [PyGObject](https://wiki.gnome.org/Projects/PyGObject)
* [PyGObject API Reference](https://lazka.github.io/pgi-docs/)
* [GTK+ 3 Reference Manual](https://developer.gnome.org/gtk3/stable/)

## Sugar Toolkit

Sugar Toolkit provides services and a set of GTK+ widgets to build activities and other Sugar components on Linux based computers using Python.

* [Sugar Toolkit for GTK+ 2](https://github.com/sugarlabs/sugar-toolkit), module name `sugar`, uses PyGTK,
* [Sugar Toolkit for GTK+ 3](https://github.com/sugarlabs/sugar-toolkit-gtk3), module name `sugar3`, uses PyGObject,
* [Sugar Toolkit for GTK+ 3 Documentation](https://developer.sugarlabs.org/sugar3)

## Sugar Activities

New Sugar activities are written in either;
* JavaScript using the [Sugar Web](https://github.com/sugarlabs/sugar-web) tools, or
* Python using GTK+ 3 and Sugar Toolkit for GTK+ 3,

Old Sugar activities were written in Python using GTK+ 2 and Sugar Toolkit for GTK+ 2.

These old activities are to be ported to GTK+ 3.  This guide explains how.

## Required Skills

* application development in Python,
* application development in GTK+ 2 and GTK+ 3, using the event loop model,
* Sugar activity development,
* use of PyGObject API libraries.

## How to Port to GTK+ 3

* [PyGObject - Porting from Static Bindings](http://pygobject.readthedocs.io/en/latest/guide/porting.html) part of the PyGObject documentation, focusing on Python,
* [PyGObject - Introspection Porting](http://live.gnome.org/PyGObject/IntrospectionPorting) on the GNOME Wiki, focusing on Python,
* [Migrating from GTK+ 2 to GTK+ 3](https://developer.gnome.org/gtk3/stable/gtk-migrating-2-to-3.html) part of the GTK+ documentation, focusing on the underlying C library and object classes, but is relevant to Python porting because the same classes are used.

## How to Port a Sugar Activity to GTK+ 3

* Quiesce the activity source by making sure the activity works properly before porting, closing any solved issues, merging any pull requests or branches and releasing the last GTK+ 2 version; see the activity [maintainer checklist](contributing.md#checklist---maintainer).

* Port to Sugar Toolkit for GTK+ 3 (see below),

* Port to GTK+ 3, using the [PyGObject script pygi-convert.sh](https://gitlab.gnome.org/GNOME/pygobject/blob/master/tools/pygi-convert.sh) to convert automatically much as it can.

* Port to any other libraries, such as Cairo, Pango, GConf to Gio.Settings, GStreamer 0.10 to GStreamer 1.0,

* Test and iterate until original functionality is reached.

Follow the [Code Guidelines](https://github.com/sugarlabs/sugar-docs/blob/master/src/contributing.md) during all porting.

Write any comments in the code, by adding **\# README:**, **\# TODO:** and **\# FIXME:** explaining what are the problems that you are having with that chunk of code. Put a link if it's necessary.

## Port to Sugar Toolkit for GTK+ 3

-   The namespace is changed from `sugar` to `sugar3`, which reflects
    that GTK+ 3 is the underlying technology, use a script to automate the rename of the imports `sugar` to
`sugar3`, [sugar-convert.sh](http://dev.laptop.org/~manuq/sugar-convert.sh),
-   The keep button has been removed
-   The old-style toolbar has been removed
-   `set_toolbar_box` is used instead of `set_toolbox`
-   Remove import of deprecated ActivityToolbox (see
    [hello-world](http://git.sugarlabs.org/hello-world/mainline/commit/22060a3063b2d6fd38d6b1cd8d44946170255af3))
-   Support for `service_name` and `class` tags in activity.info has
    been removed. Use `bundle_id` instead of `service_name` and `exec`
    instead of `class` (see in
    [Record](http://git.sugarlabs.org/record/mainline/commit/6e8968c71e474e2d8d86886badf5cf7d70217dc5))
-   `sugar3.activity.Activity` does not have the *window* attribute. Use
    the `.get_window()` method instead.

## Port to GTK+ 3

To start, change the importing instruction for GTK from

```python
import gtk
```

to

```python
import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk
```

Note that `require_version` needs to called only the first time when GTK
is being imported.

Similar imports that may be used are:
```python
from gi.repository import Gdk, Pango, Gobject
```
Then you have to change each call that involves GTK, for example
creating a button will look now like this:
```python
button = Gtk.Button()
```

A simple hello world program in GTK+ 3 looks like this:
```python
from gi.repository import Gtk

def _destroy_cb(widget, data=None):
    Gtk.main_quit()

w = Gtk.Window()
w.connect("destroy", _destroy_cb)
label = Gtk.Label('Hello World!')
w.add(label)
w.show_all()

Gtk.main()
```
The changes that were needed to port the hello-world activity can be
seen in [this
commit.](https://github.com/sugarlabs/hello-world/commit/508e1c518b56cbde5508e560c8a2ff38a3518583)

## Problems

Several common problems arise during a port.

### Simple example on creating a toolbar

A Sugar Activity has a toolbar.
These are the relevant modules required to create a simple toolbar containing the activity button and the stop button.

```python
from sugar3.activity import activity
from sugar3.graphics.toolbarbox import ToolbarBox
from sugar3.activity.widgets import ActivityToolbarButton
from sugar3.activity.widgets import StopButton
from sugar3.graphics.toolbarbox import ToolbarButton
from sugar3.graphics import style
```

Since the ActivityToolbar() module has been deprecated, the toolbar can
now be called using `ToolbarBox()`

Then, from the ToolbarBox(), include the ActivityButton and StopButton.
In order for the StopButton to be align to the right as per Sugar
activity interface, a separator has to be included as well.

```python
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
```

### Tools

If you are having trouble finding how a particular GTK
class/method/constant has been named in PyGI, run
[pygi-enumerate.py](http://dev.laptop.org/~dsd/20110806/pygi-enumerate.py)
and grep the output. (this app lists all identified methods and
constants). Usage example:
```shell
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
```

### Constructor considerations

With PyGI it is possible to use Python-like constructors, or “new”
functions e.g. the following are (usually) equivalent:

```python
label = Gtk.Button()
label = Gtk.Button.new()
```

However, the first form is preferred: it is more Python-like.
Internally, the difference is that `Gtk.Label.new()` translates to a call
to `gtk_label_new()`, whereas `Gtk.Label()` will
directly construct an instance of GtkLabel at the GObject level.

If the constructor takes parameters, they must be named. The
parameters correspond to GObject properties in the API documentation
which are usually marked as “Construct”. For example, the following code
will not work:
```python
expander = Gtk.Expander("my expander")
```
The (confusing) error is:
```shell
TypeError: GObject.__init__() takes exactly 0 arguments (1 given)
```

The solution is to go to the [GtkExpander API
documentation](http://developer.gnome.org/gtk3/3.2/GtkExpander.html#GtkExpander.properties)
and find the appropriate property that we wish to set. In this case it
is <b>label</b> (which is a Construct property, further increasing our
confidence of success), so the code should be:
```python
expander = Gtk.Expander(label="my expander")
```
Combining the two points above, if you wish to call a construct-like
function such as gtk\_button\_new\_with\_label(), you do have the option
of calling Gtk.Button.new\_with\_label(), however if we check the
[GtkButton
properties](http://developer.gnome.org/gtk3/3.2/GtkButton.html#GtkButton.properties)
we see one called "label" which is equivalent. Therefore
`gtk_button_new_with_label("foo")` should be called as:

```python
button = Gtk.Button(label="foo")
```
### HBox, VBox, pack\_start and pack\_end

GtkHBox and GtkVBox, commonly used containers in GTK+ 2 code, have
`pack_start` and `pack_end` methods. These take 4 parameters:

1.  **widget**: The widget to pack into the container
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
parameters are not optional: all 4 must be specified. Hence the
rules for adding in the extra parameters are:

1.  If `expand` was not set, use value True
2.  If `fill` was not set, use value True. (however, if expand is
    False, this parameter gets ignored so False is an equally acceptable
    option when expand=False)
3.  If `padding` was not set, use value 0.

These parameters can be specified either as positional arguments or as
named keyword arguments, however all 4 must always be specified. Some
developers prefer keyword arguments, arguing that the following:

```python
    box.pack_start(widget, expand=True, fill=False, padding=4)
```
is much more readable than:
```python
    box.pack_start(widget, True, False, 4)
```

If you are using `pack_start` with the default values (expand=True,
fill=True and padding=0), you can avoid using `pack_start` (and the
parameter pain that it brings with it) by just using .add for some added
cleanliness, e.g.
```python
    box.pack_start(widget, True, True, 0)
```
can be replaced with:
```python
    box.add(widget)
```

In GTK+ 3, `GtkVBox` and `GtkHBox` have been deprecated, which means they might be removed later. The replacement is to use `GtkBox` directly, and you may wish to
make this change now. e.g.:

```python
    vbox = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)
    hbox = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, homogeneous=True, spacing=8)
```
However, it must be noted that if `GtkBox` is used directly (instead of
using GtkHBox/GtkVBox), the default value of `expand` is now
`False`. The implications of this are:

1.  You need to check your .add() calls, as previously they would behave
    as `pack_start` with expand=True, but now they will behave as
    expand=False (you need to change them to use pack\_start with
    expand=True to retain the old behaviour)
2.  Every single `pack_start` call that has `expand=False` and `padding=0`
    (and any value of fill) can be converted to `.add()` for cleanliness

### GtkAlignment considerations

In PyGTK, the `gtk.Alignment` constructor takes four optional parameters:

1.  xalign: the fraction of horizontal free space to the left of the
    child widget. Ranges from 0.0 to 1.0. Default 0.0.
2.  yalign: the fraction of vertical free space above the child widget.
    Ranges from 0.0 to 1.0. Default 0.0.
3.  xscale: the fraction of horizontal free space that the child widget
    absorbs, from 0.0 to 1.0. Default 0.0.
4.  yscale: the fraction of vertical free space that the child widget
    absorbs, from 0.0 to 1.0. Default 0.0

In PyGI/GTK3, these parameters are still optional, however, the default values have changed. They are now:

1.  xalign: default 0.5
2.  yalign: default 0.5
3.  xscale: default 1
4.  yscale: default 1

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
```python
gtk.gdk.color_parse(color)
```
However, what we have to do now is:
```python
from gi.repository import Gdk
```
Then we can modify the code to the following:
```python
Gdk.color_parse(color)
```
### Pango

Following the release of GTK+ 3, we should not be importing pango like
this:
```python
import pango
```
In fact, we can now import pango as an attribute within the GTK+ 3
library:
```python
from gi.repository import Pango as pango
```
### Gio.Settings from GConf

Any use of GConf should be ported to Gio.Settings.

### Other considerations

`self.allocation` property is no longer available. `self.get_allocation()` should be used instead.

So to get the allocation size:
```python
self.allocation.width
self.allocation.height
```
should be replaced by:
```python
self.get_allocated_width()
self.get_allocated_height()
```
### Constants

Most of the constants have slightly different formats, e.g.,

 - `gtk.STATE_NORMAL` became `Gtk.StateFlags.NORMAL`
 - `gtk.RESPONSE_ACCEPT` became `Gtk.ResponseType.ACCEPT`
 - `gtk.JUSTIFY_CENTER` became `Gtk.Justification.CENTER`
 - `gtk.RELIEF_NONE` became `Gtk.ReliefStyle.NONE`

### Pixbufs

The pixbuf libraries are in their own repository
```python
from gi.repository import GdkPixbuf
GdkPixbuf.Pixbuf.new_from_file()
```
### Changes to the Clipboard

Two things to note:

1. You need to specify a clipboard using get()
```python
clipboard = Gtk.Clipboard.get(Gdk.SELECTION_CLIPBOARD)
```
2. You need to pass a length to set\_text()
```python
clipboard.set_text(string, len(string))
```
See [python-gtk-3-tutorial/clipboard](http://python-gtk-3-tutorial.readthedocs.org/en/latest/clipboard.html) for more details.

### Changes to Drag-and-Drop

Slightly different syntax:
```python
self.drag_dest_set(Gtk.DestDefaults.ALL, [],
                   Gdk.DragAction.COPY)
self.drag_dest_set_target_list(Gtk.TargetList.new([]))
self.drag_dest_add_text_targets()
self.connect('drag_data_received', self._drag_data_received)
```
and:
```python
data.get_text()
```
or:
```python
data.get_image()
```

See
[python-gtk-3-tutorial/drag_and_drop](http://python-gtk-3-tutorial.readthedocs.org/en/latest/drag_and_drop.html)
for more details.

### Port from Drawable to Cairo

GTK+ 3 does not support GTK Drawable objects, so the first step is to
get your activity running under Cairo.
```python
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
```

Pango is a bit different when used with Cairo:
```python
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
```
To draw a bitmap...
```python
# Again, from the xlib_surface...
cairo_context = cairo.Context(xlib_surface)

# Create a gtk context
cairo_context = gtk.gdk.CairoContext(cairo_context)
cairo_context.set_source_pixbuf(pixbuf, x, y)
cairo_context.rectangle(x, y, w, h)
cairo_context.fill()
```

To read a pixel from the xlib surface...
```python
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
```

### Port from Cairo in GTK+ 2 to Cairo in GTK+ 3

The Cairo/Pango interaction is a little different:

```python
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
```

The `get_extents()` method if different in PangoCairo. It calculates an
extent as a Rectangle, but doesn't return anything. There is a method,
`get_logical_extents()` that returns a Rectangle. Alas, it is not
necessarily available after v1.16. Note that Rectangle is not a list but
a class with methods for `get_x()`, `get_y()`, `get_width()`, and
`get_height()`, so you cannot iter over it.

Note that `cairo.Region` will no longer work in GTK+ 3

(For more detailes, see
<http://developer.gnome.org/pangomm/2.28/annotated.html>)

#### Replacing pixmaps with Cairo

You need to replace your pixmaps with Cairo in GTK+ 3.

### Taking a screenshot and making a thumbnail

To make a screenshot of the window:
```python
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
```

### Creating a video widget

Some necessary changes include:

Using
```python
get_property('window').get_xid()
```
Instead of
```python
window.xid
```
Using
```python
set_double_buffered(False)
set_app_paintable(True)
```
Instead of
```python
unset_flags(gtk.DOUBLE_BUFFERED)
set_flags(gtk.APP_PAINTABLE)
```

## Hacks to help in porting

### Use a virtual machine

Use an editor with remote file access to a virtual machine, such as emacs with tramp.

Start Terminal inside Sugar and then start Screen.  Change to the activity source directory.  Use an SSH client to reach into the Terminal shell to run `sugar-activity`.

### Use an iterative restarter

Temporarily add code to detect when your editor rewrites files.  For example in `activity.Activity.__init__`;
```
# testing restarter
ct = os.stat('file.py').st_ctime
def restarter():
    if os.stat('file.py').st_ctime != ct:
        self.close()
        return False
    return True
GObject.timeout_add(233, restarter)
```

### Use Extended Python debugger

`epdb` library is useful to inspect the code while the Activity is running.
```
sudo yum install python-epdb
```

You can put trace point in the code to stop and make tests by doing this:
```
import epdb;epdb.set_trace()
```
Finally I run Get Books Activity from the Terminal Activity to be able
to write some code on a shell. This is the command that I use:

```
sugar-launch org.laptop.sugar.GetBooksActivity
```

See also: [Development Team/Debugging](https://wiki.sugarlabs.org/go/Development_Team/Debugging)


### Check logs with multitail

multitail is really helpful for developing Sugar Activities. It can be used to read the latest log that an Activity wrote and see how it's growing.

For example, if we run an Activity three times it will create 3 different .log files behind ~/.sugar/default/logs directory. With multitail we will be seeing the most recent version of the activity log.

Install multitail using:
```shell
sudo yum install multitail
```

Show the proper log files
```shell
cd ~/.sugar/default/logs
multitail -iw "*<Activity Name>*" 1 -m 0
```
-iw is to inform to multitail about the input files and check for them every 1 second
-m is to let multitail know about the buffersize (0 is infinite)

### Use the pygobject code as example

[pygobject](https://live.gnome.org/PyGObject) is what we use to make
GTK+ 3 activities. So, it's really useful to take a look at the code
examples that are there. Even more, you can run some demo application
that show how to use something specific about the library.

-   Clone the code:
    ```
    git clone git://git.gnome.org/pygobject
    ```
-   Run an example
    ```shell
    cd pygobject
    cd demos/gtk-demo/demos
    python pixbuf.py
    ```
-   Grep the code to search for something useful
    ```shell
    cd pygobject
    git grep GdkPixbuf
    ```
### Monitoring DBus

Not sure how this command works, but it can give us an interesting
information. If you run this command and plug an USB drive you will see
useful information
```shell
dbus-monitor --system
```
## Port to Python 3

We are migrating towards Python 3. Python 3 does not support GTK+ 2.
Hence, once the activity is ported to GTK+ 3, please consider porting
the activity from Python 2 to Python 3.

Ref: [Guide to port activities to Python
3](python-porting-guide.md)

## Releasing Activities (For maintainers)

Once an activity is ported, a new release can be made. The major version
should be greater than the existing one.

Please follow
[this](contributing.md#checklist---maintainer)
guide for releasing a new version

## Notes

These are the changes noted by developers while porting activities

-   `Gtk.Widget.hide_all()` does not exist anymore. We should use just `.hide` [Ref](http://developer.gnome.org/gtk3/3.5/GtkWidget.html#gtk-widget-hide)
-   If the code creates some own object, and it defines some properties,
    you should use `__gproperties__` dictionary. [Ref](http://python-gtk-3-tutorial.readthedocs.org/en/latest/objects.html#GObject.GObject.__gproperties__)
-   `Gtk.ListStore` doesn't have the method `.reorder`. There is a
    [ticket](https://bugzilla.gnome.org/show_bug.cgi?id=677941) reported
    upstream about this.
-   I replaced the use of `dbus` by [Gio](http://developer.gnome.org/gio/unstable/pt02.html) to monitor (dis)connection of pen drives
-   Migrate custom signals:
    If you have defined custom gtk objects with custom signal you need to update them to [the new way](http://python-gtk-3-tutorial.readthedocs.org/en/latest/objects.html)
    You should replace this:

    ```python
    from gobject import signal_new, TYPE_INT, TYPE_STRING, TYPE_BOOLEAN, TYPE_PYOBJECT, TYPE_NONESIGNAL_RUN_LAST,     signal_new('extlistview-modified', gtk.TreeView,
    SIGNAL_RUN_LAST, TYPE_NONE, ())
    ```

    by adding the signal definition inside the object that you are creating using the `__gsignals__` dictionary like this (in this case Gtk.TreeView
    is the class that our object inherits):

    ```python
    from gi.repository
    import GObject
    class ExtListView(Gtk.TreeView):
    __gsignals__ = { 'extlistview-modified': (GObject.SignalFlags.RUN_LAST, None, ()), }
    ```

    The last argument of the signal definition are the
    argument types that the callback will receive.
-   Change the mouse cursor
    -   Example use case:
        When the activity is working and we want to show a work in progress cursor.
    -   Replace this:

        ```python
        self.window.set_cursor(gtk.gdk.Cursor(gtk.gdk.WATCH))
        ```

        with:

        ```python
        from gi.repository import Gdk
        self.get_window().set_cursor(Gdk.Cursor(Gdk.CursorType.WATCH))
        ```

## Resources

-   Python GTK+ 3 Tutorial: [<http://python-gtk-3-tutorial.readthedocs.org>](http://python-gtk-3-tutorial.readthedocs.org/)
-   PyGTK or GTK+ 2: <http://www.pygtk.org/docs/pygtk/>
-   Sugar Toolkit GTK+ 3 Documentation:
    <https://developer.sugarlabs.org/sugar3/>
-   GTK+ 3 Reference Manual <http://developer.gnome.org/gtk3/stable/>
-   OLPC Documentation:
    <http://wiki.laptop.org/go/Activities/PortingToGtk3>
-   Pango documentation: <http://developer.gnome.org/pangomm>
-   GStreamer-1.0 documentation:
    <http://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer/html/index.html>
-   GStreamer-1.0 porting hints:
    <https://wiki.ubuntu.com/Novacut/GStreamer1.0>

## Porting examples

### Here

- [Finance](gtk3-porting-examples/Finance.md)
- [Implode](gtk3-porting-examples/Implode.md)
- [InfoSlicer](gtk3-porting-examples/InfoSlicer.md)
- [Jukebox](gtk3-porting-examples/Jukebox.md)
- [Log](gtk3-porting-examples/Log.md)
- [Record](gtk3-porting-examples/Record.md)
- [Typing_Turtle](gtk3-porting-examples/Typing_Turtle.md)

### Other

-   [Biorhythm (GTK+ 3 and PangoCairo)](https://github.com/sugarlabs/biorhythm/commit/c16de3b70cce2cc6f8af933e2b062c844a47c144/)
-   [Peru Learns English (GTK+ 3 and GStreamer 1.0)](https://github.com/sugarlabs/peru-learns-english-activity/commit/caa2cde526b3823a5a1f7d200a76ad5bc3502b0e)
-   [Jump (GTK+ 3 and Sugargame)](https://github.com/sugarlabs/jump/commit/b75410d2879d9829df942726f5465b7cf5a9d98d)
-   [I know Madagascar (GTK+ 3 and Sugargame)](https://github.com/sugarlabs/iknowMadagascar/commit/5de78baca2daebe483bcc35912d254c77f2416f4)

