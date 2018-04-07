This page is being performed while I'm porting Log Activity to GTK+ 3.

There is a [ticket](http://bugs.sugarlabs.org/ticket/3761) with some
useful information that I'm using on the porting and to keep tracking
this port. Besides, this wiki page will be useful to write some code
snippets about what are the difficulties that I'm having on the port and
maybe can be useful for someone else.


Code Snippets
=============

Gtk.TextView
------------

-   GTK+ 2:
    <http://www.pygtk.org/docs/pygtk/class-gtktextview.html#method-gtktextview--scroll-to-mark>
-   GTK+ 3:
    <http://developer.gnome.org/gtk3/3.5/GtkTextView.html#gtk-text-view-scroll-to-mark>

Gtk.TextView.scroll\_to\_mark needs all the arguments. In gtk2 version
three of them were optional (use\_align, xalign, yalign)

`self._textview.scroll_to_mark(log.get_insert(), 0)`

replaced with:

`self._textview.scroll_to_mark(log.get_insert(), 0, use_align=False, xalign=0.5, yalign=0.5)`

Gtk.TreeSortable.set\_sort\_func
--------------------------------

-   <http://python-gtk-3-tutorial.readthedocs.org/en/latest/treeview.html#Gtk.TreeSortable.set_sort_func>

This function sometimes receives *user\_data* so we need to add an
optional argument to the definition.

`def _sort_logfile(self, treemodel, itera, iterb):`

replaced by:

`def _sort_logfile(self, treemodel, itera, iterb, user_data=None):`

Gtk.TreeModelSort.convert\_child\_iter\_to\_iter
------------------------------------------------

-   <http://developer.gnome.org/gtk3/3.5/GtkTreeModelSort.html#gtk-tree-model-sort-convert-child-iter-to-iter>

The old way to do this:

`log_iter = \`\
`    self._treeview.get_model().convert_child_iter_to_iter(None,`\
`            log.iter)`

replaced by:

`success, log_iter = \`\
`    self._treeview.get_model().convert_child_iter_to_iter(log.iter)`

Clipboard
=========

-   GTK+ 3:
    <http://python-gtk-3-tutorial.readthedocs.org/en/latest/clipboard.html>
    -   <http://developer.gnome.org/gtk3/3.5/GtkTextBuffer.html#gtk-text-buffer-copy-clipboard>

To integrate the clipboard of the activity with the *MAIN* clipboard
(the Sugar one) we should obtain that clipboard:

`# Clipboard of the activity`\
`self.clipboard = Gtk.Clipboard.get(Gdk.SELECTION_CLIPBOARD)`

And then, when the *Copy* button is pressed we should call this function
(in the callback). The *self.viewer.***active\_log** is a Gtk.TextBuffer

`self.viewer.active_log.copy_clipboard(self.clipboard)`

Missing things
==============

-   Look for **FIXME**s and **README**s in the code (logviewer.py)
-   Searching in the log is not working due to this bug:
    <https://bugzilla.gnome.org/show_bug.cgi?id=680597>

Useful Links
============

-   <http://developer.gnome.org/gtk3/3.5/GtkTextIter.html#gtk-text-iter-forward-search>
-   <http://developer.gnome.org/gtk3/3.5/GtkTreeModelSort.html#gtk-tree-model-filter-convert-child-iter-to-iter>
