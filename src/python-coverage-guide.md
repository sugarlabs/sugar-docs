Measuring coverage of Python activities
=======================================

* install the `python3-coverage` package,
* start Terminal activity inside Sugar,
* change to the directory that holds activity source code,
* run the activity like this;

```
python3-coverage run /usr/bin/sugar-activity3
```

* run any test scripts, such as those using `xdotool`, or your test plan,
* stop the activity,
* generate annotated HTML listings,

```
python3-coverage html
```

* run the http.server module in a background process,

```
python3 -m http.server &
```

* browse to http://localhost:8000/htmlcov

Tested on Ubuntu 18.04 and 19.04.

See the [Python Coverage](https://coverage.readthedocs.io) documentation.

Measuring coverage during collaboration
=======================================

When an activity is started to join a collaboration, there is little opportunity to intercept and add the command-line wrapper.

`/usr/bin/sugar-activity3` may be edited to add coverage API calls.  See [Coverage.py API](https://coverage.readthedocs.io/en/v4.5.x/api.html).
