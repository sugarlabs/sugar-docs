Measuring coverage of Python activities
=======================================

* install the `python-coverage` package,
* start Terminal activity inside Sugar,
* change to the directory that holds activity source code,
* run the activity like this;

```
python-coverage run /usr/bin/sugar-activity
```

* run any test scripts, such as those using `xdotool`,
* stop the activity,
* generate annotated HTML listings,

```
python-coverage html
```

* run the SimpleHTTPServer module in a background process,

```
python -m SimpleHTTPServer &
```

* browse to http://localhost:8000/

Tested on Ubuntu 18.04.

See the [Python Coverage](https://coverage.readthedocs.io) documentation.
