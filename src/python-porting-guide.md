Guide for porting activities from Python 2 to Python 3
=======================================

 1. Download the Python 2-3 compatible version of Sugar Toolkit GTK+ 3, from [here](https://github.com/Pro-Panda/sugar-toolkit-gtk3/tree/python3-port)
 2. Add this toolkit in the Python 2 and Python 3 set of libraries
 3. Port the code in your activity from Python 2 to Python 3
 4. Changes `exec` value in `activity.info` from `sugar-activity...` to `sugar-activity3...`
 5. Check for flake8 fixes by typing `python3 -m flake8 *.py`
 6. Test run the activity.
 7. Try building the activity by typing the command `python3 setup.py dist_xo`
 8. Once all issues are resolved, open a pull request on the github repository of that activity

**Note:** The Python 2-3 compatible toolkit is still in development mode. Kindly report any issues experienced, [here](https://github.com/sugarlabs/sugar-toolkit-gtk3/pull/383)

**Note:** These steps were tested using Python 3.6.3
