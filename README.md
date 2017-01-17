# r-richmond's dotfiles

## Installation

**Warning:** If you want to give these dotfiles a try, you should first fork this repository, review the code, and remove things you don’t want or need. Don’t blindly use my settings unless you know what that entails. Use at your own risk!

### Using Git and the bootstrap script

You can clone the repository wherever you want. The initialize script will copy the files to your home folder.

```bash
git clone https://github.com/r-richmond/dotfiles_rr.git && cd dotfiles_rr && bash initialize.sh
```

#### Refreshing
Goal: Update local repo to reflect files in actual use
Currently: Updates Atom Config Files & Updates atom_package_list
```bash
bash update.sh
```

#### Updating Not Implement yet
To update, `cd` into your local `dotfiles` repository and then:

```bash
bash bootstrap.sh
```

## Thanks to…

* @mathiasbynens and his [Legendary repository](https://github.com/mathiasbynens/dotfiles)
* @scopatz for his [nanorc language repo](https://github.com/scopatz/nanorc)
