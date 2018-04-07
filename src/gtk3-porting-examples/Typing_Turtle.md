This page is being performed while I'm porting Typing Turtle Activity to
Gtk3.

There is a [ticket](http://bugs.sugarlabs.org/ticket/3772) with some
useful information that I'm using on the porting and to keep tracking
this port. Besides, this wiki page will be useful to write some code
snippets about what are the difficulties that I'm having on the port and
maybe can be useful for someone else.

I will take [this guide](User:Humitos/PortingGetBooks "wikilink") as
reference on the Gtk3 porting.

Port to Cairo
=============

**README**: before to port this activity to GTK3, we should port it to
Cairo as the first step and then move to GTK3. Here is the
[PATCH](http://bugs.sugarlabs.org/attachment/ticket/3772/0001-Port-to-Cairo.2.patch)

Code Snippets
-------------

### Draw a rectangle

To draw a rectangle we used to do:

`gc = self.window.new_gc()`\
`gc.foreground = self.area.get_colormap().alloc_color(50000, 50000, 50000)`\
`self.area.window.draw_rectangle(gc, True, x, y, w, h)`

The arguments for *alloc\_color* are between 0-65535 and the
*set\_source\_rgb* method from cairo are between 0-1, so we have to
convert these values as well:

`cr.set_source_rgb(0.762, 0.762, 0.762)`\
`cr.rectangle(x, y, w, h)`\
`cr.fill()`

Note that the second attributo of *draw\_rectangle* tells us about if
the rectangle is filled or not. In this case is True, so we use
*cr.fill()* in the new way but if we want just the outside lines of the
rectangle we should use *cr.stroke()*

### Write some text

This is the old way to do it:

`title = _('You finished!')`\
`layout = self.area.create_pango_layout(title)`\
`layout.set_font_description(pango.FontDescription('Serif Bold 16'))    `\
`size = layout.get_size()`\
`tx = x+w/2-(size[0]/pango.SCALE)/2`\
`ty = y + 100`\
`self.area.window.draw_layout(gc, tx, ty, layout)`

and this is the way that I used to do it with pangocairo:

`title = _('You finished!')`\
`pango_cr = pangocairo.CairoContext(cr)`\
`pango_cr.set_source_rgb(0, 0, 0)`\
`pango_layout = cr.create_layout()`\
`pango_layout.set_font_description(pango.FontDescription('Serif Bold 16'))`\
`pango_layout.set_text(title)`\
`size = pango_layout.get_size()`\
`tx = x + (w / 2) - (size[0] / pango.SCALE) / 2`\
`ty = y + 100`\
`pango_cr.move_to(tx, ty)`\
`pango_cr.show_layout(pango_layout)`\
`pango_cr.stroke()`

### Draw a line

This is the old way:

`gc.foreground = self.area.get_colormap().alloc_color(0, 0, 0)`\
`self.area.window.draw_line(gc, int(b.x), int(b.y + b.size / 2), `\
`                           int(b.x), int(b.y + b.size))`

and should be replaced by this new way using cairo

`cr.set_source_rgb(0, 0, 0)`\
`cr.move_to(int(b.x), int(b.y + b.size / 2))`\
`cr.line_to(int(b.x), int(b.y + b.size))`\
`cr.stroke()`

### Draw an arc

Old way to do it (notice the second argument of *draw\_arc*:
**filled**):

`gc.foreground = self.area.get_colormap().alloc_color(b.color[0],b.color[1],b.color[2])`\
`self.area.window.draw_arc(gc, True, x-b.size/2, y-b.size/2, b.size, b.size, 0, 360*64)`

new way:

`cr.set_source_rgb(b.color[0], b.color[1], b.color[2])`\
`cr.arc(b.x, b.y, b.size / 2, 0, 2 * math.pi)`\
`cr.fill()`

Tips & tricks
-------------

### Convert cairo.Surface to GdkPixbuf

`import StringIO`

`surface = cairo.ImageSurface(cairo.FORMAT_RGB24, w, h)`\
`cr = cairo.Context(surface)`

`[... draw something into the surface ...]`

`pixbuf_data = StringIO.StringIO()`\
`surface.write_to_png(pixbuf_data)`\
`pxb_loader = gtk.gdk.PixbufLoader(image_type='png')`\
`pxb_loader.write(pixbuf_data.getvalue())`\
`temp_pix = pxb_loader.get_pixbuf()`\
`pxb_loader.close()`

### Paint a GdkPixbuf into the canvas

`cr.set_source_pixbuf(self.backgroundpixbuf, 0, 0)`\
`cr.rectangle(x, 0, self.backgroundpixbuf.get_width(),`\
`             self.backgroundpixbuf.get_height())`\
`cr.paint()`

#### Gtk3 version

`Gdk.cairo_set_source_pixbuf(cr, self.backgroundpixbuf, 0, 0)`\
`cr.rectangle(x, 0, self.backgroundpixbuf.get_width(),`\
`             self.backgroundpixbuf.get_height())`\
`cr.paint()`

Port to Gtk3 -&gt; Code Snippets
================================

Gtk.TextBuffer
--------------

`self.lessonbuffer = gtk.TextBuffer(self.tagtable)`\
`self.lessontext = gtk.TextView(self.lessonbuffer)`

replaced by:

`self.lessonbuffer = Gtk.TextBuffer.new(self.tagtable)`\
`self.lessontext = Gtk.TextView.new_with_buffer(self.lessonbuffer)`

Gdk.Event
---------

`event.state`

replaced by:

`event.get_state()`

Rsvg
----

`import rsvg`\
`image = rsvg.Handle(file=filename)`

replaced by:

`from gi.repository import Rsvg`\
`image = Rsvg.Handle.new_from_file(filename)`

Gtk.TextTag
-----------

`instructions_tag = Gtk.TextTag('instructions')`

replaced by:

`instructions_tag = Gtk.TextTag.new('instructions')`

Gdk.Keymap
----------

`entries = self.keymap.get_entries_for_keyval(keyval)`\
`for e in entries:`\
`    e[0], e[1], e[2]`

replaced by:

`valid, entries = self.keymap.get_entries_for_keyval(keyval)`\
`for e in entries:`\
`    e.keycode, e.group, e.level`

Every entry was a tuple of (keycode, group, level). Now, this is an
object with those attributes.

GdkPixbuf.PixbufLoader
----------------------

Change this:

`pxb_loader = gtk.gdk.PixbufLoader(image_type='png')`

by:

`pxb_loader = GdkPixbuf.PixbufLoader.new_with_type('png')`

KEY\_PRESS
----------

This should be done by the **pygi-convert.sh** script.

`gtk.gdk.KEY_PRESS`\
`gtk.gdk.KEY_RELEASE`

replaced by

`Gdk.EventType.KEY_PRESS`\
`Gdk.EventType.KEY_RELEASE`

Gdk.Keymap.translate\_keyboard\_state
-------------------------------------

-   <http://developer.gnome.org/gdk/stable/gdk-Keyboard-Handling.html#gdk-keymap-translate-keyboard-state>
-   <http://www.pygtk.org/docs/pygtk/class-gdkkeymap.html#method-gdkkeymap--translate-keyboard-state>

Old way:

`t = self.keymap.translate_keyboard_state(key['key-scan'], self.active_state, self.active_group)`

New way:

`success, keyval, effective_group, level, consumed_modifiers = \`\
`    self.keymap.translate_keyboard_state(key['key-scan'], self.active_state,`\
`                                         self.active_group)`

'expose-event' & 'draw' event
-----------------------------

The new *draw* event that refers to the old *expose-event* into a
Gtk.DrawingArea now receive the widget and the context instead the
widget and the event:

*expose-event*

`def expose_cb(self, area, event):`\
`    self.draw()`

*draw* event

`def draw_cb(self, area, cr):`\
`    self.draw(cr)`

Notes
=====

-   I found this chunk of code in the source (*keyboard.py* **L515**)
    and I didn't understand what it means

`# Hack to get the current modifier state - which will not be represented by the event.`\
`state = gtk.gdk.device_get_core_pointer().get_state(self.window)[1]`

-   I used a HACK related to Pango fonts and DPI:

<!-- -->

     # Set correct DPI for Rsvg and Screen
     from gi.repository import PangoCairo

     def _get_screen_dpi():
         xft_dpi = Gtk.Settings.get_default().get_property('gtk-xft-dpi')
         dpi = float(xft_dpi / 1024)
         logging.debug('Setting dpi to: %f', dpi)
         # HACK: if the DPI detected is 200.0 it seems we are on an XO, so
         # we return 133 because the XO manage its resolution in a complex
         # way. More information here:
         #     http://wiki.laptop.org/go/Display
         if 200 == int(dpi):
             return 133
         return dpi

     dpi = _get_screen_dpi()
     font_map_default = PangoCairo.font_map_get_default()
     font_map_default.set_resolution(dpi)

Missing / problematic things
============================

-   \[<span style="color: green;">SOLVED</span>\] ~~This method,
    *set\_source\_pixbuf*, is not available.~~

<!-- -->

-   \[<span style="color: green;">SOLVED</span>\] ~~We should find the
    correct way to scale Left and Right hands that are drawn over the
    keyboard, because I just put values that I thought they were
    correct. We should calculate them according to the screen~~

<!-- -->

-   \[<span style="color: green;">SOLVED</span>\] ~~PangoCairo fonts are
    not being drawn because of this:
    <https://bugzilla.gnome.org/show_bug.cgi?id=680680>~~

<!-- -->

-   \[<span style="color: green;">SOLVED</span>\] ~~Font Scale is wrong:
    <https://bugzilla.gnome.org/show_bug.cgi?id=680663>~~

<!-- -->

-   SHIFT and ALT GR keys do not show the correct keys

Useful links
============

-   <http://cairographics.org/documentation/pycairo/2/index.html>
-   <http://www.pygtk.org/docs/pygtk/pangocairo-class-reference.html>
-   <http://www.pygtk.org/docs/pygtk/class-gdkdrawable.html>
