# Setting up
```sh
git init --bare $HOME/dotfiles
alias cfg='/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME'
cfg config --local status.showUntrackFiles no
```

# Configuration
```sh
cfg remote add origin git@github.com:liuw/dotfiles.git
cfg config status.showUntrackedFiles no
```

# Replication
```sh
git clone --separate-git-dir=$HOME/dotfiles git@github.com:liuw/dotfiles.git $HOME/conf-tmp
rsync --recursive --verbose --exclude '.git' $HOME/conf-tmp/ $HOME/
rm -rf conf-tmp
```

# Usage
```sh
cfg status
cfg add .gitignore
cfg commit -m'Add gitignore'
cfg push origin
```
