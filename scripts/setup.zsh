#!/usr/bin/env zsh
# INFO: stow -t ~/.config dotfiles from ~(root)
# add stow path from file (dotfiles)
# # add symlink for .hammerspoon
# INFO:  ln -s ~/dotfiles/.hammerspoon from ~(root)
hammerspoon_path='~/dotfiles/.hammerspoon'

# # add bin files for homebrew for macos
# INFO:  eval "$(/opt/homebrew/bin/brew shellenv)"
# echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
extract_homebrew_bin() {
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
}

environment=$1
# add tmux file using the ~/.config dir
# INFO: add this for sketchybar-app-fonts to work
# Installing Fonts
# git clone git@github.com:shaunsingh/SFMono-Nerd-Font-Ligaturized.git /tmp/SFMono_Nerd_Font
# mv /tmp/SFMono_Nerd_Font/* $HOME/Library/Fonts
# rm -rf /tmp/SFMono_Nerd_Font/
# curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v1.0.4/sketchybar-app-font.ttf -o $HOME/Library/Fonts/sketchybar-app-font.ttf
setup_sketchybar() {
	# Clone the SFMono Nerd Font repository

    if [ [ -d "/tmp/SFMono_Nerd_Font" ] ]; then
      rm -rf /tmp/SFMono_Nerd_Font
    fi

    git clone git@github.com:shaunsingh/SFMono-Nerd-Font-Ligaturized.git /tmp/SFMono_Nerd_Font

    if [ [ $? -ne 0 ] ]; then
      echo "Error cloning SFMono Nerd Font repository."

    return 1
    fi

  # Move the cloned fonts to the user's Library/Fonts directory
  mv "/tmp/SFMono_Nerd_Font/"* "$HOME/Library/Fonts/"
  if [ [  $? -ne 0 ] ]; then
    echo "Error moving SFMono Nerd Font files."
    return 1
  fi
  rm -rf /tmp/SFMono_Nerd_Font/

  # Download the SketchyBar app font
  curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v1.0.4/sketchybar-app-font.ttf -o "$HOME/Library/Fonts/sketchybar-app-font.ttf"
  if [ $? -ne 0 ]; then
    echo "Error downloading SketchyBar app font."
    return 1
  fi
}

# TODO:  tmux source ~/.config/tmux/tmux.conf
# tmux_path="$HOME/.config/tmux/tmux.conf"

# WARNING: TO get spaces to work in skhd and yabai
#follow: https://github.com/koekeishiya/yabai/wiki/Installing-yabai-(latest-release)#configure-scripting-addition
#issue: https://github.com/koekeishiya/yabai/issues/1158
#commands: sudo nvram boot-args=-arm64e_preview_abi
# reboot
# sudo yabai --uninstall-sa
# sudo yabai --install-sa
# sudo yabai --load-sa
# set up the csrutils disable in recovery mode

run_setup() {
	echo "Running the setup script\n"

	#INFO: change to root directory
	cd "$HOME"
	stow -t "$HOME/.config" -d "$HOME/dotfiles" '.config'
	stow -t "$HOME" -d "$HOME/dotfiles" 'hammerspoon'

  if [[ $environment == '-p' ]]; then 
    echo "Stowing zshrc\n"
    stow -t "$HOME" -d "$HOME/dotfiles" 'gitconfig'
    stow -t "$HOME" -d "$HOME/dotfiles" 'zshrc'
  fi

	if [[ $? -ne 0 ]]; then
		echo "Error stowing dotfiles ❌\n"
		return 1
	fi
	echo "finished stowing"

  tmux-source
  echo "$?"

	if [[ $? -ne 0 ]]; then
		echo "Error sourcing tmux ❌\n"
	fi

    echo "Cloning tpm for tmux plugins 🚀 \n"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

    if [[ $? -ne 0 ]]; then
      echo "Error cloning tpm for tmux plugins ❌\n 
TPM may already exists 🌳"
      return 1
    fi

	echo "Run ctrl + t + I to install tpm plugins"
}

#INFO: run the functions
run_setup
extract_homebrew_bin 

if [[ $environment == '-p' ]]; then 
  setup_sketchybar
fi
