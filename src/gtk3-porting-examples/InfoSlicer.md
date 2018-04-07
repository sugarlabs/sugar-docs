Ticket of this port is [here](http://bugs.sugarlabs.org/ticket/3742), with some
useful information that I'm using on the porting and to keep tracking
this port.


Remove hippo
============

First of all, I had to remove the *hippo* related things and the sugar-port ([ticket](http://bugs.sugarlabs.org/ticket/3743)) wrapper.

Code Snippets
=============

Signals
-------

### Change TYPE\_PYOBJECT type from a signal

We should replace the `TYPE_PYOBJECT`

`'article-selected' : (SIGNAL_RUN_FIRST, None, [TYPE_PYOBJECT]),`

by the Python's `object` type

`'article-selected' : (GObject.SignalFlags.RUN_FIRST, None, [object]),`

### Drag And Drop: drag-motion

-   <http://www.pygtk.org/pygtk2tutorial/sec-DNDMethods.html#sec-SettingUpDestinationWidget>

The signal `drag-motion` works in the same way as it was working on
gtk2, but the callback used by InfoSlicer should be a bit modified to
use the *new* method:

`context.drag_status(Gdk.DragAction.COPY, timestamp)`

changed by:

`Gdk.drag_status(context, Gdk.DragAction.COPY, timestamp)`

### Drag And Drop: drag-data-received

-   <http://developer.gnome.org/gtk3/3.5/gtk3-Selections.html#GtkSelectionData-struct>

`data_received_type = str(selection_data.type)    `\
`data = cPickle.loads(str(selection_data.data))`

replaced by:

`data_received_type = str(selection_data.get_data_type())    `\
`data = cPickle.loads(str(selection_data.get_data()))`

Working with threads
--------------------

InfoSlicer uses threads to retrieve the information from internet
(Wikipedia articles). The *pygi* script will replace it by
`Gdk.threads_init()` by I
[found](https://bbs.archlinux.org/viewtopic.php?id=121303) this is not
the correct way to do this. In fact, I was dealing with some strange
behaviour of the Activity because of this. So, I used:

`from gi.repository import GObject`\
`GObject.threads_init()`

gtk.gdk.\_2BUTTON\_PRESS
------------------------

We should replace:

`gtk.gdk._2BUTTON_PRESS`\
`gtk.gdk._3BUTTON_PRESS`

by:

`Gdk.EventType._2BUTTON_PRESS`\
`Gdk.EventType._3BUTTON_PRESS`

Gtk.TextBuffer.get\_slice() needs a new argument
------------------------------------------------

We need a new argument to indicate if we want to include the
*hidden\_chars* as well. It wasn't required in gtk2 and by default it
was **True**

`buf = gtk.TextBuffer()`\
`buf.get_slice(start, end)`

replaced by:

`buf = Gtk.TextBuffer()`\
`buf.get_slice(start, end, include_hidden_chars)`

Alerts
------

We have to change the way that alerts were shown because
`self.notify_alert` is no longer available after applying this
[patch](http://bugs.sugarlabs.org/attachment/ticket/3743/0001-Remove-wrapper-around-sugar-toolkit-SL-3743.patch)

Example about how to use the different types of alerts:

-   <https://github.com/sugarlabs/sugar-toolkit-gtk3/blob/master/src/sugar3/graphics/alert.py#L11>

<!-- -->

-   A simple alert:

<!-- -->

     from sugar3.graphics.alert import Alert

     # Create a new simple alert
     alert = Alert()

     # Populate the title and text body of the alert.
     alert.props.title = _('Title of Alert Goes Here')
     alert.props.msg = _('Text message of alert goes here')

     # Call the add_alert() method (inherited via the sugar3.graphics.Window
     # superclass of Activity) to add this alert to the activity window.
     self.add_alert(alert)
     alert.show()

-   NotifyAlert

`from sugar3.graphics.alert import NotifyAlert`

`def __alert_notify_response_cb(alert, response_id, activity):`\
`    activity.remove_alert(alert)`

`alert = NotifyAlert(5)`\
`alert.props.title = _('Nothing to publish')`\
`alert.props.msg = _('Mark arcticles from `“`Custom`”` '`\
`                    'panel and try again.')`\
`alert.connect('response', __alert_notify_response_cb, activity)`\
`activity.add_alert(alert)`\
`alert.show()`

Gtk.Widget.drag\_source\_set()
------------------------------

-   Python docs:
    <http://python-gtk-3-tutorial.readthedocs.org/en/latest/drag_and_drop.html>
-   C docs:
    <http://developer.gnome.org/gtk3/3.5/gtk3-Drag-and-Drop.html>
-   **Good example** about how drang-n-drop on GTK+ 3 works
    <http://bugs.sugarlabs.org/raw-attachment/ticket/3742/drag-n-drop-example.tar.gz>
    -   The *drag\_data\_received\_event* method is called ONLY if in
        *drag\_data\_get\_event* method we modify the argument *data*

In GTK+ 3 the way to call this function is a bit different. Instead of
passing a tuple we should pass a list of Gtk.TargetEntry's. So, we
should replace this:

`self.imagebox = Gtk.EventBox()`\
`self.imagebox.drag_source_set(Gdk.ModifierType.BUTTON1_MASK, (`“`text/plain`”`, Gtk.TargetFlags.SAME_APP, 80), Gdk.DragAction.COPY)`

by this:

`self.imagebox = Gtk.EventBox()`\
`self.imagebox.drag_source_set(`\
`       Gdk.ModifierType.BUTTON1_MASK,`\
`       [Gtk.TargetEntry.new('text/plain', Gtk.TargetFlags.SAME_APP, 80)],`\
`       Gdk.DragAction.COPY)`

Gtk.TextView.scroll\_to\_iter
-----------------------------

-   GTK+ 2:
    <http://www.pygtk.org/docs/pygtk/class-gtktextview.html#method-gtktextview--scroll-to-iter>
-   GTK+ 3:
    <http://developer.gnome.org/gtk3/3.5/GtkTextView.html#gtk-text-view-scroll-to-iter>

This method in gtk2 takes only 2 required arguments but in GTK+ 3 all of
them (5) are required. So, I had to change the call to this method:

`self.scroll_to_iter(mouseiter, 0)`

by:

`self.scroll_to_iter(mouseiter, 0, False, 0.5, 0.5)`

Gdk.atom\_intern
================

-   <http://www.pygtk.org/docs/pygtk/class-gdkatom.html#constructor-gdkatom-intern>

I'm not sure about the meaning of this function. I've just took a look
at the documentation and added the required attribute that was missing:

`atom = Gdk.atom_intern(`“`sentence`”`)`

replaced by:

`atom = Gdk.atom_intern(`“`sentence`”`, only_if_exists=False)`

Missing / Problematic things (not ported yet)
=============================================

-   \[<span style="color: green;">DONE</span>\] ~~Select text from the
    *Edit View* (TextView) and the Home View. This error happens in many
    places of the code.~~
    -   <http://developer.gnome.org/gdk3/stable/gdk3-Event-Structures.html#GdkEventMotion>
    -   <https://bugzilla.gnome.org/show_bug.cgi?id=679795>

`Traceback (most recent call last):`\
`  File `“`/home/humitos/Activities/InfoSlicer.activity/infoslicer/widgets/Readonly_Textbox.py`”`, line 116, in motion_notify`\
`    self.emit(`“`motion-notify-event`”`, event)`\
`TypeError: could not convert type EventMotion to GdkEvent required for parameter 0`

-   \[<span style="color: orange;">ALTERNATIVE</span>\] Issue related
    with “adding columns to the TreeView”:
    <https://bugzilla.gnome.org/show_bug.cgi?id=679415>
    -   There is a workaround on the code to solve this issue
-   \[<span style="color: red;">IMPORTANT</span>\] Drag and Drop Images
    from the Edit View is not working. Line \#52
    (*infoslicer/widgets/Gallery\_View.py*)
    -   Walter Bender helped me to solve this issue. Thanks!
    -   \[<span style="color: orange;">ALTERNATIVE</span>\] Drag and
        drop is working but the image is being added twice. This is
        because the SIGNAL is being emitted twice. The same happens with
        the text, but there is an error related with the index of the
        selection on the second time that the signal is called, so it
        fails and add just once the text
        [ticket](http://bugs.sugarlabs.org/ticket/3766)
-   After drag-n-drop an arrow is added inside the article (right side)
    that is being edited. This is not working due:
    <https://bugzilla.gnome.org/show_bug.cgi?id=651962>
    -   Line \#641 (*infoslicer/processing/Article.py*)
    -   <http://bugs.sugarlabs.org/ticket/3767>
-   On “Home View” under the *Custom* TreeView if I add some articles
    there I cannot move them up or down
    -   The same happens on the *Wiki* TreeView
    -   <http://bugs.sugarlabs.org/ticket/3768>
    -   *TODO: This is not working because of the port to GTK+ 3. TreePath
        object does not support indexing*
-   Check boxes on “Home View” *Custom* TreeView don't show the tick
    after clicking (Is this related with the theme?)
    -   After clicking on all the articles under this TreeView I see the
        *Custom* check box is checked automatically
-   *Wiki* and *Custom* TreeView under “Home View” has a different
    background color (lighter)

Notes
=====

-   I had to write a workaround over [this
    bug](https://bugzilla.gnome.org/show_bug.cgi?id=679415) (adding
    columns with properties) on `bookview.py` Line \#129

<!-- -->

            # FIXME: insert_column_with_attributes does not exist on pygobject
            # column = self.tree.insert_column_with_attributes(0, '', cell, active=0)

            # TODO: this is a workaround due
            # https://bugzilla.gnome.org/show_bug.cgi?id=679415

            column = Gtk.TreeViewColumn('Wiki', cell)
            column.props.sizing = Gtk.TreeViewColumnSizing.FIXED
            column.props.fixed_width = 50
            column.props.visible = custom

            self.tree.insert_column(column, 0)

            cell = Gtk.CellRendererText()
            cell.connect('edited', self._cell_edited_cb)
            cell.props.editable = True

            # FIXME: insert_column_with_attributes does not exist on pygobject
            # self.tree.insert_column_with_attributes(1, '', cell, text=1)

            # TODO: this is a workaround due
            # https://bugzilla.gnome.org/show_bug.cgi?id=679415
            column = Gtk.TreeViewColumn('Custom', cell, text=1)
            self.tree.insert_column(column, 1)

Useful links
============

-   Ticket that removes hippo and sugar-port:
    <http://bugs.sugarlabs.org/ticket/3743>
