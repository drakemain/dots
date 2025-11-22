#!/bin/bash
# Bidirectional dotfiles synchronization script
# Usage: ./sync.sh --pull   (pull from home to repo)
#        ./sync.sh --push   (push from repo to home)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR" || exit 1

# Parse arguments
MODE=""
case "$1" in
  --pull)
    MODE="pull"
    ;;
  --push)
    MODE="push"
    ;;
  *)
    echo "Usage: $0 [--pull|--push]"
    echo "  --pull: Pull changes from home directory to repo"
    echo "  --push: Push changes from repo to home directory"
    exit 1
    ;;
esac

echo "Checking for dotfiles to sync ($MODE mode)..."
CHANGED=0
CONFLICTS=0

# Sync a single file
sync_file() {
  local src="$1"
  local dest="$2"

  if [ -e "$src" ]; then
    # Create parent directory if needed
    mkdir -p "$(dirname "$dest")"

    # Check for conflicts (destination is newer but content differs)
    if [ -e "$dest" ] && ! cmp -s "$src" "$dest" && [ "$dest" -nt "$src" ]; then
      echo "  ⚠ CONFLICT: $dest is newer but differs from $src"
      CONFLICTS=1
      return
    fi

    # Sync the file
    if rsync -auc --itemize-changes "$src" "$dest" | grep -q '^>'; then
      echo "  Synced: $dest"
      CHANGED=1
    fi
  fi
}

# Sync a directory
sync_dir() {
  local src="$1"
  local dest="$2"

  if [ -d "$src" ]; then
    mkdir -p "$dest"

    # Check for conflicts in directory
    while IFS= read -r -d '' file; do
      local rel_path="${file#$src/}"
      local dest_file="$dest/$rel_path"
      if [ -f "$dest_file" ] && ! cmp -s "$file" "$dest_file" && [ "$dest_file" -nt "$file" ]; then
        echo "  ⚠ CONFLICT: $dest_file is newer but differs from source"
        CONFLICTS=1
      fi
    done < <(find "$src" -type f -print0)

    # Sync the directory
    if rsync -auc --itemize-changes --delete "$src/" "$dest/" | grep -q '^'; then
      echo "  Synced: $dest/"
      CHANGED=1
    fi
  fi
}

# Define sync pairs based on mode
if [ "$MODE" = "pull" ]; then
  # Pull from home to repo
  sync_file ~/.zshrc ./.zshrc
  sync_file ~/.vimrc ./.vimrc
  sync_file ~/.Xdefaults ./.Xdefaults
  sync_file ~/.gitconfig ./.gitconfig
  sync_file ~/.ssh/config ./ssh-config
  sync_dir ~/.oh-my-zsh.local ./.oh-my-zsh.local
  sync_dir ~/.config/nvim ./nvim
  sync_dir ~/.config/ghostty ./ghostty

elif [ "$MODE" = "push" ]; then
  # Push from repo to home
  sync_file ./.zshrc ~/.zshrc
  sync_file ./.vimrc ~/.vimrc
  sync_file ./.Xdefaults ~/.Xdefaults
  sync_file ./.gitconfig ~/.gitconfig
  sync_file ./ssh-config ~/.ssh/config
  sync_dir ./.oh-my-zsh.local ~/.oh-my-zsh.local

  # Conditional syncs (only if application is installed)
  if command -v nvim &> /dev/null && [ -d ./nvim ]; then
    sync_dir ./nvim ~/.config/nvim
  fi

  if command -v ghostty &> /dev/null && [ -d ./ghostty ]; then
    sync_dir ./ghostty ~/.config/ghostty
  fi

  if command -v neovide &> /dev/null && [ -d ./neovide ]; then
    sync_dir ./neovide ~/.config/neovide
  fi
fi

# Summary
echo ""
if [ $CONFLICTS -eq 1 ]; then
  echo "⚠ WARNING: Conflicts detected! Files differ and destination is newer."
  echo "Resolve conflicts manually before syncing."
  echo ""
fi

if [ $CHANGED -eq 0 ] && [ $CONFLICTS -eq 0 ]; then
  echo "✓ No changes detected"
elif [ $CHANGED -eq 1 ]; then
  echo "✓ Dotfiles synchronized ($MODE completed)"
fi
