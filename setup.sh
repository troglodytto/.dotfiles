#!/usr/bin/env bash
# Install the cargo and go tools this configuration expects.
#
# Cargo and go only. Everything else the shell config touches comes from the
# system package manager and is listed at the end rather than installed here.
#
#   ./setup.sh          install everything
#   ./setup.sh --list   print what would be installed, install nothing
set -euo pipefail

# Crates. cargo-binstall goes first, then it fetches prebuilt binaries for the
# rest, which is far faster than compiling each one.
CRATES=(
  "cargo-binstall"   # prebuilt-binary installer, used for everything below
  "difftastic"       # difft, structural diff, wired as git diff.external
  "du-dust"          # dust, the `du` abbr
  "eza"              # the `ls` and `tree` abbrs
  "fd-find"          # fd, the `find` abbr
  "ripgrep"          # rg, the `grep` abbr and FZF_DEFAULT_COMMAND
  "sccache"          # RUSTC_WRAPPER in 01path.fish
  "sqlx-cli"         # sqlx
  "starship"         # the prompt
)
# Also installed here historically but no longer used by this config:
#   git-delta        # delta, replaced by difftastic

# Go modules, module path per line.
GO_MODULES=(
  "github.com/junegunn/fzf"                              # fzf, key bindings in config.fish
  "github.com/go-delve/delve/cmd/dlv"                    # dlv, go debugger
  "github.com/charmbracelet/freeze"                      # freeze, code screenshots
  "charm.land/glow/v3"                                   # glow, markdown reader
  "github.com/golangci/golangci-lint/v2/cmd/golangci-lint"
  "golang.org/x/tools/gopls"                             # gopls, go language server
  "github.com/rakyll/hey"                                # hey, load generator
  "github.com/gohugoio/hugo"                             # hugo, static site generator
  "github.com/troglodytto/prizm"                         # prizm
)

SYSTEM_PACKAGES="bat xclip neovim postgresql-client redis-tools nautilus lsof"

if [ "${1:-}" = "--list" ]; then
  echo "crates:"
  printf '  %s\n' "${CRATES[@]%% *}"
  echo "go modules:"
  printf '  %s\n' "${GO_MODULES[@]%% *}"
  echo "system packages (not installed by this script):"
  echo "  $SYSTEM_PACKAGES"
  exit 0
fi

command -v cargo >/dev/null || { echo "cargo not found. Install rust first: https://rustup.rs" >&2; exit 1; }
command -v go    >/dev/null || { echo "go not found. Install go first: https://go.dev/dl/" >&2; exit 1; }

echo "== crates =="
for entry in "${CRATES[@]}"; do
  crate="${entry%% *}"
  if [ "$crate" = "cargo-binstall" ]; then
    if command -v cargo-binstall >/dev/null; then
      echo "  have    cargo-binstall"
    else
      echo "  install cargo-binstall (from source, once)"
      cargo install --locked cargo-binstall
    fi
    continue
  fi

  if cargo install --list | grep -q "^$crate v"; then
    echo "  have    $crate"
  elif command -v cargo-binstall >/dev/null; then
    echo "  install $crate"
    cargo binstall --no-confirm "$crate"
  else
    echo "  install $crate (from source)"
    cargo install --locked "$crate"
  fi
done

echo "== go modules =="
for entry in "${GO_MODULES[@]}"; do
  mod="${entry%% *}"
  bin="$(basename "${mod%/v[0-9]}")"
  if command -v "$bin" >/dev/null; then
    echo "  have    $bin"
  else
    echo "  install $mod"
    go install "$mod@latest"
  fi
done

echo
echo "== not handled here =="
echo "System packages, install with your package manager:"
echo "  $SYSTEM_PACKAGES"
echo "uv, for python:  https://docs.astral.sh/uv/getting-started/installation/"
echo
echo "Then run ./link.sh to symlink the config and set your identity."
