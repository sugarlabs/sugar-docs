Contributing
============

We use the pull-request model, see [github's help on
pull-request](https://help.github.com/articles/using-pull-requests).

In short, you will:

* do your changes in a new branch
* push your branch and submit a pull-request for it
* go through the review process

Modifying Sugar
---------------

Before going through the details on how to submit changes, let's look
at the useful tools we provide to assist contributors in the process
of modifying Sugar.

If you are hacking on sugar-web, run the testsuit with the *karma*
command inside a osbuild shell:

    karma start sugar-web/test/karma.conf.js

We encourage writting new unit tests for new features.

After you do the changes, run:

    check

It will run all the code checks and the unit tests making sure you
won't break the build when your changes are pushed. If the checks
doesn't succeed because of coding style, see the coding style guide
[for web](web-style.md.html) or [for Python](python-style.md.html).
If a test doesn't pass either your code needs to be fixed or the test
need to be adapted.

Forking
-------

You should fork the repository first.  This step is needed only once.
See [complete help in
github](https://help.github.com/articles/fork-a-repo).  Brief
instructions follow using [sugar
component](https://github.com/sugarlabs/sugar) as example.

Navigate to the [sugar repository](https://github.com/sugarlabs/sugar/),
press **Fork** button, then

    git clone https://github.com/YOUR-NAME/sugar.git
    cd sugar
    git remote add upstream https://github.com/sugarlabs/sugar.git
    git fetch upstream

Sending a pull-request
----------------------

Create one branch per topic

    git checkout -b topic1

Make one or more commits and push the branch

    git push origin topic1

Submit a pull request for the branch.  Navigate to your repository page in
github, switch to the branch you made, and then press the **Pull Request**
button.

After that, the review process will happen in the pull-request page on
github.  The process ends with one of this:

1. A reviewer merges your request.
2. A reviewer rejects your request providing reasons  (and closes the request).
3. A reviewer requires changes (and closes the request).

In case they ask you for changes, make them using [interactive rebase](http://git-scm.com/book/en/Git-Tools-Rewriting-History#Changing-Multiple-Commit-Messages)

    git rebase -i master

Submit the changes to another remote branch

    git push origin topic1:topic1-try2

Finally submit the new pull request through the github site as you did before.
To do your next contribution, don't forget to pull in changes from the master
repository.

Keep your fork up to date
-------------------------

Pull in upstream changes:

    git fetch upstream
    git merge upstream/master

Bugfixing
---------

We track bugs in http://bugs.sugarlabs.org/ .

If you are sending a pull request that fixes a bug, make sure to add
"Fixes #1234" to the commit message, being #1234 the number of the
ticket in question.  This way, the ticket will be closed
automatically.

Reviewing
---------

We encourage testing before merging a pull-request.  So instead of
merging directly with the "merge" button on github UI, you do a local
merge, then test, then push.  See [github help on merging a
pull-request](https://help.github.com/articles/merging-a-pull-request).

The github page for the pull-request will provide you the right
commands to do the local merge.  They will be something like:

Get the changes from that branch to a new local branch:

    git checkout -b SOME-USER-topic1 master
    git pull https://github.com/SOME-USER/sugar.git topic1

Test! If everything is fine, merge:

    git checkout master
    git rebase SOME-USER-topic1
    git push origin master
