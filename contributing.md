Contributing
============

We use the pull-request model, see [GitHub's help on pull-request](https://help.github.com/articles/using-pull-requests).

In short, you will:

* file an issue about what you plan to change;
* do your changes in a new branch;
* push your branch and submit a pull-request for it;
* go through the review process until your pull-request is merged; and
* close your issue.

Activity Repositories
-----------------

To request a new activity repo, email the http://lists.sugarlabs.org/listinfo/systems list with the name of the repo and the GitHub usernames who should have access.

We recommend using the same process as below to develop your own Activities.

Modifying Sugar
---------------

Before going through the details on how to submit changes, let's look at the useful tools we provide to assist contributors in the process of modifying Sugar.

If you are hacking on sugar-web, run the testsuit with the *karma* command inside a osbuild shell:

    karma start sugar-web/test/karma.conf.js

We encourage writting new unit tests for new features.

After you do the changes, run:

    check

It will run all the code checks and the unit tests making sure you won't break the build when your changes are pushed. 
If the checks doesn't succeed because of coding style, see the coding style guide [for web](web-style.md.html) or [for Python](python-style.md.html). 
If a test doesn't pass either your code needs to be fixed or the test need to be adapted.

### Open an Issue

We track issues in http://bugs.sugarlabs.org

Generally, each improvement to Sugar should start with an issue discussion, to ensure that work to fix a bug isn't wasted.

### Forking

You should first fork the repository on GitHub. 
This step is needed only once. 
See [complete help in GitHub](https://help.github.com/articles/fork-a-repo). 
Brief instructions follow using [sugar component](https://github.com/sugarlabs/sugar) as example.

Navigate to the [sugar repository](https://github.com/sugarlabs/sugar/), press **Fork** button, then

    git clone git@github.com:YOUR-NAME/sugar.git
    cd sugar
    git remote add upstream https://github.com/sugarlabs/sugar.git
    git fetch upstream

### Branching

Create one branch per topic

    git checkout -b NAME

Make one or more commits and push the branch

    git push origin NAME

Your branch NAME can be anything, other than master.  The scope is your forked repository.  The branch name will be shown on pull-requests.

### Making commits

Change files, and commit.  When writing a commit message;

1. start with a one line summary of the change;
2. leave a blank line after the summary;
3. explain the problem that is solved, unless the summary makes it obvious;
4. when the problem was introduced by a previous commit, mention the hash;
5. when the problem is in an issue ticket, add "Fixes #1234", and the ticket may be closed automatically; and
6. avoid mentioning GitHub or other pull-requests, as these are not kept in git,

### Sending a pull-request

Send a pull-request for your branch. 
Navigate to your repository page in GitHub, switch to the branch you made, and then press the **Pull Request** button.

When writing a pull-request message;

1. if there is only one commit, accept the GitHub default of the commit message, otherwise explain the series of commits;
2. mention any relevant pull-requests; and
3. mention any relevant resources, such as issues, tickets, or competition tasks.

A review will happen in the pull-request, and a reviewer will either;

1. merge your commits;
2. merge your commits with their own changes;
3. ask you to make changes; or
4. close and reject your request giving reasons.

When they ask you for changes, make them using [interactive rebase](http://git-scm.com/book/en/Git-Tools-Rewriting-History#Changing-Multiple-Commit-Messages)

    git rebase -i master

Then push the changes to the same branch

    git push --force origin

Then respond on the pull-request.

### Keep your pull-request up to date

When there have been upstream commits while your pull-request was open, you should rebase your pull-request:

    git pull --rebase upstream

Then push the changes to the same branch

    git push --force origin

The pull-request will be updated.

### Keep your fork up to date

When there have been upstream commits since your fork was made, you should bring these into your fork:

    git checkout master
    git pull upstream
    git checkout NAME

### Review

We encourage testing before merging a pull-request. 

So instead of merging directly with the "merge" button on GitHub, we do a local merge, then test, then push.  

See [GitHub help on merging a pull-request](https://help.github.com/articles/merging-a-pull-request)

The GitHub page for the pull-request will provide you the right commands to do the local merge, similar to the following.

Get the changes from that branch to a new local branch:

    git checkout -b SOME-USER-topic1 master
    git pull https://github.com/SOME-USER/sugar.git topic1

Test! If everything is fine, merge:

    git checkout master
    git rebase SOME-USER-topic1
    git push origin master

### Close Issue

Once your changes are merged, you should close your issue. 
Be sure to thank everyone who helped you out along the way :) 
