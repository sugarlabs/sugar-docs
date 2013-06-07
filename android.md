Sugar on Android
================

An Android activity
-------------------

This are the manual steps needed to get a web activity in Android.
The process needs to be automated when things stabilize. Ideally we
could enhace the activity setup.py to do:

    ./setup.py dist-apk

The APK could be built using the android sdk and after that, an APK
will appear in the activity dist/ directory.

### Activity icon

Android stores app icons in different sizes: : 512x512, 144x144,
96x96, 72x72, 48x48 . For details see
<http://developer.android.com/guide/practices/ui_guidelines/icon_design_launcher.html>.

To convert an SVG icon to a big enough PNG do:

    convert -background none -density 1200 -resize 512x512 activity/activity-icon.svg activity-icon.png

### Android project

We'll make an Android app with just one Android activity inside, which
is the default project the IDE creates.  In Android ADT (the Android
modified Eclipse), create a new Android project.

* App name: My Activity
* Project name: MyActivity
* Package name: org.sugarlabs.myactivity
* Theme: doesn't matter
* Icon: select the converted PNG icon (see Activity icon section above)

Then, the important part is to copy all the web activity contents to
the **assets** directory.  The rest you can copy from another project,
like <https://github.com/manuq/clockjs-android>.

Android shell
-------------

Here is an Android project that contains a bound server other apps can
bind to: <ttps://github.com/manuq/aboutmejs-android/>.  This server
needs to be separated in its own app.  The important bits are:

* the Intent filter in
  [AndroidManifest.xml](https://github.com/manuq/aboutmejs-android/blob/master/AndroidManifest.xml)

* [SugarService.java](https://github.com/manuq/aboutmejs-android/blob/master/src/org/sugarlabs/aboutme/SugarService.java)

An activity launcher for Android
--------------------------------

In Android, a launcher is basically just another app, that has an
Intent with a category
[CATEGORY_HOME](http://developer.android.com/reference/android/content/Intent.html#CATEGORY_HOME).

Being a normal Android app, it can be a web activity.  And it could be
possible to put colors to the launcher SVG icons and organize them in
a spiral, just like the GTK Sugar home.

There is a Home screen replacement sample which can be found in the
[samples in the
android-sdk](http://developer.android.com/tools/samples/index.html). It
can be built and installed as any other app, following the steps at
<https://developer.android.com/training/basics/firstapp/creating-project.html>.
