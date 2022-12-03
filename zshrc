# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Use powerline
USE_POWERLINE="true"

# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi

# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Docker
export PATH=/home/james/bin:$PATH
export DOCKER_HOST=unix:///run/user/1000/docker.sock

# Homebrew Package Manager
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Nix Package Manager
if [ -e /home/james/.nix-profile/etc/profile.d/nix.sh ]; then . /home/james/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# thefuck
eval $(thefuck --alias)

# Function
function update-all() {
  echo 'All Updates Starting' | lolcat -S 0
  echo 'Pacman Update Started' | lolcat -S 0
  sudo pacman -Syu
  echo 'Pacman Update Complete' | lolcat -S 0
  echo 'AUR Update Started' | lolcat -S 0
  yay -Syu --aur
  echo 'AUR Update Complete' | lolcat -S 0
  echo 'Brew Update Started' | lolcat -S 0
  brew update
  echo 'Brew Update Complete' | lolcat -S 0 
  echo 'Nix Update Started' | lolcat -S 0
  nix-env -u
  echo 'Nix Update Complete' | lolcat -S 0 
  echo 'All Updates Finished!' | lolcat -S 0 
  echo 'Have a nice day!' | lolcat -S 0
}

# Alias
#alias shit="_ !!"
alias edit-p10k="p10k configure"
alias reload-zsh="source ~/.zshrc"
alias edit-zsh="vscodium ~/.zshrc"
alias edit-pacman="vscodium /etc/pacman.conf"
alias unlock-pacman="sudo rm /var/lib/pacman/db.lck"
alias edit-grub="vscodium /etc/default/grub"
alias edit-fstab="vscodium /etc/fstab"
alias edit-mkinitcpio="vscodium /etc/mkinitcpio.conf"
alias update-mkinitcpio="sudo mkinitcpio -P"
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias update-pacman="sudo pacman -Syu"
alias update-aur="yay -Syu --aur"
alias update-brew="brew update"
alias update-nix="nix-env -u"
alias backup="sudo timeshift --create --comments 'Made in terminal!'"


