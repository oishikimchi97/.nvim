#!/bin/bash
set -e

NVIM_DIR="${HOME}/.config/nvim"
CUSTOM_DIR="${NVIM_DIR}/lua/custom"
GITHUB_USER="oishikimchi97"

echo "=== NvChad + Custom Config Setup ==="

# 1. Install NvChad if not present
if [ ! -d "${NVIM_DIR}/.git" ]; then
  echo "Cloning NvChad..."
  git clone https://github.com/NvChad/NvChad "${NVIM_DIR}" --depth 1 --branch v2.0
else
  echo "NvChad already installed at ${NVIM_DIR}"
fi

# 2. Backup existing custom dir if present
if [ -d "${CUSTOM_DIR}" ] && [ ! -d "${CUSTOM_DIR}/.git" ]; then
  echo "Backing up existing custom dir..."
  mv "${CUSTOM_DIR}" "${CUSTOM_DIR}.bak.$(date +%s)"
fi

# 3. Clone custom config
if [ ! -d "${CUSTOM_DIR}/.git" ]; then
  echo "Cloning custom config..."
  git clone "https://github.com/${GITHUB_USER}/.nvim" "${CUSTOM_DIR}"
else
  echo "Custom config already installed, pulling latest..."
  git -C "${CUSTOM_DIR}" pull
fi

# 4. Check nvim availability
if ! command -v nvim &>/dev/null; then
  echo ""
  echo "WARNING: nvim not found in PATH."
  echo "Install Neovim 0.9.4+ before running."
  echo "  AppImage (Linux x86_64): https://github.com/neovim/neovim/releases"
  echo "  Homebrew (macOS):        brew install neovim"
  exit 1
fi

echo ""
echo "Done! Run 'nvim' to install plugins automatically."
