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


eval "$(oh-my-posh init bash --config ~/.config/themes/1_shell.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/agnoster.minimal.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/agnoster.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/agnosterplus.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/aliens.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/amro.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/atomicBit.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/atomic.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/avit.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/blueish.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/blue-owl.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/bubblesextra.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/bubblesline.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/bubbles.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/capr4n.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/catppuccin_frappe.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/catppuccin_latte.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/catppuccin_macchiato.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/catppuccin_mocha.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/catppuccin.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/cert.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/chips.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/cinnamon.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/clean-detailed.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/cloud-context.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/cloud-native-azure.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/cobalt2.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/craver.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/darkblood.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/devious-diamonds.omp.yaml)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/di4am0nd.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/dracula.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/easy-term.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/emodipt-extend.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/emodipt.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/fish.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/free-ukraine.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/froczh.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/glowsticks.omp.yaml)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/gmay.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/grandpa-style.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/gruvbox.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/half-life.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/honukai.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/hotstick.minimal.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/hul10.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/hunk.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/huvix.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/if_tea.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/illusi0n.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/iterm2.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/jandedobbeleer.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/jblab_2021.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/jonnychipz.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/json.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/jtracey93.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/jv_sitecorian.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/kali.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/kushal.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/lambdageneration.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/lambda.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/larserikfinholt.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/lightgreen.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/M365Princess.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/marcduiker.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/markbull.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/material.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/microverse-power.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/mojada.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/montys.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/mt.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/multiverse-neon.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/negligible.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/neko.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/night-owl.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/nordtron.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/nu4a.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/onehalf.minimal.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/paradox.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/pararussel.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/patriksvensson.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/peru.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/pixelrobots.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/plague.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/poshmon.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/powerlevel10k_classic.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/powerlevel10k_lean.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/powerlevel10k_modern.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/powerlevel10k_rainbow.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/powerline.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/probua.minimal.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/pure.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/quick-term.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/remk.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/robbyrussell.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/rudolfs-dark.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/rudolfs-light.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/sim-web.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/slimfat.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/slim.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/smoothie.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/sonicboom_dark.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/sonicboom_light.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/sorin.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/space.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/spaceship.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/star.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/stelbent-compact.minimal.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/stelbent.minimal.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/takuya.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/thecyberden.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/the-unnamed.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/tiwahu.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/tokyonight_storm.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/tokyo.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/tonybaloney.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/uew.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/unicorn.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/velvet.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/wholespace.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/wopian.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/xtoys.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/ys.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/themes/zash.omp.json)"

