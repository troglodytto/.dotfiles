abbr --add cpoy 'xclip -selection c'
abbr --add pasta 'xclip -selection c -o'
abbr --add python 'python3'
abbr --add pip 'pip3'
abbr --add mysql 'docker run -it --network bridge --rm mysql mysql -h 172.17.0.1 -uroot -p'
abbr --add psql 'docker run -it --rm --network bridge postgres psql -h 172.17.0.1 -U postgres -W'
abbr --add redis 'docker run -ti --network bridge --rm redis redis-cli -h 172.17.0.1'
abbr --add vim 'lvim'
abbr --add v 'nvim'
abbr --add ls 'exa -l --icons'
abbr --add cat 'batcat'
abbr --add kilmux "tmux list-sessions | grep -v attached | awk 'BEGIN{FS=\":\"}{print $1}' | xargs -n 1 tmux kill-session -t"
abbr --add grep 'rg'
abbr --add du 'dust -d 1'
abbr --add tmux 'tmux -u'
abbr --add avd 'avdmanager'
abbr --add tree 'exa --tree --icons --level=4'

function office --wraps git --description "Setup the current repository for office use"
  git config --local user.name "Piyush Upadhyay"
  git config --local user.email piyush@rivi.co
  git config --local user.signingkey DE042B1B56FBD106278C17D9927F7DB60649C8DE
  git config --local commit.gpgsign true
end
