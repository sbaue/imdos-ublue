# imdos-ublue

[![build-ublue](https://github.com/sbaue/imdos-ublue/actions/workflows/build.yml/badge.svg)](https://github.com/sbaue/imdos-ublue/actions/workflows/build.yml)

This is a modified image of ublue(based in turn on Fedora Silverblue) designed to provide a very basic Gnome installation and running nvidia drivers by default.

For more info, check out the [uBlue homepage](https://ublue.it/) and the [main uBlue repo](https://github.com/ublue-os/main/)

## Version

This is running on Silverblue 38 package base.

The base changes of this version is trimming down the preinstalled Flatpaks, changing the base to silverblue-nvidia(for nvidia drivers), and removing yafti. It adds some simple files for adding and removing rpm based packages from the base image.

## Customization

I recommend using [ublue/startingpoint](https://github.com/ublue-os/startingpoint) image as a base for your own modified images, this image might change unexpectedly as I try things out.

## Installation of base system

> **Warning**
> This is an experimental feature and should not be used in production, try it in a VM for a while!

To rebase an existing Silverblue/Kinoite installation to the latest build:

```
sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/sbaue/imdos-ublue:latest
```

This repository builds date tags as well, so if you want to rebase to a particular day's build:

```
sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/sbaue/imdos-ublue:20230403
```

The `latest` tag will automatically point to the latest build. That build will still always use the Fedora version specified in `release.yml`, so you won't get accidentally updated to the next major version.

## Installation of user software

I highly recommend your first step to be opening a terminal and running `just setup-flatpaks` these are optional but highly recommended flatpaks that help you finding and installing gnome extensions and managing permissions for flatpaks. Your second step should probably picking a webbrowser you fancy from the Software app.

When you begin to customise the system for your workflow you should choose your package sources according to these priorities:

1. Flatpaks 
Use them whenever available. This is your bread and butter and we run the official [Flathub Repository](https://flathub.org/home). You have a problem with one of them, everyone has that problem, so you are more likely to find help.

2. Podman container

These are managed by [distrobox](https://github.com/89luca89/distrobox) here. You find a few exampes below. They are little containers containing normal linux distributions, including their fully functional package managers. You can use the [Podman Desktop](https://flathub.org/apps/details/io.podman_desktop.PodmanDesktop) flatpak available in Software to manage them. Just delete the box if you messed it up. Keep in mind though that they have write access and use your home directory.

3. RPM-OStree

If nothing else works you can change the base system directly. One of the reasons this repo exists is so that you DON'T have to do this. Because anything can happen. [Silverblue documentation(https://docs.fedoraproject.org/en-US/fedora-silverblue/getting-started/#package-layering)] explains it's use a bit. 

## Just

The `just` task runner is included in main for further customization after first boot.
You can copy the justfile from `/etc/justfile` to `~/.justfile` to get started. Once `just` supports [include directives](https://just.systems/man/en/chapter_52.html), you can just include the file in `/etc` into your own justfile, where you have the option of adding new tasks.
After that run the following commands:

- `just` - Show all tasks, more will be added in the future
- `just bios` - Reboot into the system bios (Useful for dualbooting)
- `just changelogs` - Show the changelogs of the pending update
- Various containers. These should be used to install apps not available as Flatpak, they share the user home directory.
  - `just distrobox-boxkit`Alpine based toolbox image, very small, good for ephermal
  - `just distrobox-debian` Unstable debian, rolling
  - `just distrobox-opensuse` Optimised for distrobox, rolling
  - `just distrobox-ubuntu` 22.04 based ubuntu toolbox
  - `just toolbox-fedora` Fedora toolbox matching the system, optimised for and using toolbox
- `just setup-flatpaks` - Install of flatseal and extension manager, recommended
- `just setup-gaming` - Install Steam, Heroic Game Launcher, OBS Studio, Discord, Boatswain, Bottles, and ProtonUp-Qt. MangoHud is installed and enabled by default, hit right Shift-F12 to toggle
- `just update` - Update rpm-ostree, flatpaks, and distroboxes in one command

Check the [just website](https://just.systems) for tips on modifying and adding your own recipes.

## Verification

These images are signed with sisgstore's [cosign](https://docs.sigstore.dev/cosign/overview/). You can verify the signature by downloading the `cosign.pub` key from this repo and running the following command:

    cosign verify --key cosign.pub ghcr.io/sbaue/imdos-ublue

If you're forking this repo, the uBlue website has [instructions](https://ublue.it/making-your-own/) for setting up signing properly.
