# Tutorial on installing Sugar on Debian

## Get Debian

Download the Debian 10 (Buster) ISO. 
> I suggest downloading the `standard` edition ISO because it is smaller and because the Desktop Environment will get removed while installing Sugar. Current `standard` edition for `amd64` linked [here.](https://cdimage.debian.org/debian-cd/current-live/amd64/iso-hybrid/)

Install the Debian ISO on a system or Virtual Machine.

## Install Sugar 0.112-6 on Debian 10 (Buster)

```bash
# Update Debian repositories and install Sugar
sudo apt update
```

```bash
# Install Sugar, its dependencies
sudo apt install sucrose lightdm
```
 
Reboot and login to Sugar.
Done 🎉
> Tutorial to login to Sugar is [available here](https://github.com/sugarlabs/sugar-docs/blob/master/src/sugar-logging-in.md).

## Install Sugar 0.117-3 on Debian 11 (Bullseye)

Let's set default package repository to `unstable`. This is because Sugar 0.117 and above are only available in the Debian `unstable` repositories.
eg. using the nano editor
```bash
# create a new apt config file
nano /etc/apt/apt.conf.d/my-default-release

# Add this line to the file, then press CTRL-X to save it
APT::Default-Release "unstable";
```

Update Debian and install Sugar
```bash
# Let's update Debian. Should update to Debian 11 (Bullseye)
sudo apt update
sudo apt upgrade
```

```bash
# Install Sugar, its dependencies
# gcc-8-base is a dependency of Sugar 0.117
# libglib2.0-dev is a dependency of the Browse activity
# lightdm is a desktop manager which we will use to select Sugar while logging in
sudo apt install sucrose gcc-8-base libglib2.0-dev lightdm
```
 
Reboot and login to Sugar.
Done 🎉

> Tutorial to login to Sugar is [available here](https://github.com/sugarlabs/sugar-docs/blob/master/src/sugar-logging-in.md).

## Post install

This part is completely optional. These programs help in debugging/developing Sugar.

```bash
# install multitail and ssh
apt install multitail openssh-server
```

Setup colorful Multitail logs (Makes it easier to identify errors and warnings) 
```bash
# Paste the snippet into /etc/multitail.conf
# Or save as .multitailrc in the home directory

# Sugar
colorscheme:sugar
cs_re:green:DEBUG
cs_re:red:^(([a-zA-Z]*Error)|Traceback).*$
cs_re:yellow:^.*(Warning|WARNING).*$
cs_re_s:blue:([0-9]{10,}\.[0-9]{6,})
#
```

Now you can view logs with `multitail` using:
```bash
cd ~/.sugar/default/logs/ && multitail -CS sugar -iw "*ACTIVITY_NAME*" 1 -m 0
```
> Make sure to replace `ACTIVITY_NAME` with the name of the Activity whose logs you are trying to view. eg. `Pippy`
