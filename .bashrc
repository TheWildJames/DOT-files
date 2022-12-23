### EXPORT ###
export EDITOR='vscodium'
export VISUAL='nano'
export HISTCONTROL=ignoreboth:erasedups
export PAGER='most'

#Ibus settings if you need them
#type ibus-setup in terminal to change settings and start the daemon
#delete the hashtags of the next lines and restart
#export GTK_IM_MODULE=ibus
#export XMODIFIERS=@im=dbus
#export QT_IM_MODULE=ibus

PS1='[\u@\h \W]\$ '

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

#ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

###############
### ALIASES ###
###############

#########
# Edits #
#########
alias edit-p10k="p10k configure"
alias edit-lxdm="$EDITOR /etc/lxdm/lxdm.conf"
alias edit-lightdm="$EDITOR /etc/lightdm/lightdm.conf"
alias edit-pacman="$EDITOR /etc/pacman.conf"
alias edit-grub="$EDITOR /etc/default/grub"
alias edit-confgrub="$EDITOR /boot/grub/grub.cfg"
alias edit-mkinitcpio="$EDITOR /etc/mkinitcpio.conf"
alias edit-mirrorlist="$EDITOR /etc/pacman.d/mirrorlist"
alias edit-arcomirrorlist="$EDITOR /etc/pacman.d/arcolinux-mirrorlist"
alias edit-sddm="$EDITOR /etc/sddm.conf"
alias edit-sddmk="$EDITOR /etc/sddm.conf.d/kde_settings.conf"
alias edit-fstab="$EDITOR /etc/fstab"
alias edit-nsswitch="$EDITOR /etc/nsswitch.conf"
alias edit-samba="$EDITOR /etc/samba/smb.conf"
alias edit-gnupgconf="sudo $EDITOR /etc/pacman.d/gnupg/gpg.conf"
alias edit-hosts="sudo $EDITOR /etc/hosts"
alias edit-hostname="sudo $EDITOR /etc/hostname"
alias edit-bash="$EDITOR ~/.bashrc"
alias edit-zsh="$EDITOR ~/.zshrc"
alias edit-fish="$EDITOR ~/.config/fish/config.fish"
alias edit-neofetch="$EDITOR ~/.config/neofetch/config.conf"

###########
# Updates #
###########
#update betterlockscreen images
alias update-bls="betterlockscreen -u /usr/share/backgrounds/arcolinux/"
alias reload-zsh="source ~/.zshrc"
#add new fonts
alias reload-fc='sudo fc-cache -fv'
alias update-mkinitcpio="sudo mkinitcpio -P"
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias update-pacman="sudo pacman -Syu"
alias update-aur="yay -Syu --aur"
alias update-brew="brew update"
alias update-nix="nix-env -u"
alias update-paru="paru -Syu --noconfirm"
update-all() {
  echo 'All Updates Starting' | lolcat -S 0
  echo 'Pacman Update Started' | lolcat -S 0
  sudo pacman -Syu
  echo 'Pacman Update Complete' | lolcat -S 0
  echo 'AUR Update Started' | lolcat -S 0
  yay -Syu --aur
  echo 'AUR Update Complete' | lolcat -S 0
  echo 'Brew Update Started' | lolcat -S 0
  brew update
  brew upgrade
  echo 'Brew Update Complete' | lolcat -S 0 
  echo 'Nix Update Started' | lolcat -S 0
  nix-env -u
  echo 'Nix Update Complete' | lolcat -S 0 
  echo 'All Updates Finished!' | lolcat -S 0 
  echo 'Have a nice day!' | lolcat -S 0
}

