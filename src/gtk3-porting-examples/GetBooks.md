This page is being performed while I'm porting Get Books Activity to
Gtk3.

There is a [ticket](http://bugs.sugarlabs.org/ticket/3681) with some
useful information that I'm using on the porting and to keep tracking
this port. Besides, this wiki page will be useful to write some code
snippets about what are the difficulties that I'm having on the port and
maybe can be useful for someone else.

Steps that you should follow to Port an Activity to Gtk3
========================================================

1.  Read the [Sugar Official
    Wiki](http://wiki.sugarlabs.org/go/Features/GTK3)
2.  Read the [specific Sugar Wiki
    Page](http://wiki.sugarlabs.org/go/Features/GTK3/Porting) that talks
    about how to porting. Please, follow those steps and if you have a
    suggestion about the process you can contact with us and let us
    know.
3.  Comment on IRC about the Activity that you are going to Port
    (\#sugar on irc.freenode.net)
4.  Run this
    [script](http://git.gnome.org/browse/pygobject/tree/pygi-convert.sh)
    that will convert automatically things as much as it can. This is to
    avoid some stressful manually conversions that a “simple script” can
    do using *sed* :)
5.  Convert all the `from sugar.* import` to
    `from sugar`**3**`.* import` using [this
    script](http://dev.laptop.org/~manuq/sugar-convert.sh)
6.  Follow the [Code
    Guidelines](Development_Team/Code_guidelines "wikilink") during all
    the porting process
7.  Remove all things related with **old toolbar** support. They are no
    longer maintained
8.  Write comments on the code, by adding **\# README:**, **\# TODO:**
    and **\# FIXME:** explaining what are the problems that you are
    having with that chunk of code. Put a link if it's necessary
9.  If you are considering to fix some *pep8* or *pylint*
    errors/warnings, please create two separate patch files (one for the
    port and one for the pylint/pep8 changes). If we follow this way it
    is easier to check the port patches, if not the information about
    the port itself it's difficult to follow
10. Keep reading this wiki page to find out more things that you should
    do

Tips and Tricks
===============

Create a “new” activity from the git version
--------------------------------------------

It's really useful to keep the “original” version of the Activity that
we are porting to know how it was working before the port. Sometimes you
find an strange behaviour on the ported version of the activity and you
*think* that you don't touch that part of the code or that the change
shouldn't affect it. In these cases it's good to run the “original”
version and test how it worked before the port.

I [asked to the Sugar Developers mailing
list](http://lists.sugarlabs.org/archive/sugar-devel/2012-June/037996.html)
about how to do this and they told me that I should change the
*bundle\_id*. In fact, we have to change the **bundle\_id** and the
**name** from the *activity/activity.info* file. I used:

`name = Get Books Gtk3`\
`bundle_id = git.GetBooksActivity`

After this, you should run the *build* and *dev* setup commands:

`cd get-books`\
`python setup.py dev`\
`python setup.py build`

Now, you will see two Get Books activities: one called just “Get Books”
and another one called “Get Books Gtk3”.

Script to list all the enumeration
----------------------------------

There is an
[script](http://dev.laptop.org/~dsd/20110806/pygi-enumerate.py) that
list all the Gtk methods and it's useful to know the new name and from
where it comes from. For example:

    [humitos@michifus get-books]$ python pygi-enumerate.py | grep get_selection
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
    [humitos@michifus get-books]$

Use the same keyboard and mouse
-------------------------------

If you have an XO, I'm sure you want to take a look at
[this](User:Humitos/x2x "wikilink")...

Use Extended Python debugger
----------------------------

There is a library called **epdb** and it's useful to inspect the code
while the Activity is running. I'm using this module when I'm not sure
about the type of an object or I can test some different things that the
code says in some point. So, I installed this package on my Fedora 17 by
running this command

`sudo yum install python-epdb`

After that I put some trace point in the code where I can stop and make
my tests by doing this:

`import epdb;epdb.set_trace()`

Finally I run Get Books Activity from the Terminal Activity to be able
to write some code on a shell. This is the command that I use:

`sugar-launch org.laptop.sugar.GetBooksActivity`

See also [Development
Team/Debugging](Development_Team/Debugging "wikilink").

Check logs with *multitail*
---------------------------

Here is a really useful command to open new logs automatically:
<User:Humitos/MultiTail>

Use the pygobject code as example
---------------------------------

[pygobject](https://live.gnome.org/PyGObject) is what we use to make
Gtk3 activities. So, it's really useful to take a look at the code
examples that are there. Even more, you can run some demo application
that show how to use something specific about the library.

-   Clone the code:

`git clone `[`git://git.gnome.org/pygobject`](git://git.gnome.org/pygobject)

![](/src/images/Screenshot_from_2012-06-14_13-26-50.png)

-   Run an example

`cd pygobject`\
`cd demos/gtk-demo/demos`\
`python pixbuf.py`

-   Grep the code to search for something useful

`cd pygobject`\
`git grep GdkPixbuf`

Monitoring DBus
---------------

Not sure how this command works, but it can give us an interesting
information. If you run this command and plug an USB drive you will see
useful information

`dbus-monitor --system`

Code Snippets
=============

On this section I will explain all the things that I had to do manually
and took me some time to find out. Some of them are really simple but
time-consuming so the idea is to reduce that time as much as we can.

Migrate custom signals
----------------------

If you have defined custom gtk objects with custom signal you should
migrate them to [the new
way](http://python-gtk-3-tutorial.readthedocs.org/en/latest/objects.html)
to do this.

You should replace this:

`from gobject import signal_new, TYPE_INT, TYPE_STRING, TYPE_BOOLEAN, \`\
`TYPE_PYOBJECT, TYPE_NONE, SIGNAL_RUN_LAST`

`signal_new('extlistview-modified', gtk.TreeView, SIGNAL_RUN_LAST, TYPE_NONE,`\
`            ())`

by adding the signal definition inside the object that you are creating
using the `__gsignals__` dictionary like this (in this case Gtk.TreeView
is the class that our object inherits):

`from gi.repository import GObject`

`class ExtListView(Gtk.TreeView):`\
`    __gsignals__ = {`\
`      'extlistview-modified': (GObject.SignalFlags.RUN_LAST, None,`\
`                             ()),`\
`       }`

The last argument of the signal definition are the argument types that
the callback will receive. For example, that tuple could be (str, int)
if the callback receives two arguments, a string and an integer (first
and second argument position)

Access to the *Window* instance
-------------------------------

`sugar3.activity.Activity` doesn't have the *window* attribute anymore
instead of this it has the `.get_window()` method that do the same
thing. So, you should change all the occurrences of them.

Change the mouse cursor
-----------------------

The *window* attribute that I mention before is used to set the mouse
cursor. This is used when the activity is working on the background
(maybe searching something on the Internet) and we want to show a *work
in progress* cursor for example.

The old way to set the cursor is:

`self.window.set_cursor(gtk.gdk.Cursor(gtk.gdk.WATCH))`

And it should be replaced by the new one:

`from gi.repository import Gdk`\
`self.get_window().set_cursor(Gdk.Cursor(Gdk.CursorType.WATCH))`

In that case we are creating a new instance of `Gdk.Cursor` every time
that this chunk of code is called. I think that we could define all the
cursor used by the Activity once at the beginning of the file maybe. *We
should discuss about this.*

Use Gtk.Box instead Gtk.HBox / Gtk.VBox | Gtk.HSeparator / Gtk.VSeparator
-------------------------------------------------------------------------

As [its documentation
says](http://developer.gnome.org/gtk3/3.5/GtkHBox.html#GtkHBox.description),
Gtk.VBox and Gtk.HBox have been deprecated. So, we should use Gtk.Box
instead them. Replacing:

`self.list_box = gtk.HBox()`

by:

`self.list_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL)`

and,

`self.list_box = gtk.VBox()`

by:

`self.list_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)`

The same happens with Gtk.Separator: [link to the
documentation](http://developer.gnome.org/gtk3/3.5/GtkVSeparator.html#GtkVSeparator.description)

Using Pixbuf
------------

As I said, this is what I did, but maybe is not the correct way to do it
or there is a better way. I think that if we are porting an Activity we
can take advantage of this and improve the code. manuq told me that the
image handling now is done with Cairo, so we should port that to cairo.
Although, I didn't do this because I consider that the image handling
done in Get Books is really simple and we don't have the necessity to
use Cairo here.

So, what I did is keep using Pixbuf with Gtk3 version of the Activity.
We need to replace and import some things:

`from gi.repository import GdkPixbuf`

Replace:

`gtk.gdk.PixbufLoader()`

by:

`GdkPixbuf.PixbufLoader()`

and,

`gtk.gdk.pixbuf_new_from_file(file_path)`

by:

`GdkPixbuf.Pixbuf.new_from_file(file_path)`

and,

`gtk.gdk.Pixbuf(gtk.gdk.COLORSPACE_RGB,`\
`               pixbuf.get_has_alpha(),`\
`               pixbuf.get_bits_per_sample(),`\
`               image_width, image_height)`

by:

`GdkPixbuf.Pixbuf.new(GdkPixbuf.Colorspace.RGB,`\
`                     pixbuf.get_has_alpha(),`\
`                     pixbuf.get_bits_per_sample(),`\
`                     image_width, image_height)`

*note the **.new** and the **colorspace** in the replacement.*

and,

`gtk.gdk.INTERP_BILINEAR`

by:

`GdkPixbuf.InterpType.BILINEAR`

### Save the GdkPixbuf into a buffer

This was very difficult to find out. The gtk2 version of the code was
using `pixbuf.save_to_callback` to save the Image on the Journal's
Preview Entry but that function no longer exist in Gtk3. So, I found a
similar one called `pixbuf.save_to_callbackv` that I couldn't find out
how to use it. Even more, I realized that this function call another
callback function that doesn't do so much. Reading I found an
alternative (and easier) way to do this using `pibuxf.save_to_bufferv`:

`succes, data = pixbuf2.save_to_bufferv('png', [], [])`

Notes
=====

There are some things that I realized while I was doing the port. I will
mention them here:

-   `Gtk.Widget.hide_all()` doesn't exist anymore. We should use just
    `.hide`:
    <http://developer.gnome.org/gtk3/3.5/GtkWidget.html#gtk-widget-hide>
-   This is not necessary because the code will work anyway but I think
    that it's better. I replaced `GObject.TYPE_STRING` by **`str`** on
    the definition of the `Gtk.ListStore`

`self.treemodel = Gtk.ListStore(GObject.TYPE_STRING)`

`self.treemodel = Gtk.ListStore(str)`

-   There is something related with `.pack_start` that I couldn't find
    it out and understand either:
    <http://wiki.sugarlabs.org/go/Features/GTK3/Porting#HBox.2C_VBox.2C_pack_start_and_pack_end>
-   I didn't find a solution for this yet:
    **gtk.gdk.Pixbuf.save\_to\_callback**. So, at the moment, I'm not
    saving the preview cover for the books
-   If the code creates some own object, and it defines some properties,
    you should use **\_\_gproperties\_\_** dictionary:
    <http://python-gtk-3-tutorial.readthedocs.org/en/latest/objects.html#GObject.GObject.__gproperties__>
-   I removed this
    (`UDISK_DEVICE_PATH = 'org.freedesktop.UDisks.Device'`) because I
    don't know what it does and it was crashing the Activity
-   `Gtk.ListStore` doesn't have the method **.reorder**. There is a
    [ticket](https://bugzilla.gnome.org/show_bug.cgi?id=677941) reported
    upstream about this.
-   Should I use the Sugar's Palette instead of Gtk.Menu?
-   I replaced the use of `dbus` by
    [Gio](http://developer.gnome.org/gio/unstable/pt02.html) to monitor
    the (dis)connection of pen drives

Missing / Problematic things (not ported yet)
=============================================

-   \[<span style="color: green;">DONE</span>\] ~~When a book is
    downloaded, the cover is not saved in the Journal Entry~~
-   \[<span style="color: green;">DONE</span>\] ~~Switch the results to
    **Internet Archive** doesn't work~~
-   \[<span style="color: orange;">ALTERNATIVE</span>\] When the
    “generic book image” is shown (at the bottom left), the gray color
    used to fill it is not the same as the background. *I changed the
    color with is the GdkPixbuf filled to match with the darker one
    (style.COLOR\_BUTTON\_GREY) because I couldn't find how to fill the
    alpha of the “generic\_cover.png” with the old color
    (style.COLOR\_PANEL\_GREY)*: <http://bugs.sugarlabs.org/ticket/3723>
-   \[<span style="color: green;">DONE</span>\] ~~I'm not sure what is
    *org.freedesktop.UDisks.Device* for? I don't understand it very well
    but I had to remove it because it was failing~~. I replaced this by
    GIO
-   The *Catalogs* column title is bigger than the other column titles
-   Right clicking on the column titles doesn't show the Gtk.Menu popup

Theme related things
--------------------

-   ~~Cancel search button. It shows a really big **X** when you start
    typing: <http://bugs.sugarlabs.org/ticket/3385>~~
-   ~~Clicking some things on the screen makes the ListView grows a bit
    and it doesn't fit on the screen (the right scroll-bar goes outside
    the window): <http://bugs.sugarlabs.org/ticket/3722>~~
-   ~~Some time when I click on the Search Entry all the toolbar is
    moved a bit~~
-   ~~After searching and selecting a book, if we change the format to
    *EPUB* the *Get Book* button is moved a bit:
    <http://bugs.sugarlabs.org/ticket/3724>~~
-   W~~hen the book download starts, a *Cancel* is shown but it doesn't
    have the **X** icon: <http://bugs.sugarlabs.org/ticket/3725>~~
-   The background of the rows on the ListView do not cycle between
    *white* and *gray*: <http://bugs.sugarlabs.org/ticket/3726>
-   The column width should be re-sized to fit with the text inside them
    with a max width pre-set

References / Useful links
=========================

-   Guide you should follow:
    <http://wiki.sugarlabs.org/go/Features/GTK3/Porting>
-   PyGtk documentation
    -   Gtk3: <http://python-gtk-3-tutorial.readthedocs.org>
    -   gtk2: <http://www.pygtk.org/docs/pygtk/>
-   Reference Manual
    -   Gtk3: <http://developer.gnome.org/gtk3/3.4/>
-   Gdk documentation:
    -   Gdk3: <http://developer.gnome.org/gdk/2.24/>
-   OLPC Documentation:
    <http://wiki.laptop.org/go/Activities/PortingToGtk3>
-   Patch file of Clock's port to Cairo:
    <http://bugs.sugarlabs.org/attachment/ticket/3454/0001-Port-to-Cairo.2.patch>
-   GetBooks' diff (these .diff doesn't reflect the final port):
    -   First version:
        <http://bugs.sugarlabs.org/attachment/ticket/3681/Port-Gtk3-backup.diff>
    -   Second version:
        <http://bugs.sugarlabs.org/attachment/ticket/3681/Port-Gtk3-backup.2.diff>
-   Used to know the arguments of `GdkPixbuf.Pixbuf.save_to_bufferv`
    <https://mail.gnome.org/archives/javascript-list/2011-March/msg00001.html>
-   pdb Python's module docs: <http://docs.python.org/library/pdb.html>
-   Monitor Volumes / GNOME Input-Output
    <http://developer.gnome.org/gio/unstable/pt02.html>
