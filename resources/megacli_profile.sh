# Provide support for 'man megacli'
man() {
    shopt -s nocasematch
    if [[ $@ =~ "megacli" ]]; then
        command megacli -help | less -S
    elif [[ $@ =~ "storcli" ]]; then
        command storcli -help | less -S
    else
        command man "$@"
    fi
}

# Environment variabls
TERM="xterm"
PATH="/megacli:$PATH"

# Bash aliases
alias pico="nano"
