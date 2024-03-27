#!usr/bin/env zsh
# INFO: # Brew Formulae
# brew install gsl
# brew install llvm
# brew install ccls
# brew install boost
# brew install libomp
# brew install armadillo
# brew install mas
# brew install neovim
# brew install tree
# brew install wget
# brew install jq
# brew install gh
# brew install ripgrep
# brew install rename
# brew install bear
# brew install neofetch
# brew install wireguard-go
# brew install gnuplot
# brew install lulu
# brew install ifstat
# brew install hdf5
# brew install mactex
# brew install starship
# brew install dooit
# brew install alfred
# brew install zsh-autosuggestions
# brew install zsh-syntax-highlighting
# brew install skhd
# brew install fyabai --head
# brew install fnnn --head
# brew install sketchybar
# brew install svim
# brew install sf-symbols
# brew install switchaudio-osx
# brew install lazygit
# brew install btop

# add stow path from file (dotfiles)
# INFO: stow -t ~/.config dotfiles from ~(root)
dotfiles_path='~/.config dotfiles'

# # add symlink for .hammerspoon
# INFO:  ln -s ~/.dotfiles/.hammerspoon from ~(root)
hammerspoon_path= ~/.dotfiles/.hammerspoon

# # add bin files for homebrew for macos
# INFO:  eval "$(/opt/homebrew/bin/brew shellenv)"
# echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
extract_homebrew_bin() {
	echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>~/.zprofile
}

# add tmux file using the ~/.config dir
# INFO: add this for sketchybar-app-fonts to work
# Installing Fonts
# git clone git@github.com:shaunsingh/SFMono-Nerd-Font-Ligaturized.git /tmp/SFMono_Nerd_Font
# mv /tmp/SFMono_Nerd_Font/* $HOME/Library/Fonts
# rm -rf /tmp/SFMono_Nerd_Font/
# curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v1.0.4/sketchybar-app-font.ttf -o $HOME/Library/Fonts/sketchybar-app-font.ttf
setup_sketchybar() {
	# Clone the SFMono Nerd Font repository
	if [ -d "/tmp/SFMono_Nerd_Font" ]; then
		rm -rf /tmp/SFMono_Nerd_Font
	fi
	git clone git@github.com:shaunsingh/SFMono-Nerd-Font-Ligaturized.git /tmp/SFMono_Nerd_Font

	if [ $? -ne 0 ]; then
		echo "Error cloning SFMono Nerd Font repository."

    # Exit the function with an error status
		return 1 

	# Move the cloned fonts to the user's Library/Fonts directory
	mv "/tmp/SFMono_Nerd_Font/"* "$HOME/Library/Fonts/"
	if [ $? -ne 0 ]; then
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
  tmux_path='tmux source ~/.config/tmux/tnux.conf'

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
	echo "Running the setup script"

	"stow -t $dotfiles_path"

  ifp$? -ne 0]
  then 
    echo "Error stowing dotfiles"
    return 1
  fi

	"ln -s $hammerspoon_path" "$(basename $hammerspoon_path)"

  if [$? -ne 0]
  then 
    echo "Error creating symlink for hammerspoon"
    return 1
  fi

    
  "tmux source ${tmux_path}"
  if [$? -ne 0]
  then 
    echo "Error sourcing tmux"
    return 1
  fi

}

#INFO: run the functions
extract_homebrew_bin()
setup_sketchybar
run_setup
