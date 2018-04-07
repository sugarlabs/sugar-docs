This page is being performed while I'm porting Implode Activity to GTK+ 3.

There is a [ticket](http://bugs.sugarlabs.org/ticket/3715) with some
useful information that I'm using on the porting and to keep tracking
this port. Besides, this wiki page will be useful to write some code
snippets about what are the difficulties that I'm having on the port and
maybe can be useful for someone else.

Porting Gtk.DrawingArea
=======================

There are some things related with `gtk.DrawingArea` that we have to
change when we are porting an activity to GTK+ 3. The names of the signals
change and the way that they work as well.

Get allocation size
-------------------

*self.allocation* property is no longer available and we should use
`self.get_allocation_width` to get the allocation size:

`self.allocation.width`\
`self.allocation.height`

should be replaced by:

`self.get_allocated_width()`\
`self.get_allocated_height()`

Signals
-------

### expose-event

This signal was override by **draw** and it have to be connected with
the method that was connected with the *expose-event* before. The method
itself does not change but the arguments that it receives do. This is
the new definition of the function in my case:

`def _draw_event_cb(self, widget, cr):`

### size-allocate

This signal was used to resize the gtk.DrawingArea every time the window
grows and at the startup of the activity. This is useful to re-draw the
widget for different resolutions (desktops and XOs for example).

I used the same function connected to this signal but I change the
signal connected by **configure-event**. Here is the definition of the
callback:

`def _configure_event_cb(self, widget, event):`

Focus
-----

Implode defines a new widget called *GridWidget* and it should be
focusable because we want to move a cursor with the key arrows on it.
So, this widget was using:

`self.set_flags(Gtk.CAN_FOCUS)`

but that method (*set\_flags*) is no longer available and we have to
replace it by:

`self.set_can_focus(True)`

Another thing related with the focus is to know who has the actual
focus. In gtk2 it was done by

`.focus_child`

and in GTK+ 3 it should be replaced by:

`.get_focus_child()`

Handling .svg with rsvg
=======================

**rsvg** is a library to manage *.svg* files. The only thing that I
found that should be updated is the import and the loading of a rsvg
from data.

Replace the usual import:

`import rsgv`

by the GTK+ 3 one:

`from gi.repository import Rsvg`

This way to load a rsvg from data should be replaced:

`rsvg.Handle(data=data)`

by this new way

`Rsvg.Handle.new_from_data(data)`

Invalidate rectangle
====================

`Gdk.Window.invalidate_rect` takes a *Gdk.Rectangle* instead a tuple in
GTK+ 3.

`rect = Gdk.Rectangle()`\
`rect.x, rect.y, rect.width, rect.height = (0, 0, width, height)`

`self.get_window().invalidate_rect(rect, True)`

Notes
=====

-   I had to add a third argument (None) to Gtk.Notebook.append\_page
    but I don't know why
-   Use **json** instead of *simplejson* or so
-   Replace `gtk.VISIBLE` by **Gtk.AccelFlags.VISIBLE**

Missing things (not ported yet)
===============================

-   *sugarless.py* is not working. The board is not shown. Do we update
    this to keep it working? I mean, do we need to maintain this code?
-   \[<span style="color: green;">DONE</span>\] ~~help dialogue is not
    working. It shows the example board but it's one pixel size when it
    opens~~
-   When the help dialogue is shown and you hover the animation with the
    mouse something strange happens and it starts to flap.
    [Screenshot](http://bugs.sugarlabs.org/attachment/ticket/3715/53.png)

Useful Links
============

-   <http://developer.gnome.org/gtk3/3.5/GtkWidget.html#GtkWidget-draw>
-   <http://developer.gnome.org/gtk3/3.5/GtkWidget.html#GtkWidget-configure-event>
-   <http://developer.gnome.org/rsvg/stable/>
-   <http://developer.gnome.org/gdk3/stable/gdk3-Windows.html#gdk-window-invalidate-rect>
-   <http://developer.gnome.org/gtk3/3.5/GtkWidget.html#gtk-widget-get-allocated-width>
-   <http://developer.gnome.org/gtk3/3.5/GtkNotebook.html#gtk-notebook-append-page>
