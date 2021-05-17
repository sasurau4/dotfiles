## dotfiles

### Initial setup

```
git clone git@github.com:sasurau4/dotfiles.git
cd dotfiles
./scripts/init.sh
env RCRC=$HOME/dotfiles/rcrc rcup
```

Install [fisher](https://github.com/jorgebucaran/fisher)

```
fisher install decors/fish-ghq
fisher install oh-my-fish/plugin-peco
```

If you on Mac, `brew install vim` and conirm version with `+python3`
You on Linux, use `install-vim.sh`
