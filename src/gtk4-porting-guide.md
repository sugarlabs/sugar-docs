# GTK 4 Porting Guide

Guide to porting Sugar Activities to GTK 4 and Wayland.

## GTK

GTK is a library for creating graphical user interfaces. GTK is written in C. GTK for Python is a language binding.

* [GTK](https://gtk.org/)

GTK 3 is the previous major version of GTK. GTK 3 is considered legacy.

GTK 4 is the current major version of GTK. It breaks both API and ABI compared with GTK 3. GTK 4 heavily emphasizes retained-mode rendering via `Gtk.Snapshot`, modern layout managers, and Wayland compatibility.

* [GTK 4 Reference Manual](https://docs.gtk.org/gtk4/)
* [Migrating from GTK 3 to GTK 4](https://docs.gtk.org/gtk4/migrating-3to4.html)

## Sugar Toolkit

Sugar Toolkit provides services and a set of GTK widgets to build activities and other Sugar components.

* [Sugar Toolkit for GTK 4](https://github.com/sugarlabs/sugar-toolkit-gtk4), module name `sugar4`, uses PyGObject.

## Sugar Activities

Old Sugar activities were written in Python using GTK 3 and Sugar Toolkit for GTK 3.
These old activities are to be ported to GTK 4. This guide explains how.

## Required Skills

* Application development in Python.
* Application development in GTK 4, using the Event Controller model.
* Understanding of Wayland window hierarchy.
* Sugar activity development.

## How to Port to GTK 4

General information for all GTK applications:
* [GNOME GTK4 Migration Guide](https://docs.gtk.org/gtk4/migrating-3to4.html)

## How to Port a Sugar Activity to GTK 4

* Set up development environment for Sugar on GTK 4 (e.g., Debian 13/Trixie, which has newer GTK4 packages).
* Quiesce the activity source by making sure the activity works properly before porting.
* **Port to Sugar Toolkit for GTK 4 (`sugar4`)**: The namespace has changed. You must update imports from `sugar3` to `sugar4`. While many Sugar-specific widgets (like `ToolbarBox`) are preserved, the underlying GTK widgets they inherit from have changed. Note that some older Sugar widgets (like the Keep button) have been removed entirely.
* Port to GTK 4, manually substituting deprecated widgets with their modern equivalents.
* Port other libraries (e.g., Evince to Papers, WebKit2 to WebKit6).
* Test heavily under Wayland, as X11 behavior is no longer guaranteed.

---

## Quick Reference: GTK3 to GTK4 Replacements

| GTK3 / Old API | GTK4 / New API | Notes |
| :--- | :--- | :--- |
| `Gtk.HBox` / `Gtk.VBox` | `Gtk.Box` | Set orientation explicitly. |
| `Gtk.Table` | `Gtk.Grid` | |
| `pack_start()` | `append()` / `prepend()` | |
| `add()` | `set_child()` | Depends on the container. |
| `Gtk.Toolbar` | `Gtk.Box` + `Gtk.Popover` | Toolbar was removed entirely. |
| `Gtk.IconView` | `Gtk.FlowBox` | Useful with `Gtk.Picture` for scaling SVGs. |
| `button-press-event` | `Gtk.GestureClick` | |
| `key-press-event` | `Gtk.EventControllerKey` | |
| EventBox | `Gtk.GestureClick` / `Gtk.GestureDrag` / `Gtk.GestureZoom` | Use the controller matching the interaction. |
| `modify_bg()` | `Gtk.CssProvider` | Bind strictly to the needed widgets. |
| `Gdk.cairo_set_source_pixbuf` | Convert pixbuf to a Cairo image surface | Convert pixbufs manually. |
| `Gtk.Menu` | `Gio.Menu` + `Gtk.PopoverMenuBar` | Use `Gio.SimpleAction`. |
| `connect("draw", ...)` | `set_draw_func()` | For `Gtk.DrawingArea`. Callback signature changes to `(area, cr, width, height)`. |
| `Gtk.IconTheme.get_default()` | `Gtk.IconTheme.get_for_display(Gdk.Display.get_default())` | |
| `Gdk.Cursor(Gdk.CursorType.WATCH)` | `Gdk.Cursor.new_from_name('wait')` | String-based cursor names. |
| `Gtk.Image` (for scaled content) | `Gtk.Picture` | `Gtk.Picture` respects aspect ratio and scales properly; `Gtk.Image` is for fixed-size icons. |

---

## Constants

Ensure you use PyGObject enums correctly (e.g., `Gtk.StateFlags.NORMAL`). Avoid legacy string/integer constants.

---

## Problems & Solutions

Several common problems arise during a port.

### 1. Layouts and Containers

In GTK4, `Gtk.HBox`, `Gtk.VBox`, `Gtk.Table`, and `Gtk.Toolbar` have all been removed. GTK4 shifts layout responsibility away from explicit container packing properties (like `pack_start(expand=True, fill=True)`) and pushes it directly onto the child widgets themselves (using `hexpand`, `vexpand`, `halign`, `valign`).

**Solution**: Migrate to `Gtk.Box` with explicit orientation, and `Gtk.Grid`. When porting `pack_start` or `pack_end`, you must move the expansion/fill flags to the child widget before appending it.

```python
# GTK 3: Expansion properties defined by the container's packing method
vbox = Gtk.VBox()
vbox.pack_start(child_widget, True, True, 0) # expand=True, fill=True

# GTK 4: Expansion properties defined on the child widget itself
vbox = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)
child_widget.set_vexpand(True)
child_widget.set_valign(Gtk.Align.FILL)
vbox.append(child_widget)

# Alternate GTK 4 pattern: prepend (replaces pack_start at index 0)
vbox.prepend(child_widget)
```

### 2. Toolbar Migrations (ToolbarBox)

In standard GTK4, `Gtk.Toolbar` was removed entirely. However, the Sugar Toolkit for GTK4 (`sugar4`) preserves the custom `ToolbarBox`, `ActivityToolbarButton`, and `StopButton` APIs. 

**The Problem**: While the API looks the same, the underlying `ToolbarBox` in `sugar4` is backed by a GTK4 `Gtk.Box`. This means GTK3 packing methods like `.insert()` no longer exist and will crash your activity.

**The Solution**: Update your imports to `sugar4` and use standard GTK4 `.append()` methods to add widgets to the toolbar.

```python
# GTK 3 / sugar3
from sugar3.graphics.toolbarbox import ToolbarBox, ToolbarButton
from sugar3.activity.widgets import ActivityToolbarButton, StopButton

toolbar_box = ToolbarBox()
activity_button = ActivityToolbarButton(self)
# GTK3 used insert()
toolbar_box.toolbar.insert(activity_button, -1)

# GTK 4 / sugar4
from sugar4.graphics.toolbarbox import ToolbarBox, ToolbarButton
from sugar4.activity.widgets import ActivityToolbarButton, StopButton

toolbar_box = ToolbarBox()
activity_button = ActivityToolbarButton(self)
# GTK4 uses append() or prepend() directly on the toolbar attribute
toolbar_box.toolbar.prepend(activity_button)
```

### 3. Event Controllers (Keyboard & Mouse)

GTK4 drops raw event signals (like `key-press-event` or `button-press-event`) in favor of `Gtk.EventController`.

**The Problem**: In GTK3, signals like `key-press-event` were emitted directly on widgets. GTK4 delegates all input to `Gtk.EventController` subclasses.

**The Solution**: Create the appropriate controller, connect to its signal, and attach it to your widget with `add_controller()`. By default, event controllers use the `BUBBLE` propagation phase — events trigger on the focused child widget first and propagate upward. For most activities, this default is correct.

```python
# GTK 4: Standard event controllers (default BUBBLE phase)
# Replace button-press-event:
click_ctrl = Gtk.GestureClick()
click_ctrl.connect("pressed", self._on_button_press)
click_ctrl.connect("released", self._on_button_release)
self.my_widget.add_controller(click_ctrl)

# Replace motion-notify-event:
motion_ctrl = Gtk.EventControllerMotion()
motion_ctrl.connect("motion", self._on_mouse_move)
self.my_widget.add_controller(motion_ctrl)

# Replace key-press-event:
key_ctrl = Gtk.EventControllerKey()
key_ctrl.connect("key-pressed", self._on_key_press)
self.my_widget.add_controller(key_ctrl)
```

**When to use CAPTURE phase**: If your activity contains child widgets that aggressively consume keystrokes (like `Gtk.Entry` or `Gtk.TextView`), the default `BUBBLE` phase means the child swallows the event before your handler sees it. In this case, set the propagation phase to `CAPTURE` so the parent window intercepts the keystroke on its way *down* the hierarchy:

```python
# GTK 4: CAPTURE phase for global shortcuts that must override child widgets
self._key_controller = Gtk.EventControllerKey()
self._key_controller.set_propagation_phase(Gtk.PropagationPhase.CAPTURE)
self._key_controller.connect("key-pressed", self.__on_key_pressed)
self.add_controller(self._key_controller)
```

*Note: Most ported activities (including TurtleArt) work fine without setting `CAPTURE`. Only use it when you have confirmed that child widgets are swallowing events you need.*

For mouse events and gestures (replacing `EventBox` and `SugarGestures`), use the native controllers:
```python
# E.g., for Image Viewer panning/zooming
drag_controller = Gtk.GestureDrag()
self.add_controller(drag_controller)

zoom_controller = Gtk.GestureZoom()
self.add_controller(zoom_controller)
```

### 4. Popups and Wayland Restrictions

**The Problem**: Wayland is incredibly strict about window hierarchies. It does not allow free-floating, unparented windows like X11 did. If you try to spawn a custom `Gtk.Window` or dialog without a parent, Wayland will either render it behind the main window, refuse to give it focus, or simply fail to show it at all.

**The Solution**: You must hunt down every custom alert popup and dialog (e.g., config wizards, help buttons) and explicitly tie them to their parent windows using `.set_transient_for(parent)` and `.set_modal(True)`.

```python
class CustomConfigPopup(Gtk.Window):
    def __init__(self, parent_window):
        super().__init__()
        
        # REQUIRED for Wayland: Tie this popup to the main activity window
        self.set_transient_for(parent_window)
        
        # REQUIRED for Wayland: Prevent interaction with the parent while open
        self.set_modal(True)
```

### 5. Custom Rendering (DrawingArea and Snapshots)

GTK4 completely removes the legacy `draw` signal. There are two main approaches to porting Cairo rendering code, depending on your use case.

#### Approach A: `Gtk.DrawingArea.set_draw_func()` (Recommended for canvases)

If your activity has a dedicated drawing canvas (like TurtleArt's block canvas, or a paint area), `set_draw_func()` is the simplest migration path. It gives you a `cairo.Context` directly — no snapshot conversion needed.

**Important**: The callback signature changed from GTK3's `draw(widget, cr)` to GTK4's `draw(area, cr, width, height)`. The extra `width` and `height` parameters will cause confusing crashes if missed.

```python
# GTK 3: connect to the 'draw' signal
# canvas.connect('draw', self._draw_cb)
# def _draw_cb(self, widget, cr):

# GTK 4: use set_draw_func instead
canvas = Gtk.DrawingArea()
canvas.set_draw_func(self._draw_cb)

def _draw_cb(self, area, cr, width, height):
    # cr is already a cairo.Context — use it directly
    cr.set_source_rgb(0.2, 0.6, 0.8)
    cr.rectangle(0, 0, width, height)
    cr.fill()
    
    # Draw sprites, overlays, etc. using the same cr
    if self.turtle_canvas is not None:
        cr.set_source_surface(self.turtle_canvas)
        cr.paint()
```

To trigger a redraw, call `queue_draw()` on the `DrawingArea` (same as GTK3).

#### Approach B: `do_snapshot()` override (For custom widget subclasses)

If you are creating a custom `Gtk.Widget` subclass (not a `DrawingArea`) that needs to render itself inline within the widget tree, override `do_snapshot()` and use `snapshot.append_cairo()` to get a legacy Cairo context.

```python
import gi
gi.require_version('Gtk', '4.0')
from gi.repository import Gtk, Graphene

class CustomRoundBox(Gtk.Box):
    # Override do_snapshot instead of connecting to the old 'draw' signal
    def do_snapshot(self, snapshot):
        w = self.get_width()
        h = self.get_height()
        
        # Create bounds
        rect = Graphene.Rect().init(0, 0, w, h)
        
        # Grab a Cairo context from the GTK4 snapshot
        cr = snapshot.append_cairo(rect)
        
        # ... Insert legacy Cairo drawing code here ...
        cr.set_source_rgb(1, 0, 0)
        cr.rectangle(0, 0, w, h)
        cr.fill()
        
        # Chain up to allow children to snapshot themselves
        Gtk.Widget.do_snapshot(self, snapshot)
```

### 6. Pixbufs to Cairo (Gdk.cairo_set_source_pixbuf is gone)

GTK4 deprecated and removed the `Gdk.cairo_set_source_pixbuf` helper entirely.

**The Solution**: If your activity relies heavily on sprites and pixbufs (like TurtleArt), you must manually dump the pixbuf data to a PNG buffer in memory, and then read it back as a native `cairo.ImageSurface`.

```python
import io
import cairo

def pixbuf_to_cairo_surface(pixbuf):
    """Simple version: returns a surface sized to the pixbuf's own dimensions."""
    success, png_data = pixbuf.save_to_bufferv("png", [], [])
    if not success:
        return None
    return cairo.ImageSurface.create_from_png(io.BytesIO(png_data))


def pixbuf_to_sized_surface(pixbuf, width, height):
    """Sized-canvas version: paints the pixbuf onto a surface of specific
    dimensions. Useful for block sprites that need exact sizing."""
    surface = cairo.ImageSurface(
        cairo.FORMAT_ARGB32, int(width), int(height))
    context = cairo.Context(surface)
    success, png_data = pixbuf.save_to_bufferv("png", [], [])
    if success:
        img_surface = cairo.ImageSurface.create_from_png(
            io.BytesIO(png_data))
        context.set_source_surface(img_surface, 0, 0)
    else:
        return surface
    context.rectangle(0, 0, int(width), int(height))
    context.fill()
    return surface
```

### 7. Terminal Spawning (VTE)

The simple GTK3 `vte.Terminal().fork_command()` and GTK3-era `fork_command_full()` have been removed or deprecated in modern libvte bindings.

**The Solution**: Rewrite the shell spawning pipeline to use `spawn_async()`, explicitly managing PTY flags and GLib spawn flags.

```python
import os
import gi
gi.require_version('Vte', '3.91')
from gi.repository import Vte, GLib

vt = Vte.Terminal()

def on_spawn_cb(terminal, pid, error, user_data):
    pass

# Use spawn_async instead of deprecated fork_command_full
vt.spawn_async(
    Vte.PtyFlags.DEFAULT,
    os.environ.get("HOME", "/tmp"),
    ["/bin/bash"],
    [],
    GLib.SpawnFlags.DEFAULT,
    None, # child_setup
    None, # child_setup_data
    -1,   # timeout
    None, # cancellable
    on_spawn_cb,
    None  # user_data
)
```

### 8. Multimedia (GStreamer on Wayland)

Passing an X11 window handle (`xid`) to a GStreamer sink will crash under Wayland.

**The Solution**: Adapt your GStreamer pipeline to use `gtk4paintablesink`, which is the proper Wayland-native way to handle video overlays in GTK4.

```python
import gi
gi.require_version('Gst', '1.0')
from gi.repository import Gst

Gst.init(None)

# Use gtk4paintablesink instead of xvimagesink or similar X11 sinks
paintablesink = Gst.ElementFactory.make('gtk4paintablesink', None)

if paintablesink is None:
    print("Warning: gtk4paintablesink not found, video may not render correctly on Wayland")
```

---

### 9. Clipboard and Drag-and-Drop

GTK4 heavily refactors `Gdk.Clipboard` and Drag-and-Drop capabilities, making them exclusively asynchronous to prevent blocking the main thread during IPC (Inter-Process Communication).

* **Clipboard**: Instead of the synchronous `Gtk.Clipboard.get().wait_for_text()`, GTK4 forces you to use asynchronous read methods. 
  * **Failure Mode / Trap**: If your GTK3 code expected to read the clipboard and return a value immediately in the same function, you must refactor your logic to use callbacks or async/await. Attempting to force synchronous reads will break the execution flow or cause deadlocks.

```python
# GTK 3: Synchronous (Blocking)
clipboard = Gtk.Clipboard.get(Gdk.SELECTION_CLIPBOARD)
text = clipboard.wait_for_text()
print(text)

# GTK 4: Asynchronous (Non-blocking callback)
def on_clipboard_read(clipboard, result):
    text = clipboard.read_text_finish(result)
    if text:
        print(text)

clipboard = Gdk.Display.get_default().get_clipboard()
clipboard.read_text_async(None, on_clipboard_read)

# GTK 4: Writing appears synchronous in Python, but acts asynchronously via IPC under the hood
clipboard.set_text("Hello World")
```

* **Drag-and-Drop**: GTK4 replaces the old `drag_dest_set` and `drag_source_set` with `Gtk.DropTarget` and `Gtk.DragSource` event controllers.

```python
# GTK4 Drop Target Example
from gi.repository import GObject
drop_target = Gtk.DropTarget(type=GObject.TYPE_STRING, actions=Gdk.DragAction.COPY)
drop_target.connect("drop", self.on_drop)
self.add_controller(drop_target)
```

### 10. WebKit WebContext to NetworkSession

In GTK4 with WebKit6, `WebKit.WebContext` is no longer the correct place to manage networking state (like cookies or TLS errors).

**The Solution**: Use `WebKit.NetworkSession.get_default()` to handle these operations.

*Note: This migration is only required for activities that manage web state (like the `Browse` activity). If your activity simply renders local content (e.g., the EPUB reader in `Read`), you can bypass `NetworkSession` and just rely on `WebKit.UserContentManager`.*

```python
# GTK 3 (WebKit2)
context = WebKit2.WebContext.get_default()
cookie_manager = context.get_cookie_manager()

# GTK 4 (WebKit6)
network_session = WebKit.NetworkSession.get_default()
network_session.set_tls_errors_policy(WebKit.TLSErrorsPolicy.IGNORE)
cookie_manager = network_session.get_cookie_manager()
```

### 11. Screenshots and Thumbnails

Generating a thumbnail from a widget in GTK3 relied on Cairo surfaces. In GTK4, `get_window()` is gone.

**The Solution**: For generic `Gtk.Widget` instances, use `Gtk.WidgetPaintable` to rasterize the widget to a texture. For `WebKit.WebView` specifically, use its native async `get_snapshot()` API.

```python
# GTK 4: Generic Widget Snapshot
paintable = Gtk.WidgetPaintable.new(my_widget)
snapshot = Gtk.Snapshot()
width, height = my_widget.get_width(), my_widget.get_height()
paintable.snapshot(snapshot, width, height)
node = snapshot.to_node()
# Render node to texture/PNG...

# GTK 4: WebKit.WebView Snapshot
def snapshot_ready(webview, result):
    snapshot_texture = webview.get_snapshot_finish(result)
    bytes_data = snapshot_texture.save_to_png_bytes()

browser.get_snapshot(WebKit.SnapshotRegion.VISIBLE,
                     WebKit.SnapshotOptions.NONE,
                     None,
                     snapshot_ready)
```

### 12. Gestures (Zoom and Drag)

`EventBox` and `SugarGestures` wrappers were used in GTK3 to handle complex touch interactions.

**The Solution**: Replace these entirely with native GTK4 `Gtk.GestureZoom` and `Gtk.GestureDrag`.

```python
# GTK 4
zoom_controller = Gtk.GestureZoom()
zoom_controller.connect("scale-changed", self.on_zoom)
self.add_controller(zoom_controller)
```





## CSS and Theming

GTK 4 introduces significant changes to CSS parsing, widget node names, and supported properties. 

**CRITICAL RULE:** Any CSS added directly within an activity **must be activity-specific**. General UI styling, standard button colors, and globally shared widget appearances should **never** be defined in an activity. All global styles belong in the [sugar-artwork](https://github.com/sugarlabs/sugar-artwork) repository. 

If your activity requires custom CSS for its unique features, follow these guidelines:

### 1. CSS Scoping (Preventing Theme Bleed)
As mentioned in the "Problems & Solutions" section, global CSS injection via `Gtk.CssProvider` will bleed into the Sugar shell (Jarabe) and alter the desktop's appearance. 
If you must use CSS in your activity, bind it strictly to the specific widget's style context, or use a custom CSS class to isolate it.

```python
from sugar4.graphics import style

# The toolkit helper takes a raw string, not a CssProvider object
style.apply_css_to_widget(my_button, ".my-activity-custom-button { background-color: purple; }")

# Then apply that class to your widget
my_button.add_css_class("my-activity-custom-button")
```

### 2. Widget Node Names
In GTK 3, CSS nodes often mirrored the class name (e.g., `GtkLabel`). In GTK 4, CSS nodes are strictly standardized and lowercase (e.g., `label`, `box`, `button`, `window`). You can no longer reliably target widgets by their GType name.
* **GTK 3**: `GtkWindow { background-color: white; }`
* **GTK 4**: `window { background-color: white; }`

*(Tip: You can launch your activity with `GTK_DEBUG=interactive` to inspect the CSS nodes of your widgets at runtime.)*

### 3. Removed GTK-Specific Properties
GTK 4 removes many of the `-gtk-*` prefixed properties that were heavily used in GTK 3.
* `-gtk-icon-effect` (e.g., `dim-label`) is **gone**. Use standard CSS `opacity` or `filter` instead.
* `-gtk-outline-*` properties are **gone**. Use standard CSS `outline` properties.
* `-gtk-gradient` is deprecated in favor of standard CSS `linear-gradient()`.

### 4. Backgrounds and Borders
GTK 4 simplifies backgrounds. You can no longer use `background-image` and `background-color` simultaneously in the same overlapping way GTK3 allowed without explicitly layering them.
* If a widget's background color isn't showing up, ensure `background-image: none;` is set, as some widgets default to an image (like a gradient) that overrides the color.

---

## Tools for API Discovery

With the removal of automated conversion scripts like `pygi-convert.sh`, API discovery requires manual lookup:

* **[GTK4 Documentation](https://docs.gtk.org/gtk4/)**: The primary reference for C API changes.
* **[PyGObject API Reference](https://lazka.github.io/pgi-docs/)**: Crucial for discovering Python-specific bindings, enums, and naming conventions.
* **Python Introspection**: Run `dir(Gtk)` in a Python 3 REPL to dynamically explore available GTK4 classes and methods.

---

## Hacks to help in porting

### Inspecting CSS Nodes with GTK_DEBUG

In GTK4, CSS node names are strictly standardized (e.g., `window`, `button`). To inspect the active node hierarchy and applied CSS classes of your activity in real-time, launch it with the GTK Inspector:

```bash
GTK_DEBUG=interactive python3 local_run.py
```

### The DBus Null-Byte Trap

When sending binary data over DBus (like activity previews), the `dbus-python` bindings may try to parse the stream as a UTF-8 string, treating null bytes as string terminators and truncating the data. Ensure you pass `byte_arrays=True` to the DBus method decorator to force raw binary handling:

```python
@dbus.service.method(IFACE, in_signature="ssayb", out_signature="", byte_arrays=True)
def create(self, name, description, preview_data):
    pass
```

### Write a Standalone Test Script

Testing activities inside the Sugar shell (Jarabe) during a massive porting effort is unstable. It is highly recommended to write a `local_run.py` script to test your GTK4 UI code in isolation, bypassing DBus and Sugar's datastore.

If it crashes in `local_run.py`, the bug is in your activity. If it runs standalone but crashes in Sugar, it's an integration issue.

```python
# local_run.py
import sys
import gi
gi.require_version('Gtk', '4.0')
from gi.repository import Gtk

# Import your main UI widget here
from my_activity_widget import MyWidget 

def on_activate(app):
    win = Gtk.ApplicationWindow(application=app)
    widget = MyWidget()
    win.set_child(widget)
    win.present()

app = Gtk.Application(application_id='org.sugarlabs.Test')
app.connect('activate', on_activate)
app.run(sys.argv)
```

---

## Notes

These are miscellaneous gotchas developers hit mid-port:

* **Python 3 Assumed**: GTK4 Sugar activities inherently assume Python 3. If you are porting an exceptionally old activity still on Python 2, you must complete the Python 3 port first.

* **No automated conversion scripts**: Unlike GTK3 which had `pygi-convert.sh`, there are no automated tools for porting GTK3 Python code to GTK4. You must manually substitute deprecated widgets.
* **Python 3 MRO / C3 Linearization conflicts**: During the porting of complex activities like TurtleArt, you may uncover pre-existing Python 3 Method Resolution Order crashes (e.g., in `util/odf/element.py`). Be prepared to untangle legacy inheritance chains.
* **Subprocess Execution**: While not strictly a GTK4 issue, old code often used `os.popen`. Replace it with `subprocess.run(["cmd"], capture_output=True, text=True)` to modernize Python standard library usage.
* **Gtk.IconView deprecation**: Deprecated starting in GTK 4.10. Migrate to `Gtk.FlowBox`, which is often used alongside `Gtk.Picture` for scaling SVGs properly.
* **Papers instead of Evince**: `EvinceDocument` is no longer viable for GTK4. Migrate PDF handling to `PapersDocument` (Papers 4.0). Note that the Table of Contents (TOC) outline was moved from `GtkTreeModel` to `GListModel`, and `has_document_links()` currently segfaults on `GListModel` input, requiring a full rewrite of the outline parser.
* **`Gtk.IconTheme` API change**: `Gtk.IconTheme.get_default()` is removed. Use `Gtk.IconTheme.get_for_display(Gdk.Display.get_default())` instead.
* **Cursor API change**: `Gdk.Cursor(Gdk.CursorType.WATCH)` is removed. Use `Gdk.Cursor.new_from_name('wait')` with string-based cursor names instead.
* **`Gtk.Picture` vs `Gtk.Image`**: When displaying scaled content (like SVG thumbnails in a FlowBox), use `Gtk.Picture` instead of `Gtk.Image`. `Gtk.Picture` respects aspect ratio and scales content properly, while `Gtk.Image` is designed for fixed-size icons.
* **`set_draw_func` callback signature**: The GTK4 `Gtk.DrawingArea` draw callback takes `(area, cr, width, height)`, not the GTK3 `(widget, cr)`. The extra `width` and `height` parameters cause silent crashes if the old signature is copied over.


## Porting Examples

Here are common structural patterns you will encounter, drawn from the core Fructose activities:

* **Browse Activity**: `Gtk.Toolbar` was completely removed in GTK4. Navigation and toolbars were successfully rebuilt using a combination of `Gtk.Box` and `Gtk.Popover`.
* **Calculate Activity**: Replaced legacy `Gtk.Table` and `pack_start` calls with `Gtk.Grid` and `Gtk.Box`, pushing explicit `hexpand`/`vexpand` properties onto the child widgets.
* **TurtleArt Activity**: Addressed massive `do_snapshot` rendering changes. To maintain legacy drawing logic, sprite pixbufs were explicitly converted to Cairo image surfaces in-memory. Removed `Gtk.IconView` in favor of `Gtk.FlowBox` paired with `Gtk.Picture` for proper SVG scaling.
* **Jukebox Activity**: Adapted media pipelines for Wayland by swapping `xid`-based X11 video sinks for `gtk4paintablesink`.

---

## Resources

* [Sugar Toolkit GTK4 Repository](https://github.com/sugarlabs/sugar-toolkit-gtk4)
* [GNOME GTK4 Migration Guide](https://docs.gtk.org/gtk4/migrating-3to4.html)
* [PyGObject API Documentation](https://lazka.github.io/pgi-docs/)

---

## Releasing Activities (For maintainers)

Once an activity is ported, a new release can be made. The major version should be greater than the existing one.

Please follow the standard [maintainer checklist](contributing.md#checklist---maintainer) for releasing a new version. Ensure that you test thoroughly on a modern environment (like Debian 13 Trixie) under both X11 and Wayland before publishing (verified via `local_run.py`).
