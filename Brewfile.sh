#!/bin/sh
brew update
brew upgrade

brew install caskroom/cask/brew-cask

brew install zsh
brew install zsh-completions
# After install zsh, run below
#
# sudo sh -c "echo '/usr/local/bin/zsh' >> /etc/shells"
# chsh -s /usr/local/bin/zsh

brew install coreutils
brew install git
brew install tig
brew install curl --with-rtmp
brew install lv
brew install wget
brew install mysql
brew install postgresql
brew install vim --with-lua
brew install rbenv
brew install ruby-build
brew install imagemagick
brew install qt
brew install nodejs
brew install go
brew install peco/peco/peco
brew install mercurial
brew install elasticsearch
brew install hub
brew install phantomjs

brew cask install alfred
# After install alfred, run below
#
# brew cask alfred link

brew cask install google-chrome
brew cask install google-japanese-ime
brew cask install iterm2
brew cask install karabiner
brew cask install slack
brew cask install skype
brew cask install butter
brew cask install mailplane
brew cask install flash
brew cask install kobito
brew cask install dropbox
brew cask install trailer
brew cask install limechat
brew cask install sequel-pro
brew cask install appcleaner
brew cask install heroku-toolbelt
brew cask install atom
brew cask install anvil
brew cask install cyberduck
brew cask install silverlight
brew cask install vlc
brew cask install java
brew cask install vagrant
brew cask install virtualbox
brew cask install rescuetime
brew cask install libreoffice
brew cask install blink1control