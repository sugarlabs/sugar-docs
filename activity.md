Write your own web activity
===========================

After you have [built](dev-environment.md.html) the development
environment, enter the sugar-build shell

    ./osbuild

Create an activity based on the default template

    volo create my-activity ./sugar-web-template
    cd my-activity

Choose a name for your activity.  Write it in the activity name and
bundle-id in `activity/activity.info`.

![activity.info](images/activity-info.png "activity.info")

And also in the title tag of `index.html`.

![index.html](images/activity-html.png "index.html")

Install the activity for development

    python setup.py dev

Now you should have a basic activity running!


![Activity template](images/activity-template.png "Activity template")


### File structure

In your new activity, you will find the following file structure:

    my-activity/
    |-- activity/
    |   |-- activity.info
    |   `-- activity-icon.svg
    |-- index.html
    |-- css/
    |   `-- activity.css
    |-- js/
    |   |-- activity.js
    |   `-- loader.js
    |-- lib/
    |-- package.json
    `-- setup.py

* `activity/` contains information about your activity, including the
  name, ID, and the icon.

* `index.html` is where the elements that compose your activity are
  defined.  The template comes with a toolbar and a canvas where you
  can place your content.

* `js/activity.js` is where the logic of your activity lives.

* `css/activity.css` is where you add the styling of your activity.

Those are the files you'll modify.  The others are:

* `js/loader.js` configures the libraries paths and loads your
  `js/activity.js`

* `lib/` contains the libraries

* `package.json` contains information about the libraries the activity
  depends

* `setup.py` lets you install your activity or make an installable
  bundle with it

Now you are ready to go ahead and develop your activity in the html,
js and css files.

### Revision control your code

For development you can initialize the repository as a git
repository. This will help you to track your changes. First use [git
init](https://www.kernel.org/pub/software/scm/git/docs/git-init.html)
to initialize the repository:

    git init

With [git
status](https://www.kernel.org/pub/software/scm/git/docs/git-status.html)
you can show the available files in the folder they are still
untracked. Now add all the files in the directory besides the lib
folder and commit those changes, you can use git status again to see
the current state:

    git add .
    git commit -a -m 'Initial import'
    git status

### First steps

#### Adding a button to the toolbar

This simple example will show you how web activities are structured as
bits of HTML, CSS and JavaScript.

You will need a SVG graphic for the button.  Or you can use one from
the Sugar icon set at `lib/sugar-web/graphics/icons/`.  For this
example, let's say you have one custom icon called `my-button.svg`.
Create a directory `icons/` inside your activity and place the SVG
file inside.  Then do the following steps.

In `index.html`, add a new &lt;button&gt; element inside the toolbar:

    <button class="toolbutton" id="my-button" title="My Button"></button>

In `css/activity.css`, define the button style:

    #main-toolbar #my-button {
        background-image: url(../icons/my-button.svg);
    }

In `js/activity.js`, add a callback for the button:

    var myButton = document.getElementById("my-button");
    myButton.onclick = function () {
        console.log("You clicked me!");
    }

#### Adding HTML content dinamically

Soon you will find that adding content to the HTML as we did with the
toolbar button in the previous section, is very limited.  You'll want
to add HTML elements on the fly, as the user interacts with the
activity, or as the data structures of your activity logic change.
There are several options to archive this.  Most of the time you'll
end using a mix of them, so is important to know them all.

First, it is possible to create HTML elements and append them to other
HTML elements using JavaScript.  This is called "manipulating the
DOM".

For example, to create a new div with class 'my-div', and append it to
the canvas div, you can do:

    myElem = document.createElement('div');
    myElem.className = "my-div";
    var canvas = document.getElementById("canvas");
    canvas.appendChild(myElem);

But it is a pain to do that for large HTML structures.  Writing HTML
directly is much better:

    var canvas = document.getElementById("canvas");
    canvas.innerHTML +=
        '<ul id="names-list">' +
          '<li class="name">Tom</li>' +
          '<li class="name">Chris</li>' +
          '<li class="name">Donald</li>' +
        '</ul>';

Nice, that saves us many JavaScript lines.  But what if the HTML
depends on your data?  Let's say you have an array of names and you
want one &lt;li&gt; per name, as in the previous example.  You have
two options: 1. go back to use the JavaScript methods for DOM
manipulation, or 2. use a template system.

There are many template systems out there, and you can use whatever
you like.  Let's try [mustache](http://mustache.github.io/) here.

Add mustache to your activity:

    volo add mustache

Import mustache in your `js/activity.js`:

    var mustache = require("mustache");

Use it:

    var template =
        '<ul id="names-list">' +
          '{{#names}}' +
          '<li class="name">{{ name }}</li>' +
          '{{/names}}' +
        '</ul>';

    var data = {names: [{name: "Laura"}, {name: "Joao"},
                        {name: "Willy"}, {name: "Sandra"}]};

    var containerElem = document.getElementById("container");
    containerElem.innerHTML = mustache.render(template, data);

### Debugging

If you want to inspect the code, you can press ctrl+shift+I while your
Activity is running.

The inspector is a very useful tool for many things. For example, you
can edit the activity CSS or HTML, and interactively see how it is
affected. Or you can execute JavaScript commands in the console.

![Activity inspector](images/activity-inspector.png "Activity inspector")

It has also more advanced tools for JavaScript debugging. They are
nicely documented here:
<https://developers.google.com/chrome-developer-tools/docs/javascript-debugging>.

### Keeping Sugar libraries up to date

The activity depends on the
[sugar-web](http://github.com/sugarlabs/sugar-html-activity) library
that provides the Sugar API and the Sugar look & feel.

This means that if there are changes to the library you have to update your
local copy. You can do this with running the following command inside the
activity directory:

    volo add -f

### Ready to release

Before your first release, you should:

* make your activity unique in the Sugar interface by changing your
  activity icon activity/activity-icon.svg .  Or if you don't have
  graphics skills, you can ask in the community if someone can do it.

After that, you can make an XO bundle and upload it to the Sugar
activities market <http://activities.sugarlabs.org/> .

    python setup.py dist_xo

For further releases, you should update the activity_version in
`activity/activity.info`.
