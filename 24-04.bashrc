# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
# mise
eval "$(/usr/bin/mise activate bash)"

#------- Customized themes
#eval "$(oh-my-posh init bash --config ~/.OMP/atomic.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.OMP/atomicBit.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.OMP/chips.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.OMP/cloud-native-azure.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.OMP/huvix.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.OMP/iterm2.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.OMP/negligible.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.OMP/ys.omp.json)"
#------- Default themes
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/1_shell.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/agnoster.minimal.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/agnoster.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/agnosterplus.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/aliens.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/amro.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/atomicBit.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/atomic.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/avit.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/blueish.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/blue-owl.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/bubblesextra.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/bubblesline.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/bubbles.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/capr4n.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/catppuccin_frappe.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/catppuccin_latte.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/catppuccin_macchiato.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/catppuccin_mocha.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/catppuccin.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/cert.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/chips.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/cinnamon.omp.json)"
eval "$(oh-my-posh init bash --config ~/.oh-my-posh/clean-detailed.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/cloud-context.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/cloud-native-azure.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/cobalt2.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/craver.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/darkblood.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/devious-diamonds.omp.yaml
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/di4am0nd.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/dracula.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/easy-term.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/emodipt-extend.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/emodipt.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/fish.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/free-ukraine.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/froczh.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/glowsticks.omp.yaml
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/gmay.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/grandpa-style.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/gruvbox.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/half-life.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/honukai.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/hotstick.minimal.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/hul10.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/hunk.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/huvix.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/if_tea.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/illusi0n.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/iterm2.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/jandedobbeleer.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/jblab_2021.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/jonnychipz.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/json.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/jtracey93.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/jv_sitecorian.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/kali.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/kushal.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/lambdageneration.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/lambda.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/larserikfinholt.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/lightgreen.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/M365Princess.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/marcduiker.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/markbull.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/material.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/microverse-power.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/mojada.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/montys.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/mt.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/multiverse-neon.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/negligible.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/neko.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/night-owl.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/nordtron.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/nu4a.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/onehalf.minimal.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/paradox.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/pararussel.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/patriksvensson.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/peru.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/pixelrobots.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/plague.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/poshmon.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/powerlevel10k_classic.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/powerlevel10k_lean.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/powerlevel10k_modern.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/powerlevel10k_rainbow.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/powerline.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/probua.minimal.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/pure.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/quick-term.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/remk.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/robbyrussell.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/rudolfs-dark.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/rudolfs-light.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/sim-web.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/slimfat.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/slim.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/smoothie.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/sonicboom_dark.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/sonicboom_light.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/sorin.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/space.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/spaceship.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/star.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/stelbent-compact.minimal.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/stelbent.minimal.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/takuya.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/thecyberden.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/the-unnamed.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/tiwahu.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/tokyonight_storm.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/tokyo.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/tonybaloney.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/uew.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/unicorn.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/velvet.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/wholespace.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/wopian.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/xtoys.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/ys.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/zash.omp.json)"
