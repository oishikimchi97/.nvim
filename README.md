# .nvim

Personal NvChad custom configuration.

## Quick Setup

```bash
bash <(curl -s https://raw.githubusercontent.com/oishikimchi97/.nvim/main/setup.sh)
```

## Manual Setup

```bash
# 1. Install NvChad
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 --branch v2.0

# 2. Clone this repo as custom config
git clone https://github.com/oishikimchi97/.nvim ~/.config/nvim/lua/custom

# 3. Launch nvim (plugins install automatically)
nvim
```

## Environments

| Host | OS | Arch | Notes |
|------|-----|------|-------|
| local | macOS | ARM | IM switching enabled |
| liq | Ubuntu 22.04 | x86_64 | nvim install needed |
| miya | RHEL 9 | aarch64 | nvim upgrade needed (0.8 → 0.9.4+) |
