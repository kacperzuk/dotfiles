source ~/.config/fish/nvm-wrapper/nvm.fish

if status --is-interactive
    if [ -z "$TMUX" ]
        set SESSIONS (tmux list-sessions ^/dev/null)
        if [ $status -eq 0 ]
            set SESS_ID (echo $SESSIONS | grep -v "attached" | head -1 | cut -d":" -f1)
            if [ -n "$SESS_ID" ]
                echo asd
                echo $SESS_ID
                exec tmux -2 -u attach-session -t $SESS_ID
            end
        end
        exec tmux -2 -u
    end
end

set -x ABSROOT /home/kaz/PKGBUILDs
set -x PATH ~/bin $PATH ~/npm/bin
set -x EDITOR vim
set -x SSH_AUTH_SOCK $HOME/.gnupg/S.gpg-agent.ssh

set fish_greeting

alias vim='nvim'
