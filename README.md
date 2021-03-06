# r-richmond's dotfiles

## Installation

**Warning:** If you want to give these dotfiles a try, you should first fork this repository, review the code, and remove things you don’t want or need. Don’t blindly use my settings unless you know what that entails. Use at your own risk!

### Using Git and the initialize script

You can clone the repository wherever you want. The initialize script will copy the files to your home folder.

```bash
git clone https://github.com/r-richmond/dotfiles_rr.git && cd dotfiles_rr && bash initialize.sh
```
### Subsequent deploys/intializations

`initialize.sh` behaves a little differently after the first run
#### Only First Run (i.e. no brew or with --force-new option)
* Install Brew
* Run all Brew Files
* Change default shell to brew-installed shell
* Install all Atom Packages listed in `./.atom/.my_atom_packages`
* Ask if you want to install personal brew files / personal.macos
* Run `.setup_files/universal.macos` to configure macos

#### All Runs (Including First)
* Copy all dotfiles to ~/
 * This excludes .extras & personal.macos (used for Computer Name)
* Reassigns Crontab

### Update the local repo
`update.sh` behaves the same every run
* [Atom](https://atom.io/) configs
* Updates list of Atom packages in .atom/.my_atom_packages
* [DBeaver](http://dbeaver.jkiss.org/) configs
* [dotfiles](https://dotfiles.github.io/) from ~/.dotfiles-bash/
* [Nano](https://www.nano-editor.org/overview.php) language files from ~/.nano/
* [pip.conf](https://pip.pypa.io/en/stable/user_guide/#config-file)
* [.psqlrc](https://robots.thoughtbot.com/an-explained-psqlrc)

## Things left to do
* updated keyboard shortcuts
  * change caps to esc-key - system preferences > keyboard > modifier keys
  * add notification to option-` - system preferences > keyboard > shortcuts > mission control
  * change keyboard ctrl-option-cmd-space - system preferences > keyboard > shortcuts > input sources
* replace siri button with lock button on touchbar
  * system preferences > keyboard > customize control strip
* turnoff mission control key settings for ctrl-up/down
  * system preferences > mission control > mission control, application windows
* add mouse settings for buttons 4, 5, 3
  * system preferences > mission control >
* configure alfred powerpack
  * setup powerpack & link to sync folder & setup theme

## When Python Update season rolls around
* Fix Hydrogen
  * python3 -m jupyter kernelspec remove python3
  * python3 -m ipykernel install
* Fix Virtual envs

## Thanks to…

* @mathiasbynens and his [legendary repository](https://github.com/mathiasbynens/dotfiles)
* @scopatz for his [nanorc language repo](https://github.com/scopatz/nanorc)
