# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    zsh-syntax-highlighting
    #zsh-completions
)

# User configuration

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"



##################################################
##################################################


export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=1000000
setopt share_history

export LD_LIBRARY_PATH=/usr/local/lib:/usr/lib

# use vim keybinding in zsh
bindkey -v

# use Caps Lock as extra Control
#setxkbmap -option ctrl:nocaps

# suppress ssh related error messages
export NO_AT_BRIDGE=1

ssh-add -A 2>/dev/null


##################################################
##################################################


if [ -f ~/.secrets/git_ssh.sh ]; then
    alias git="GIT_SSH=~/.secrets/git_ssh.sh git"
fi

if git config github.token > /dev/null 2>&1; then
    function create_github_repo()
    {
        curl -v -H "Authorization: token $(git config github.token)" https://api.github.com/user/repos -d '{"name":"'$1'"}'
    }

    function delete_github_repo()
    {
        curl -v -H "Authorization: token $(git config github.token)" -X DELETE https://api.github.com/repos/$(git config github.user)/$1
    }
fi


##################################################
##################################################


alias grep='grep --color=auto -E --exclude-dir={.bzr,CVS,.git,.hg,.svn}'
alias sgrep='grep -EIUrn'

alias ll='ls -lAhFcrt'

alias df='df -h'
alias free='free -h'
alias du='du -h'

alias dud='du -h -d 1'
alias duf='du -sh *'

alias ff='find . -type f -name'
alias fd='find . -type d -name'

# open images with eog
alias -s {jpg,png,bmp,tiff,pgm,ppm,gif,jpeg,JPG,JPEG,PNG,BMP,PGM,PPM}=eog
# open videos with vlc
alias -s {mp4,avi,wmv,ogg,ogv,mov}=vlc
# open html and pdf with chrome
alias -s {html,pdf}='google-chrome --incognito'

# global alias
alias -g @g='| grep'
alias -g @l='| less'
alias -g NUL="> /dev/null 2>&1"

# show archive contents
function show_archive()
{
    case $1 in
        *.tar|*.tar.gz|*.tgz) tar tf   $1 | less ;;
        *.zip)                unzip -l $1 | less ;;
        *.rar)                unrar l  $1 | less ;;
        *.gz)                 gzip -l  $1 | less ;;
        *.7z)                 7z l     $1 | less ;;
    esac
}
alias -s {tar,tar.gz,tgz,zip,rar,gz,7z}=show_archive


# nvidia-docker
if nvidia-docker > /dev/null 2>&1; then
    alias docker='nvidia-docker'
fi
# docker ps -a
alias dps='docker ps -a'
# docker images
alias di='docker images'


# terminator
alias term='terminator -l tile'
# gnome-system-monitor
alias sysm='gnome-system-monitor'
# Chrome
alias chrome='google-chrome'

# jupyter console
alias jc='jupyter console'
# jupyter notebook
alias jnb='jupyter notebook'
# jupyter qtconsole
alias jqt='jupyter qtconsole'

# apt upgrade
alias aptupgrade='sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y'


##################################################
##################################################


function peco-select-history() {
    BUFFER="$(\history -nr 1 | awk '!a[$0]++' | peco --query "$LBUFFER" | sed 's/\\n/\n/')"
    CURSOR=$#BUFFER
    zle -R -c
}

zle -N peco-select-history
bindkey '^R' peco-select-history


##################################################
##################################################


# pyenv
export PYTHON_CONFIGURE_OPTS='--enable-shared --enable-unicode=ucs4'
export PYENV_ROOT=$HOME/.pyenv
if [ -d "${PYENV_ROOT}" ]; then
    export PATH=$PYENV_ROOT/bin:$PATH
    eval "$(pyenv init -)"
fi

# pyenv virtualenvwrapper
pyenv virtualenvwrapper > /dev/null 2>&1
workon py371 > /dev/null 2>&1


##################################################
##################################################


# pip zsh completion start
function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="$words[*]" \
             COMP_CWORD=$(( cword-1 )) \
             PIP_AUTO_COMPLETE=1 $words[1] ) )
}
compctl -K _pip_completion pip
# pip zsh completion end


##################################################
##################################################


# CUDA, cuDNN
export CUDA_ROOT=/usr/local/cuda
export PATH=$CUDA_ROOT/bin:$PATH
export LIBRARY_PATH=$CUDA_ROOT/lib64:$LIBRARY_PATH
export LD_LIBRARY_PATH=$CUDA_ROOT/lib64:$LD_LIBRARY_PATH

