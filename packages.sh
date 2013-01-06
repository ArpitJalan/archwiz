#!/bin/bash
#
# LAST_UPDATE="4 Jan 2013 16:33"
#
# Software Packages:
# If I declare them here, I can use them in menus
# I could make this multi-distro by putting in if $DISTRO == Arch statements
INSTALL_MATE="mate mate-session-manager mate-extras mate-screensaver gnome-icon-theme trayer gvfs-smb gvfs-afc"
# @FIX something in this package has a dependancy on wicd
AV_STUDIO="audacity ardour avidemux-cli avidemux-qt blender brasero cdrkit cheese devede dvd+rw-tools dvdauthor enca ffmpeg gaupol gimp gcolor2 gpicview gtk2 gthumb gtkmm handbrake handbrake-cli inkscape kdenlive kino libdvdread libxml++ mcomix mypaint mjpegtools mjpegtools mpgtx mencoder openshot python2-numpy python-lxml uniconvertor shotwell scribus simple-scan scons twolame"
AV_STUDIO_KDE="kde-meta-kdegraphics"
AV_STUDIO_GTK="avidemux-gtk"
AV_STUDIO_KDEGRAPHICS="kdegraphics-gwenview kdegraphics-kamera kdegraphics-kcolorchooser kdegraphics-kgamma kdegraphics-kolourpaint kdegraphics-kruler kdegraphics-ksaneplugin 	kdegraphics-ksnapshot kdegraphics-mobipocket kdegraphics-okular kdegraphics-strigi-analyzer kdegraphics-svgpart kdegraphics-thumbnailers"
AV_STUDIO_AUR="gimp-paint-studio gimphelp-scriptfu gimp-resynth gimpfx-foundry gimp-plugin-pandora gimp-plugin-saveforweb xnviewmp"
INSTALL_GIT_TOR="openbsd-netcat vidalia privoxy git tor"
INSTALL_SYSTEMD="systemd systemd-sysvcompat accountsservice python2-gobject"
AUR_INSTALL_SYSTEMD="user-session-units"
INSTALL_BASH_TOOLS="bc rsync mlocate bash-completion ntp pkgstats"
INSTALL_AVAHI="avahi nss-mdns"
INSTALL_ACPI="acpi acpid"
INSTALL_ALSA="alsa-utils alsa-plugins"
INSTALL_NTFS="ntfs-3g ntfsprogs dosfstools exfat-utils fuse fuse-exfat"
INSTALL_SSH="openssh"
INSTALL_NFS="nfs-utils"
INSTALL_SAMBA="samba smbnetfs"
INSTALL_PRELOAD="preload"
INSTALL_LAPTOP_MODE_TOOLS="laptop-mode-tools xf86-input-synaptics"
INSTALL_XORG='xorg-server xorg-xinit xorg-server-utils xorg-xkill xorg-setxkbmap xf86-input-mouse xf86-input-keyboard mesa mesa-demos gamin xorg-twm xorg-xclock xterm xorg-fonts-100dpi xorg-fonts-75dpi ttf-dejavu ttf-freefont'
INSTALL_SCIENCE_EDUCATION="stellarium celestia"
INSTALL_UTILITES="faac gpac espeak faac antiword unrtf odt2txt txt2tags nrg2iso bchunk gnome-disk-utility"
INSTALL_KDE="kde-meta kde-l10n-$LANGUAGE_KDE kipi-plugins kdeadmin-system-config-printer-kde xdg-user-dirs kdelibs automoc4 qt"
INSTALL_PHONON_VLC="phonon-vlc"
INSTALL_PHONON="phonon-gstreamer ttf-dejavu"
INSTALL_APPER="apper"
INSTALL_CHOQOK="choqok"
INSTALL_DIGIKAM="digikam"
INSTALL_K3B="k3b cdrdao dvd+rw-tools"
INSTALL_YAKUAKE="yakuake"
INSTALL_GNOME="gnome gucharmap gksu nautilus-open-terminal gnome-search-tool gedit-plugins gnome-tweak-tool gvfs-smb gvfs-afc zeitgeist deja-dup pulseaudio system-config-printer-gnome ttf-bitstream-vera ttf-dejavu ttf-freefont empathy-theme-candybars empathy-theme-adium-matte gnome-defaults-list"
INSTALL_GNOME_PACKAGEKIT="gnome-packagekit gnome-settings-daemon-updates"
INSTALL_AWESOME="awesome lxappearance leafpad epdfview nitrogen ttf-bitstream-vera ttf-dejavu ttf-freefont" # consolekit
INSTALL_XCOMPMGR="xcompmgr transset-df"
INSTALL_VIEWNIOR="viewnior"
INSTALL_PCMANFM="pcmanfm"
INSTALL_RXVT_UNICODE="rxvt-unicode"
INSTALL_SCROT="scrot"
INSTALL_THUNAR="thunar tumbler"
INSTALL_TINT2="tint2"
INSTALL_VOLWHEEL="volwheel"
INSTALL_CINNAMON_PACKAGE="gedit-plugins gksu nautilus-open-terminal gnome-tweak-tool xdg-user-dirs-gtk gvfs-smb gvfs-afc pulseaudio deja-dup system-config-printer-gnome ttf-bitstream-vera ttf-dejavu ttf-freefont accountsservice caribou empathy dbus-glib folks gjs gnome-bluetooth gnome-control-center gnome-desktop gnome-menus gnome-menus2 gnome-panel gnome-session gnome-settings-daemon gnome-themes-standard libcroco libgnomekbd libpulse notification-daemon python2 python2-gconf python2-imaging python2-lxml telepathy-logger python2-distutils-extra"
INSTALL_GNOME_PACKAGEKIT="gnome-packagekit gnome-settings-daemon-updates"
INSTALL_ZEITGEIST="zeitgeist libzeitgeist python2-rdflib zeitgeist-datahub"
INSTALL_E17="e-svn e17-extra-svn xdg-user-dirs gvfs-smb gvfs-afc leafpad epdfview lxappearance ttf-bitstream-vera ttf-dejavu ttf-freefont" # consolekit
INSTALL_VIEWNIOR="viewnior"
INSTALL_PCMANFM="pcmanfm"
INSTALL_RXVT_UNICODE="rxvt-unicode"
INSTALL_SCROT="scrot"
INSTALL_THUNAR="thunar tumbler"
INSTALL_TINT2="tint2"
INSTALL_VOLWHEEL="volwheel"
INSTALL_XFCE="xfce4 xfce4-goodies gvfs-smb gvfs-afc polkit-gnome xdg-user-dirs ttf-bitstream-vera ttf-dejavu ttf-freefont gamin"
INSTALL_UNITY="unity gnome-terminal baobab eog eog-plugins evince file-roller gcalctool gedit gedit-plugins gnome-disk-utility gnome-font-viewer gnome-screenshot totem gksu nautilus-open-terminal gnome-search-tool gvfs-smb gvfs-afc zeitgeist deja-dup pulseaudio ttf-bitstream-vera ttf-dejavu ttf-freefont"
INSTALL_GDM="gdm gnome-themes-standard"
INSTALL_GDM_CONTROL="gdm gnome-control-center gconf-editor"
INSTALL_KDM="kdebase-workspace archlinux-themes-kdm"
INSTALL_LIGHTDM="dbus-glib libxklavier"
INSTALL_LXDM="lxdm"
INSTALL_SLIM="slim slim-themes archlinux-themes-slim"
INSTALL_QINGY="qingy qingy-theme-arch"
INSTALL_XDM="xorg-xdm qiv"
INSTALL_YAPAN="kdebase-konsole phonon qt"
INSTALL_AMAROK="amarok"
INSTALL_AUDACIOUS="audacious audacious-plugins"
INSTALL_BANSHEE="banshee"
INSTALL_CLEMENTINE="clementine"
INSTALL_DEADBEEF="deadbeef"
INSTALL_RHYTHMBOX="rhythmbox"
INSTALL_SOUNDCONVERTER="soundconverter"
INSTALL_SOUNDKONVERTER="soundkonverter"
INSTALL_AUDACITY="audacity"
INSTALL_AUDIO_CODECS="gstreamer0.10-base gstreamer0.10-good-plugins mpg123 flac faac faad2 lame libdca wavpack"
# Failed: libreoffice-{${LANGUAGE_LO},common,base,calc,draw,impress,math,writer,gnome,kde4,sdk,sdk-doc}
INSTALL_LIBRE_OFFICE="libreoffice-$LANGUAGE_LO libreoffice-common libreoffice-base libreoffice-calc libreoffice-draw libreoffice-impress libreoffice-math libreoffice-writer libreoffice-extension-presenter-screen libreoffice-extension-pdfimport hunspell hunspell-$LANGUAGE_HS hyphen hyphen-$LANGUAGE_HS libmythes mythes-$LANGUAGE_HS aspell-$LANGUAGE_AS ttf-dejavu artwiz-fonts"
INSTALL_LIBRE_OFFICE_GNOME="libreoffice-gnome"
INSTALL_LIBRE_OFFICE_KDE="libreoffice-kde4"
INSTALL_GNUMERIC="gnumeric abiword abiword-plugins"
INSTALL_CALLIGRA="calligra"
INSTALL_LATEX="texlive-most"
INSTALL_CALIBRE="calibre"
INSTALL_GCSTAR="gcstar"
INSTALL_HOMEBANK="homebank"
INSTALL_IMPRESSIVE="impressive"
INSTALL_OCRFEEDER="ocrfeeder tesseract gocr"
INSTALL_ZATHURA="zathura"
INSTALL_GPARTED="gparted"
INSTALL_GRSYNC="grsync"
INSTALL_HTOP="htop"
INSTALL_VIRTUALBOX="virtualbox virtualbox-host-modules virtualbox-guest-iso"
INSTALL_WEBMIN="webmin perl-net-ssleay"
INSTALL_WINE_ALSA="lib32-alsa-lib lib32-openal lib32-mpg123 lib32-giflib lib32-libpng q4wine"
INSTALL_WINE_ATI="lib32-ati-dri"
INSTALL_WINE_INTEL="lib32-intel-dri"
INSTALL_WINE_NOUVEAU="lib32-nouveau-dri"
INSTALL_WINE_NVIDIA="lib32-nvidia-utils"
INSTALL_WINE="wine wine_gecko winetricks"
INSTALL_GTK_ICONS="gtk-update-icon-cache"
INSTALL_ASTROMENANCE="astromenace"
INSTALL_ABUSE="abuse"
INSTALL_BTANKS="btanks"
INSTALL_BOMBERCLONE="bomberclone"
INSTALL_FROGATTO="frogatto"
INSTALL_NEVERBALL="neverball"
INSTALL_SMC="smc"
INSTALL_XMOTO="xmoto"
INSTALL_ZSNES="zsnes"
INSTALL_ALIENARENA="alienarena"
INSTALL_WARSOW="warsow"
INSTALL_XONOTIC="xonotic"
INSTALL_FROZEN_BUBBLE="frozen-bubble"
INSTALL_FREEDROUDRPG="freedroidrpg"
INSTALL_SUPTERTUXKART="supertuxkart"
INSTALL_SPEED_DREAMS="speed-dreams"
INSTALL_SIMUTRANS="simutrans"
INSTALL_OPENTTD="openttd"
INSTALL_0AD="0ad"
INSTALL_HEDGEWARS="hedgewars"
INSTALL_MEGAGLEST="megaglest"
INSTALL_UNKNOW_HORIZONS="unknow-horizons"
INSTALL_WARZONE2100="warzone2100"
INSTALL_WESNOTH="wesnoth"
INSTALL_GNOME_GAMES="gnome-games"
INSTALL_KDE_GAMES="kdegames"
INSTALL_MISC_GAMES="torcs pingus scorched3d aisleriot"
INSTALL_WEB_SERVER_1="apache mysql php php-apache php-mcrypt php-gd"
INSTALL_WEB_SERVER_2="apache postgresql php php-apache php-pgsql php-gd"
INSTALL_TTF_DEJAVU="ttf-dejavu"
INSTALL_TTF_LIBERATION="ttf-liberation"
INSTALL_NETWORKMANAGER_KDE="networkmanager kdeplasma-applets-networkmanagement"
INSTALL_NETWORKMANAGER_APPLET="network-manager-applet"
INSTALL_NETWORKMANAGER="networkmanager network-manager-applet"
INSTALL_NETWORKMANAGER_CORE="networkmanager-dispatcher-ntpd"
INSTALL_WICD_GTK="wicd wicd-gtk"
INSTALL_USB_3G_MODEM="usbutils usb_modeswitch modemmanager"
INSTALL_DOCKY="docky"
INSTALL_GUAKE="guake"
INSTALL_ZEITGEIST="zeitgeist"
INSTALL_TERMINATOR="terminator"
INSTALL_ZIM="zim"
INSTALL_ECLIPSE="eclipse"
INSTALL_ECLIPSE_CDT="eclipse-cdt"
INSTALL_EMACS="emacs"
INSTALL_VIM="gvim ctags ack ttf-liberation"
INSTALL_GEANY="geany"
INSTALL_INTELLIJ="intellij-idea-community-edition"
INSTALL_KDEVELOP="kdevelop"
INSTALL_NETBEANS="netbeans"
INSTALL_MELD="meld"
INSTALL_ASTYLE="astyle"
INSTALL_PUTTY="putty"
INSTALL_FIREFOX="firefox firefox-i18n-$LANGUAGE_FF flashplugin"
INSTALL_THUNDERBIRD="thunderbird thunderbird-i18n-$LANGUAGE_FF"
INSTALL_CHROMIUM="chromium flashplugin"
INSTALL_OPERA="opera flashplugin"
INSTALL_REKONQ="rekonq"
INSTALL_MIDORI="midori"
INSTALL_DELUGE="deluge"
INSTALL_SPARKLESHARE="sparkleshare"
INSTALL_TRANSMISSION_GTK="transmission-gtk"
INSTALL_TRANSMISSION_QT="transmission-qt"
INSTALL_EVOLUTION="evolution"
INSTALL_LIFEREA="liferea"
INSTALL_EMESENE="emesene"
INSTALL_PIDGIN="pidgin"
INSTALL_SKYPE="skype skype-call-recorder"
INSTALL_IRSSI="irssi" 
INSTALL_XCHAT="xchat"
INSTALL_QUASSEL="quassel"
INSTALL_GOOGLE_EARTH="desktop-file-utils fontconfig hicolor-icon-theme libsm libxrender mesa lib32-mesa lib32-mesa-demos shared-mime-info"
INSTALL_REMMINA="remmina"
INSTALL_BLENDER="blender"
INSTALL_HANDBRAKE="handbrake handbrake-cli"
INSTALL_BRASERO="brasero dvd+rw-tools dvdauthor"
INSTALL_GIMP="gimp gcolor2"
INSTALL_GTHUMB="gthumb"
INSTALL_INKSCAPE="inkscape uniconvertor python2-numpy python-lxml"
INSTALL_MCOMIX="mcomix"
INSTALL_MYPAINT="mypaint"
INSTALL_SCRIBUS="scribus"
INSTALL_SHOTWELL="shotwell"
INSTALL_SIMPLE_SCAN="simple-scan"
INSTALL_GNOME_MPLAYER="gnome-mplayer"
INSTALL_PAROLE="parole"
INSTALL_MIRO="miro"
INSTALL_SMPLAYER="smplayer smplayer-themes"
INSTALL_VLC="vlc"
INSTALL_VLC_KDE="phonon-vlc"
INSTALL_XBNC="xbmc"
INSTALL_TRAMSMAGEDDON="transmageddon"
INSTALL_KDENLIVE="kdenlive"
INSTALL_OPENSHOT="openshot"
INSTALL_PITIVI="pitivi"
INSTALL_VIDEO_CODECS="libquicktime libdvdread libdvdnav libdvdcss cdrdao a52dec xvidcore x264 libxv libvorbis libtheora libmpeg2 libmad libdv jasper gstreamer0.10-plugins"
INSTALL_NVIDIA="nvidia nvidia-utils lib32-nvidia-utils abs mesa mesa-demos pangox-compat gtk"
INSTALL_NOUVEAU="libgl xf86-video-nouveau nouveau-dri"
INSTALL_INTEL="libgl xf86-video-intel"
INSTALL_ATI="libgl xf86-video-ati"
INSTALL_VESA="xf86-video-vesa"
INSTALL_VIRTUALBOX="virtualbox-guest-utils"
INSTALL_CUPS_PACK="cups cups-filters cups-pdf ghostscript gsfonts gutenprint foomatic-db foomatic-db-engine foomatic-db-nonfree foomatic-filters hplip splix"
INSTALL_ALSA_FIRMWARE="alsa-firmware"
INSTALL_IPW2100_FW="ipw2100-fw"
INSTALL_IPW2200_FW="ipw2200-fw"
INSTALL_ZD1211_FIRMWARE="zd1211-firmware"
INSTALL_BLUEZ_FIREWARE="bluez-firmware"
INSTALL_LIBFFADO="libffado"
INSTALL_LIBRAW1394="libraw1394"
INSTALL_SANE_GT68XX_FIRMWARE="sane-gt68xx-firmware"
INSTALL_WT="wt boost boost-build sqlite libharu graphicsmagick mercurial"
INSTALL_QT="qt qtcreator qt-doc"
INSTALL_BLUEFISH="bluefish"
INSTALL_XFBURN="xfburn"
INSTALL_SCROT="scrot"
INSTALL_THUNAR="thunar tumbler"
INSTALL_LXDE="lxde obconf pm-utils upower polkit-gnome xdg-user-dirs gvfs-smb gvfs-afc leafpad epdfview ttf-bitstream-vera ttf-dejavu ttf-freefont" # consolekit
INSTALL_VIEWNIOR="viewnior"
INSTALL_OPENBOX="openbox obconf obmenu menumaker lxappearance xdg-user-dirs leafpad epdfview nitrogen gvfs-smb gvfs-afc ttf-bitstream-vera ttf-dejavu ttf-freefont" # consolekit
INSTALL_RXVT_UNICODE="rxvt-unicode"
INSTALL_PCMANFM="pcmanfm"
INSTALL_GMRUN="gmrun"
INSTALL_VIEWNIOR="viewnior"
INSTALL_XCOMPMGR="xcompmgr transset-df"
# *****************************************************************************
# AUR PACKAGES
AUR_INSTALL_ARCHIVE_TOOLS="rar"
AUR_INSTALL_SSH="rssh"
AUR_INSTALL_ARISTA_TRANSCODER="arista-transcoder"
AUR_INSTALL_ZRAM="zramswap"
AUR_INSTALL_KDE="kde-gtk-config oxygen-gtk2 oxygen-gtk3 qtcurve-gtk2 qtcurve-kde4 bespin-svn"
AUR_INSTALL_BANGARANG="bangarang"
AUR_INSTALL_ROSA_ICONS="rosa-icons"
AUR_INSTALL_PLASMA_THEMES="caledonia-bundle plasma-theme-rosa plasma-theme-produkt ronak-plasmatheme"
AUR_INSTALL_YAKUAKE="yakuake-skin-plasma-oxygen-panel"
AUR_INSTALL_GNOME_CUSTOM_ACT_JOURNAL="libzeitgeist python2-rdflib zeitgeist-datahub gnome-activity-journal"
AUR_INSTALL_GNOME_CUSTOM_ACT_LOG_MANAGER_="activity-log-manager"
AUR_INSTALL_GNOME_CUSTOM_GLOOBUS="gloobus-sushi-bzr"
AUR_INSTALL_GSHELL_DISPER="disper"
AUR_INSTALL_GSHELL_GPASTE="gpaste"
AUR_INSTALL_GSHELL_MEDIAPLAYER="gnome-shell-extension-mediaplayer-git"
AUR_INSTALL_GSHELL_NOA11Y="gnome-shell-extension-noa11y-git"
AUR_INSTALL_GSHELL_POMODORO="libkeybinder3 gnome-shell-extension-pomodoro-git"
AUR_INSTALL_GSHELL_SYSTEM_MONITOR="gnome-shell-system-monitor-applet-git"
AUR_INSTALL_USER_THEME="gnome-shell-extension-user-theme-git"
AUR_INSTALL_GSHELL_WEATHER="gnome-shell-extension-weather-git"
AUR_INSTALL_GSHELL_GTILE="gnome-shell-extension-gtile-git"
AUR_INSTALL_GSHELL_THEMES_DEFAULT="gnome-shell-theme-default-mod"
AUR_INSTALL_GSHELL_THEMES_DARK_SHINE="gnome-shell-theme-dark-shine"
AUR_INSTALL_GSHELL_THEMES_ELEGANCE="gnome-shell-theme-elegance"
AUR_INSTALL_GSHELL_THEMES_EOS="gnome-shell-theme-eos"
AUR_INSTALL_GSHELL_THEMES_FRIEZE="gnome-shell-theme-frieze"
AUR_INSTALL_GSHELL_THEMES_GOOGLE="gnome-shell-theme-google+"
AUR_INSTALL_AWESOME="gnome-defaults-list"
AUR_INSTALL_CINNAMON_PACKAGE="cinnamon empathy-theme-ubuntu-adium-bzr gnome-defaults-list gnome-extra-meta muffin-wm"
AUR_INSTALL_CINNAMON_APPLETS="cinnamon-applets"
AUR_INSTALL_CINNAMON_THEMES="cinnamon-themes"
AUR_INSTALL_GNOME_ACTIVITY_JOURNAL="gnome-activity-journal"
AUR_INSTALL_GLOOBUS="gloobus-sushi-bzr"
AUR_INSTALL_E17="file-roller2-nn gnome-defaults-list"
AUR_INSTALL_E17_ICONS="e17-icons"
AUR_INSTALL_E17_THEMES="e17-themes"
AUR_INSTALL_LXDE="file-roller2-nn gnome-defaults-list"
AUR_INSTALL_OPENBOX="file-roller2-nn gnome-defaults-list"
AUR_INSTALL_XFCE="file-roller2-nn gnome-defaults-list"
AUR_INSTALL_XFCE_CUSTOM="xfce4-volumed"
#AUR_INSTALL_GDM="gdm3setup"
AUR_INSTALL_ELSA="elsa-svn-arch"
AUR_INSTALL_LIGHTDM_KDE="lightdm-kde"
AUR_INSTALL_LIGHTDM="lightdm lightdm-gtk-greeter lightdm-webkit-greeter lightdm-crowd-greeter"
AUR_INSTALL_YAPAN="yapan"
AUR_INSTALL_EP_AUDIENCE="audience-bzr"
AUR_INSTALL_EP_CONTRACTOR="contractor-bzr"
AUR_INSTALL_EP_EIDETE="eidete-bzr"
AUR_INSTALL_EP_DEXTER="dexter-contacts-bzr"
AUR_INSTALL_EP_FEEDLER="feedler-bzr"
AUR_INSTALL_EP_FILES="files-bzr tumbler"
AUR_INSTALL_EP_FOOTNOTE="footnote-bzr"
AUR_INSTALL_EP_GALA="gala-bzr"
AUR_INSTALL_EP_GEARY="geary-git"
AUR_INSTALL_EP_LINGO="lingo-dictionary-bzr"
AUR_INSTALL_EP_MAYA="maya-bzr"
AUR_INSTALL_EP_MIDORI="midori"
AUR_INSTALL_EP_NOISE="noise-bzr"
AUR_INSTALL_EP_SCRATCH="scratch-bzr"
AUR_INSTALL_EP_PLANK="plank-bzr"
AUR_INSTALL_EP_PANTHEON="pantheon-terminal-bzr"
AUR_INSTALL_EP_SLINGSHOT="slingshot-bzr"
AUR_INSTALL_EP_SWITCHBOARD="switchboard-bzr"
AUR_INSTALL_EP_WINGPANEL="wingpanel-bzr"
AUR_INSTALL_EP_ICONS="elementary-icons-bzr"
AUR_INSTALL_EP_EGTK="egtk-bzr"
AUR_INSTALL_PUDDLETAG="puddletag"
AUR_INSTALL_OCENAUDIO="ocenaudio"
AUR_INSTALL_EXAILE="exaile"
AUR_INSTALL_MUSIQUE="musique"
AUR_INSTALL_NUVOLAPLAYER="nuvolaplayer"
AUR_INSTALL_RADIOTRAY="radiotray"
AUR_INSTALL_SPOTIFY="spotify"
AUR_INSTALL_TOMAHAWK="tomahawk"
AUR_INSTALL_TIMIDITY="timidity++ fluidr3"
AUR_INSTALL_HUNSPELL="hunspell-$LANGUAGE_HS"
AUR_INSTALL_ASPELL_LANGUAGE="aspell-$LANGUAGE_AS"
AUR_INSTALL_="texmaker"
AUR_INSTALL_ABNTEX="abntex"
AUR_INSTALL_NITROTASKS="nitrotasks"
AUR_INSTALL_ASPELL_LANGUAGE="aspell-$LANGUAGE_AS"
AUR_INSTALL_XMIND="xmind"
AUR_INSTALL_VIRTUALBOX_EXT_ORACLE="virtualbox-ext-oracle"
AUR_INSTALL_GTK_THEMES_ADWAITA="gtk-theme-adwaita-cupertino"
AUR_INSTALL_GTK_THEMES_BOOMERANG="gtk-theme-boomerang"
AUR_INSTALL_GTK_THEMES_BLACKBIRD="xfce-theme-blackbird"
AUR_INSTALL_GTK_THEMES_BLUEBIRD="xfce-theme-bluebird"
AUR_INSTALL_GTK_THEMES_EGTK="egtk-bzr"
AUR_INSTALL_GTK_THEMES_XFCE_GREYBIRD="xfce-theme-greybird"
AUR_INSTALL_GTK_THEMES_LIGHT_THEMES="light-themes"
AUR_INSTALL_GTK_THEMES_ORION="orion-gtk-theme"
AUR_INSTALL_GTK_THEMES_ZUKINI="zukini-theme"
AUR_INSTALL_GTK_THEMES_ZUKITWO="zukitwo-themes"
AUR_INSTALL_GNOME_ICONS_AWOKEN="awoken-icons"
AUR_INSTALL_GNOME_ICONS_FAENZA="faenza-icon-theme"
AUR_INSTALL_GNOME_ICONS_FEANZA_CUPERTINO="faenza-cupertino-icon-theme"
AUR_INSTALL_GNOME_ICONS_FAIENCE="faience-icon-theme"
AUR_INSTALL_GNOME_ICONS_ELEMENTARY="elementary-icons-bzr"
AUR_INSTALL_GNOME_ICONS_ELEMENTARY_XFCE="elementary-xfce-icons"
AUR_INSTALL_GNOME_ICONS_NITRUX="nitrux-icon-theme"
AUR_INSTALL_COUNTER_STRIKE_2D="counter-strike-2d"
AUR_INSTALL_DEAD_CYBORG_EP_1="dead-cyborg-episode1"
AUR_INSTALL_MARS_SHOOTER="mars-shooter"
AUR_INSTALL_NIKKI="nikki"
AUR_INSTALL_OPENTYRIAN="opentyrian-hg"
AUR_INSTALL_SRB2="srb2"
AUR_INSTALL_STEELSTORM="steelstorm"
AUR_INSTALL_YOFRANKIE="yofrankie"
AUR_INSTALL_FUNGULOIDS="funguloids"
AUR_INSTALL_GOONIES="goonies"
AUR_INSTALL_MARI0="mari0"
AUR_INSTALL_OPENSONIC="opensonic"
AUR_INSTALL_ROBOMBS_BIN="robombs_bin"
AUR_INSTALL_ADOM="adom"
AUR_INSTALL_TOME4="tome4"
AUR_INSTALL_LOST_LABYRINTH="lostlabyrinth"
AUR_INSTALL_SCOURGE="scourge"
AUR_INSTALL_STONE_SOUP="stone-soup"
AUR_INSTALL_BSMES="bsnes"
AUR_INSTALL_DESMUME="desmume-svn"
AUR_INSTALL_DOLPHIN="dolphin-emu"
AUR_INSTALL_EPSXE="epsxe"
AUR_INSTALL_PROJECT_64="project64"
AUR_INSTALL_VBA="vba-m-gtk-svn"
AUR_INSTALL_WXMUPEN64PLUS="wxmupen64plus"
AUR_INSTALL_ENEMY_TERRITORY="enemy-territory"
AUR_INSTALL_WORLD_OF_PADMAN="worldofpadman"
AUR_INSTALL_HON="hon"
AUR_INSTALL_MANAPLUS="manaplus"
AUR_INSTALL_RUNESCAPE="unix-runescape-client"
AUR_INSTALL_SAVAGE_2="savage2"
AUR_INSTALL_SPIRAL_KNIGHTS="spiral-knights"
AUR_INSTALL_WAKFU="wakfu"
AUR_INSTALL_NUMPTYPHYSICS="numptyphysics-svn"
AUR_INSTALL_ARDENTRYST="ardentryst"
AUR_INSTALL_FLARE_RPG="flare-rpg"
AUR_INSTALL_MANIADRIVE="maniadrive"
AUR_INSTALL_DEATH_RALLY="death-rally"
AUR_INSTALL_STUNTRALLY="stuntrally"
AUR_INSTALL_CORSIX_TH="corsix-th"
AUR_INSTALL_COMMANDER_ZOD="commander-zod"
AUR_INSTALL_ADMINER="adminer"
AUR_INSTALL_GOOGLE_WEBFONTS="ttf-google-webfonts"
AUR_INSTALL_FUN_FONTS="ttf-funfonts"
AUR_INSTALL_KOCHI_FONTS="ttf-kochi-substitute"
AUR_INSTALL_MS_FONTS="ttf-ms-fonts"
AUR_INSTALL_VISTA_FONTS="ttf-vista-fonts"
AUR_INSTALL_WQY_FONTS="wqy-microhei"
AUR_INSTALL_WICD_KDE="wicd wicd-kde"
AUR_INSTALL_="cairo-dock-bzr cairo-dock-plugins-bzr"
AUR_INSTALL_="conky-lua conky-colors"
AUR_INSTALL_="deepin-scrot-git"
AUR_INSTALL_="dockbarx dockbarx-shinybar-theme"
AUR_INSTALL_="speedcrunch"
AUR_INSTALL_="galculator"
AUR_INSTALL_GNOME_PIE="gnome-pie"
AUR_INSTALL_KUPFER="kupfer"
AUR_INSTALL_PYRENAMER="pyrenamer"
AUR_INSTALL_SHUTTER="shutter"
AUR_INSTALL_ZEITGEIST="libzeitgeist zeitgeist-datahub synapse"
AUR_INSTALL_TERMINATOR="python-keybinder"
AUR_INSTALL_REVELATION="revelation"
AUR_INSTALL_MYSQL_WORKBENCH="mysql mysql-workbench"
AUR_INSTALL_APTANA_STUDIO="aptana-studio"
AUR_INSTALL_DISCOUNT="discount"
AUR_INSTALL_JDK="jdk"
AUR_INSTALL_SUBLIME="sublime-text"
AUR_INSTALL_DEBUGGER_TOOLS="valgrind gdb splint tidyhtml python2-pyflakes jslint"
AUR_INSTALL_RABBITVCS="rabbitvcs"
AUR_INSTALL_RABBITVCS_NAUTILUS="rabbitvcs-nautilus"
AUR_INSTALL_="rabbitvcs-thunar"
AUR_INSTALL_RABBITVCS_CLI="rabbitvcs-cli"
AUR_INSTALL_ECLIPSE_ANDROID="eclipse-android android-apktool android-sdk android-sdk-platform-tools android-udev"
AUR_INSTALL_ECLIPSE_WTP="eclipse-wtp-wst"
AUR_INSTALL_ECLIPSE_PDT="eclipse-pdt"
AUR_INSTALL_ECLIPSE_PYDEV="eclipse-pydev"
AUR_INSTALL_ECLIPSE_APTANA="eclipse-aptana"
AUR_INSTALL_ECLIPSE_VRAPPER="eclipse-vrapper"
AUR_INSTALL_ECLIPSE_EGIT="eclipse-egit"
AUR_INSTALL_GOOGLE_CHROME="google-chrome openssl098 flashplugin"
AUR_INSTALL_DROPBOX="dropbox"
AUR_INSTALL_DROPBOX_NAUTILUS="nautilus-dropbox dropbox-tango-emblems"
AUR_INSTALL_DROPBOX_THUNAR="thunar-dropbox"
AUR_INSTALL_DROPBOX_KFILEBOX="kfilebox"
AUR_INSTALL_DROPBOX_CLI="dropbox-cli"
AUR_INSTALL_INSYNC="insync"
AUR_INSTALL_JDOWNLOADER="jdownloader"
AUR_INSTALL_NITROSHARE="nitroshare"
AUR_INSTALL_STEADYFLOW="steadyflow-bzr"
AUR_INSTALL_LIGHTREAD="lightread"
AUR_INSTALL_GOOGLE_TALKPLUGIN="google-talkplugin"
AUR_INSTALL_TEAMSPEAK3="teamspeak3"
AUR_INSTALL_GOOGLE_EARTH="google-earth ld-lsb"
AUR_INSTALL_WORLDWIND="worldwind jogl"
AUR_INSTALL_TEAMVIEWER="teamviewer"
AUR_INSTALL_GIMP_PLUGINS="gimp-paint-studio gimphelp-scriptfu gimp-resynth gimpfx-foundry gimp-plugin-pandora gimp-plugin-saveforweb"
AUR_INSTALL_SOZI="sozi"
AUR_INSTALL_XNVIEWMP="xnviewmp"
AUR_INSTALL_CODECS="codecs"
AUR_INSTALL_CODECS_64="codecs64"
AUR_INSTALL_AUDIENCE="audience-bzr"
AUR_INSTALL_MINITUBE="minitube"
AUR_INSTALL_ROSA_MEDIA_PLAYER="rosa-media-player"
AUR_INSTALL_KAZAM_BZR="python-rsvg kazam-bzr"
AUR_INSTALL_B43_FIRMWARE="b43-firmware"
AUR_INSTALL_B43_FIRMWARE_LEGACY="b43-firmware-legacy"
AUR_INSTALL_BROADCOM_WL="broadcom-wl"