#########
# Fixes #
#########
alias fix-perms="sudo chown -R $USER:$USER ~/.config ~/.local"
alias fix-keys="/usr/local/bin/arcolinux-fix-pacman-databases-and-keys"
#fix-sddm-config is no longer an alias but an application - part of ATT
#alias fix-sddm-config="/usr/local/bin/arcolinux-fix-sddm-config"
alias fix-pacman-conf="/usr/local/bin/arcolinux-fix-pacman-conf"
alias fix-pacman-keyserver="/usr/local/bin/arcolinux-fix-pacman-gpg-conf"
alias fix-qwerty="sudo localectl set-x11-keymap us"
alias fix-locale="sudo localectl set-locale LANG=en_US.UTF-8"
alias fix-pacman-unlock="sudo rm /var/lib/pacman/db.lck"
#grub issue 08/2022
alias fix-grub-efi="sudo grub-install --target=x86_64-efi --efi-directory=/boot/efi"
alias fix-keyserver="[ -d ~/.gnupg ] || mkdir ~/.gnupg ; cp /etc/pacman.d/gnupg/gpg.conf ~/.gnupg/ ; echo 'done'"
alias fix-gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"
alias fix-gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"
alias fix-docker="~/scripts/fixdocker.sh"

###########
# Removes #
###########
alias rm-pacmanlock="sudo rm /var/lib/pacman/db.lck"
#arcolinux logout unlock
alias rm-logoutlock="sudo rm /tmp/arcologout.lock"
alias rm-gitcache="rm -r ~/.cache/git"

########
# list #
########
alias ls='ls --color=auto'
alias la='ls -a'
alias ll='ls -alFh'
alias l='ls'
alias l.="ls -A | egrep '^\.'"

########
# grep #
########
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

########
# Bats #
########
#reading logs with bat
alias lcalamares="bat /var/log/Calamares.log"
alias lpacman="bat /var/log/pacman.log"
alias lxorg="bat /var/log/Xorg.0.log"
alias lxorgo="bat /var/log/Xorg.0.log.old"

############
# Utilitys #
############
alias which-x11="ls /usr/share/xsessions"
alias which-wayland="ls /usr/share/wayland-sessions"
alias which-vga="/usr/local/bin/arcolinux-which-vga"
alias which-audio="pactl info | grep 'Server Name'"
alias hw="hwinfo --short"
#check vulnerabilities microcode
alias check-microcode='grep . /sys/devices/system/cpu/vulnerabilities/*'
#enabling vmware services
alias start-vmware="sudo systemctl enable --now vmtoolsd.service"
#Recent Installed Packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
alias riplong="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -3000 | nl"
#iso and version used to install ArcoLinux
alias which-iso="cat /etc/dev-rel | awk -F '=' '/ISO/ {print $2}'"
alias which-isoo="cat /etc/dev-rel"
#Cleanup orphaned packages
alias cleanup-pacman='sudo pacman -Rns $(pacman -Qtdq)'
#clear
alias clean="clear; seq 1 $(tput cols) | sort -R | sparklines | lolcat"
alias big="expac -H M '%m\t%n' | sort -h | nl"
alias downgrada="sudo downgrade --ala-url https://ant.seedhost.eu/arcolinux/"
#systeminfo
alias probe="sudo -E hw-probe -all -upload"
alias sysfailed="systemctl list-units --failed"
#get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"
#search content with ripgrep
alias rg="rg --sort path"


###############
# Switch-To's #
###############
# Switch between Desktop Managers
alias switch-to-lightdm="sudo pacman -S lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings --noconfirm --needed ; sudo systemctl enable lightdm.service -f ; echo 'Lightm is active - reboot now'"
alias switch-to-sddm="sudo pacman -S sddm --noconfirm --needed ; sudo systemctl enable sddm.service -f ; echo 'Sddm is active - reboot now'"
alias switch-to-ly="sudo pacman -S ly --noconfirm --needed ; sudo systemctl enable ly.service -f ; echo 'Ly is active - reboot now'"
alias switch-to-gdm="sudo pacman -S gdm --noconfirm --needed ; sudo systemctl enable gdm.service -f ; echo 'Gdm is active - reboot now'"
alias switch-to-lxdm="sudo pacman -S lxdm --noconfirm --needed ; sudo systemctl enable lxdm.service -f ; echo 'Lxdm is active - reboot now'"
# Switch between Shells
alias switch-to-bash="sudo chsh $USER -s /bin/bash && echo 'Now log out.'"
alias switch-to-zsh="sudo chsh $USER -s /bin/zsh && echo 'Now log out.'"
alias switch-to-fish="sudo chsh $USER -s /bin/fish && echo 'Now log out.'"

