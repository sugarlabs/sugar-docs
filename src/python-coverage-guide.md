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

* browse to http://localhost:8000/htmlcov

Tested on Ubuntu 18.04 and Ubuntu 16.04.

See the [Python Coverage](https://coverage.readthedocs.io) documentation.

Measuring coverage during collaboration
=======================================

When an activity is started to join a collaboration, there is little opportunity to intercept and add the command-line wrapper.

`/usr/bin/sugar-activity3` may be edited to add coverage API calls.  See [Coverage.py API](https://coverage.readthedocs.io/en/v4.5.x/api.html).
