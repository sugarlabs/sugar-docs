# Beginner Setup Guide: Running Sugar Activities Locally

This guide will help beginners set up a local development environment for Sugar and run Sugar activities easily.

---

## 🧰 Prerequisites

Before starting, make sure you have the following tools installed:

### For Linux Users (Ubuntu/Debian-based):

* `git`
* `python3`
* `pip`
* `virtualenv`

Install them using:

```bash
sudo apt update
sudo apt install git python3 python3-pip virtualenv
```

---

## 🔄 Step 1: Clone the Activity Repository

Clone the Sugar activity you'd like to run. For example, to clone the **HelloWorld** activity:

```bash
git clone https://github.com/sugarlabs/hello-world.git
cd hello-world
```

---

## ⚙️ Step 2: Set Up the Environment

Create and activate a Python virtual environment:

```bash
virtualenv venv
source venv/bin/activate
```

Install the dependencies (if a `requirements.txt` is present):

```bash
pip install -r requirements.txt
```

---

## ▶️ Step 3: Run the Activity

Many activities include a script to run them. Run the activity using:

```bash
./hello-world.py
```

If it's a `.xo` bundle:

1. Install `sugar-build` or run a Sugar desktop session.
2. Use the `sugar-install-bundle` tool:

```bash
sugar-install-bundle hello-world.xo
```

You can also launch Sugar using:

```bash
sugar-emulator
```

---

## 💡 Troubleshooting Tips

* **Permission Denied**: Run `chmod +x filename.py` to make scripts executable.
* **Missing GTK**: Install GTK 3 and PyGObject:

```bash
sudo apt install python3-gi python3-gi-cairo gir1.2-gtk-3.0
```

* **Can't find XO bundle?** Build it using:

```bash
./setup.py dist_xo
```

* **Virtualenv not working?** Make sure you're using `python3 -m venv` if `virtualenv` fails.

---

## 🧑‍💻 Recommended Resources

* [Sugar Activity Team Guidelines](https://github.com/sugarlabs/sugar-activity-template)
* [Sugar Developer Portal](https://developer.sugarlabs.org/)
* Join the [Sugar Labs community](https://wiki.sugarlabs.org/go/Community)

---

If you're stuck, feel free to open an issue or ask for help on the GitHub discussions or Sugar Labs IRC/matrix channels.
Link fo the matrix channel: 
Happy coding! 🚀
