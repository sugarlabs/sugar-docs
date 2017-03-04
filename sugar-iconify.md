#Sugar Iconify

##Description

This script will create Sugar-compatible SVG icons from input.svg by
adding the appropriate stroke and fill entities. It has two primary
modes of operation: single-icon and icon set. For additional
information about creating an SVG suitable for passing as the input
to this script, see the tutorial on Making Sugar Icons.

Single-icon: The default operation creates a single sugar icon — for
instance an activity icon — from the input SVG. By default, the
Sugarized icon will be written to a new file named input.sugar.svg,
optionally in the output directory specified with -d. By invoking
the -o option, the input file will be overwritten in place.

In some cases, you may desire to update a single icon, or a subset of
the icons defined within a given SVG. To do so, pass a pattern to the
script with -p, and only those icons which match the pattern will be
exported.

```
Options

   -c    Apply default color entities (#666666, #FFFFFF) to output 
   -d    [directory] The preferred output directory 
   -e    Do not insert entities for strokes and fills 
   -f    [hex] Hex value to replace with fill entity 
   -g    Automatically accept guesses for stroke and fill entities 
   -h    Display this help message 
   -i    Insert "isolated stroke" entities 
   -m    Multiple export; export top level groups as separate icons 
   -o    Modify input file in place, overwriting it; overridden by -m 
   -p    [pattern] Only export icons whose name contains pattern 
   -s    [hex] Hex value to replace with stroke entity 
   -v    Verbose 
   -x    Create HTML preview files, for icon validation 
```

##Instantiating SugarIconify

``` 
   from sugariconify import SugarIconify
   icon = SugarIconify()
```

##Methods

#####set_stroke_color():
It is equivalent of -s on command line, it can be a hex value
(e.g #FFFF00) or a rgb percent value such as rgb(31%, 28%, 56%).

```
   icon.set_stroke_color('#FFFF00')
   icon.set_stroke_color('rgb(55%, 12%, 55%)')
```
#####set_fill_color():
It is quivalent of -f on command line, it can be a hex value
(e.g #FF0000) or a rgb percent value such as rgb(32%, 33%, 87%).

```
   icon.set_fill_color('#FFFFFF')
   icon.set_fill_color('rgb(55%, 12%, 55%)')
```
#####set_confirm_guess():
It is equivalent of -g on command line, so it can automatically
accept guesses for stroke and fill entities, True or False are
the only accepted values.

```
   icon.set_confirm_guess(True)
```
#####set_use_default_colors():
It is equivalent of -c on command line, uses default stroke and
fill entities (#666666, #FFFFFF) for sugar iconify, True or False
are the only accepted values.

```
   icon.set_use_default_colors(True)
```

#####set_overwrite_input():
It is equivalent of -o on command line, overrides input file in
place, True or False are the only accepted values.

```
   icon.set_overwrite_input(True)
```

#####set_output_path():
It is equivalent of -d on command line, sets the output path where
the iconified file will be placed, string values are accepted.

```
   icon.set_output_path('/home/user/Desktop')
```

#####set_use_entity():
It is  equivalent of -e on command line, do not insert entities for
strokes and fills, True or False are the only accepted values.

```
   icon.set_use_entity(True)
```

#####set_verbose():
It is equivalent of -v on command line, outputs information messages
on console, True or False are the only accepted values.

```
   icon.set_verbose(True)
```
#####set_pattern():
It is equivalent of -p on command line, only export icons whose name
contains pattern, string values are accepted.

```
   icon.set_pattern('pattern')
```
#####set_multiple():
It is  equivalent of -m on command line, export top level groups as 
separate icons, True or False are the only accepted values.

```
   icon.set_multiple(True)
```
#####set_output_examples():It is equivalent of -x on command line,
create HTML preview files, for icon validation, True or False are
the only accepted values.

```
   icon.set_output_examples(True)
```

#####set_use_iso_strokes():
It is equivalent of -i on command line, insert "isolated stroke"
entities, True or False are the only accepted values.

```
   icon.set_use_iso_strokes(True)
```

You can find more at : https://wiki.sugarlabs.org/go/Sugar_iconify