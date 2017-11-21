Contributing
============

We use the pull-request model, see [GitHub's help on pull-request](https://help.github.com/articles/using-pull-requests).

In brief, you will:

* add an issue about what you plan to change;
* on GitHub, find and fork the source repository;
* on your computer, clone your fork repository,
* commit your changes in a new branch;
* push your branch and submit a pull-request for it;
* go through the review process until your pull-request is merged; and
* close your issue.

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
activity](desktop-activity.md.html), or [Write your own Sugar web
activity](web-activity.md.html), then make a new repository in your
GitHub account, put the source code in it, then ask the [systems@
list](https://lists.sugarlabs.org/listinfo/systems) to move it to the
GitHub `sugarlabs` organization.

Modifying Sugar
---------------

Sugar repositories can be found in our [GitHub `sugarlabs`
organization](https://github.com/sugarlabs).  Sugar desktop
environment repositories are:

* https://github.com/sugarlabs/sugar (the shell);
* https://github.com/sugarlabs/sugar-artwork (images, icons, themes);
* https://github.com/sugarlabs/sugar-toolkit-gtk3 (graphical widget library); and,
* https://github.com/sugarlabs/sugar-datastore (journal backend).

### Open an Issue

We track issues in http://bugs.sugarlabs.org/ or in the GitHub Issues tab of activity repositories.

Each improvement to Sugar should start with an issue discussion, to build consensus and ensure that work isn't wasted.

### Forking

You should first fork the repository on GitHub.
This step is needed only once.
See [complete help in GitHub](https://help.github.com/articles/fork-a-repo).
Brief instructions follow using [sugar](https://github.com/sugarlabs/sugar) as example.

Navigate to the [sugar](https://github.com/sugarlabs/sugar/) repository, press **Fork** button, then on your computer

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

Change files, and commit.  When writing a commit message;

1. start with a one line summary of the change;
2. leave a blank line after the summary;
3. explain the problem that is solved, unless the summary makes it obvious;
4. when the problem was introduced by a previous commit, mention the hash;
5. when the problem is in an issue or ticket, add "Fixes #1234";
6. avoid mentioning GitHub or other pull-requests, as these are not kept in git; and
7. avoid mentioning any contest tasks or mentors; use the pull-request instead.

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

When squashing commits to different files, use [interactive rebase](http://git-scm.com/book/en/Git-Tools-Rewriting-History#Changing-Multiple-Commit-Messages).

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

We encourage testing before merging a pull-request.

So instead of merging directly with the "merge" button on GitHub, we may do a local merge, then test, then push.

See [GitHub help on merging a pull-request](https://help.github.com/articles/merging-a-pull-request).

The GitHub page for the pull-request will provide you the right commands to do the local merge, similar to the following.

Get the changes from that branch to a new local branch:

```
git checkout -b SOME-USER-topic1 master
git pull https://github.com/SOME-USER/sugar.git topic1
```

Test! If everything is fine, merge:

```
git checkout master
git rebase SOME-USER-topic1
git push origin master
```

### Close Issue

Once your pull-request is merged, you should close any issue or ticket.  GitHub issues named as "Fixes" in a commit message may be automatically closed.

Be sure to thank everyone who helped you out along the way.

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
