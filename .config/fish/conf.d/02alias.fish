abbr --add cpoy 'xclip -selection c'
abbr --add pasta 'xclip -selection c -o'
abbr --add python python3
abbr --add pip pip3
abbr --add mysql 'mysql -h localhost -uroot -p -P 3306 --protocol=tcp'
abbr --add psql 'psql -h localhost -U postgres -W'
abbr --add redis 'redis-cli -h localhost'
abbr --add vim nvim
abbr --add vi nvim
abbr --add ls 'exa -l --icons'
abbr --add cat batcat
abbr --add kilmux "tmux list-sessions | grep -v attached | awk 'BEGIN{FS=\":\"}{print $1}' | xargs -n 1 tmux kill-session -t"
abbr --add grep rg
abbr --add du 'dust -d 1 -x -D'
abbr --add tmux 'tmux -u'
abbr --add avd avdmanager
abbr --add tree 'exa --tree --icons --level=4'
abbr --add find fd
abbr --add explorer nautilus

function killport
    kill -9 (lsof -i :$argv[1] -t)
end

function office --wraps git --description "Setup the current repository for Rivi use"
    git config --local user.name "Piyush Devara"
    git config --local user.email piyush@rivi.co
    git config --local user.signingkey (gpg --list-keys piyush@rivi.co | sed -n 2p | xargs)
    git config --local commit.gpgsign true
end

function decathlon --wraps git --description "Setup the current repo for Decathlon use"
    git config --local user.name "Piyush Devara"
    git config --local user.email piyush.devara.partner@decathlon.com
    git config --local user.signingkey (gpg --list-keys piyush.devara.partner@decathlon.com | sed -n 2p | xargs)
    git config --local commit.gpgsign true
end

function fish_greeting
    fortune -a -s -n 175 | dogsay | lolcat
    fortune -a -s -n 175 | cowsay | lolcat
end
