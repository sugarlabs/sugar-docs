Humane Interface Guidelines
===========================

The Grid System
---------------

In keeping with the simple, flat visual style of the Sugar interface,
all of the interface elements are designed on a straightforward grid
system.  The system functions like a basic floorplan which allows
interface elements to tile neatly within its boundaries.  The grid of
the original XO consists of a 16x12 array of square tiles.

The diagram below shows the screen dissected into cells in a 16x12
grid.  Furthermore, the cells highlighted in blue indicate the area
covered by the activity toolbar.  Note the exclusion of the corners,
which are reserved for the hot corners which invoke the frame in Sugar
GTK.  In order to prevent accidental invocation, no buttons should be
placed in these locations.

[FIXME screenshots: grid in horizontal and vertical layouts]

Note that there is a maximum available space for the elements in the
toolbar, and it is 10 cells.  This is given by the most constrained
layout, the vertical layout.  Activity developers need to consider
this.  By the way, an arbitrary amount of interface elements can be
added in palettes, as we'll see.

Each cell is comprised of a 5x5 array of subcells.  These subcells
provide layout guidelines at a finer level of detail.  In general, the
3x3 subcell interior region is icon-safe.

[FIXME screenshot: icons and subcells]

When a new screen is targetted, the size of the subcell should be
determined to make the grid fit the screen.  For example, in the
original XO with the screen at its maximum resolution of 1200x900
pixels in luminance mode, each square tile is 75x75 pixels in size.
Then each cell is comprised of a 5x5 array of 15 pixel subcells.
