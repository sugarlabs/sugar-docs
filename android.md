Sugar on Android
================

Web activity on Android
-----------------------

Currently there are several manual steps that need to be executed in
order to create a web activity for Android. When things stabilize the
process can be automated, ideally we would enhance the setup.py
command to build an Android application package file (APK) ready for
distribution and installation on a device running Android.

    ./setup.py dist-apk

The APK could be built using the android sdk and after that, an APK
would appear in the activity dist/ directory.

### Activity icon

Android stores app icons in different sizes: : 512x512, 144x144,
96x96, 72x72, 48x48 . For details see
<http://developer.android.com/guide/practices/ui_guidelines/icon_design_launcher.html>.

To convert an SVG icon to a PNG suitable as a launcher icon you can
use the 'convert' command from <http://www.imagemagick.org>.

    convert -background none -density 1200 -resize 512x512 activity/activity-icon.svg activity-icon.png

### Android project

Make an Android app with one android.app.Activity inside, which is the
default project the IDE creates. See
<https://developer.android.com/training/basics/firstapp/creating-project.html>.

For the icon, select the converted PNG icon in the Activity icon
section above.

Copy all the web activity contents to the **assets** directory.  You
can copy the boilerplate and adjust from
<https://github.com/manuq/clockjs-android>.

Android shell
-------------

Here is an Android project that contains a bound service to which
other apps can bind to: <https://github.com/manuq/aboutmejs-android/>.
This service needs to be separated in its own app.  The important bits
are:

* the Intent filter in
  [AndroidManifest.xml](https://github.com/manuq/aboutmejs-android/blob/master/AndroidManifest.xml)

* [SugarService.java](https://github.com/manuq/aboutmejs-android/blob/master/src/org/sugarlabs/aboutme/SugarService.java)

An activity launcher for Android shell
--------------------------------------

In Android is possible to replace the default launcher. A launcher is
basically a normal app, that has an Intent with a category
[CATEGORY_HOME](http://developer.android.com/reference/android/content/Intent.html#CATEGORY_HOME).

Being a normal Android app, it can be a web activity.  And it would be
possible to put colors to the launcher SVG icons and organize them in
a spiral, just like the GTK Sugar home.

There is a Home screen replacement sample in the
[android-sdk samples](http://developer.android.com/tools/samples/index.html). It
can be built and installed as any other app, following the steps at
<https://developer.android.com/training/basics/firstapp/creating-project.html>.

Debugging web activities on Android
-----------------------------------

To get the inspector in your web activity using Chrome, see [Remote
Debugging on
Android](https://developers.google.com/chrome-developer-tools/docs/remote-debugging).
