# Abbreviations and shortcuts.
# Session scope is the fish 4 default, so no scope flag is needed.

abbr -a cpoy 'xclip -selection c'
abbr -a pasta 'xclip -selection c -o'
abbr -a python python3
abbr -a psql 'psql -h localhost -U postgres -W'
abbr -a redis 'redis-cli -h localhost'
abbr -a vim nvim
abbr -a vi nvim
abbr -a ls 'eza -l --icons'
abbr -a tree 'eza --tree --icons --level=4'
abbr -a cat batcat
abbr -a grep rg
abbr -a du 'dust -d 1 -x -D'
abbr -a find fd
abbr -a explorer nautilus
abbr -a gdp 'git diff --no-ext-diff'

function killport --description "Kill whatever listens on a port"
    kill -9 (lsof -i :$argv[1] -t)
end

function personal --wraps git --description "Set the current repository to the personal identity"
    # Name and email come from ~/.config/fish/conf.d/00identity.fish, which
    # link.sh writes per machine and this repo never tracks.
    if not set -q dotfiles_personal_email
        echo "personal: identity is not configured on this machine" >&2
        echo "personal: run link.sh in the dotfiles repo to set it" >&2
        return 1
    end

    set -l email $dotfiles_personal_email
    set -l name $dotfiles_personal_name
    if test -z "$name"
        set name (git config --global --get user.name)
    end

    # Keys rotate, so resolve the fingerprint at call time instead of pinning
    # it. Takes the newest secret key for the address that is not expired,
    # revoked, invalid, or disabled. Colon format: sec field 2 is validity and
    # field 6 is the creation date, and the fpr line that follows a sec block
    # carries the primary fingerprint in field 10.
    set -l key (gpg --list-secret-keys --with-colons $email 2>/dev/null | awk -F: '
        $1 == "sec" {
            valid = ($2 != "e" && $2 != "r" && $2 != "i" && $2 != "d")
            created = $6
            next
        }
        $1 == "fpr" && valid {
            if (created + 0 > best + 0) { best = created; fpr = $10 }
            valid = 0
        }
        END { if (fpr) print fpr }
    ')

    if test -z "$key"
        echo "personal: no usable secret key for $email" >&2
        echo "personal: check `gpg --list-secret-keys $email`" >&2
        return 1
    end

    git config --local user.name "$name"
    git config --local user.email $email
    git config --local user.signingkey $key
    git config --local commit.gpgsign true
end

function diff1 --wraps git --description "Step through a git diff one file at a time"
    set -l plain 0
    if test (count $argv) -gt 0 -a "$argv[1]" = --plain
        set plain 1
        set -e argv[1]
    end

    set -l files (git diff --name-only $argv)
    set -l n (count $files)
    if test $n -eq 0
        echo "No changes."
        return 0
    end

    for i in (seq $n)
        set -l f $files[$i]
        printf '\n%s  (%d of %d)\n\n' $f $i $n

        # Paging is the prompt below, not less, so every file stops whether its
        # diff is one line or a hundred.
        if test $plain -eq 1
            git --no-pager diff --no-ext-diff --color=always -- $f
        else
            git --no-pager diff -- $f
        end

        if test $i -lt $n
            read -P "  [enter] next  [q] quit  > " -n 1 key
            if test "$key" = q
                return 0
            end
        end
    end
end

function fish_greeting
end
