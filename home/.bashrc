# dotfiles/home/.bashrc -> /home/$USER/.bashrc
# Author: Mountain Man


# Test for an interactive shell.
if [[ $- != *i* ]] ; then
	  return
fi


##########################################################################
# PS1 - Primary prompt displayed before each command
####################################################
# The PS1 prompt is constructed piece-by-piece by concatenating each
# component to the previous component. Parts of the prompt are colored
# conditionally based on what kind of user is logged in.
#
# Breakdown of PS1 components:
# [TTY#] [DATE TIME] [USER HOST] [DIR] >
#
# Example of what the prompt should look like:
# [1] [2023-03-28 16:02:55] [user host] [/etc/portage] >
##########################################################################
# Set colors for easy reading
PS1_COLOR_RESET="\[\e[0m\]"
PS1_COLOR_GREY="\[\e[90m\]"
PS1_COLOR_RED="\[\e[91m\]"
PS1_COLOR_YELLOW="\[\e[33m\]"
PS1_COLOR_BLUE="\[\e[94m\]"
PS1_COLOR_CYAN="\[\e[96m\]"

if [[ "$(id -u)" == 0 ]]; then       # if root
    PS1_COLOR_MAIN=$PS1_COLOR_RED    # set main color red
elif [[ "$USER" == *"-dev" ]]; then  # if -dev account
    PS1_COLOR_MAIN=$PS1_COLOR_YELLOW # set main color yellow
else                                 # all other accounts
    PS1_COLOR_MAIN=$PS1_COLOR_GREY   # set main color grey
fi

# Start with a blank PS1 prompt
PS1=""

# [TTY#] [DATE TIME]
PS1+=$PS1_COLOR_MAIN
TTY_NUM=$(ps -p $$ -o tty= | tr -dc '0-9')
PS1+="[$TTY_NUM] [\D{%F} \t] "
PS1+=$PS1_COLOR_RESET

# [SSH USER@HOST]
PS1+=$PS1_COLOR_MAIN
if [[ "$SSH_TTY" == "/dev/pts"* ]]; then # if this is SSH session
    PS1+="[SSH "                         # add "[SSH "
else                                     # if not
    PS1+="["                             # don't
fi
PS1+=$PS1_COLOR_RESET

PS1+="$PS1_COLOR_CYAN\u$PS1_COLOR_RESET" # USER
PS1+="$PS1_COLOR_GREY@$PS1_COLOR_RESET"  # @
PS1+="$PS1_COLOR_BLUE\h$PS1_COLOR_RESET" # HOST
PS1+="$PS1_COLOR_MAIN] $PS1_COLOR_RESET" # ]

# [DIR] >
PS1+="$PS1_COLOR_MAIN[$PS1_COLOR_RESET"    # [
PS1+="$PS1_COLOR_CYAN\w$PS1_COLOR_RESET"   # DIR
PS1+="$PS1_COLOR_MAIN] > $PS1_COLOR_RESET" # ] >
##########################################################################


##########################################################################
# PS2 - Secondary prompt displayed when a command needs more input
##################################################################
PS2=" > "
##########################################################################


##########################################################################
# Aliases
#########
alias wget="wget -c --tries=10 --timeout=10 --waitretry=30s"
alias ls="exa -1aFghlU --git --color=always --sort=name --time-style=iso"
##########################################################################
