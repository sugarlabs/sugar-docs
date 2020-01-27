Contributing
============

We use the pull-request model, see [GitHub's help on pull-request](https://help.github.com/articles/using-pull-requests).

In brief, you will:

* on GitHub, find and fork the source repository;
* on your computer, clone your fork repository,
* commit your changes in a new branch;
* push your branch and submit a pull-request for it;
* go through the review process until your pull-request is merged; and

Please note there is no need to ask permission to work on an
issue. You should check for pull requests linked to an issue you are
addressing; if there are none, then assume nobody has done
anything. Begin to fix the problem, test, make your commits, push your
commits, then make a pull request. Mention an issue number in the
pull request, but not the commit message. These practices allow the
competition of ideas (Sugar Labs is a meritocracy).

Modifying Activities
--------------------

Most activity repositories can be found in our [GitHub `sugarlabs`
organization](https://github.com/sugarlabs).

A few activity repositories are somewhere else; read the
`activity/activity.info` file, check the metadata on the
[activities.sugarlabs.org app
store](https://activities.sugarlabs.org/), or the [Activity page on
wiki.sugarlabs.org](https://wiki.sugarlabs.org/go/Activity), or our
deprecated [gitorious instance](https://git.sugarlabs.org/).

For new activities, see [Write your own Sugar desktop
activity](desktop-activity.md), or [Write your own Sugar web
activity](web-activity.md), then make a new repository in your
GitHub account, put the source code in it, then ask the [systems@
list](https://lists.sugarlabs.org/listinfo/systems) to move it to the
GitHub `sugarlabs` organization.

After modifying an activity, a new release may be needed.  Some activities have no maintainer, so you may need to be the maintainer for a short time.

### Checklist - anyone

* [ ] run the activity and confirm that you understand what it is for, what it does, and how a child will use it,

* [ ] make a fork and clone it,

* [ ] check if what you want to change is available already in any other branches or forks,

* [ ] make and [test](#testing) your changes,

* [ ] if your changes add a new feature or will affect users; update the NEWS file, the README.md file, and the help-activity,

* [ ] if there is a `po/*.pot` file, and your changes affect translated strings; regenerate using `python setup.py genpot`,

* [ ] make a branch, one or more commits, and a pull request, see [Workflow](#workflow) below.

### Checklist - maintainer

* [ ] for Python 2 branches, check version of latest bundle release in
  [activities.sugarlabs.org](https://activities.sugarlabs.org/),

* [ ] check version of latest tarball release in [download.sugarlabs.org/sources/sucrose/fructose/](https://download.sugarlabs.org/sources/sucrose/fructose/) or [download.sugarlabs.org/sources/honey/](https://download.sugarlabs.org/sources/honey/),

* [ ] check for a release version git tag, e.g. v34,

* [ ] correlate with `activity_version` metadata in `activity/activity.info`,

* [ ] look for commits _after_ any of these, in either;

    * [ ] master branch of repository at sugarlabs,
    * [ ] any other branches,
    * [ ] any other forks,
    * [ ] orphaned repositories with the same `bundle_id` value, using GitHub or Google Search,
    * [ ] deprecated repositories at git.sugarlabs.org,

* [ ] review and merge all pull requests,

* [ ] apply all desired commits, making pull requests if review is needed,

* [ ] apply any [translate.sugarlabs.org](https://translate.sugarlabs.org) changes, e.g. using a [download script](https://github.com/sugarlabs/sugar-tools/blob/master/activity-translations),

* [ ] if there is a `po/*.pot` file, regenerate using `python setup.py genpot`, review the changes, and commit,

* [ ] notify our translation-community manager @leonardcj if the POT file changes contain new or changed strings,

* [ ] update the README.md file if necessary,

* [ ] write release notes for the NEWS file, change the `activity_version` metadata in `activity/activity.info`, commit, and `git tag` the version,

* [ ] update the activity documentation in the help-activity repository,

* [ ] for activities that include a tarball release, or where Fedora or Debian packages may be made, create a tarball using `python setup.py dist_source`, and upload tarball to download.sugarlabs.org using shell account,

* [ ] create bundle using `python setup.py dist_xo`, and test that it
  can be installed by Browse,

* [ ] for Python 2 branches only, upload to activities.sugarlabs.org
  using developer account,

* [ ] rebase any other maintained branches or pull requests, such as
  those for past or future versions of Python, or past releases of
  Fedora, Ubuntu or libraries.


Modifying Sugar
---------------

Sugar repositories can be found in our [GitHub `sugarlabs`
organization](https://github.com/sugarlabs).  Sugar desktop
environment repositories are:

* https://github.com/sugarlabs/sugar (the desktop shell);
* https://github.com/sugarlabs/sugar-artwork (images, icons, themes);
* https://github.com/sugarlabs/sugar-toolkit-gtk3 (graphical widget library); and,
* https://github.com/sugarlabs/sugar-datastore (journal backend).

Workflow
--------

### Open an Issue

We track issues in http://bugs.sugarlabs.org/ or in the GitHub Issues tab of repositories.

An improvement to Sugar may start with an issue discussion, to build consensus and ensure that work isn't wasted.  An issue may be avoided for fixing bugs that are obvious to everyone or part of a project.

### Forking

You should first fork a repository on GitHub.
This step is needed only once.
See [complete help in GitHub](https://help.github.com/articles/fork-a-repo).

### Cloning

You should clone your fork.
This step is needed only once.
Using [sugar](https://github.com/sugarlabs/sugar) as example;

```
git clone git@github.com:YOUR-NAME/sugar.git
cd sugar
git remote add upstream https://github.com/sugarlabs/sugar.git
git fetch upstream
```

### Branching

Create a branch per set of changes; e.g. to fix a problem or add a feature;

```
git checkout -b BRANCH-NAME
```

Your BRANCH-NAME can be anything, other than master.  The scope is your forked repository.  The branch name will be shown on pull-requests.

### Making commits

Change files, and commit.  Commit messages are kept by git, and are used later when problems are being solved.  When writing a commit message;

1. start with a one line summary of the change;
2. leave a blank line after the summary;
3. explain the problem that is solved, unless the summary makes it obvious;
4. when the problem was introduced by a previous commit, mention the hash;
5. when the problem is in an issue or ticket, add "Fixes #1234";
6. avoid mentioning GitHub or other pull-requests, as these are not kept in git;
7. avoid mentioning any contest tasks or mentors; use pull-request comments instead; and
8. use imperative mood, like "add foo", or "port to bar"; (if English is not your first language, see [imperative mood](https://en.wikipedia.org/wiki/Imperative_mood), [git documentation](https://git.kernel.org/pub/scm/git/git.git/tree/Documentation/SubmittingPatches#n133) and [blog post by Dan Clarke](https://www.danclarke.com/git-tense)).

Make one or more commits and push the branch to your repository;

```
git push origin BRANCH-NAME
```

### Sending a pull-request

Send a pull-request for your branch.
Navigate to your repository page in GitHub, switch to the branch you made, and then press the **Pull Request** button.

When writing a pull-request message;

1. if there is only one commit, begin with the GitHub default of the commit message, otherwise write a summary of the series of commits;
2. link to any relevant pull-requests, issues, or tickets; and
3. link to any contest tasks, and name your @mentors to subscribe them.

A review will happen in the pull-request, and a reviewer will either;

1. merge, squash, or rebase your commits;
2. merge your commits with their own changes;
3. ask you to make changes; or
4. close and reject your pull-request giving reasons.

When they ask you for changes, you may have to change both files, commits or commit messages.

When squashing commits to different files, use interactive rebase.

```
git rebase -i master
```

After resolving any conflicts, push the changes to the same branch;

```
git push --force origin
```

Then respond on the pull-request.

### Keep your pull-request up to date

When there have been upstream commits while your pull-request was open, you should rebase your pull-request;

```
git pull --rebase upstream
```

Then push the changes to the same branch;

```
git push --force origin
```

The pull-request will be updated.

### Keep your fork up to date

When there have been upstream commits since your fork was made, you should bring these into your fork:

```
git checkout master
git pull upstream
git checkout BRANCH-NAME
```

### Review

We encourage [testing](#testing) before merging a pull-request.

So instead of merging directly with the "merge" button on GitHub, we may do a local merge, then test, then push.

See [GitHub help on merging a pull-request](https://help.github.com/articles/merging-a-pull-request).

The GitHub page for the pull-request will provide you the right commands to do the local merge, similar to the following.

Get the changes from that branch to a new local branch:

```
git checkout -b SOME-USER-topic1 master
git pull https://github.com/SOME-USER/sugar.git topic1
```

[Test](#testing)! If everything is fine, merge:

```
git checkout master
git rebase SOME-USER-topic1
git push origin master
```

### Close Issue

Once your pull-request is merged, you should close any issue or ticket.  GitHub issues named as "Fixes" in a commit message may be automatically closed.

Be sure to thank everyone who helped you out along the way.

Testing
-------

When testing activities;

* activity must start,

* activity must refresh entire display when focus is restored,

* activity must behave predictably (except where randomness is designed),

* activity must save data to journal,

* activity must restore the saved data from journal (click on the journal entry),

* other activities must be able to use saved data, if it is declared with the relevant content type,

* every coded feature should either work properly, or be removed if it cannot be fixed,

* collaboration support, if present, must function properly between two or more systems,

* activity should not consume all available battery power (e.g. pygame clock rate too high),

* activity should not contain any security vulnerabilities,

* activity should not reveal personal information.


Guide for Reviewers
-------------------

### Goals

Goals for review are to;

* detect trivial mistakes,

* maintain consistent and good code quality,

* reproduce [test](#testing) results, (especially for critical repositories),

* maintain a useful git commit history for use by git bisect, and developers who read it,

* maintain other records, such as issues, tickets, and documentation,

* not waste the time of the contributor, by doing anything trivial that otherwise the contributor might have to do.

### Checklist

* [ ] does the change have consensus of the community, see also [code of conduct](CODE_OF_CONDUCT.md) (if a reviewer is in doubt, seek opinions by @mentioning people),

* [ ] does the commit message explain the summary, problem, and solution, so that it can be used in future analysis, see also [making commits](#making-commits) (if a reviewer can fix it by squash or manual rebase, do so),

* [ ] does the commit message reference any issue, bugs.sugarlabs.org ticket number, or downstream ticket numbers, (if a reviewer can fix it by squash or manual rebase, do so),

* [ ] are the number of commits excessive for future analysis, (a reviewer may squash or rebase if necessary),

* [ ] is the changed code consistent in style with the existing code, see also [coding standards](desktop-activity.md#coding-standards), (on the other hand, expect flake8 changes to be in separate commits),

* [ ] for critical repositories, does the change work properly on our latest version of Sugar on either Fedora, Debian, or Ubuntu.

### Critical repositories

- sugar, sugar-toolkit, sugar-toolkit-gtk3, sugar-artwork, sugar-datastore, gst-plugins-espeak,

- each of the [Fructose](https://wiki.sugarlabs.org/go/Development_Team/Release/Modules#Fructose) activity set repositories,

Frequently Asked Questions
--------------------------

### I've used the GitHub editor, how can I rebase or amend commits?

Make a local clone of your GitHub repository, use `git commit --amend` or the other advanced CLI features, then `git push` back to GitHub.

### Error 403 on `git push`

Most likely you have cloned someone else's repository, and you should
instead fork their repository, clone your own repository, make your
changes, then push.  See [Getting error 403 while submitting
PR](http://lists.sugarlabs.org/archive/sugar-devel/2017-March/053926.html)
and [D. Joe's
reply](http://lists.sugarlabs.org/archive/sugar-devel/2017-March/053929.html).
