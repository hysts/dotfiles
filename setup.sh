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
    [ $dotfile = '.ssh' ] && continue
    [ $dotfile = '.gitignore' ] && continue
    [ $dotfile = '.jupyter' ] && continue
    [ $dotfile = '.ipython' ] && continue
    ln -snfv ~/dotfiles/$dotfile ~/$dotfile
done


# setup global gitignore
src_dir=~/dotfiles/git
dst_dir=~/.config/git
mkdir -p ${dst_dir}
ln -sfnv ${src_dir}/ignore  ${dst_dir}/ignore

# needed for fixing ssh agent when tmux is detached
src_dir=~/dotfiles/.ssh
dst_dir=~/.ssh
mkdir -p ${dst_dir}
ln -sfnv ${src_dir}/rc ${dst_dir}/rc

# setup ipython startup scripts
src_dir=~/dotfiles/.ipython/profile_default/startup
dst_dir=~/.ipython/profile_default/startup
mkdir -p ${dst_dir}
ln -sfnv ${src_dir}/start.py  ${dst_dir}/start.py
ln -sfnv ${src_dir}/start.ipy ${dst_dir}/start.ipy

# setup jupyter notebook config
src_dir=~/dotfiles/.jupyter/custom
dst_dir=~/.jupyter/custom
mkdir -p ${dst_dir}
ln -sfnv ${src_dir}/custom.js ${dst_dir}/custom.js

src_dir=~/dotfiles/.jupyter/nbconfig
dst_dir=~/.jupyter/nbconfig
mkdir -p ${dst_dir}
ln -sfnv ${src_dir}/notebook.json ${dst_dir}/notebook.json
ln -sfnv ${src_dir}/tree.json     ${dst_dir}/tree.json

# setup matplotlib config
src_dir=~/dotfiles/matplotlib
dst_dir=~/.config/matplotlib
mkdir -p ${dst_dir}
ln -sfnv ${src_dir}/matplotlibrc ${dst_dir}/matplotlibrc

# setup pip config
src_dir=~/dotfiles/
dst_dir=~/.config/pip
mkdir -p ${dst_dir}
ln -sfnv ${src_dir}/pip.conf ${dst_dir}/pip.conf


