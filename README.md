# r-richmond's dotfiles

## Installation

**Warning:** If you want to give these dotfiles a try, you should first fork this repository, review the code, and remove things you don’t want or need. Don’t blindly use my settings unless you know what that entails. Use at your own risk!

### Using Git and the initialize script

You can clone the repository wherever you want. The initialize script will copy the files to your home folder.

```bash
git clone https://github.com/r-richmond/dotfiles_rr.git && cd dotfiles_rr && bash initialize.sh
```

### Update the local repo
* [Atom](https://atom.io/) configs
* Updates list of Atom packages in .atom/.my_atom_packages
* [DBeaver](http://dbeaver.jkiss.org/) configs
* [dotfiles](https://dotfiles.github.io/) from ~/.dotfiles/
* Nano language files from ~/.nano/

```bash
bash update.sh
```

## Thanks to…

* @mathiasbynens and his [Legendary repository](https://github.com/mathiasbynens/dotfiles) (I've butchered so many of his scripts)
* @scopatz for his [nanorc language repo](https://github.com/scopatz/nanorc)