###########
# Mirrors #
###########
#get fastest mirrors in your neighborhood
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirror-delay="sudo reflector --latest 30 --number 10 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirror-score="sudo reflector --latest 30 --number 10 --sort score --save /etc/pacman.d/mirrorlist"
alias mirror-age="sudo reflector --latest 30 --number 10 --sort age --save /etc/pacman.d/mirrorlist"
#our experimental - best option for the moment
alias mirror-x="sudo reflector --age 6 --latest 20  --fastest 20 --threads 5 --sort rate --protocol https --save /etc/pacman.d/mirrorlist"
alias mirror-xx="sudo reflector --age 6 --latest 20  --fastest 20 --threads 20 --sort rate --protocol https --save /etc/pacman.d/mirrorlist"
alias mirror-rate='rate-mirrors --allow-root --disable-comments arch | sudo tee /etc/pacman.d/mirrorlist'
alias mirror-rate-https='rate-mirrors --allow-root --disable-comments --protocol https arch  | sudo tee /etc/pacman.d/mirrorlist'

######################
# Youtube Downloader #
######################
alias ytd-aac="yt-dlp --extract-audio --audio-format aac "
alias ytd-best-audio="yt-dlp --extract-audio --audio-format best "
alias ytd-flac="yt-dlp --extract-audio --audio-format flac "
alias ytd-mp3="yt-dlp --extract-audio --audio-format mp3 "
alias ytd-best-video="yt-dlp -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4 "

#######
# GPG #
#######
#verify signature for isos
alias gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"
#receive the key of a developer
alias gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"

###############
# Quick Kills #
###############
alias qk-conkey='killall conky'
alias qk-polybar='killall polybar'
alias qk-picom='killall picom'

###########
# snapper #
###########
alias snapchome="sudo snapper -c home create-config /home"
alias snapli="sudo snapper list"
alias snapcr="sudo snapper -c root create"
alias snapch="sudo snapper -c home create"

##########################
# Arcolinux Applications #
##########################
#att is a symbolic link now
#alias att="archlinux-tweak-tool"
alias adt="arcolinux-desktop-trasher"
alias abl="arcolinux-betterlockscreen"
alias agm="arcolinux-get-mirrors"
alias amr="arcolinux-mirrorlist-rank-info"
alias aom="arcolinux-osbeck-as-mirror"
alias ars="arcolinux-reflector-simple"
alias atm="arcolinux-tellme"
alias avs="arcolinux-vbox-share"
alias awa="arcolinux-welcome-app"

###########
# Adblock #
###########
alias enable-adblock="hblock"
alias disable-adblock="hblock -S none -D none"

##########################################################################################################


#readable output
alias df='df -h'

#free
alias free="free -mt"

#continue download
alias wget="wget -c"

#userlist
alias userlist="cut -d: -f1 /etc/passwd | sort"

#merge new settings
alias merge="xrdb -merge ~/.Xresources"

#ps
alias psa="ps auxf"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"

#shutdown or reboot
alias ssn="sudo shutdown now"
alias sr="sudo reboot"

# # ex = EXtractor for all kinds of archives
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   tar xf $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

#create a file called .zshrc-personal and put all your personal aliases
#in there. They will not be overwritten by skel.

[[ -f ~/.bashrc-personal ]] && . ~/.bashrc-personal

# reporting tools - install when not installed
#neofetch
#screenfetch
#alsi
#paleofetch
#fetch
#hfetch
#sfetch
#ufetch
#ufetch-arco
#pfetch
#sysinfo
#sysinfo-retro
#cpufetch
#colorscript random
