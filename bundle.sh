#!/bin/bash

# Downloads all the repositories I need, and bundle them in a single tar.gz
# antibody:
#    - plugin.git
#    - plugin.git
# dotfiles.git
#

die() {
    local rc
    local msg
    rc=$1
    msg=$2

    [ -n "$msg" ] && echo "$msg" && exit "$rc"

    case "$rc" in
        "307")
            echo "PROXYCONNECT failed"
            ;;
        *)
            echo "Unknown error, please see logs"
            ;;
    esac
    exit "$rc"
}

renew() {
    if [ -d "$1" ]; then
        rm -Rf "$1" || ( echo "Couldn't delete $1"; exit 1 )
    fi
    mkdir -p "$1" || ( echo "Couln't create $1"; exit 1 )
}

iscompressed() {
    file "$1" | grep -q 'compressed data'
}

[ -z "$HOME" ] && echo -e "ERROR: \$HOME not set. Exiting" && exit 1

TMPDIR="$HOME/.tmp/centos-config"
BAREDIR="$TMPDIR/bare"
ARCHIVESDIR="$TMPDIR/archives"

# renew
renew "$TMPDIR"
renew "$BAREDIR"
renew "$ARCHIVESDIR"

# We need to clone dotfiles to get the plugins list
git clone https://github.com/joscherrer/dotfiles.git "$TMPDIR/dotfiles" || die $?
# plugins_list=$(awk '{print $1}' "$TMPDIR/dotfiles/.config/zsh/plugins_list")
# readarray -t plugins < <(echo -e "$plugins_list")

# Cloning all the bare repositories
# git clone https://github.com/joscherrer/dotfiles.git "$BAREDIR/joscherrer/dotfiles.git" --bare || die $?
# for plugin in "${plugins[@]}"; do
#     git clone "https://github.com/$plugin" "$BAREDIR/$plugin.git" --bare
# done

# Downloading all the archives
curl -q -L https://sourceforge.net/projects/zsh/files/zsh/5.8/zsh-5.8.tar.xz -o "$ARCHIVESDIR/zsh.tar.xz"
iscompressed "$ARCHIVESDIR/zsh.tar.xz" || die 1 "$ARCHIVESDIR/zsh.tar.xz is not a compressed file"
curl -q -L https://github.com/git/git/archive/v2.28.0.tar.gz -o "$ARCHIVESDIR/git.tar.gz"
iscompressed "$ARCHIVESDIR/git.tar.gz" || die 1 "$ARCHIVESDIR/zsh.tar.xz is not a compressed file"
curl -q -L https://github.com/neovim/neovim/releases/download/v0.4.4/nvim-linux64.tar.gz -o "$ARCHIVESDIR/nvim.tar.gz"
iscompressed "$ARCHIVESDIR/nvim.tar.gz" || die 1 "$ARCHIVESDIR/nvim.tar.gz is not a compressed file"
curl -q -L https://github.com/tmux/tmux/releases/download/3.1c/tmux-3.1c.tar.gz -o "$ARCHIVESDIR/tmux.tar.gz"
iscompressed "$ARCHIVESDIR/tmux.tar.gz" || die 1 "$ARCHIVESDIR/tmux.tar.gz is not a compressed file"

cd "$TMPDIR" || exit 1
tar czvf bare.tar.gz bare archives