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
#### Only First Run
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
* [Atom](https://atom.io/) configs
* Updates list of Atom packages in .atom/.my_atom_packages
* [DBeaver](http://dbeaver.jkiss.org/) configs
* [dotfiles](https://dotfiles.github.io/) from ~/.dotfiles/
* [Nano](https://www.nano-editor.org/overview.php) language files from ~/.nano/
* [pip.conf] (https://pip.pypa.io/en/stable/user_guide/#config-file)
* [.psqlrc] (https://robots.thoughtbot.com/an-explained-psqlrc)

```bash
bash update.sh
```

## Thanks to…

* @mathiasbynens and his [Legendary repository](https://github.com/mathiasbynens/dotfiles) (I've butchered so many of his scripts)
* @scopatz for his [nanorc language repo](https://github.com/scopatz/nanorc)
