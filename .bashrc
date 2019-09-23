# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

export EDITOR=vim 
HISTTIMEFORMAT="%Y-%m-%dT%H:%M:%SZ"
shopt -s histappend

# Reset
Color_Off='\[\e[0m\]'       # Text Reset
# Regular Colors
Black='\[\e[0;30m\]'        # Black
Red='\[\e[1;31m\]'          # Red
Green='\[\e[1;32m\]'
Yellow='\[\e[0;33m\]'       # Yellow
Blue='\[\e[0;34m\]'         # Blue
Purple='\[\e[0;35m\]'       # Purple
Cyan='\[\e[0;36m\]'         # Cyan
White='\[\e[0;37m\]'        # White
Light_Purple='\[\e[1;35m\]'


#get current branch in git repo #stolen
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo " [${BRANCH}${STAT}]"
	else
		echo ""
	fi
}

if [[ $UID -eq 0 ]]; then
	prompt_color=$Red
else
	prompt_color=$Green
fi

PS1="${Blue}[${Green}\u${Blue}@${White}\`hostname -f\`${Blue}][${White}\w${Blue}]${Red}\`parse_git_branch\`\n[\t]${Blue}[${prompt_color}\\\$${White}]>${Light_Purple} "

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias grep='grep --color=auto'
    alias master='git checkout master'
    alias egrep='egrep --color=auto'
    alias ll='ls -l'
    alias glp='git log -p --graph'
    alias gs='git status'
    alias psit='ps auxef'
    alias add='git add'
    alias commit='git commit'
    alias push='git push'
    alias eni='cat /etc/network/interfaces'
    alias pretty="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset)%C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"

fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

HISTSIZE=
HISTFILESIZE=
HISTCONTROL=ignoreboth

shopt -s histappend
shopt -s checkwinsize

# moar aliases
alias l='ls -laFh'
alias lart='ls -lartFh'
alias ls='ls -F --color=auto'
alias ll='ls -hlF'
alias la='ll -a'
alias mv='mv -i'
alias rm='rm -i'
alias vi='vim'
#ganeti specific
alias job_archive="gnt-job list --no-headers  --error  | tee /dev/tty | awk '{print \$1}' | xargs -I{} gnt-job archive {}"
alias gnl='gnt-node list -o +tags,group,role'
alias gil_full='gnt-instance list -o name,admin_state,status,pnode,snodes,os,vcpus,be/memory,nic.links,disk_template,disk.count,disk.sizes,tags'
alias gil='gnt-instance list -o name,status,pnode,nic.links,disk_template,tags'
alias list_vms="ps h -C qemu-system-x86_64,kvm -o args | sed 's/.* -name \+\([^ ]*\).*/\1/'"
#network
alias bond0='cat /proc/net/bonding/bond0'
alias eni='cat /etc/network/interfaces'
alias oports='netstat -tulpn'

function reswap() {
    swapoff -a
    swapon -a
}

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# get current status of git repo #stolen
function parse_git_dirty {
        status=`git status 2>&1 | tee`
        dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
        untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
        ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
        newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
        renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
        deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
        bits=''
        if [ "${renamed}" == "0" ]; then
                bits=">${bits}"
        fi
        if [ "${ahead}" == "0" ]; then
                bits="*${bits}"
        fi
        if [ "${newfile}" == "0" ]; then
                bits="+${bits}"
        fi
        if [ "${untracked}" == "0" ]; then
                bits="?${bits}"
        fi
        if [ "${deleted}" == "0" ]; then
                bits="x${bits}"
        fi
        if [ "${dirty}" == "0" ]; then
                bits="!${bits}"
        fi
        if [ ! "${bits}" == "" ]; then
                echo " ${bits}"
        else
                echo ""
        fi
}
