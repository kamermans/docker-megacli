# Provide support for 'man megacli'
man() {
    shopt -s nocasematch
    if [[ $@ =~ "megacli" ]]; then
        command megacli -help | less -S
    else
        command man "$@"
    fi
}

# Environment variabls
TERM="xterm"

# Bash aliases
alias pico="nano"

