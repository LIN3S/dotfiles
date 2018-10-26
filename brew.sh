#!/usr/bin/env bash

if ! brew -v &> /dev/null; then
  echo "Installing brew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  echo "Done!"
fi

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Make sure we’re using the latest Homebrew.
brew update && brew doctor

# Upgrade any already-installed formulae.
brew upgrade --all

# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils

# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names
brew install bash && \
sudo echo $(brew --prefix)/bin/bash >> /etc/shells && \
chsh -s $(brew --prefix)/bin/bash
brew install bash-completion2

if ! grep '/usr/local/bin/bash' /etc/shells; then
  echo '/usr/local/bin/bash' | sudo tee -a /etc/shells;
  chsh -s /usr/local/bin/bash;
fi;

# Install `wget` with IRI support.
brew install wget --with-iri

# Install more recent versions of some OS X tools.
brew install vim --override-system-vi

# Install casks
brew tap caskroom/versions

brew install Caskroom/cask/java

brew cask install filezilla
brew cask install firefox
brew cask install google-chrome
brew cask install sequel-pro
brew cask install slack
brew cask install jetbrains-toolbox
brew cask install appcleaner
brew cask install daisydisk
brew cask install spectacle
brew cask install spotify
brew cask install iterm2
brew cask install sublime-text3 && cp -rf ~/init/SublimeText/* ~/Library/Application\ Support/Sublime\ Text\ 3/

# https://gist.github.com/DragonBe/0faebe58deced34744953e3bf6afbec7
sudo apachectl stop
sudo launchctl unload -w /System/Library/LaunchDaemons/org.apache.httpd.plist 2>/dev/null

brew install httpd24 --with-privileged-ports --with-http2
brew install php@5.6
brew install php@7.0
brew install php@7.1
brew install php@7.2
brew install mariadb 
brew install node@8
brew install redis
brew install yarn
brew install composer
brew install git
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install font tools.
brew tap bramstein/webfonttools
brew install sfnt2woff
brew install sfnt2woff-zopfli
brew install woff2

# Install other useful binaries.
brew install ack
brew install ansible
brew install dark-mode
brew install composer
brew install git
brew install git-lfs
brew install imagemagick --with-webp
brew install lua
brew install lynx
brew install mongodb
brew install mysql
brew install node
brew install p7zip
brew install pigz
brew install pv
brew install redis
brew install rename
brew install speedtest_cli
brew install ssh-copy-id
brew install tree
brew install webkit2png
brew install yarn
brew install zopfli
brew install zsh
brew install zsh-completions

# Añadir .gitignore .global
touch ~/.gitignore
git config --global core.excludesfile ~/.gitignore

# Remove outdated versions from the cellar.
brew cleanup

# Install PHP Switcher
curl -L https://gist.githubusercontent.com/rhukster/f4c04f1bf59e0b74e335ee5d186a98e2/raw > /usr/local/bin/sphp
chmod +x /usr/local/bin/sphp

# Install PHP dependencies
pecl install xdebug
pecl install imagick

