#!/bin/bash
# =====================================
# ====== Make Ubuntu Great Again ======
# =====================================
# Version : 1.0
# Author : GNU/Alex
# Description : Script for making Ubuntu
# Great Again.
# =====================================

# Check if script is executed with sudo 
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script with sudo."
  exit 1
fi

# Removing snaps
echo "Removing snaps..."
snap remove gtk-common-themes
snap remove core22
snap remove snapd-desktop-integration
snap remove snap-store
snap remove firmware-updater
snap remove bare
echo "Snaps removed !"



# Removing Snapd's Daemon and his files
echo "Removing snapd..."
systemctl stop snapd
systemctl disable snapd
apt autoremove --purge --assume-yes snapd snap-store
apt-mark hold snapd
rm -rf ~/snap
rm -rf /snap
rm -rf /var/snap
rm -rf /var/lib/snapd
echo "Snapd is uninstalled !"

# Prevent Snap From Reinstalling
bash -c 'cat > /etc/apt/preferences.d/nosnap.pref << EOF
Package: snapd
Pin: release a=*
Pin-Priority: -10
EOF'

# Updating repositories
apt update

# Installing and configure flatapaks
echo "Installing Flatpak..."
apt install flatpak -y
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
echo "Flatpak installed !"

# Installing gnome-software
echo "Installing Gnome-Software..."
apt install gnome-software gnome-software-common gnome-software-plugin-deb gnome-software-plugin-flatpak gnome-software-plugin-fwupd -y
echo "Gnome-Software installed !"


# ===========================================================
# == Installing Firefox & Thunderbird with mozilla's guide ==
# ===========================================================

# Creating /opt/ folder if don't exist :
mkdir -p /opt
cd /opt/

# Installing Firefox
# Getting archive on Mozilla's website.
echo "Downloading Firefox..."
wget -q --show-progress -O firefox.tar.xz https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=en-US
echo "Download complete."
# Decompressing archive.
tar -xzvf firefox.tar.xz
rm firefox.tar.xz
# Create a symlink to the Firefox executable: 
ln -s /opt/firefox/firefox /usr/local/bin/firefox
# Downloading a copy of the .desktop file from Mozilla :
wget https://raw.githubusercontent.com/mozilla/sumo-kb/main/install-firefox-linux/firefox.desktop -P /usr/local/share/applications/

# Installing Thunderbird
# Getting archive on Mozilla's website.
echo "Downloading Thunderbird..."
wget -q --show-progress -O thunderbird.tar.bz2 https://download.mozilla.org/?product=thunderbird-128.7.1esr-SSL&os=linux64&lang=en-US
echo "Download complete."
# Decompressing archive.
tar -xzvf thunderbird.tar.bz2
rm thunderbird.tar.bz2
# Create a symlink to the Firefox executable: 
ln -s sudo ln -s /opt/thunderbird/thunderbird /usr/local/bin/thunderbird
# Creating .desktop file for Thunderbird
bash -c 'cat > /usr/local/share/applications/thunderbird.desktop << EOF
[Desktop Entry]
Encoding=UTF-8
Name=Thunderbird Mail
Comment=Send and receive mail with Thunderbird
GenericName=Mail Client
Keywords=Email;E-mail;Newsgroup;Feed;RSS
Exec=thunderbird %u
Terminal=false
X-MultipleArgs=false
Type=Application
Icon=/opt/thunderbird/chrome/icons/default/default128.png
Categories=Application;Network;Email;
MimeType=x-scheme-handler/mailto;application/x-xpinstall;
StartupNotify=true
Actions=Compose;Contacts
StartupWMClass=thunderbird-esr

[Desktop Action Compose]
Name=Compose New Message
Name[fr]=Rédiger un nouveau courriel
Exec=thunderbird -compose

[Desktop Action Contacts]
Name=Contacts
Exec=thunderbird -addressbook
EOF'



echo "Ubuntu is now Great Again ! Please restart to affect the changes.. "
