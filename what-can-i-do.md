## Table Of Contents
1. [What Can I Do? A Brief Overview] (#what-can-I-do)
2. [Outreachy/GSoC Tasks] (#outreachy-gsoc)
3. [Release Engineer's Tasks] (#release-engineer)
4. [Design Team UX Tasks] (#design-team)
5. [Sugar Labs Repository Issue Lists] (#issue-lists)
6. [I'm Stuck!] (#im-stuck)

## What Can I Do? A Brief Overview <a name="what-can-I-do"></a>

Developers can do anything.  Start with what you know and work down this list;
  * Install Sugar, see Wiki pages [Fedora](https://wiki.sugarlabs.org/go/Fedora), [Debian](https://wiki.sugarlabs.org/go/Debian), and [Ubuntu](https://wiki.sugarlabs.org/go/Ubuntu),
  * Learn how to use Sugar and activities, see [Help](https://help.sugarlabs.org/),
  * Test Sugar and Activities; familiarise yourself with Sugar, make a note of where your expectation is betrayed by your observations, seek feedback from others learn if your expectation was right, and post inconsistencies to GitHub [issues](https://github.com/sugarlabs/sugar/issues), to our [bug tracker](https://bugs.sugarlabs.org/), [Wiki](https://wiki.sugarlabs.org), or mailing list [sugar-devel@lists.laptop.org][2],
  * Write documentation, see the [Wiki](https://wiki.sugarlabs.org), the [Help Activity](http://wiki.sugarlabs.org/go/Activities/Help/Contribute) which is kept in the [Help](https://github.com/godiard/help-activity) repository, and this [developer documentation](docs.md.html),
  * Update web sites, see [www.sugarlabs.org](https://www.sugarlabs.org/) which is kept in the [www-sugarlabs](https://github.com/sugarlabs/www-sugarlabs) repository,
  * Monitor [activities.sugarlabs.org](https://activities.sugarlabs.org/) for activities to download in Sugar,
  * Write translations, see [Translation Team](https://wiki.sugarlabs.org/go/Translation_Team) and [translate.sugarlabs.org](https://translate.sugarlabs.org/),
  * [Setup a development environment](dev-environment.md.html)
  * [Write your own desktop activity][1]
  * [Write your own web activity][5]
  * Implement new programs or fix some bugs in the tasks listed below.
  * And anything else!

## Outreachy/GSoC Tasks <a name="outreachy-gsoc"></a>
Outreachy and GSoC (Google Summer Of Code) are internship programs which attaches interns to a free and open source organisation (such as Sugar Labs). Interns work on several major tasks in the different repositories of the organisation. The tasks listed below were originally intended for students  (at least for GSoC), however anyone can work on the tasks listed below-

|Title |Mentors |Key Details |Prerequisite Knowledge |
|----- |------- |----------- |---------------------- |
|Internationalization and Localization |Chris Leonard |A goal of Sugar Labs is to enable our users to experience Sugar in their own native language. Our expected result is work flow improvements for internationalisation (i18n). |Pootle, Python, Javascript |
|New Back-end Server for Turtle Blocks and Music Blocks |Walter Bender, Vikram Ahuja, Ignacio Rodriguez |Previously we had explored with using a Git-like back end for projects so that they could be cloned and forked. Now, we hope to implement and deploy this new approach. |Git, JavaScript, Server-Side Skills |
|Going Beyond Equal Temperament in Music Blocks |Walter Bender, Devin Ulibarri |Most modern music systems are designed around equal temperament. But there are many ways to chose and tune notes in a musical system that offer different expressive characteristics. We hope to extend Music Blocks such that different approaches to temperament are available to the user. |JavaScript, Music Theory |
|Maintaining The Sugar Labs Website |Ignacio Rodriguez, Samson Goddy, Tymon Radzik, Hrishi Patel |Sugar Labs has a new look for its homepage, with the goals of making it more attractive and easier to explore. We hope to fix some remaining issues and bugs. |JavaScript, HTML, CSS, Ruby, JQuery, Jekyll, Django |
|Maintenance of ASLO (activities.sugarlabs.org) |Tony Anderson |ASLO is the Sugar Labs app store, where activities are hosted and downloaded. Some maintenance tasks are needed. We hope to fix downloads by non-Sugar browsers and new versions of Sugar, make activity maintainer take-overs easier (not easy at the moment), adopt the new look from the new Sugar Labs site as theme now is quite old, show new activity.info metadata such as source repository, semi-automate common maintenance tasks like adding a new Sugar version and document future maintenance on the Wiki. |PHP, MySQL, Python, Apache, cron, PHP-Cake, JavaScript, HTML, CSS, Git |
|School Management Backend |Walter Bender |Sugar is a desktop and a collection of apps. It has great internal features for collaboration and journaling, but it doesn't have any mechanism for managing courses/curriculum/administrative functions commonly found in "school management systems". It could be possible to overlay on top of Sugar web-services such a toolkit. We hope to create a framework, a core implementation, and documentation for expanding the implementation. |Python, Django |
|Sugarizer Server Dashboard |Lionel Laské, Michaël Ohayon |Sugarizer is a way to use Sugar on any device using web technologies (HTML5/JavaScript). We hope to implement a "Sugarizer Server Dashboard", which requires an enhancement of the existing Sugarizer Server API specifically to integrate a real authentication mechanism and allow to manage and analyze all activity on a Sugarizer Server. |HTML5, JavaScript, Bootstrap, NodeJS, MongoDB |
|Sugarizer Deployement and Management Tool for Android |Michaël Ohayon, Lionel Laské |Sugarizer is a way to use Sugar on any device using web technologies. Sugarizer can be deployed on many devices including Android phones and tablets. We hope to implement a "Sugarizer Deployment and Management Tool for Android",  a GUI Tool working on GNU/Linux, Mac and Windows to deploy and configure Android devices using ADB (Android Debug Bridge). |Java, JavaFX, Kotlin, TornadoFX |
|Upgrading From GTK2 To GTK3 |Ignacio Rodriguez, Sam Parkinson, Abhijit Patel | As GTK2 and GST0.10 are not going to be supported, we need to upgrade the remaining Sugar activities with these dependencies. We hope to publish new versions of Turtle, Speak, Chat, Record, and a dozen other activities. |GTK, GST, Python |
|Develop Activity |Sebastian Silva |We don't have a Javascript IDE for writing activities. This is a proposal to collaborate in making one; it would have templates for writing Javascript and Python. We hope to implement a new activity capable of making new activities, runnable in Web and Sugarizer. |Python, Javascript, HTML5, CSS |
|Sugar on Raspberry Pi |Walter Bender, Hrishi Patel, Abhijit Patel |Raspberry Pi is a popular tool with the Maker Movement. Sugar runs quite well on RPi3, but it is in need of some love. We hope to create an image for RPi, which boots to a Sugar desktop environment, and is suitable for inclusion on the RPi download page. |Debian/Fedora Packaging, Linux, Shell |
|Music Blocks for Mobile |Walter Bender, Devin Ulibarri |Music Blocks was written for a browser, not mobile. It would be great to have a version native to mobile. We hope to create a working version on Android/iOS, some UI adjustments will be necessary. |JavaScript, Cordova, React/Swift |
|Collab Rethink |Abhijit Patel, Walter Bender |Sugar collaboration uses a deprecated library, python-telepathy, which we no longer wish to maintain. We need to upgrade Sugar collab using something better. We hope to have a working version of revised collab system, with refactored presenceservice and a common Collabwrapper module for all sugar activities. |Python, Networking, Telepathy |

## Release Engineer's Tasks <a name="release-engineer"></a>

## Design Team UX Tasks <a name="design-team"></a>

## Sugar Labs Repository Issue Lists <a name="issue-lists"></a>

## I'm Stuck! <a name="im-stuck"></a>

Well, don't worry; there are real people here who will try to help you. Some
ways to get in touch with real people are:

* [Hang out on the irc](irc://irc.freenode.net#sugar). Please stay for a
little while, as people will come and go at different times of the day.
* [Send an email on the mailing list][3]

Some of our developers have elected to be put on the list of mentors.
You can find the list [here][4].

[1]: desktop-activity.md.html
[2]: https://bugs.sugarlabs.org
[3]: https://lists.sugarlabs.org/listinfo/sugar-devel
[4]: https://wiki.sugarlabs.org/go/Mentors
[5]: web-activity.md.html
