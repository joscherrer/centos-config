# centos-config

## Packages

- 'Development Tools'
- epel-release
- xrdp (EPEL)
- xorgxrdp (EPEL)
- nvim (make)
- dwm (make)
- st (make)
- dmenu (make)

## Neovim configuration

### vim-plug

```shell
sh -c 'curl -fLo "${$HOME/.local/share}"/nvim/site/autoload/plug.vim \
    --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
mkdir -p ~/.local/share/nvim/plugged/
```

