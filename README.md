# Setting up
git init --bare $HOME/dotfiles
alias config='/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME'

# Configuration
config remote add origin git@github.com:liuw/dotfiles.git
config config status.showUntrackedFiles no

# Replication
git clone --separate-git-dir=$HOME/dotfiles git@github.com:liuw/dotfiles.git $HOME/conf-tmp
rsync --recursive --verbose --exclude '.git' conf-tmp $HOME
rm -rf conf-tmp

# Usage
config status
config add .gitignore
config commit -m'Add gitignore'
config push origin
