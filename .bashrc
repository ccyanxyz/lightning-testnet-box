
if [ "`id -u`" -ne 0 ]; then
    export PS1='\[\033[32;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w\[\033[00m\]\$ '
else
    export PS1='\[\033[32;32m\]\h\[\033[00m\] \[\033[01;34m\]\w\[\033[00m\]\$ '
fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
	eval "`dircolors -b`"
	alias ls='ls -a --color=auto'
	alias grep='grep --color=auto'
	alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -l'
alias lh='ls -lh'
alias la='ls -Al'

alias b1='bitcoin-cli -datadir=/root/lightning-testnet-box/node1 '
alias b2='bitcoin-cli -datadir=/root/lightning-testnet-box/node2 '
alias b3='bitcoin-cli -datadir=/root/lightning-testnet-box/node3 '
alias b4='bitcoin-cli -datadir=/root/lightning-testnet-box/node4 '
alias l1='lightning-cli --lightning-dir=/root/lightning-testnet-box/node1/lightning '
alias l2='lightning-cli --lightning-dir=/root/lightning-testnet-box/node2/lightning '
alias l3='lightning-cli --lightning-dir=/root/lightning-testnet-box/node3/lightning '
alias l4='lightning-cli --lightning-dir=/root/lightning-testnet-box/node4/lightning '
