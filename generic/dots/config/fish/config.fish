if test -z "$PATHSET"
    set -x PATHSET true
    set -x PATH ~/bin /usr/local/bin $PATH ~/npm/bin
end

if test -z "$LANG"
    set -x LANG (grep LANG /etc/locale.conf | sed 's/LANG=//')
end

if status --is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" -eq 1 -a -z "$TMUX"
        exec sway -dV &>/tmp/sway.log
    end
end

if status --is-interactive
    if [ -z "$TMUX" -a -n "$XDG_VTNR" -a "$XDG_VTNR" -ne 2 ]
        tmux start-server
        set SESS_ID (tmux list-sessions ^/dev/null | grep -v "attached" | head -1 | cut -d":" -f1)
        if [ -n "$SESS_ID" ]
            exec tmux -2 -u attach-session -t $SESS_ID
        end
        exec tmux -2 -u
    end
end

source ~/.config/fish/nvm-fish-wrapper/nvm.fish
source ~/.config/fish/pass.fish-completion

set -x ABSROOT /home/kaz/PKGBUILDs
set -x EDITOR nvim
set -x SSH_AUTH_SOCK /run/user/(id -ru)/gnupg/S.gpg-agent.ssh

alias gdb "gdb -q"

set fish_greeting
alias vim nvim
