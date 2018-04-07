This page is being performed while I'm porting Jukebox Activity to Gtk3.

There is a [ticket](http://bugs.sugarlabs.org/ticket/3760) with some
useful information that I'm using on the porting and to keep tracking
this port. Besides, this wiki page will be useful to write some code
snippets about what are the difficulties that I'm having on the port and
maybe can be useful for someone else.

I will take [this guide](User:Humitos/PortingGetBooks "wikilink") as
reference on the Gtk3 porting.

Code Snippets
=============

Gtk.Scale
---------

Replace:

`self.hscale = gtk.HScale(self.adjustment)`

with:

`self.hscale = Gtk.Scale(orientation=Gtk.Orientation.HORIZONTAL,`\
`                        adjustment=self.adjustment)`

GtkWindow.xid
-------------

The way to access to the “window” attribute changed and the way to
access to “xid” as well. So,

Replace:

`self.videowidget_xid = videowidget.window.xid`

with:

`self.videowidget_xid = videowidget.get_window().get_xid()`

*NOTE: this is used to insert the animation window inside a widget
instead opening a new window*

Gtk.DrawingArea's flags
-----------------------

Replace:

`self.unset_flags(gtk.DOUBLE_BUFFERED)`\
`self.set_flags(gtk.APP_PAINTABLE)`

with:

`self.set_app_paintable(True)`\
`self.set_double_buffered(False)`

Gtk.TreeView
------------

-   <http://python-gtk-3-tutorial.readthedocs.org/en/latest/treeview.html>

Access to a particular row:

Replaced:

`media_idx = path[COLUMNS['index']]`

with:

`treeiter = model.get_iter(path)`\
`media_idx = model.get_value(treeiter, COLUMNS['index'])`

Same here:

`self._playlist.pop(row[0])`

replaced with:

`index = sel_model.get_value(sel_model.get_iter(row), 0)`\
`self._playlist.pop(index)`

The function that **Gtk.TreeViewColumn.set\_cell\_data\_func** receives
needs a new required argument: *data*

`def _set_number(self, column, cell, model, it):`

replaced:

`def _set_number(self, column, cell, model, it, data):`

Sugar ObjectChooser
-------------------

Some arguments are deprecated in the *sugar-toolkit-gtk3* version

`chooser = ObjectChooser(_('Choose document'), self,`\
`            gtk.DIALOG_MODAL |`\
`            gtk.DIALOG_DESTROY_WITH_PARENT,`\
`            what_filter=mime.GENERIC_TYPE_AUDIO)`

replaced by:

`chooser = ObjectChooser(self, what_filter=mime.GENERIC_TYPE_AUDIO)`

Notes
=====

-   There is something related with **collaboration** in
    *jukeboxactivity.py* but I didn't understand how it works. I thought
    this activity is not collaborative.
-   The gtk2 version uses “gst” as “import gst” and “import pygst” but I
    found that there is a new way to do that using introspection: “from
    gi.repository import Gst”. What's about this? Should we use this new
    way?
    -   <https://wiki.ubuntu.com/Novacut/GStreamer1.0>
    -   <https://live.gnome.org/GnomeGoals/PortToGstreamer1>
    -   www.spinics.net/lists/fedora-desktop/msg07545.html

Missing / Problematic / Un-ported things
========================================

-   The slider has a problem with the theme.
    [Issue](http://bugs.sugarlabs.org/attachment/ticket/3760/36.png)
-   The Gtk3 version in XO 1.75 os18 shows the animation too slow

Useful Links
============

-   <https://wiki.ubuntu.com/Novacut/GStreamer1.0>
-   <https://live.gnome.org/GnomeGoals/PortToGstreamer1>
-   <http://www.spinics.net/lists/fedora-desktop/msg07545.html>
