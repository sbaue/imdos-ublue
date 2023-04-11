# imdos-ublue

[![build-ublue](https://github.com/sbaue/imdos-ublue/actions/workflows/build.yml/badge.svg)](https://github.com/sbaue/imdos-ublue/actions/workflows/build.yml)

This is a modified startingpoint image of ublue(based in turn on Fedora Silverblue) designed to provide a very basic Gnome installation and running nvidia drivers by default.

The base changes of this version is trimming down the preinstalled Flatpaks, changing the base to silverblue-nvidia(for nvidia drivers), and removing yafti. For now the image will be based on Silverblue 37 with a later update to Silverblue 38 planned for after official release. This update will be automatic and transparant for you if you are on this version.

For more info, check out the [uBlue homepage](https://ublue.it/) and the [main uBlue repo](https://github.com/ublue-os/main/)

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

In generel your first choice should be Flatpaks, use them whenever possible. If a software is not available in Flathub you pick one of the distroboxes mentioned below and install the software within that. In case you have a special software(like drivers) or have been instructed to do so by a reasonably competent person you can also install software via package layering by following the [Getting Started](https://docs.fedoraproject.org/en-US/fedora-silverblue/getting-started/) guide from Fedora.

The reason for that is simply the update process. Layering has the highest likelihood of introducing problems and finding unique and interesting problems. They will break things on YOUR end, you want things to break on THIS end though because a broken build will never be pushed to your system.

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
