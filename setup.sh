#!/bin/sh

##################################################
##################################################

# install oh-my-zsh
if [ ! -d ~/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
    echo "oh-my-zsh is already installed!"
fi


# install neobundle
if [ ! -d ~/.vim/bundle/neobundle.vim ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh)"
else
    echo "neobundle is already installed!"
fi

##################################################
##################################################

# symlink dotfiles
cd ~/dotfiles
for dotfile in .??*
do
    [ $dotfile = ".git" ] && continue
    [ $dotfile = '.gitignore' ] && continue
    ln -snfv ~/dotfiles/$dotfile ~/$dotfile
done


# setup matplotlib config
if [ ! -d ~/.config ]; then
    mkdir ~/.config
fi
if [ ! -d ~/.config/matplotlib ]; then
    ln -snfv ~/dotfiles/matplotlib ~/.config/matplotlib
fi

