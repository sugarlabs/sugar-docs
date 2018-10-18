# How Can I Help?
## Table Of Contents
1.  [Prepare](#PREPARE)
2.  [Coding/Documentation/Quality Assurance](#OUTREACHY-GSOC)
3.  [Design](#DESIGN-TEAM)
4.  [Marketing/Outreach](#MARKETING-OUTREACH)
5.  [Important Links](#IMPORTANT-LINKS)
5.  [I'm Stuck!](#IM-STUCK)

## <a name="PREPARE"></a> Prepare
Before contributing to Sugar Labs, you should use Sugarizer or Sugar Desktop.

### Sugarizer

<table style="width:100%; border-collapse:collapse">
  <tbody><tr>
    <th style="border: 2px black solid">Your Equipment</th>
    <th style="border: 2px black solid">Your Operating System</th> 
    <th style="border: 2px black solid">Recommendations</th>
  </tr>
  <tr>
    <td style="border: 2px black solid">You have a tablet or phone</td>
    <td style="border: 2px black solid">Android</td> 
    <td style="border: 2px black solid">Install the <a href="https://sugarizer.org/">Sugarizer</a> app from Google Play.</td>
  </tr>
  <tr>
    <td style="border: 2px black solid">You have a tablet or phone</td>
    <td style="border: 2px black solid">iOS</td> 
    <td style="border: 2px black solid">Install the <a href="https://sugarizer.org/">Sugarizer</a> app from the App Store.</td>
  </tr>
  <tr>
    <td style="border: 2px black solid">You have a Chromebook</td>
    <td style="border: 2px black solid">Chrome OS</td> 
   <td style="border: 2px black solid">Install the <a href="https://sugarizer.org/">Sugarizer</a> app from the Chrome Web Store.</td>
  </tr>
  <tr>
    <td style="border: 2px black solid">You have a Windows computer</td>
    <td style="border: 2px black solid">Windows</td> 
    <td style="border: 2px black solid">Install the <a href="https://sugarizer.org/">Sugarizer</a> app from the Windows Store.</td>
  </tr>
</tbody></table>

  * [Complete the activity development tutorial](https://github.com/llaske/sugarizer/blob/master/docs/tutorial.md)
 

### Sugar Desktop

<table style="width:100%; border-collapse:collapse">
  <tr>
    <th style="border: 2px black solid">Your Equipment</th>
    <th style="border: 2px black solid">Your Operating System</th> 
    <th style="border: 2px black solid">Recommendations</th>
  </tr>
  <tr>
    <td style="border: 2px black solid">You have only one computer and don't want to erase it</td>
    <td style="border: 2px black solid">Linux, Windows, macOS, or iOS</td> 
    <td style="border: 2px black solid">Install virtualisation software, make a new virtual machine and install <a href="https://wiki.sugarlabs.org/go/Live_Build">Sugar Live Build</a>, <a href="https://wiki.sugarlabs.org/go/SoaS">Sugar on a Stick</a>, <a href="https://wiki.sugarlabs.org/go/Ubuntu">Ubuntu</a>, <a href="https://wiki.sugarlabs.org/go/Fedora">Fedora</a>, or <a href="https://wiki.sugarlabs.org/go/Debian">Debian</a>.</td>
  </tr>
  <tr>
    <td style="border: 2px black solid">You have only one computer and don't want to erase it</td>
    <td style="border: 2px black solid">Linux</td> 
    <td style="border: 2px black solid">Install Sugar packages from your distribution, see <a href="https://wiki.sugarlabs.org/go/Ubuntu">Ubuntu</a>, <a href="https://wiki.sugarlabs.org/go/Fedora">Fedora</a>, or <a href="https://wiki.sugarlabs.org/go/Debian">Debian</a>. For other distributions, contact your distribution community.</td>
  </tr>
  <tr>
    <td style="border: 2px black solid">You have another computer that can be erased</td>
    <td style="border: 2px black solid">Doesn't matter</td> 
    <td style="border: 2px black solid">Install <a href="https://wiki.sugarlabs.org/go/Live_Build">Sugar Live Build</a>, <a href="https://wiki.sugarlabs.org/go/SoaS">Sugar on a Stick</a>, <a href="https://wiki.sugarlabs.org/go/Ubuntu">Ubuntu</a>, <a href="https://wiki.sugarlabs.org/go/Fedora">Fedora</a>, or <a href="https://wiki.sugarlabs.org/go/Debian">Debian</a>.</td>
  </tr>
</table>

  * Learn how to use Sugar and activities, see [Help](https://help.sugarlabs.org/),
  * [Setup a development environment](https://github.com/sugarlabs/sugar/blob/master/docs/development-environment.md)


## <a name="OUTREACHY-GSOC"></a> Coding, Documentation and Quality Assurance
Coding, documentation and quality assurance is important - it is required everywhere from producing new software, rolling out new features, maintaining and upgrading current releases, distributing instructions for others to know how to operate the software, and ensuring that others can use software without any problem.

  * We have mentoring opportunities through our participation in programs such as [Outreachy](https://wiki.sugarlabs.org/go/Outreachy), [Google Summer Of Code](https://wiki.sugarlabs.org/go/Summer_of_Code/2017), and [Google Code-In](https://wiki.sugarlabs.org/go/Google_Code_In_2017). You can read about these programs in the Wiki.
  * Another way you can contribute to Sugar Labs is the [Release Engineer's Feature Tracking wiki page](https://wiki.sugarlabs.org/go/Features). These are features proposed and implemented by other Sugar Labs community contributors. The progress of the feature is also indicated in the page - please contribute to tasks which are "In Progress".
  * You can test Sugar and Activities and familiarise yourself with Sugar, making a note of where your expectation is betrayed by your observations, then seek feedback from others to learn if your expectation was right, and post inconsistencies to the corresponding GitHub repository issues page, [Wiki](https://wiki.sugarlabs.org), or mailing list [sugar-devel@lists.laptop.org][2],
  * You can go to a specific GitHub repository and work on the bugs in the source code.  Choose the "Issues" tabs and work through the various issues listed in it. The main Sugar Labs GitHub Repositories are listed in the "Important Sugar Labs Links".
  * You can write documentation, see the [Wiki](https://wiki.sugarlabs.org), the [Help Activity](http://wiki.sugarlabs.org/go/Activities/Help/Contribute) which is kept in the [Help](https://github.com/godiard/help-activity) repository, and this [developer documentation](docs.md).
  * You can update web sites, see [www.sugarlabs.org](https://www.sugarlabs.org/) which is kept in the [www-sugarlabs](https://github.com/sugarlabs/www-sugarlabs) repository.
  * You can monitor [activities.sugarlabs.org](https://activities.sugarlabs.org/) for activities to download in Sugar.
  * You can choose to write your own [desktop activity][1] or write your own [web activity][5].
  * You can port activities which are in GTK+ 2 to GTK+ 3, using the [guide](gtk3-porting-guide.md).
  * You can port activities which are in Python 2 to Python 3, using the [guide](python-porting-guide.md).
  * You can test code coverage of activities, using the [guide](python-coverage-guide.md).

## <a name="DESIGN-TEAM"></a> Design
Design is also crucial to Sugar Labs - it is where new ideas and initiatives are formed into proper reports which can be worked on. You can either contribute a new design proposal or implement an existing one in the [Design Team User Experience Proposals wiki page](https://wiki.sugarlabs.org/go/Design_Team/Proposals).

## <a name="MARKETING-OUTREACH"></a> Marketing/Outreach
You can help to increase the number of Sugar Labs users through -

  * Write translations, see [Translation Team](https://wiki.sugarlabs.org/go/Translation_Team) and [translate.sugarlabs.org](https://translate.sugarlabs.org/), thereby the user experience of users speaking other languages.
  * Publish blogs and detail your experience using Sugar Labs software, introducing more people to use Sugar Labs software.
  * Design and execute lesson plans to introduce more children and youth to Sugar Labs, either in schools, outside school or in an informal setting.

## <a name="IMPORTANT-LINKS"></a> Important Sugar Labs Links
The links listed below are of important Sugar Labs code repositories, wiki and website. Some of the code repositories ar based under the Sugar Labs GitHub Organisation, while others are not.

__Github Organisation Page__

  * [Sugar Labs](https://github.com/sugarlabs)

__GitHub Repositories Under Sugar Labs__

  * [Sugar Shell for GTK+ 3](https://github.com/sugarlabs/sugar)
  * [Sugar Toolkit for GTK+ 2](https://github.com/sugarlabs/sugar-toolkit)
  * [Sugar Toolkit for GTK+ 3](https://github.com/sugarlabs/sugar-toolkit-gtk3)
  * [Sugar Build/Development Scripts](https://github.com/sugarlabs/sugar-build)
  * [Sugar Artwork](https://github.com/sugarlabs/sugar-artwork)
  * [Sugar Labs Documentation](https://github.com/sugarlabs/sugar-docs)
  * [Sugar Labs Website](https://github.com/sugarlabs/www-sugarlabs)

__GitHub Repositories Not Under Sugar Labs__

  * [Sugarizer](https://github.com/llaske/sugarizer)
  * [TurtleBlocksJS](https://github.com/walterbender/turtleblocksjs)
  * [MusicBlocks](https://github.com/walterbender/musicblocks)
  * [Help Activity](https://github.com/godiard/help-activity)

__Other Relevant Links__

  * [Sugar Labs Website](https://www.sugarlabs.org/)
  * [Sugar Labs Wiki](https://wiki.sugarlabs.org/go/Welcome_to_the_Sugar_Labs_wiki)
  * [Sugar Labs IRC](https://chat.sugarlabs.org:9091/)

## <a name="IM-STUCK"></a>I'm Stuck!
Well, don't worry; there are real people here who will try to help you. Some
ways to get in touch with real people are:

* [Hang out on the irc](irc://irc.freenode.net#sugar). Please stay for a
little while, as people will come and go at different times of the day.
* [Send an email on the mailing list][3]


[1]: desktop-activity.md
[2]: https://bugs.sugarlabs.org
[3]: https://lists.sugarlabs.org/listinfo/sugar-devel
[4]: https://wiki.sugarlabs.org/go/Mentors
[5]: web-activity.md
