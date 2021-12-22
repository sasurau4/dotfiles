## dotfiles

### Initial setup

```
git clone git@github.com:sasurau4/dotfiles.git
cd dotfiles
sudo ./scripts/init.sh
env RCRC=$HOME/dotfiles/rcrc rcup
```

then logout, login and run with fish

```
./scripts/post-install.sh
```

If you on Mac, `brew install vim` and conirm version with `+python3`
You on Linux, use `install-vim.sh`
