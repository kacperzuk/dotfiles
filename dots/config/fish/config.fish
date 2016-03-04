source ~/.config/fish/nvm-wrapper/nvm.fish

if status --is-interactive
    if [ -z "$TMUX" ]
        set SESSIONS (tmux list-sessions ^/dev/null)
        if [ $status -eq 0 ]
            set SESS_ID (echo $SESSIONS | grep -v "attached" | head -1 | cut -d":" -f1)
            if [ -n "$SESS_ID" ]
                echo asd
                echo $SESS_ID
                exec tmux -u attach-session -t $SESS_ID
            end
        end
        exec tmux -u
    end
    keychain --agents gpg,ssh --confhost --confirm -Q --eval | source
end

set -x ABSROOT /home/kaz/PKGBUILDs
set -x PATH ~/bin (find ~/Qt/Tools -type d -name bin) /home/kaz/.gem/ruby/2.2.0/bin $PATH /home/kaz/Android/android-sdk-linux/tools /home/kaz/Android/android-sdk-linux/platform-tools /home/kaz/Android/android-ndk-r10d/ ~/npm/bin ~/.cabal/bin ~/.composer/vendor/bin
set -x OPENCV_PATH ~/Android/OpenCV
set -x EDITOR vim
set fish_greeting
