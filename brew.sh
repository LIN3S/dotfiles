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
brew tap homebrew/versions
brew install bash-completion2

if ! grep '/usr/local/bin/bash' /etc/shells; then
  echo '/usr/local/bin/bash' | sudo tee -a /etc/shells;
  chsh -s /usr/local/bin/bash;
fi;

# Install `wget` with IRI support.
brew install wget --with-iri

# Install more recent versions of some OS X tools.
brew install vim --override-system-vi
brew install homebrew/dupes/grep
brew install homebrew/dupes/openssh
brew install homebrew/dupes/screen
brew install homebrew/php/php70 --with-gmp

# Install casks
brew tap caskroom/versions

brew install caskroom/cask/brew-cask
brew install Caskroom/cask/java

brew cask install appcleaner
brew cask install filezilla
brew cask install firefox
brew cask install iterm2 && \
cp ~/init/Bash/com.googlecode.iterm2.plist ~/Library/Preferences
brew cask install robomongo
brew cask install sequel-pro
brew cask install sublime-text3 && \
cp -rf ~/init/SublimeText/* ~/Library/Application\ Support/Sublime\ Text\ 3/
brew cask install virtualbox

# Install font tools.
brew tap bramstein/webfonttools
brew install sfnt2woff
brew install sfnt2woff-zopfli
brew install woff2

# Install PHP 7.0 and its common drivers.
brew tap homebrew/dupes
brew tap homebrew/homebrew-php

brew install php56
brew install php56-apcu
brew install php56-imagick
brew install php56-intl
brew install php56-mcrypt
brew install php56-xdebug

brew unlink php56

brew install php70
brew install php70-apcu
brew install php70-imagick
brew install php70-intl
brew install php70-mcrypt
brew install php70-xdebug

brew unlink php70

brew install php71
brew install php71-apcu
brew install php71-imagick
brew install php71-intl
brew install php71-mcrypt
brew install php71-xdebug

# Install other useful binaries.
brew install ack
brew install ansible
brew install dark-mode
brew install composer
brew install git
brew install git-lfs
brew install heroku
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

# Remove outdated versions from the cellar.
brew cleanup
