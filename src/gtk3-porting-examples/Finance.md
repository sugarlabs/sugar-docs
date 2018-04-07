Ticket of this port is [here](http://bugs.sugarlabs.org/ticket/3740), with some
useful information that I'm using on the porting and to keep tracking
this port.


Gtk.EventBox
============

EventBox has not `get_colormap` method anymore and this method is used
to set the background color. Now, instead of this one I'm using
`Gdk.Color.parse` to parse the color string:

`ebox = gtk.EventBox()`\
`ebox.modify_bg(gtk.STATE_NORMAL, ebox.get_colormap().alloc_color('#000000'))`

replaced by:

`ebox = Gtk.EventBox()`\
`parse, color = Gdk.Color.parse('#000000')`\
`self.helpbox.modify_bg(Gtk.StateType.NORMAL, color)`

Gtk.TreeViewColumn
==================

The callback function used by `Gtk.TreeViewColumn.set_cell_data_func`
receives a new argument called: *data*

`col = Gtk.TreeViewColumn(_('Description'), renderer)`\
`col.set_cell_data_func(renderer, self.description_render_cb) `

added a new argument to the function definition:

`def description_render_cb(self, column, cell_renderer, model, iter, data):`

Useful links
============

-   <http://developer.gnome.org/gtk3/3.5/GtkTreeViewColumn.html#GtkTreeCellDataFunc>
-   <http://developer.gnome.org/gdk3/stable/gdk3-Colors.html#GdkColor>