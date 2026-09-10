#!/usr/bin/env bash
# Symlink every config file in this repo to its place under $HOME, then set up
# the machine-local identity the fish `personal` function uses.
# Whatever is already at a destination is replaced. The repo is the source of
# truth, so there are no backups.
set -euo pipefail

REPO="$(cd "$(dirname "$0")" && pwd)"

# repo path : path under $HOME
MAP=(
  "config/fish/config.fish:.config/fish/config.fish"
  "config/fish/conf.d/01path.fish:.config/fish/conf.d/01path.fish"
  "config/fish/conf.d/02alias.fish:.config/fish/conf.d/02alias.fish"
  "config/starship.toml:.config/starship.toml"
  "config/alacritty/alacritty.toml:.config/alacritty/alacritty.toml"
  "config/zed/settings.json:.config/zed/settings.json"
)

for pair in "${MAP[@]}"; do
  src="$REPO/${pair%%:*}"
  dst="$HOME/${pair##*:}"

  if [ ! -f "$src" ]; then
    echo "missing in repo, skipped: ${pair%%:*}"
    continue
  fi

  if [ -L "$dst" ] && [ "$(readlink -f "$dst")" = "$src" ]; then
    echo "already linked: ${pair##*:}"
    continue
  fi

  mkdir -p "$(dirname "$dst")"
  rm -rf "$dst"
  ln -s "$src" "$dst"
  echo "linked:         ${pair##*:}"
done

# ---------------------------------------------------------------------------
# Identity for the fish `personal` function. Machine-local, never tracked.
# The function resolves the gpg fingerprint from this email at call time, so
# rotating a key needs no change here.
# ---------------------------------------------------------------------------

IDENT="$HOME/.config/fish/conf.d/00identity.fish"

if [ -f "$IDENT" ] && [ "${1:-}" != "--reset-identity" ]; then
  echo "identity:       already set, pass --reset-identity to change it"
  exit 0
fi

echo
echo "Identity for the fish 'personal' function."

if command -v gpg >/dev/null 2>&1; then
  keys="$(gpg --list-secret-keys --keyid-format=short 2>/dev/null | grep -E '^(sec|uid)' || true)"
  if [ -n "$keys" ]; then
    echo "Secret keys in this keyring:"
    printf '%s\n' "$keys" | sed 's/^/  /'
  else
    echo "No secret keys in this keyring yet. Import or generate one first,"
    echo "then re-run with --reset-identity."
  fi
else
  echo "gpg is not installed. 'personal' needs it to find a signing key."
fi

echo
read -r -p "Full name: " ident_name
read -r -p "Email:     " ident_email

if [ -z "$ident_email" ]; then
  echo "Email is required. Nothing written." >&2
  exit 1
fi

mkdir -p "$(dirname "$IDENT")"
cat > "$IDENT" <<EOF
# Machine-local identity, written by the dotfiles link.sh.
# Not tracked by the repo. Re-run 'link.sh --reset-identity' to change it.
set -g dotfiles_personal_name "$ident_name"
set -g dotfiles_personal_email "$ident_email"
EOF

echo
echo "wrote:          ~${IDENT#$HOME}"
echo "Open a new shell, then 'personal' inside any repo."
