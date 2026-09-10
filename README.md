# .dotfiles 💙

Oh My GOD! This is beautiful ✨ This Terminal config is Pure Pizzazz 🎩

Fish 🐟 starship 💫 alacritty 🖤 zed ✏️ — paths drop the leading dot, so
`config/fish/config.fish` lands at `~/.config/fish/config.fish`. 🪄

## 🚀 Install

```sh
git clone git@github.com:troglodytto/.dotfiles.git ~/Projects/.dotfiles
cd ~/Projects/.dotfiles
./setup.sh    # 📦 cargo + go tools  (--list to peek first)
./link.sh     # 🔗 symlinks, then asks who you are
```

Both skip what is already done. Re-run freely. 🔁

## 🔑 Identity

`link.sh` asks name + email, drops them in `conf.d/00identity.fish`, off this
repo. Then `personal` in any repo sets your git identity and hunts down the
newest live gpg key for that address. Rotate keys all you like. 🔄

## 🧰 Tools

🦀 `difft` `dust` `eza` `fd` `rg` `sccache` `sqlx` `starship`
🐹 `fzf` `dlv` `freeze` `glow` `golangci-lint` `gopls` `hey` `hugo` `prizm`
🐧 `bat` `xclip` `neovim` `postgresql-client` `redis-tools` `nautilus` `lsof`

`setup.sh` does the crab 🦀 and the gopher 🐹. The penguin 🐧 is yours.

## 🙈 Absent on purpose

Fisher, omf, rustup, deno and fish 4.3 each write their own `conf.d` file.
Machine's business, not the repo's.