# Intel MKL, IPP
export MKL_ROOT_DIR=/opt/intel/mkl
export IPP_ROOT_DIR=/opt/intel/ipp
export LD_LIBRARY_PATH=$MKL_ROOT_DIR/lib/intel64:/opt/intel/lib/intel64_lin:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$IPP_ROOT_DIR/lib/intel64:$LD_LIBRARY_PATH
export LIBRARY_PATH=$MKL_ROOT_DIR/lib/intel64:$IPP_ROOT_DIR/lib/intel64:$LIBRARY_PATH

# Qt5.7
#export Qt_DIR=$HOME/libs/Qt5.7/5.7/gcc_64
#export PATH=${Qt_DIR}/bin:$PATH
#export LD_LIBRARY_PATH=${Qt_DIR}/lib:$LD_LIBRARY_PATH
#export PKG_CONFIG_PATH=${Qt_DIR}/lib/pkgconfig:$PKG_CONFIG_PATH
## QtCreator
#export PATH=$HOME/libs/Qt5.7/Tools/QtCreator/bin:$PATH

# OpenCV 3.4.3
export OpenCV_DIR=$HOME/libs/opencv3.4.3
export LD_LIBRARY_PATH=${OpenCV_DIR}/lib:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=${OpenCV_DIR}/lib/pkgconfig:$PKG_CONFIG_PATH
export CMAKE_PREFIX_PATH=${OpenCV_DIR}/share/OpenCV

# dlib 19.16
export DLIB_DIR=$HOME/libs/dlib19.16
export LD_LIBRARY_PATH=${DLIB_DIR}/lib:$LD_LIBRARY_PATH
export DLIB_SHARE=${DLIB_DIR}/share
export CMAKE_PREFIX_PATH=${DLIB_DIR}/lib/cmake/dlib

# Caffe
export CAFFE_ROOT=$HOME/caffe
export PYTHONPATH=$CAFFE_ROOT/python:$PYTHONPATH

# Torch
export TORCH_DIR=$HOME/torch
if [ -d "${TORCH_DIR}" ]; then
    . ${TORCH_DIR}/install/bin/torch-activate
    #export PATH=$HOME/torch/install/bin:$PATH
    #export LD_LIBRARY_PATH=$HOME/torch/install/lib:$LD_LIBRARY_PATH
fi

# ROS
export ROS_DIR=/opt/ros/indigo
if [ -d "${ROS_DIR}" ]; then
    source /opt/ros/indigo/setup.zsh
    source /usr/share/gazebo/setup.sh
    export GAZEBO_MODEL_PATH=$HOME/.gazebo/additional_models:$GAZEBO_MODEL_PATH
    export PYTHONPATH=$PYTHONPATH:/usr/lib/python2.7/dist-packages/wx-2.8-gtk2-unicode
fi

# ViZDoom 1.1.3
export PYTHONPATH=$PYTHONPATH:$HOME/libs/ViZDoom/bin/python2/pip_package


##################################################
##################################################


# PyCharm
export PATH=$PATH:$HOME/PyCharm/pycharm-community-2017.2.3/bin
alias pycharm=pycharm.sh

# TORCS
export TORCS_DIR=$HOME/softwares/Torcs/torcs-1.3.7
export PATH=$PATH:${TORCS_DIR}/install/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${TORCS_DIR}/install/lib


##################################################
##################################################


alias upgrade_numpy='pip uninstall numpy; pip install -U --no-binary :all: numpy'
alias upgrade_scipy='pip uninstall scipy; pip install -U --no-binary :all: scipy'


##################################################
##################################################


# nautilus
function open()
{
    local name=$1
    if [ -d $name ]; then
        nautilus $name
    fi
}

# pandoc
function md2html()
{
    pandoc -s --self-contained -t html5 -c $HOME/.pandoc/github.css $@
}

# docker
#
# Usage:
# dor ubuntu:16.04 -v`pwd`:/data -p8080:5000
#
function dor()
{
    local name=$1
    shift 1
    docker run -it --rm \
    --env="DISPLAY=unix$DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --volume=datavol:/root \
    --workdir=/root \
    $@ \
    $name
}

# wget
#
# Usage:
# wget_recurs --cut-dirs=1 http://foo.com/bar/baz
#
function wget_recurs()
{
    wget -r -np -nH -R 'index.html*' $@
}

# chmod recursively
function chmod_recurs()
{
    local name=$1
    find $name -type f -exec chmod 644 {} \;
    #find $name -type d -exec chmod 755 {} \;
}


##################################################
##################################################

alias fixtmuxssh='export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock'
