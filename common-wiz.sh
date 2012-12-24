#!/bin/bash
#
# LAST_UPDATE="22 Dec 2012 16:33"
# SCRIPT_VERSION="1.0"
#
# VARIABLES {{{
# DESKTOP ENVIRONMENT {{{
MOUNTPOINT="/mnt"
# Instructions: on boot up of Arch ISO, mkdir usb, cd usb, call this script: path = /root/usb/; this is not hard coded; only a reference.
#
CUSTOM_PACKAGES_NAME="Packages"
AUR_REPO_NAME="AUR-Packages" # ${USERNAME}
CUSTOM_PACKAGES="${FULL_SCRIPT_PATH}/${CUSTOM_PACKAGES_NAME}" # mount path of script: /root/usb/Packages
AUR_CUSTOM_PACKAGES="${FULL_SCRIPT_PATH}/${AUR_REPO_NAME}" # if Boot Mode /root/usb/AUR-Packages, if Live Mode /mnt/AUR-Packages
PACMAN_CACHE="/var/cache/pacman/pkg"
CUSTOM_REPO_NAME="custom"
INSTALL_DEVICE='sda'
SCRIPT_DEVICE='sdb1'
#
AUR="Arch User Repository (AUR)"
declare -i PACMAN_OPTIMIZER=0
declare -i PACMAN_REPO_TYPE=1 # 0=None, 1=Server, 2=Client
declare -i INSTALL_NO_INTERNET=0
declare -i USE_PACMAN=1
declare -i AUR_REPO=0
declare PACMAN_OPTIMIZE_PACKAGES="rsync"
#
declare -i MATE_INSTALLED=0
declare -i GNOME_INSTALL=0
declare -i XFCE_INSTALLED=0
declare -i E17_INSTALLED=0
declare -i KDE_INSTALLED=0
declare -i LXDE_INSTALLED=0
declare -i OPENBOX_INSTALLED=0
declare -i AWESOME_INSTALLED=0
declare -i GNOME_INSTALLED=0
declare -i CINNAMON_INSTALLED=0
declare -i UNITY_INSTALLED=0
#
declare -i IS_INSTALL_SOFTWARE=0
declare -i IS_LAST_CONFIG_LOADED=0
declare -i SAVED_SOFTWARE=0
declare -i FAST_INSTALL=0
declare -i DISK_PROFILE=0
declare -i BOOT_MODE=0
declare -i DRIVE_FORMATED=0
declare -i BOOT_PARTITION_NO=2
declare -a LOCALE_ARRAY=( "" ) 
declare -a USER_GROUPS=( "" ) 
declare -a LIST_DEVICES=( "" ) 
USERNAME='archlinux'
USERPASSWD='archlinux'
ROOTPASSWD='archlinux'
declare -i REFRESH_REPO=1
declare -i REFRESH_AUR=1
declare -i IS_CUSTOM_NAMESERVER=0
CUSTOM_NS1="192.168.1.1"
CUSTOM_NS2="192.168.0.1"
CUSTOM_NS_SEARCH="localhost"
#
declare -i CONFIG_KDE=0
declare -i CONFIG_XORG=0
declare -i CONFIG_ORPHAN=0
declare -i CONFIG_TOR=0
declare -i CONFIG_SSH=0
#
declare -i WEBSERVER=0
declare -i CUSTOM_MIRRORLIST=0
declare -i SAFE_MODE=0
declare -i FLESH=0
declare -i VIDEO_CARD=7
declare -a VIDEO_CARDS=( "nVidia" "Nouveau" "Intel" "ATI" "Vesa" "Virtualbox" "Skip" );
#
NETWORK_MANAGER="networkmanager" # or wicd
#
declare -a PACKAGE_CHECK_FAILURES=( "mate" "mate-extras" "base-devel" )
#
declare -a PACKAGES=( "" )
declare -a AUR_PACKAGES=( "" )
declare -a PACKMANAGER=( "" )
declare -a PACKMANAGER_NAME=( "" )
#
declare -a TASKMANAGER=( "" )
declare -a TASKMANAGER_NAME=( "" )
PACSTRAP_PACKAGES=" "
#
declare -a CORE_INSTALL=( "" )
declare -a AUR_INSTALL=( "" )
declare -a FAILED_CORE_INSTALL=( "" )
declare -a FAILED_AUR_INSTALL=( "" )
declare -i E_BADARGS=65
#
CONFIG_HOSTNAME="archlinux"
#
declare -i CREATE_SCRIPT=0
declare -a AUR_HELPERS=("yaourt" "packer" "pacaur")
declare -i CONFIG_VERIFIED=0
AUR_HELPER="yaourt"
declare -a FSTAB=("UUID" "DEV" "LABEL");
declare -i FSTAB_CONFIG=1
declare -i FSTAB_EDIT=0
#
# Disk
#
declare -i IS_SSD=0
declare -i EDIT_GDISK=0
declare -i IS_DISK_CONFIG_LOADED=0
declare -i IS_SOFTWARE_CONFIG_LOADED=0
declare -i BOOT_SYSTEM_TYPE=0 # ("Grub2" "Syslinux" "Skip")
declare -i IS_BOOT_PARTITION=0
declare -a BIOS_SYSTEM_TYPES=("UEFI" "BIOS" "NONE"); # UEFI=0, BIOS=1 and NONE=2
declare -i UEFI=0
UEFI_SIZE="512M"
BOOT_SIZE="1G"
ROOT_SIZE="50G"
ROOT_FORMAT="ext4"
declare -i IS_SWAP_PARTITION=0
SWAP_SIZE="4G"
declare -i IS_HOME_PARTITION=0
declare -i IS_HOME_DRIVE=0
HOME_SIZE="0"
HOME_FORMAT="ext4"
declare -i IS_VAR_PARTITION=0
declare -i IS_VAR_DRIVE=0 
VAR_SIZE="13G"
VAR_FORMAT="ext4"
declare -i IS_TMP_PARTITION=0
declare -i IS_TMP_SIZE=0
TMP_SIZE="1G"
TMP_FORMAT="ext4"
OPTION=" "
#
# AUTOMATICALLY DETECTS THE SYSTEM LANGUAGE {{{
# automatically detects the system language based on your locale
LANGUAGE=`locale | sed '1!d' | sed 's/LANG=//' | cut -c1-5` # en_US 
LOCALE="$LANGUAGE" # en_US 
declare -a COUNTRIES=("Australia" "Belarus" "Belgium" "Brazil" "Bulgaria" "Canada" "Chile" "China" "Colombia" "Czech Republic" "Denmark" "Estonia" "Finland" "France" "Germany" "Greece" "Hungary" "India" "Ireland" "Israel" "Italy" "Japan" "Kazakhstan" "Korea" "Macedonia" "Netherlands" "New Caledonia" "New Zealand" "Norway" "Poland" "Portugal" "Romania" "Russian Federation" "Serbia" "Singapore" "Slovakia" "South Africa" "Spain" "Sri Lanka" "Sweden" "Switzerland" "Taiwan" "Ukraine" "United Kingdom" "United States" "Uzbekistan" "Viet Nam")
declare -a COUNTRY_CODES=("AU" "BY" "BE" "BR" "BG" "CA" "CL" "CN" "CO" "CZ" "DK" "EE" "FI" "FR" "DE" "GR" "HU" "IN" "IE" "IL" "IT" "JP" "KZ" "KR" "MK" "NL" "NC" "NZ" "NO" "PL" "PT" "RO" "RU" "RS" "SG" "SK" "ZA" "ES" "LK" "SE" "CH" "TW" "UA" "GB" "US" "UZ" "VN")
COUNTRY_CODE=${LOCALE#*_} # en_US = en-US = US
COUNTRY="United States"
LANGUAGE_LO="en-US"
LANGUAGE_HS="en"
LANGUAGE_AS="en"
LANGUAGE_KDE="en_gb"
LANGUAGE_FF="en-us" # af ak ar as ast be bg bn-bd bn-in br bs ca cs csb cy da de el en-gb en-us en-za eo es-ar es-cl es-es es-mx et eu fa ff fi fr fy-nl ga-ie gd gl gu-in he hi-in hr hu hy-am id is it ja kk km kn ko ku lg lij lt lv mai mk ml mr nb-no nl nn-no nso or pa-in pl pt-br pt-pt rm ro ru si sk sl son sq sr sv-se ta ta-lk te th tr uk vi zh-cn zh-tw zu
KEYBOARD="us" # used to drill down into more specific layouts for some; not the same as KEYMAP necessarily  
KEYMAP="us"
ZONE="America"
SUBZONE="Los_Angeles"
set_language="$LANGUAGE" # Run function to set defaults
#}}}
# ARCH {{{
ARCHI=`uname -m`
#}}}
#
EDITOR=nano
declare -a EDITORS=("nano" "emacs" "vi" "vim" "joe");
#}}}
#SUPPORT FUNCTIONS {{{
# -----------------------------------------------------------------------------
# INSTALLED CORE {{{
NAME="installed_core"
USAGE=$(localize "INSTALLED-CORE-USAGE")
DESCRIPTION=$(localize "INSTALLED-CORE-DESC")
NOTES=$(localize "NONE")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "INSTALLED-CORE-USAGE" "installed_core 1->(package-name)"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "INSTALLED-CORE-DESC"  "Installed core"
# -------------------------------------
installed_core()
{
    if [[ "${#CORE_INSTALL}" -ne 0 ]]; then
        CORE_INSTALL[0]="$1" # Accessing below first will give unbound variable error
    else
        CORE_INSTALL[$[${#CORE_INSTALL[@]}]]="$1"
    fi    
}
#}}}
# -----------------------------------------------------------------------------
# FAILED INSTALL CORE {{{
NAME="failed_install_core"
USAGE=$(localize "FAILED-INSTALL-CORE-USAGE")
DESCRIPTION=$(localize "FAILED-INSTALL-CORE-DESC")
NOTES=$(localize "NONE")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "FAILED-INSTALL-CORE-USAGE" "failed-install_core 1->(package-name)"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "FAILED-INSTALL-CORE-DESC"  "Failed install core"
# -------------------------------------
failed_install_core()
{
    if [[ "${#FAILED_CORE_INSTALL}" -ne 0 ]]; then
        FAILED_CORE_INSTALL[0]="$1" # Accessing below first will give unbound variable error
    else
        FAILED_CORE_INSTALL[$[${#FAILED_CORE_INSTALL[@]}]]="$1"
    fi    
}
#}}}
# -----------------------------------------------------------------------------
# INSTALLED AUR {{{
NAME="installed_aur"
USAGE=$(localize "INSTALLED-AUR-USAGE")
DESCRIPTION=$(localize "INSTALLED-AUR-DESC")
NOTES=$(localize "NONE")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "INSTALLED-AUR-USAGE" "installed_aur 1->(package-name)"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "INSTALLED-AUR-DESC"  "Installed aur"
# -------------------------------------
installed_aur()
{
    if [[ "${#AUR_INSTALL}" -ne 0 ]]; then
        AUR_INSTALL[0]="$1" # Accessing below first will give unbound variable error
    else
        AUR_INSTALL[$[${#AUR_INSTALL[@]}]]="$1"
    fi    
}
#}}}
# -----------------------------------------------------------------------------
# FAILED INSTALL AUR {{{
NAME="failed_install_aur"
USAGE=$(localize "FAILED-INSTALL-AUR-USAGE")
DESCRIPTION=$(localize "FAILED-INSTALL-AUR-DESC")
NOTES=$(localize "NONE")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "FAILED-INSTALL-AUR-USAGE" "failed_install_aur 1->(package-name)"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "FAILED-INSTALL-AUR-DESC"  "Failed install aur"
# -------------------------------------
failed_install_aur()
{
    if [[ "${#FAILED_AUR_INSTALL}" -ne 0 ]]; then
        FAILED_AUR_INSTALL[0]="$1" # Accessing below first will give unbound variable error
    else
        FAILED_AUR_INSTALL[$[${#FAILED_AUR_INSTALL[@]}]]="$1"
    fi    
}
#}}}
# -----------------------------------------------------------------------------
# CHECK PACKAGE {{{
NAME="check_package"
USAGE=$(localize "CHECK-PACKAGE-USAGE")
DESCRIPTION=$(localize "CHECK-PACKAGE-DESC")
NOTES=$(localize "CHECK-PACKAGE-NOTES")
AUTHOR="helmuthdu and Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CHECK-PACKAGE-USAGE" "check_package 1->(Single-Package-to-Check Or Multiple Packages)"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CHECK-PACKAGE-DESC"  "checks package(s) to see if they are installed in pacman."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CHECK-PACKAGE-NOTES" "I have seen this fail for one or more packages that were already install: mate; so I added -Qm for this reason."
# -------------------------------------
check_package()
{
    refresh_pacman
    # @FIX direct error to null &>
    if ! pacman -Q "$1" ; then        # check if a package is already installed from Core
        if ! pacman -Qm "$1" ; then   # check if a package is already installed from Outside Repository
            return 1
        else
            return 0
        fi
    else
        return 0
    fi
} 
#}}}
# -----------------------------------------------------------------------------
# SET LANGUAGE {{{
NAME="set_language"
USAGE="set_language"
DESCRIPTION=$(localize "SET-LANGUAGE-DESC")
NOTES=$(localize "NONE")
# af ak ar as ast be bg bn-bd bn-in br bs ca cs csb cy da de el en-gb en-us en-za eo es-ar es-cl es-es es-mx et eu fa ff fi fr fy-nl ga-ie gd gl gu-in he hi-in hr hu hy-am id is it ja kk km kn ko ku lg lij lt lv mai mk ml mr nb-no nl nn-no nso or pa-in pl pt-br pt-pt rm ro ru si sk sl son sq sr sv-se ta ta-lk te th tr uk vi zh-cn zh-tw zu"
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "SET-LANGUAGE-DESC"  "Set Language: Used to set Languages for packages"
# -------------------------------------
set_language()
{
    LANGUAGE="$1"
    # KDE #{{{
    if [[ "$LANGUAGE" == pt_BR || "$LANGUAGE" == en_GB || "$LANGUAGE" == zh_CN ]]; then
        LANGUAGE_KDE=`echo $LANGUAGE | tr '[:upper:]' '[:lower:]'`
    elif [[ "$LANGUAGE" == en_US ]]; then
        LANGUAGE_KDE="en_gb"
    else
        LANGUAGE_KDE=`echo $LANGUAGE | cut -d\_ -f1`
    fi
    #}}}
    # FIREFOX #{{{
    if [[ "$LANGUAGE" == pt_BR || "$LANGUAGE" == pt_PT || "$LANGUAGE" == en_GB || "$LANGUAGE" == es_AR || "$LANGUAGE" == es_ES || "$LANGUAGE" == zh_CN ]]; then
        LANGUAGE_FF=`echo $LANGUAGE | tr '[:upper:]' '[:lower:]' | sed 's/_/-/'`
    elif [[ "$LANGUAGE" == en_US ]]; then
        LANGUAGE_FF="en-us"
        #LANGUAGE_FF="en-gb"
    else
        LANGUAGE_FF=`echo $LANGUAGE | cut -d\_ -f1`
    fi
    #}}}
    # HUNSPELL #{{{
    if [[ "$LANGUAGE" == pt_BR ]]; then
        LANGUAGE_HS=`echo $LANGUAGE | tr '[:upper:]' '[:lower:]' | sed 's/_/-/'`
    elif [[ "$LANGUAGE" == pt_PT ]]; then
        LANGUAGE_HS="pt_pt"
    else
        LANGUAGE_HS=`echo $LANGUAGE | cut -d\_ -f1`
    fi
    #}}}
    # ASPELL #{{{
    LANGUAGE_AS=`echo $LANGUAGE | cut -d\_ -f1`
    #}}}
    # LIBREOFFICE #{{{ 
    if [[ "$LANGUAGE" == pt_BR || "$LANGUAGE" == en_GB || "$LANGUAGE" == en_US || "$LANGUAGE" == zh_CN ]]; then
        LANGUAGE_LO=`echo $LANGUAGE | sed 's/_/-/'`
    else
        LANGUAGE_LO=`echo $LANGUAGE | cut -d\_ -f1`
    fi
    #}}}
}
#}}}
# -----------------------------------------------------------------------------
# REFRESH PACMAN {{{
NAME="refresh_pacman"
USAGE="refresh_pacman"
DESCRIPTION=$(localize "REFRESH-PACMAN-DESC")
NOTES=$(localize "NONE") 
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "REFRESH-PACMAN-DESC"  "Refresh pacman"
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "REFRESH-PACMAN-INFO"  "Refresh Pacman Database..."
# -------------------------------------
refresh_pacman()
{
    if [[ "$REFRESH_REPO" -eq 1 ]]; then
        REFRESH_REPO=0
        print_info "REFRESH-PACMAN-INFO"
        pacman -Syy
    fi
} 
#}}}
# -----------------------------------------------------------------------------
# SYSTEM UPDATE {{{
NAME="system_upgrade"
USAGE="system_upgrade"
DESCRIPTION=$(localize "SYSTEM-UPDATE-DESC")
NOTES=$(localize "NONE")
AUTHOR="helmuthdu and Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "SYSTEM-UPDATE-DESC"  "Full pacman System Upgrade: Set a var so you do not do this every call, then perform a pacman-optimize"
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "SYSTEM-UPDATE-INFO"  "UPDATING YOUR Pacman SYSTEM"
# -------------------------------------
system_upgrade()
{
    print_info "SYSTEM-UPDATE-INFO"
    if [[ "$REFRESH_REPO" -eq 1 ]]; then
        if [[ "$USE_PACMAN" -eq 1 ]]; then
            pacman -Syy --noconfirm
            pacman -Su --noconfirm
            pacman -Sc && pacman-optimize
        else
            # pplsyu
            aria2_args=( "--metalink-file=-" "--conf-path=/etc/ppl.conf" ) # Arguments for aria2c.
            pacman -Sy # sync databases
            #pm2ml -ysd var/lib/pacman/sync | aria2c "${aria2_args[@]}"
            # download packages
            pm2ml -no var/cache/pacman/pkg -u -r -p http -l 50 | aria2c "${aria2_args[@]}"
            # invoke pacman
            pacman -Su  --noconfirm
        fi
        REFRESH_REPO=0
    else
        if [[ "$USE_PACMAN" -eq 1 ]]; then
            pacman -Su --noconfirm
        else
            # pplsyu
            aria2_args=( "--metalink-file=-" "--conf-path=/etc/ppl.conf" ) # Arguments for aria2c.
            # download packages
            pm2ml -no var/cache/pacman/pkg -u -r -p http -l 50 | aria2c "${aria2_args[@]}"
            # invoke pacman
            pacman -Su  --noconfirm
        fi
    fi
}
#}}}
# -----------------------------------------------------------------------------
# UPDATE SYSTEM {{{
NAME="update_system"
USAGE="update_system"
DESCRIPTION=$(localize "UPDATE-SYSTEM-DESC")
NOTES=$(localize "NONE")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "UPDATE-SYSTEM-DESC"  "Update system"
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "UPDATE-SYSTEM-INFO"  "Update system"
# -------------------------------------
update_system()
{
    print_info "UPDATE-SYSTEM-INFO"
    if [[ "$USE_PACMAN" -eq 1 ]]; then
        pacman -Syy && pacman -Su --noconfirm && yaourt -Syua --noconfirm && yaourt -Syua --devel --noconfirm
    else
        pplsyu
    fi
}
#}}}
# -----------------------------------------------------------------------------
#
# DOWNLOAD AUR REPO PACKAGES {{{
NAME="download_aur_repo_packages"
USAGE="download_aur_repo_packages"
DESCRIPTION=$(localize "DOWNLOAD-AUR-REPO-PACKAGES-DESC")
NOTES=$(localize "NONE")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "DOWNLOAD-AUR-REPO-PACKAGES-DESC"  "Download AUR Repository Packages: download all AUR Repository Packages into one folder, unarchive them, compile them, and copy package to Custom Package Repo"
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "DOWNLOAD-AUR-REPO-PACKAGES-NO-PACKAGES"          "No packages in download_aur_repo_packages; create Software Configuration first."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "DOWNLOAD-AUR-REPO-PACKAGES-DOWNLOADING"          "Downloading AUR Repository with"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "DOWNLOAD-AUR-REPO-PACKAGES-DOWNLOADING-PACKAGE"  "AUR downloading package"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "DOWNLOAD-AUR-REPO-PACKAGES-PACKAGE-FAIL"         "aur_download_packages Failed to download package"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "DOWNLOAD-AUR-REPO-PACKAGES-COMPLETED"            "Download AUR Repo Packages Completed"
# -------------------------------------
download_aur_repo_packages()
{
    AUR_CUSTOM_PACKAGES="${FULL_SCRIPT_PATH}/${AUR_REPO_NAME}" # if Boot Mode /root/usb/AUR-Packages, if Live Mode /mnt/AUR-Packages
    #
    pacman -Syyu
    local all_packages=""
    if [ "${#AUR_PACKAGES}" -gt 0 ]; then
        local -i total="${#AUR_PACKAGES[@]}"
        for (( i=0; i<${total}; i++ )); do
            all_packages="$all_packages ${AUR_PACKAGES[$i]}"
        done
    else
        print_warning "DOWNLOAD-AUR-REPO-PACKAGES-NO-PACKAGES" " - $(basename $BASH_SOURCE) : $LINENO"
        abort_install
    fi
    print_info "DOWNLOAD-AUR-REPO-PACKAGES-DOWNLOADING" ": $all_packages"
    #
    DO_SINGLES=0
    if [[ "$DO_SINGLES" -eq 1 ]]; then
        for PACKAGE in $all_packages; do
            print_info "DOWNLOAD-AUR-REPO-PACKAGES-DOWNLOADING-PACKAGE" ": [${PACKAGE}] -> [${AUR_CUSTOM_PACKAGES}]"
            if ! aur_download_packages "$PACKAGE" ; then
                write_error   "DOWNLOAD-AUR-REPO-PACKAGES-PACKAGE-FAIL" ": $PACKAGE - $(basename $BASH_SOURCE) : $LINENO"
                print_warning "DOWNLOAD-AUR-REPO-PACKAGES-PACKAGE-FAIL" ": $PACKAGE - $(basename $BASH_SOURCE) : $LINENO"
                if [[ "$DEBUGGING" -eq 1 ]]; then pause_function "download_aur_repo_packages DO_SINGLES @ $(basename $BASH_SOURCE) : $LINENO"; fi
            fi
        done        
    else
        if ! aur_download_packages "$all_packages" ; then
            write_error   "DOWNLOAD-AUR-REPO-PACKAGES-PACKAGE-FAIL" ": $all_packages - $(basename $BASH_SOURCE) : $LINENO"
            print_warning "DOWNLOAD-AUR-REPO-PACKAGES-PACKAGE-FAIL" ": $all_packages - $(basename $BASH_SOURCE) : $LINENO"
            if [[ "$DEBUGGING" -eq 1 ]]; then pause_function "download_aur_repo_packages @ $(basename $BASH_SOURCE) : $LINENO"; fi
        fi
    fi
    #    
    if [[ "$AUR_REPO" -eq 1 ]]; then
        # set before getting here: AUR_REPO_NAME="${MOUNTPOINT}$AUR_REPO_NAME" # /mnt/home/${USERNAME}/aur-packages/
        if [[ "$RUNTIME_MODE" -eq 1 ]]; then
            # AUR_CUSTOM_PACKAGES = Boot Mode /root/usb/AUR-Packages
            copy_files "$AUR_CUSTOM_PACKAGES" " " "${MOUNTPOINT}${MOUNTPOINT}/${AUR_REPO_NAME}" "$(basename $BASH_SOURCE) : $LINENO"
        else
            # AUR_CUSTOM_PACKAGES = Live Mode /mnt/AUR-Packages
            copy_files "$AUR_CUSTOM_PACKAGES" " " "/mnt/${AUR_REPO_NAME}" "$(basename $BASH_SOURCE) : $LINENO"
        fi
    fi
    #
    print_info "DOWNLOAD-AUR-REPO-PACKAGES-COMPLETED"
    if [[ "$DEBUGGING" -eq 1 ]]; then pause_function "download_aur_repo_packages @ $(basename $BASH_SOURCE) : $LINENO"; fi
    return 0
}
#}}}
# -----------------------------------------------------------------------------
# COPY CUSTOM REPO {{{
NAME="copy_custom_repo"
USAGE=$(localize "COPY-CUSTOM-REPO-USAGE")
DESCRIPTION=$(localize "COPY-CUSTOM-REPO-DESC")
NOTES=$(localize "NONE") 
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "COPY-CUSTOM-REPO-USAGE" "copy_custom_repo 1->(/From-Full-Path) 2->(Repo Name) 3->(/To-Full-Path/)"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "COPY-CUSTOM-REPO-DESC"  "Copy Custom Repository"
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "COPY-CUSTOM-REPO-INFO"  "Copying Custom Repository..."
# -------------------------------------
copy_custom_repo()
{
    check_arg "copy_custom_repo" "3" "${#@}" "$(basename $BASH_SOURCE) : $LINENO"
    print_info ""COPY-CUSTOM-REPO-INFO""
    copy_file  "${1}/${2}.db.tar.gz" "$3"          "$(basename $BASH_SOURCE) : $LINENO"
    copy_file  "${1}/${2}.db.tar.gz" "${3}${2}.db" "$(basename $BASH_SOURCE) : $LINENO" # rename it to db
    copy_files "${1}/"               "xz" "$3"     "$(basename $BASH_SOURCE) : $LINENO"
    #copy_files "/var/lib/pacman/sync/" "db" "${MOUNTPOINT}/var/lib/pacman/sync/" "$(basename $BASH_SOURCE) : $LINENO"
}
#}}}
# -----------------------------------------------------------------------------
# DOWNLOAD REPO PACKAGES {{{
NAME="download_repo_packages"
USAGE="download_repo_packages"
DESCRIPTION=$(localize "DOWNLOAD-REPO-PACKAGES-DESC")
NOTES=$(localize "NONE")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "DOWNLOAD-REPO-PACKAGES-DESC"  "Download Repository Packages: download all Arch/Repository Packages into one folder, unarchive them, compile them, and copy package to Custom Package Repo."
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "DOWNLOAD-REPO-PACKAGES-NO-PACKAGES"   "No Packages: create Software Configuration first: "
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "DOWNLOAD-REPO-PACKAGES-DOWNLOADING"   "pacman Downloading Package"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "DOWNLOAD-REPO-PACKAGES-CREATING"     "Creating Custom Repo with"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "DOWNLOAD-REPO-PACKAGES-DOWNLOAD-FAIL" "pacman Failed to Download Package"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "DOWNLOAD-REPO-PACKAGES-NOT-FOUND"     "Not Found Files"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "DOWNLOAD-REPO-PACKAGES-REPO-ADD-FAIL"     "repo-add failed for"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "DOWNLOAD-REPO-PACKAGES-COMPLETED"     "Download Repo Packages Completed"
# -------------------------------------
download_repo_packages()
{
    # Create a Custom Repository
    local all_packages="${PACSTRAP_PACKAGES}" # = pacstrap package list
    if [ "${#PACKAGES}" -gt 0 ]; then
        local -i total="${#PACKAGES[@]}"
        for (( i=0; i<${total}; i++ )); do
            all_packages="$all_packages ${PACKAGES[$i]}"
        done
    else
        print_warning "DOWNLOAD-REPO-PACKAGES-NO-PACKAGES" ": download_repo_packages - $(basename $BASH_SOURCE) : $LINENO"
        write_error   "DOWNLOAD-REPO-PACKAGES-NO-PACKAGES" ": download_repo_packages - $(basename $BASH_SOURCE) : $LINENO"
        abort_install
    fi
    print_info "DOWNLOAD-REPO-PACKAGES-CREATING" ": ${all_packages}"
    # @ FIX; is optimized use other methods
    # @FIX Optimize
    USE_PACMAN=1
    # REFRESH_REPO=1
    refresh_pacman
    DO_SINGLES=1
    if [[ "$DO_SINGLES" -eq 1 ]]; then
        for PACKAGE in $all_packages; do
            print_info "DOWNLOAD-REPO-PACKAGES-DOWNLOADING" ": [${PACKAGE}] -> [${CUSTOM_PACKAGES}]"
            if ! pacman -Sw "$PACKAGE" --noconfirm --cachedir "${CUSTOM_PACKAGES}/" ; then
                print_warning "DOWNLOAD-REPO-PACKAGES-DOWNLOAD-FAIL" ": $PACKAGE - $(basename $BASH_SOURCE) : $LINENO"
                write_error   "DOWNLOAD-REPO-PACKAGES-DOWNLOAD-FAIL" ": $PACKAGE - $(basename $BASH_SOURCE) : $LINENO"
            fi
        done        
    else
        if ! pacman -Sw "$all_packages" --noconfirm --cachedir "${CUSTOM_PACKAGES}/" ; then
            print_warning "DOWNLOAD-REPO-PACKAGES-DOWNLOAD-FAIL" ": $all_packages - $(basename $BASH_SOURCE) : $LINENO"
            write_error   "DOWNLOAD-REPO-PACKAGES-DOWNLOAD-FAIL" ": $PACKAGE - $(basename $BASH_SOURCE) : $LINENO"
        fi
    fi
    if [[ "$DEBUGGING" -eq 1 ]]; then pause_function "download_repo_packages: pacman downloaded @ $(basename $BASH_SOURCE) : $LINENO"; fi
    if is_wildcard_file "${CUSTOM_PACKAGES}/" "pkg.tar.xz" ; then # " " | "ext" 
        #print_info "ls [${CUSTOM_PACKAGES}/*]"
        #ls "${CUSTOM_PACKAGES}"/*
        #print_info "ls [${CUSTOM_PACKAGES}/*.pkg.tar.xz]"
        #ls "${CUSTOM_PACKAGES}"/*.pkg.tar.xz
        if [ -f "${CUSTOM_PACKAGES}/${CUSTOM_REPO_NAME}.db.tar.gz" ]; then
            rm "${CUSTOM_PACKAGES}/${CUSTOM_REPO_NAME}.db.tar.gz"
        fi
        repo-add "${CUSTOM_PACKAGES}/${CUSTOM_REPO_NAME}.db.tar.gz" "${CUSTOM_PACKAGES}"/*.pkg.tar.xz # /root/usb/Packages/
        if [[ "$?" -ne 0 ]]; then
            print_warning "DOWNLOAD-REPO-PACKAGES-REPO-ADD-FAIL" ": ${CUSTOM_PACKAGES}/*.pkg.tar.xz - $(basename $BASH_SOURCE) : $LINENO"
            write_error   "DOWNLOAD-REPO-PACKAGES-REPO-ADD-FAIL" ": ${CUSTOM_PACKAGES}/*.pkg.tar.xz - $(basename $BASH_SOURCE) : $LINENO"
            if [[ "$DEBUGGING" -eq 1 ]]; then pause_function "download_repo_packages: repo-add @ $(basename $BASH_SOURCE) : $LINENO"; fi
            #cd "$FULL_SCRIPT_PATH"
            return 1
        fi
    else
        print_warning "DOWNLOAD-REPO-PACKAGES-NOT-FOUND" ": [${CUSTOM_PACKAGES}/*.pkg.tar.xz]"
        ls "${CUSTOM_PACKAGES}"/*.pkg.tar.xz
        if [[ "$DEBUGGING" -eq 1 ]]; then pause_function "download_repo_packages @ $(basename $BASH_SOURCE) : $LINENO"; fi
        #cd "$FULL_SCRIPT_PATH"
        return 1
    fi
    print_info "DOWNLOAD-REPO-PACKAGES-COMPLETED"
    if [[ "$DEBUGGING" -eq 1 ]]; then pause_function "download_repo_packages @ $(basename $BASH_SOURCE) : $LINENO"; fi
    return 0
}
#}}}
# -----------------------------------------------------------------------------
# CREATE CUSTOM AUR REPO {{{
NAME="create_custom_aur_repo"
USAGE=$(localize "CREATE-CUSTOM-AUR-REPO-USAGE")
DESCRIPTION=$(localize "CREATE-CUSTOM-AUR-REPO-DESC")
NOTES=$(localize "CREATE-CUSTOM-AUR-REPO-NOTES")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="1 OCT 2012"
REVISION="1 NOV 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CREATE-CUSTOM-AUR-REPO-USAGE" "create_custom_aur_repo 1->( 1=archwiz Install OS, 2=packagewiz Install Software)"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CREATE-CUSTOM-AUR-REPO-DESC"  "Create a Custom Repository; so you can do installs real fast after the first try."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CREATE-CUSTOM-AUR-REPO-NOTES" "If we have more than one Arch Box; we want a common Repository; mounted drive or NAS; plus we want to copy those files to local cache."
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CREATE-CUSTOM-AUR-REPO-ERROR"  "Failed Download AUR Repo Packages for"
# -------------------------------------
create_custom_aur_repo()
{
    # In Boot Mode; hard drive is formated and pacstrap has not completed.
    if [[ "$RUNTIME_MODE" -eq 1 ]]; then
        myMOUNTPOINT="${MOUNTPOINT}"
    else
        myMOUNTPOINT="/mnt" # I could just set this, but where is the fun in that
    fi
    # Download Repo packages, check files copied above
    if ! download_aur_repo_packages ; then
        print_warning "CREATE-CUSTOM-AUR-REPO-ERROR" ": ${CUSTOM_PACKAGES} - $(basename $BASH_SOURCE) : $LINENO"
        write_error   "CREATE-CUSTOM-AUR-REPO-ERROR" ": ${CUSTOM_PACKAGES} - $(basename $BASH_SOURCE) : $LINENO"
        if [[ "$DEBUGGING" -eq 1 ]]; then pause_function "create_custom_aur_repo: download_aur_repo_packages @ $(basename $BASH_SOURCE) : $LINENO"; fi
        return 1
    fi
}
#}}}
# -----------------------------------------------------------------------------
# CREATE CUSTOM REPO {{{
NAME="create_custom_repo"
USAGE=$(localize "CREATE-CUSTOM-REPO-USAGE")
DESCRIPTION=$(localize "CREATE-CUSTOM-REPO-DESC")
NOTES=$(localize "CREATE-CUSTOM-REPO-NOTES")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="1 OCT 2012"
REVISION="1 NOV 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CREATE-CUSTOM-REPO-USAGE" "create_custom_repo 1->( 1=archwiz Install OS, 2=packagewiz Install Software)"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CREATE-CUSTOM-REPO-DESC"  "Create a Custom Repository; so you can do installs real fast after the first try."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CREATE-CUSTOM-REPO-NOTES" "If we have more than one Arch Box; we want a common Repository; mounted drive or NAS; plus we want to copy those files to local cache <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/var/lib/pacman/sync/{core,extra,testing,community}<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;https://wiki.archlinux.org/index.php/Pacman_Tips#Network_shared_pacman_cache<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;https://wiki.archlinux.org/index.php/Custom_local_repository_with_ABS_and_gensync#Custom_local_repository<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;This Function assumes you have configured database, and will download all software into a Repository, if one is chosen; otherwise it just copies them to cache."
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CREATE-CUSTOM-REPO-ERROR-DOWNLOAD-REPO"          "Failed Download Repo Packages for"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CREATE-CUSTOM-REPO-COPYING-REPO-LOCAL-CACHE"     "Coping Repository to Local Cache..."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CREATE-CUSTOM-REPO-COPYING-REPO-SHARE-CACHE"     "Coping Repository to Sharable Cache..."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CREATE-CUSTOM-REPO-CLIENT-REPO"                  "Setting up Client Repository..."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CREATE-CUSTOM-REPO-NO-REPO"                      "No Repository."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CREATE-CUSTOM-REPO-EDIT-PACMAN-CONF-REPO-CACHE"  "Edit pacman.conf for Repository cache..."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CREATE-CUSTOM-REPO-COMPLETE"                     "Create Custom Repo Completed"
# -------------------------------------
create_custom_repo()
{
    # In Boot Mode; hard drive is formated and pacstrap has not completed.
    if [[ "$RUNTIME_MODE" -eq 1 ]]; then
        myMOUNTPOINT="${MOUNTPOINT}"
    else
        myMOUNTPOINT="/mnt" # I could just set this, but where is the fun in that
    fi
    #
    make_dir "${CUSTOM_PACKAGES}/" "$(basename $BASH_SOURCE) : $LINENO" # First time [${FULL_SCRIPT_PATH}/${CUSTOM_PACKAGES_NAME}] folder will not exist
    # Download Repo packages, check files copied above
    if ! download_repo_packages ; then
        print_warning "CREATE-CUSTOM-REPO-ERROR-DOWNLOAD-REPO" ": ${CUSTOM_PACKAGES} - $(basename $BASH_SOURCE) : $LINENO"
        write_error "CREATE-CUSTOM-REPO-ERROR-DOWNLOAD-REPO"   ": ${CUSTOM_PACKAGES} - $(basename $BASH_SOURCE) : $LINENO"
        if [[ "$DEBUGGING" -eq 1 ]]; then pause_function "create_custom_repo: download_repo_packages @ $(basename $BASH_SOURCE) : $LINENO"; fi
        return 1
    fi
    # Copy Sync db to Flash Drive
    copy_files "/var/lib/pacman/sync/" "db" "${FULL_SCRIPT_PATH}/Sync/" "$(basename $BASH_SOURCE) : $LINENO"
    # Copy Repo from Flash Drive to Disk
    if [[ "$PACMAN_REPO_TYPE" -eq 0 ]]; then # 0=None, 1=Server, 2=Client
        print_info "CREATE-CUSTOM-REPO-COPYING-REPO-LOCAL-CACHE"
        copy_files "${CUSTOM_PACKAGES}/" "xz" "${PACMAN_CACHE}/" "$(basename $BASH_SOURCE) : $LINENO"
        #copy_files "/var/lib/pacman/sync/" "db" "${myMOUNTPOINT}/var/lib/pacman/sync/" "$(basename $BASH_SOURCE) : $LINENO"
    elif [[ "$PACMAN_REPO_TYPE" -eq 1 ]]; then # 1=Server
        print_info "CREATE-CUSTOM-REPO-COPYING-REPO-SHARE-CACHE"
        #
        if [[ "$1" -eq 1 ]]; then # Boot Mode: Copy them to /mnt/mnt/Packages, so when it mounts, its /mnt/Packages
            copy_custom_repo "${CUSTOM_PACKAGES}" "${CUSTOM_REPO_NAME}" "${MOUNTPOINT}/${CUSTOM_PACKAGES_NAME}/"
        else
            copy_custom_repo "${CUSTOM_PACKAGES}" "${CUSTOM_REPO_NAME}" "${myMOUNTPOINT}/${CUSTOM_PACKAGES_NAME}/"
        fi
        #
        if [[ "$DEBUGGING" -eq 1 ]]; then pause_function "create_custom_repo: Server Copy at line @ $(basename $BASH_SOURCE) : $LINENO"; fi
    elif [[ "$PACMAN_REPO_TYPE" -eq 2 ]]; then # 2=Client
        print_info "CREATE-CUSTOM-REPO-CLIENT-REPO"
        copy_files "${CUSTOM_PACKAGES}/" "xz" "${PACMAN_CACHE}/" "$(basename $BASH_SOURCE) : $LINENO"
    fi
    #
    if [[ "$PACMAN_REPO_TYPE" -eq 0 ]]; then # 0=None, 1=Server, 2=Client
        print_info "CREATE-CUSTOM-REPO-NO-REPO"
    elif [[ "$PACMAN_REPO_TYPE" -eq 1 ]]; then # 1=Server
        print_info "CREATE-CUSTOM-REPO-EDIT-PACMAN-CONF-REPO-CACHE"
        #                
        if ! is_string_in_file "/etc/pacman.conf" "$FILE_SIGNATURE" ; then
            # @FIX ask if using a Local Repo; and mount it there
            # if Live Mode CUSTOM_PACKAGES = /root/usb/Packages, if Boot Mode /root/usb/Pacstrap-Packages
            # /mnt/Packages and /mtn/Pacstrap-Packages; option is best; you can mount it as a shared drive in fstab
            # Note: if this text 'uncommented to enable the repo.' in pacman.conf changes, this will not work
            sed -i "/# uncommented to enable the repo./a #\n${FILE_SIGNATURE}\n# Commented below lines to disable the Custom Repository.\n[${CUSTOM_REPO_NAME}]\nSigLevel = Optional TrustedOnly\nServer = file://${myMOUNTPOINT}/${CUSTOM_PACKAGES_NAME}/" "/etc/pacman.conf"
            sed -i '/\[options\]/a CleanMethod = KeepCurrent' "/etc/pacman.conf"
            if [[ "$DEBUGGING" -eq 1 ]]; then pause_function "create_custom_repo: pacman.conf edit at line @ $(basename $BASH_SOURCE) : $LINENO"; fi
        fi
    elif [[ "$PACMAN_REPO_TYPE" -eq 2 ]]; then # 2=Client
        print_info "CREATE-CUSTOM-REPO-CLIENT-REPO"
        # @FIX setup NFS share
        sed -i "/# uncommented to enable the repo./a #\n${FILE_SIGNATURE}\n# Commented below lines to disable the Custom Repository.\n[${CUSTOM_REPO_NAME}]\nSigLevel = Optional TrustedOnly\nServer = file://${myMOUNTPOINT}/${CUSTOM_PACKAGES_NAME}/" "/etc/pacman.conf"
        sed -i '/\[options\]/a CleanMethod = KeepCurrent' "/etc/pacman.conf"
        print_info "mount /var/lib/pacman/sync/"
        print_info "mount /var/cache/pacman/pkg"
    fi
    copy_file "/etc/pacman.conf" "${MOUNTPOINT}/etc/pacman.conf"       "$(basename $BASH_SOURCE) : $LINENO" # Get Copy of pacman.conf
    copy_file "/etc/pacman.conf" "${FULL_SCRIPT_PATH}/etc/pacman.conf" "$(basename $BASH_SOURCE) : $LINENO" # Get Copy of pacman.conf
    #
    print_info "CREATE-CUSTOM-REPO-COMPLETE"
    if [[ "$DEBUGGING" -eq 1 ]]; then pause_function "create_custom_repo completed at line @ $(basename $BASH_SOURCE) : $LINENO"; fi
    return 0
}
#}}}
# -----------------------------------------------------------------------------
# ADD REPO {{{
NAME="add_repo"
USAGE=$(localize "ADD-REPO-USAGE")
DESCRIPTION=$(localize "ADD-REPO-DESC")
NOTES=$(localize "ADD-REPO-NOTES")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "ADD-REPO-USAGE" "add_repo 1->(repo-name) 2->(url) 3->(trust-level) 4->(1=add &#36;arch to url)"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "ADD-REPO-DESC"  "Add repo: Ran from Task Manager."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "ADD-REPO-NOTES" "trust-level: Optional TrustAll, PackageRequired, Never"
# -------------------------------------
add_repo()
{
    check_arg "add_repo" "4" "${#@}" "$(basename $BASH_SOURCE) : $LINENO"
    if ! is_string_in_file "/etc/pacman.conf" "$1" ; then
        sed -i '$ a #'               "/etc/pacman.conf"
        sed -i "$ a [${1}]"          "/etc/pacman.conf"
        sed -i "$ a SigLevel = ${3}" "/etc/pacman.conf"
        if [[ "$4" -eq 1 ]]; then
            sed -i "$ a Server = ${2}\$arch" "/etc/pacman.conf"
        else
            sed -i "$ a Server = ${2}"       "/etc/pacman.conf"
        fi
        if [[ "$RUNTIME_MODE" -eq 1 ]]; then # Boot
            copy_file "/etc/pacman.conf" "${MOUNTPOINT}/etc/pacman.conf" "$(basename $BASH_SOURCE) : $LINENO" # Get Copy of pacman.conf
        fi
        copy_file "/etc/pacman.conf" "${FULL_SCRIPT_PATH}/etc/pacman.conf" "$(basename $BASH_SOURCE) : $LINENO" # Get Copy of pacman.conf        
    fi
}
#}}}
# -----------------------------------------------------------------------------
# REQUIRED REPO {{{
NAME="required_repo"
USAGE="required_repo 1->(repo)"
DESCRIPTION=$(localize "REQUIRED-REPO-DESC")
NOTES=$(localize "REQUIRED-REPO-NOTES")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="13 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "REQUIRED-REPO-DESC"  "Add Required Repository."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "REQUIRED-REPO-NOTES" "Ran from Boot Mode in Task Manager."
required_repo()
{
    if [[ "$1" == "multilib" ]]; then
        if [[ "$ARCHI" == x86_64 ]]; then
            multilib=`grep -n "\[multilib\]" "/etc/pacman.conf" | cut -f1 -d:`
            if $multilib &> /dev/null; then
                echo -e "\n[multilib]\nSigLevel = PackageRequired\nInclude = /etc/pacman.d/mirrorlist" >> "/etc/pacman.conf"
                echo -e '\nMultilib repository added into pacman.conf file'
            else
                sed -i "${multilib}s/^#//" "/etc/pacman.conf"
                multilib=$(( $multilib + 1 ))
                sed -i "${multilib}s/^#//" "/etc/pacman.conf"
                multilib=$(( $multilib + 1 ))
                sed -i "${multilib}s/^#//" "/etc/pacman.conf"
            fi
        fi
        copy_file "/etc/pacman.conf" "${MOUNTPOINT}/etc/pacman.conf" "$(basename $BASH_SOURCE) : $LINENO" # Get Copy of pacman.conf
        copy_file "/etc/pacman.conf" "${FULL_SCRIPT_PATH}/etc/pacman.conf" "$(basename $BASH_SOURCE) : $LINENO" # Get Copy of pacman.conf        
    fi
}
#}}}
# -----------------------------------------------------------------------------
# OPTIMIZE PACMAN {{{
NAME="optimize_pacman"
USAGE="optimize_pacman"
DESCRIPTION=$(localize "OPTIMIZE-PACMAN-DESC")
# https://wiki.archlinux.org/index.php/Aria2
# http://xyne.archlinux.ca/scripts/pacman/#parisync
# http://xyne.archlinux.ca/projects/reflector/
# http://xyne.archlinux.ca/projects/pm2ml/
NOTES=$(localize "OPTIMIZE-PACMAN-NOTES")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "OPTIMIZE-PACMAN-DESC"  "Optimize Pacman to use parallel downloads using Aria2, rsync and ppl parisync"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "OPTIMIZE-PACMAN-NOTES" "Implement: UseDelta install xdelta3"
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "OPTIMIZE-PACMAN-FAILED"    "PACMAN Optimization Failed."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "OPTIMIZE-PACMAN-COMPLETED" "PACMAN Optimization Completed."
optimize_pacman()
{
    required_repo "multilib"
    #    
    # Add xyne Repositories
    # http://xyne.archlinux.ca/repos/
    # http://xyne.archlinux.ca/#signing-key
    #
    if ! is_string_in_file "/etc/pacman.conf" "xyne-any" ; then
        sed -i '$ a #' "/etc/pacman.conf"
        sed -i '$ a [xyne-any]' "/etc/pacman.conf"
        sed -i '$ a SigLevel = Required' "/etc/pacman.conf"
        sed -i '$ a Server = http://xyne.archlinux.ca/repos/xyne-any' "/etc/pacman.conf"
    fi
    if ! is_string_in_file "/etc/pacman.conf" "xyne-i686" ; then
        if [[ "$ARCHI" != "x86_64" ]]; then
            sed -i '$ a #' "/etc/pacman.conf"
            sed -i '$ a [xyne-i686]' "/etc/pacman.conf"
            sed -i '$ a SigLevel = Required' "/etc/pacman.conf"
            sed -i '$ a Server = http://xyne.archlinux.ca/repos/xyne-i686' "/etc/pacman.conf"
        fi
    fi
    #
    if ! is_string_in_file "/etc/pacman.conf" "xyne-x86_64" ; then
        if [[ "$ARCHI" == "x86_64" ]]; then
            sed -i '$ a #' "/etc/pacman.conf"
            sed -i '$ a [xyne-x86_64]' "/etc/pacman.conf"
            sed -i '$ a SigLevel = Required' "/etc/pacman.conf"
            sed -i '$ a Server = http://xyne.archlinux.ca/repos/xyne-x86_64  ' "/etc/pacman.conf"
            sed -i '$ a #' "/etc/pacman.conf"
        fi
    fi
    # @FIX 
    if package_install "aria2 reflector pm2ml" "INSTALL-OPTIMIZE-PACMAN" ; then
        if [[ "PACMAN_OPTIMIZER" -eq 1 ]]; then # @FIX make this an option
            if ! is_string_in_file "/etc/pacman.conf" "XferCommand = /usr/bin/aria2c" ; then
                if ! is_string_in_file "/etc/pacman.conf" "XferCommand = exec /usr/bin/pacget" ; then
                    if [[ "$1" -eq 0 ]]; then # Live Mode
                        get_root_format # We may not have used the config file to format this drive
                    fi
                    sed -i '/\[options\]/a XferCommand = exec /usr/bin/pacget %u %o' "/etc/pacman.conf"
                    copy_file "${FULL_SCRIPT_PATH}/pacget"      "/usr/bin/pacget"  "$(basename $BASH_SOURCE) : $LINENO"
                    copy_file "${FULL_SCRIPT_PATH}/pacget.conf" "/etc/pacget.conf" "$(basename $BASH_SOURCE) : $LINENO"
                    if [[ "$ROOT_FORMAT" == "ext4" ]]; then
                        sed -i 's/file-allocation=none/file-allocation=falloc/g' "/etc/pacget.conf"
                    fi
                fi
                USE_PACMAN=0
            fi
        fi
        print_info "OPTIMIZE-PACMAN-COMPLETED" " - $(basename $BASH_SOURCE) : $LINENO"
        write_log  "OPTIMIZE-PACMAN-COMPLETED" " - $(basename $BASH_SOURCE) : $LINENO"
        if [[ "$DEBUGGING" -eq 1 ]]; then pause_function "optimize_pacman @ $(basename $BASH_SOURCE) : $LINENO"; fi
    else
        write_error   "OPTIMIZE-PACMAN-FAILED" " - $(basename $BASH_SOURCE) : $LINENO"
        print_warning "OPTIMIZE-PACMAN-FAILED" " - $(basename $BASH_SOURCE) : $LINENO"
        if [[ "$DEBUGGING" -eq 1 ]]; then pause_function "optimize_pacman @ $(basename $BASH_SOURCE) : $LINENO"; fi
        return 1
    fi
    # Copy all files that can be changed by optimize_pacman
    copy_file "/etc/pacman.conf" "${MOUNTPOINT}/etc/pacman.conf" "$(basename $BASH_SOURCE) : $LINENO" # Get Copy of pacman.conf
    copy_file "/etc/pacman.conf" "${FULL_SCRIPT_PATH}/etc/pacman.conf" "$(basename $BASH_SOURCE) : $LINENO" # Get Copy of pacman.conf
    #
    #reflector -p rsync --sort rate -c "$COUNTRY" --save /etc/pacman.d/mirrorlist.rsync
    return 0
    #
}
#}}}
# -----------------------------------------------------------------------------
# INSTALL PACKAGE {{{
NAME="install_package"
USAGE=$(localize "INSTALL-PACKAGE-USAGE")
DESCRIPTION=$(localize "INSTALL-PACKAGE-DESC")
NOTES=$(localize "INSTALL-PACKAGE-NOTES")
AUTHOR="helmuthdu and Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "INSTALL-PACKAGE-USAGE" "install_package 1->(NAME_OF_PACKAGE) 2->(NAME-OF-PACKAGE-MANAGER)"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "INSTALL-PACKAGE-DESC"  "Install package from core or additional Repositories."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "INSTALL-PACKAGE-NOTES" "Install one at a time, check to see if already install, if fails, try again with with confirm."
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "INSTALL-PACKAGE-INSTALLING"     "pacman Installing"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "INSTALL-PACKAGE-ERROR-1"        "pacman did not install Package"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "INSTALL-PACKAGE-ERROR-2"        "for Install Package Manager"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "INSTALL-PACKAGE-INSTALL-PM2ML"  "using pm2ml: Installing"
# -------------------------------------
install_package()
{
    refresh_pacman
    if [[ "$USE_PACMAN" -eq 1 ]]; then
        print_info "INSTALL-PACKAGE-INSTALLING" ": $2"
        if ! package_install "$1" "$2" ; then
            IS_ERROR=1
            write_error   "INSTALL-PACKAGE-ERROR" ": [$1] $(localize "INSTALL-PACKAGE-ERROR-2") $2 - $(basename $BASH_SOURCE) : $LINENO"
            print_warning "INSTALL-PACKAGE-ERROR" ": [$1] $(localize "INSTALL-PACKAGE-ERROR-2") $2 - $(basename $BASH_SOURCE) : $LINENO"
            if [[ "$DEBUGGING" -eq 1 ]]; then pause_function "install_package @ $(basename $BASH_SOURCE) : $LINENO"; fi
        fi
        # pacman -S --noconfirm --needed "$1"
    else
        print_info "INSTALL-PACKAGE-INSTALL-PM2ML" ": $2"
        # ppls "$1"
        # Arguments for aria2c.
        aria2_args=( "--metalink-file=-"  "--conf-path=/etc/ppl.conf" )
        # download packages
        pm2ml -no /var/cache/pacman/pkg "$1" -r -p http -l 50 | aria2c "${aria2_args[@]}"        
        # invoke pacman
        if [[ "$RUNTIME_MODE" -eq 1 ]]; then
            pacman -S --noconfirm --needed "$1" # If running from Boot Mode; you don't want to upgrade the system
        else
            pacman -Su --noconfirm --needed "$1"
        fi
    fi
    IS_ERROR=0
    for PACKAGE in $1; do
        if ! check_package "$PACKAGE" ; then
            IS_ERROR=1
            write_error   "INSTALL-PACKAGE-ERROR" ": [$1] $(localize "INSTALL-PACKAGE-ERROR-2") $2 - $(basename $BASH_SOURCE) : $LINENO"
            print_warning "INSTALL-PACKAGE-ERROR" ": [$1] $(localize "INSTALL-PACKAGE-ERROR-2") $2 - $(basename $BASH_SOURCE) : $LINENO"
            if [[ "$DEBUGGING" -eq 1 ]]; then pause_function "install_package @ $(basename $BASH_SOURCE) : $LINENO"; fi
        fi        
    done    
    if [[ "$IS_ERROR" -eq 1 ]]; then
        if [[ "$DEBUGGING" -eq 1 ]]; then pause_function "install_package @ $(basename $BASH_SOURCE) : $LINENO"; fi
        return 1
    fi
    return 0
}
#}}}
# -----------------------------------------------------------------------------
# PACKAGE INSTALL {{{
NAME="package_install"
USAGE=$(localize "PACKAGE-INSTALL-USAGE")
DESCRIPTION=$(localize "PACKAGE-INSTALL-DESC")
NOTES=$(localize "PACKAGE-INSTALL-NOTES")
AUTHOR="helmuthdu and Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "PACKAGE-INSTALL-USAGE" "package_install 1->(SPACE DELIMITED LIST OF PACKAGES TO INSTALL) 2->(NAME-OF-PACKAGE-MANAGER)"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "PACKAGE-INSTALL-DESC"  "Install package from core or additional Repositories."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "PACKAGE-INSTALL-NOTES" "Install one at a time, check to see if already install, if fails, try again with with confirm."
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "PACKAGE-INSTALL-ERROR"            "pacman did not install Package"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "PACKAGE-INSTALL-FAILED-INTERNET"  "Internet check failed"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "PACKAGE-INSTALL-PACKAGE-MANAGER"  "for Package Manager"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "PACKAGE-INSTALL-REFRESH"          "Refreshing pacman Database and Updates..."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "PACKAGE-INSTALL-COMPLETE"         "Package Manager Completed"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "PACKAGE-INSTALL-FAILURES"         "Installed"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "PACKAGE-INSTALL-PACKAGES"         "Packages"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "PACKAGE-INSTALL-FAILED"           "Failed"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "PACKAGE-INSTALL-INSTALLED"        "Installed"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "PACKAGE-INSTALL-RETRY"            "Retry"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "PACKAGE-INSTALL-PACKAGE"          "install package"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "PACKAGE-INSTALL-MANUAL"           "with Manual intervention."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "PACKAGE-INSTALL-CURRENTLY"        "currently working on"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "PACKAGE-INSTALL-RETRIES"          "Retries"
# -------------------------------------
package_install()
{
    refresh_pacman
    if [[ "$USE_PACMAN" -eq 0 ]]; then
        # This is all done in Parallel; whereas below runs once install at a time
        if ! install_package "$1" "$2" "PACKAGE-INSTALL-$2" ; then
            if [[ "$INSTALL_NO_INTERNET" -eq 0 ]]; then
                if ! is_internet ; then
                    restart_internet
                    sleep 13
                    if ! is_internet ; then
                        failed_install_core "$PACKAGE"
                        write_error   "PACKAGE-INSTALL-ERROR" ": $PACKAGE - $(localize "PACKAGE-INSTALL-PACKAGE-MANAGER") $2 - $(localize "PACKAGE-INSTALL-FAILED-INTERNET") - USE_PACMAN=$USE_PACMAN - $(basename $BASH_SOURCE) : $LINENO"
                        print_warning "PACKAGE-INSTALL-ERROR" ": $PACKAGE - $(localize "PACKAGE-INSTALL-PACKAGE-MANAGER") $2 - $(localize "PACKAGE-INSTALL-FAILED-INTERNET") - USE_PACMAN=$USE_PACMAN - $(basename $BASH_SOURCE) : $LINENO"
                        if [[ "$DEBUGGING" -eq 1 ]]; then pause_function "package_install @ $(basename $BASH_SOURCE) : $LINENO"; fi
                        # @FIX what to do now: restart network adapter
                        abort_install
                    else
                        print_this "PACKAGE-INSTALL-REFRESH"
                        pacman -Syu
                    fi
                fi
            fi             
            print_this " " "${BRed} $(localize "PACKAGE-INSTALL-RETRY") ${BWhite}  $(localize "PACKAGE-INSTALL-PACKAGE") $PACKAGE $(localize "PACKAGE-INSTALL-PACKAGE-MANAGER") $2 $(localize "PACKAGE-INSTALL-MANUAL")"
            if ! install_package "$1" "$2" "PACKAGE-INSTALL-$2" ; then
                failed_install_core "$PACKAGE"
                write_error   "PACKAGE-INSTALL-ERROR" ": $PACKAGE - $(localize "PACKAGE-INSTALL-PACKAGE-MANAGER") $2 - $(localize "PACKAGE-INSTALL-FAILED-INTERNET") - USE_PACMAN=$USE_PACMAN - $(basename $BASH_SOURCE) : $LINENO"
                print_warning "PACKAGE-INSTALL-ERROR" ": $PACKAGE - $(localize "PACKAGE-INSTALL-PACKAGE-MANAGER") $2 - $(localize "PACKAGE-INSTALL-FAILED-INTERNET") - USE_PACMAN=$USE_PACMAN - $(basename $BASH_SOURCE) : $LINENO"
                if [[ "$DEBUGGING" -eq 1 ]]; then pause_function "package_install @ $(basename $BASH_SOURCE) : $LINENO"; fi
                return 1           
            fi            
        fi
        print_this "PACKAGE-INSTALL-COMPLETE" ": $2"
        return 0
    fi
    # install packages one at a time using pacman to check if package is already loaded.
    local -i retry_times=0
    local -i total_packages=$(echo "$1" | wc -w)
    local -i number_installed=0
    local -i number_failed=0
    local -i current=0
    #    
    for PACKAGE in $1; do
        if ! check_package "$PACKAGE" ; then
            print_info "Installing Package $PACKAGE for Package Manager $2 -> currently working on $current of $total_packages packages, with $number_installed installs and $number_failed failures -> retry times = ${retry_times}."
            pacman -S --noconfirm --needed "$PACKAGE"
             # some packages do not register, i.e. mate and mate-extras, so this is a work around; so you do not get stuck in a loop @FIX make a list
            if ! check_package "$PACKAGE" ; then
                print_this " " "${BRed} $(localize "PACKAGE-INSTALL-RETRY") ${BWhite}  $(localize "PACKAGE-INSTALL-PACKAGE") $PACKAGE $(localize "PACKAGE-INSTALL-PACKAGE-MANAGER") $2"
                print_this "PACKAGE-INSTALL-REFRESH"
                pacman -Syu
                pacman -S --noconfirm --needed --force "$PACKAGE" # Install with the force
                if ! check_package "$PACKAGE" ; then
                    if is_in_array "PACKAGE_CHECK_FAILURES[@]" "$PACKAGE" ; then
                        failed_install_core "$PACKAGE"
                        write_error   "PACKAGE-INSTALL-ERROR" ": $PACKAGE - $(localize "PACKAGE-INSTALL-PACKAGE-MANAGER") $2 - USE_PACMAN=$USE_PACMAN - $(basename $BASH_SOURCE) : $LINENO"
                        print_warning "PACKAGE-INSTALL-ERROR" ": $PACKAGE - $(localize "PACKAGE-INSTALL-PACKAGE-MANAGER") $2 - USE_PACMAN=$USE_PACMAN - $(basename $BASH_SOURCE) : $LINENO"
                        if [[ "$DEBUGGING" -eq 1 ]]; then pause_function "package_install @ $(basename $BASH_SOURCE) : $LINENO"; fi
                    else
                        if [[ "$INSTALL_NO_INTERNET" -eq 0 ]]; then
                            if ! is_internet ; then
                                restart_internet
                                sleep 13
                                if ! is_internet ; then
                                    failed_install_core "$PACKAGE"
                                    write_error   "PACKAGE-INSTALL-ERROR" ": $PACKAGE - $(localize "PACKAGE-INSTALL-PACKAGE-MANAGER") $2 - $(localize "PACKAGE-INSTALL-FAILED-INTERNET") - USE_PACMAN=$USE_PACMAN - $(basename $BASH_SOURCE) : $LINENO"
                                    print_warning "PACKAGE-INSTALL-ERROR" ": $PACKAGE - $(localize "PACKAGE-INSTALL-PACKAGE-MANAGER") $2 - $(localize "PACKAGE-INSTALL-FAILED-INTERNET") - USE_PACMAN=$USE_PACMAN - $(basename $BASH_SOURCE) : $LINENO"
                                    if [[ "$DEBUGGING" -eq 1 ]]; then pause_function "package_install @ $(basename $BASH_SOURCE) : $LINENO"; fi
                                    # @FIX what to do now: restart network adapter
                                    abort_install
                                else
                                    print_this "Refreshing pacman Database and Updates..."
                                    pacman -Syu
                                fi
                            fi
                        fi             
                        print_this " " "${BRed} $(localize "PACKAGE-INSTALL-RETRY") ${BWhite}  $(localize "PACKAGE-INSTALL-PACKAGE") $PACKAGE $(localize "PACKAGE-INSTALL-PACKAGE-MANAGER") $2 $(localize "PACKAGE-INSTALL-MANUAL") $(localize "PACKAGE-INSTALL-CURRENTLY") $current -> $total_packages - $(localize "PACKAGE-INSTALL-PACKAGES") -> $(localize "PACKAGE-INSTALL-RETRIES") = ${retry_times}"
                        pacman -S --needed "$PACKAGE" # Install with Manual Interaction
                        # Last try     
                        if ! check_package "$PACKAGE" ; then
                            failed_install_core "$PACKAGE"
                            write_error   "PACKAGE-INSTALL-ERROR" ": $PACKAGE - $(localize "PACKAGE-INSTALL-PACKAGE-MANAGER") $2 - USE_PACMAN=$USE_PACMAN - $(basename $BASH_SOURCE) : $LINENO"
                            print_warning "PACKAGE-INSTALL-ERROR" ": $PACKAGE - $(localize "PACKAGE-INSTALL-PACKAGE-MANAGER") $2 - USE_PACMAN=$USE_PACMAN - $(basename $BASH_SOURCE) : $LINENO"
                            if [[ "$DEBUGGING" -eq 1 ]]; then pause_function "package_install @ $(basename $BASH_SOURCE) : $LINENO"; fi
                        else
                            installed_core "$PACKAGE"
                            ((number_installed++))
                        fi
                    fi
                else
                    installed_core "$PACKAGE"
                    ((number_installed++))
                fi
            else
                installed_core "$PACKAGE"
                ((number_installed++))
            fi
        else
            installed_core "$PACKAGE" # Already Installed
                ((number_installed++))
        fi
    done
    print_this "PACKAGE-INSTALL-COMPLETE" ": $2"
    if [[ "$number_installed" -eq "$total_packages" ]]; then
        return 0
    else
        print_warning "PACKAGE-INSTALL-FAILURES" ": $total_packages - $(localize "PACKAGE-INSTALL-PACKAGES"), $number_failed $(localize "PACKAGE-INSTALL-FAILED"), $number_installed $(localize "PACKAGE-INSTALL-INSTALLED") - $(basename $BASH_SOURCE) : $LINENO"
        write_error   "PACKAGE-INSTALL-FAILURES" ": $total_packages - $(localize "PACKAGE-INSTALL-PACKAGES"), $number_failed $(localize "PACKAGE-INSTALL-FAILED"), $number_installed $(localize "PACKAGE-INSTALL-INSTALLED") - $(basename $BASH_SOURCE) : $LINENO"
        if [[ "$DEBUGGING" -eq 1 ]]; then pause_function "package_install @ $(basename $BASH_SOURCE) : $LINENO"; fi
        return 1
    fi
} 
#}}}
# -----------------------------------------------------------------------------
# PACKAGE REMOVE {{{
NAME="package_remove"
USAGE="PACKAGE-REMOVE-USAGE"
DESCRIPTION=$(localize "PACKAGE-REMOVE-DESC")
NOTES=$(localize "NONE")
AUTHOR="helmuthdu and Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "PACKAGE-REMOVE-USAGE" "package_remove 1->(SPACE DELIMITED LIST OF PACKAGES TO REMOVE) 2->(NAME-OF-PACKAGE-MANAGER)"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "PACKAGE-REMOVE-DESC"  "Package remove"
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "PACKAGE-REMOVE-INFO"  "Removing package"
# -------------------------------------
package_remove()
{
    refresh_pacman
    for PACKAGE in $1; do
        if check_package "$PACKAGE" ; then
            print_info "PACKAGE-REMOVE-INFO" ": $PACKAGE"
            # pacman -Rcsn --noconfirm "$PACKAGE" # This operation is recursive, and must be used with care since it can remove many potentially needed packages.
            pacman -Rddn --noconfirm "$PACKAGE" # We wish to remove some apps that will be replace with ones that replace it, so do not remove dependencies.
        fi
    done
} 
#}}}
# -----------------------------------------------------------------------------
# AUR DOWNLOAD {{{
NAME="aur_download"
USAGE="aur_download 1->(Package Name)"
DESCRIPTION=$(localize "AUR-DOWNLOAD-DESC")
NOTES=$(localize "AUR-DOWNLOAD-NOTES")
AUTHOR="helmuthdu and Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "AUR-DOWNLOAD-DESC"  "AUR Download Packages"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "AUR-DOWNLOAD-NOTES" "&#36;AUR_CUSTOM_PACKAGES: if Boot Mode /root/usb/AUR-Packages, if Live Mode /mnt/AUR-Packages"
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "AUR-DOWNLOAD-DOWNLOADING-AUR-PACKAGE" "Downloading AUR Package"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "AUR-DOWNLOAD-FILE-EXIST"              "File Exist, check date of file"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "AUR-DOWNLOAD-DOWNLOADING"             "Downloading:"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "AUR-DOWNLOAD-PACKAGE-UP2DATE"         "Up to date Package"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "AUR-DOWNLOAD-FILE-CORRUPTED"          "File Corrupted:"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "AUR-DOWNLOAD-FILE-NOT-FOUND"          "File Not Found"
# -------------------------------------
aur_download()
{ 
    local -i IsFileNew=0
    print_info "AUR-DOWNLOAD-DOWNLOADING-AUR-PACKAGE" " $1"
    cd "$AUR_CUSTOM_PACKAGES/"
    if [ -f "${1}.tar.gz" ]; then
        print_this "AUR-DOWNLOAD-FILE-EXIST" " ${1}" # @FIX check date
        IsFileNew=0
        # curl -z 21-Dec-11 http://www.example.com/yy.html        
        # -z "$(date —rfc-2822 -d @$(<index.html.timestamp))"
        # @FIX will it rename on download, since file exist
        # curl -z "${1}.tar.gz" -o "${1}.tar.gz" "https://aur.archlinux.org/packages/${1:0:2}/${1}/${1}.tar.gz"
    else
        print_this "AUR-DOWNLOAD-DOWNLOADING" " $1.tar.gz from https://aur.archlinux.org/packages/${1:0:2}/$1/$1.tar.gz"
        curl -o "${1}.tar.gz" "https://aur.archlinux.org/packages/${1:0:2}/${1}/${1}.tar.gz"
        IsFileNew=1
    fi
    #
    if [ -f "${1}.tar.gz" ]; then
        if [[ -d "$1" && IsFileNew -eq 0 ]]; then
            print_this "AUR-DOWNLOAD-PACKAGE-UP2DATE" " $1"
            # @FIX check for compliled code
            return 2
        else
            if tar zxvf "$1.tar.gz" ; then
                if [[ "$AUR_REPO" -ne 1 ]]; then # AUR Repo 
                    rm "${1}.tar.gz"
                fi
                chown -R "${USERNAME}:${USERNAME}" "$AUR_CUSTOM_PACKAGES/${1}" 
                chmod -R 775 "$AUR_CUSTOM_PACKAGES/${1}"
                cd "${1}"
                return 0
            else
                write_error "AUR-DOWNLOAD-FILE-CORRUPTED" " curl -o ${1}.tar.gz https://aur.archlinux.org/packages/${1:0:2}/${1}/${1}.tar.gz - $(basename $BASH_SOURCE) : $LINENO"
                if [[ "$DEBUGGING" -eq 1 ]]; then 
                    print_this     "AUR-DOWNLOAD-FILE-CORRUPTED" " curl -o ${1}.tar.gz https://aur.archlinux.org/1/${1:0:2}/${1}/${1}.tar.gz - $(basename $BASH_SOURCE) : $LINENO"
                    pause_function "aur_download ${1} $(basename $BASH_SOURCE) : $LINENO"
                fi
                return 1
            fi
        fi           
    else
        write_error "AUR-DOWNLOAD-FILE-NOT-FOUND" " curl -o ${1}.tar.gz https://aur.archlinux.org/packages/${1:0:2}/${1}/${1}.tar.gz - $(basename $BASH_SOURCE) : $LINENO"
        if [[ "$DEBUGGING" -eq 1 ]]; then 
            print_this     "AUR-DOWNLOAD-FILE-NOT-FOUND" " curl -o ${1}.tar.gz https://aur.archlinux.org/packages/${1:0:2}/${1}/${1}.tar.gz - $(basename $BASH_SOURCE) : $LINENO"
            pause_function "aur_download ${1} - $(basename $BASH_SOURCE) : $LINENO"
        fi
        return 1
    fi
    return 1
} 
#}}}
# -----------------------------------------------------------------------------
# GET AUR PACKAGES {{{
NAME="get_aur_packages"
USAGE="get_aur_packages 1->(package-name) 2->(&#36;DEBUGGING) 3->(&#36;AUR_REPO)"
DESCRIPTION=$(localize "GET-AUR-PACKAGES-DESC")
NOTES=$(localize "GET-AUR-PACKAGES-NOTES")
AUTHOR="helmuthdu and Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-AUR-PACKAGES-DESC"  "Get AUR packages"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-AUR-PACKAGES-NOTES" "Called from export under user, so script functions not available, cd folder before calling"
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "WRONG-NUMBER-OF-ARGUMENTS" "Wrong Number of Arguments"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-AUR-PACKAGES-COMPILING"        "Compiling Package"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-AUR-PACKAGES-FAILED-COMPILING" "Failed to compile"
# -------------------------------------
get_aur_packages()
{ 
    local White='\e[0;37m'  # White
    local BWhite='\e[1;37m' # Bold White
    local BRed='\e[1;31m'   # Red
    #
    if [ "$#" -ne "3" ]; then echo -e "${BRed} get_aur_packages $(gettext -s "WRONG-NUMBER-OF-ARGUMENTS") ${White}"; fi
    local parms="-s"
    if [[ "$3" -eq 1 ]]; then # AUR Repo 
        parms="-s"
    else                      # No Repo
        parms="-si"           # Install
    fi
    echo -e "${BWhite}\t $(gettext -s "GET-AUR-PACKAGES-COMPILING") ${1} makepkg ${parms} --noconfirm in function: get_aur_packages at line: $(basename $BASH_SOURCE) : $LINENO ${White}"
    cd "${1}"
    if ! makepkg ${parms} --noconfirm ; then
        if [[ "$2" -eq 1 ]]; then # DEBUGGING
            echo -e "${BRed}\t${1} $(gettext -s "GET-AUR-PACKAGES-FAILED-COMPILING") makepkg ${parms} --noconfirm in function: get_aur_packages at line: $(basename $BASH_SOURCE) : $LINENO ${White}"
            read -e -sn 1 -p "$(gettext -s "PRESS-ANY-KEY-CONTINUE") (get_aur_packages ${1})..."
        fi
        return 1
    fi
    return 0
        
    #
    echo -e "${BWhite}\t $(gettext -s "GET-AUR-PACKAGES-COMPILING") ${1} makepkg ${parms} --noconfirm in function: get_aur_packages at line: $(basename $BASH_SOURCE) : $LINENO ${White}"
    cd "${1}"
    if [[ "$3" -eq 1 ]]; then # AUR Repo 
        if ! makepkg -s --noconfirm ; then
            if [[ "$2" -eq 1 ]]; then # DEBUGGING
                echo -e "${BRed}\t${1} $(gettext -s "GET-AUR-PACKAGES-FAILED-COMPILING") makepkg ${parms} --noconfirm in function: get_aur_packages at line: $(basename $BASH_SOURCE) : $LINENO ${White}"
                read -e -sn 1 -p "$(gettext -s "PRESS-ANY-KEY-CONTINUE") (get_aur_packages ${1})..."
            fi
            return 1
        fi
    else                      # No Repo
        if ! makepkg -si --noconfirm ; then
            if [[ "$2" -eq 1 ]]; then # DEBUGGING
                echo -e "${BRed}\t${1} $(gettext -s "GET-AUR-PACKAGES-FAILED-COMPILING") makepkg ${parms} --noconfirm in function: get_aur_packages at line: $(basename $BASH_SOURCE) : $LINENO ${White}"
                read -e -sn 1 -p "$(gettext -s "PRESS-ANY-KEY-CONTINUE") (get_aur_packages ${1})..."
            fi
            return 1
        fi
    fi
    return 0
}
#}}}
# -----------------------------------------------------------------------------
#
export -f get_aur_packages # need to export so if we are running as user it will find it
#
# AUR DOWNLOAD PACKAGES {{{
NAME="aur_download_packages"
USAGE="aur_download_packages 1->(Package Names Space Delimited)"
DESCRIPTION=$(localize "AUR-DOWNLOAD-PACKAGES-DESC")
NOTES=$(localize "AUR-DOWNLOAD-PACKAGES-NOTES")
AUTHOR="helmuthdu and Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "AUR-DOWNLOAD-PACKAGES-DESC"  "AUR Download Packages"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "AUR-DOWNLOAD-PACKAGES-NOTES" "AUR_CUSTOM_PACKAGES: if Boot Mode /root/usb/AUR-Packages, if Live Mode /mnt/AUR-Packages"
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "AUR-DOWNLOAD-PACKAGES-TITLE" "AUR Package Downloader."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "AUR-DOWNLOAD-PACKAGES-WARN-CREATE-FOLDER" "Could not create folder "
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "AUR-DOWNLOAD-PACKAGES-WORKING-ON" "Working on Package "
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "AUR-DOWNLOAD-PACKAGES-RETRIES" "retries"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "AUR-DOWNLOAD-PACKAGES-FAILED-DOWNLOAD" "Failed Downloading AUR Package"
# -------------------------------------
aur_download_packages()
{ 
    AUR_CUSTOM_PACKAGES="/home/${USERNAME}/${AUR_REPO_NAME}" # if Boot Mode /root/usb/AUR-Packages, if Live Mode /mnt/AUR-Packages
    #
    print_info "AUR-DOWNLOAD-PACKAGES-TITLE"
    local FUN_RETURN=0    
    local -i retries=0
    for PACKAGE in $1; do
        if [ ! -d "$AUR_CUSTOM_PACKAGES/" ]; then
            if ! make_dir "$AUR_CUSTOM_PACKAGES/" "$(basename $BASH_SOURCE) : $LINENO" ; then
                print_warning  "AUR-DOWNLOAD-PACKAGES-WARN-CREATE-FOLDER" "$AUR_CUSTOM_PACKAGES"
                pause_function "aur_download_packages $(basename $BASH_SOURCE) : $LINENO"
                cd "$FULL_SCRIPT_PATH"
                return 1
            fi
            chmod -R 770 "$AUR_CUSTOM_PACKAGES/${1}"
        fi
        retries=0 # Reset
        YN_OPTION=0
        while [[ "$YN_OPTION" -ne 1 ]]; do
            print_info "AUR-DOWNLOAD-PACKAGES-WORKING-ON" "$PACKAGE $(localize "AUR-DOWNLOAD-PACKAGES-RETRIES") = $retries"
            aur_download "$PACKAGE"
            FUN_RETURN="$?"
            if [[ "$FUN_RETURN" == 0 ]]; then
                cd "$AUR_CUSTOM_PACKAGES/"
                chown -R "${USERNAME}:${USERNAME}" "$AUR_CUSTOM_PACKAGES/" 
                # exec command as user instead of root
                su "${USERNAME}" -c "get_aur_packages \"$PACKAGE\" \"$DEBUGGING\" \"$AUR_REPO\"" # Run as User
                FUN_RETURN="$?"
                YN_OPTION=1
            fi
            if [[ "$retries" -gt 3 ]]; then
                YN_OPTION=1
                write_error   "AUR-DOWNLOAD-PACKAGES-FAILED-DOWNLOAD" " $PACKAGE - $(basename $BASH_SOURCE) : $LINENO"
                print_warning "AUR-DOWNLOAD-PACKAGES-FAILED-DOWNLOAD" " $PACKAGE - $(basename $BASH_SOURCE) : $LINENO"
                if [[ "$DEBUGGING" -eq 1 ]]; then pause_function "aur_download_packages @ $(basename $BASH_SOURCE) : $LINENO"; fi
            fi
            ((retries++))
            #
            if [[ "$DEBUGGING" -eq 1 ]]; then pause_function "aur_download_packages $PACKAGE $(localize "AUR-DOWNLOAD-PACKAGES-RETRIES") = $retries @ $(basename $BASH_SOURCE) : $LINENO"; fi            
        done
        #
    done
    cd "$FULL_SCRIPT_PATH"
    return "$FUN_RETURN"
} 
#}}}
# -----------------------------------------------------------------------------
# INSTALL DOWNLOAD {{{
NAME="install_download"
USAGE=$(localize "INSTALL-DOWNLOAD-USAGE")
DESCRIPTION=$(localize "INSTALL-DOWNLOAD-DESC")
NOTES=$(localize "INSTALL-DOWNLOAD-NOTES")
AUTHOR="helmuthdu and Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "INSTALL-DOWNLOAD-USAGE" "install_download 1->(PACKAGE FROM AUR) 2->(Args: NoConfirm, Force)"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "INSTALL-DOWNLOAD-DESC"  "Install AUR Package using AUR_HELPER"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "INSTALL-DOWNLOAD-NOTES" "Called from add_packagemanager, run in Live Mode: Install one at a time, check to see if its already installed, if fail, try again with confirm.<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: --needed --recursive --force --upgrades"
# -------------------------------------
install_download()
{
    if [[ "$AUR_REPO" -eq 1 ]]; then
        # package-name-1.0.1-1-x86_64.pkg.tar.xz
        pacman --needed -U "${AUR_CUSTOM_PACKAGES}/${1}/${1}-"*.pkg.tar.xz 
    else
        su - "${USERNAME}" -c "$AUR_HELPER $2 --needed -S $1" # Run as User
    fi
}
#}}}
# -----------------------------------------------------------------------------
# AUR PACKAGE INSTALL {{{
NAME="aur_package_install"
USAGE=$(localize "AUR-PACKAGE-INSTALL-USAGE")
DESCRIPTION=$(localize "AUR-PACKAGE-INSTALL-DESC")
NOTES=$(localize "AUR-PACKAGE-INSTALL-NOTES")
#            : --needed --recursive --force --upgrades
AUTHOR="helmuthdu and Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "AUR-PACKAGE-INSTALL-USAGE" "aur_package_install 1->(SPACE DELIMITED LIST OF PACKAGES TO INSTALL FROM AUR) 2->(NAME-OF-PACKAGE-MANAGER)"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "AUR-PACKAGE-INSTALL-DESC"  "Install AUR Package using AUR_HELPER"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "AUR-PACKAGE-INSTALL-NOTES" "Called from add_packagemanager, run in Live Mode: Install one at a time, check to see if its already installed, if fail, try again with confirm."
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "AUR-PACKAGE-INSTALL-WORKING-ON"     "AUR Package Install"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "AUR-PACKAGE-INSTALL-CURRENTLY"      "currently Working on"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "AUR-PACKAGE-INSTALL-OF"             "of"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "AUR-PACKAGE-INSTALL-PACKAGES"       "packages"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "AUR-PACKAGE-INSTALL-INSTALLED"      "Installed"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "AUR-PACKAGE-INSTALL-FAIL"           "Fails"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "AUR-PACKAGE-INSTALL-RETRIES"        "retries"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "AUR-PACKAGE-INSTALL-REFRESH"        "Refreshing"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "AUR-PACKAGE-INSTALL-ERROR-1"        "Error: Did not install AUR Package"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "AUR-PACKAGE-INSTALL-ERROR-2"        "Package Manager"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "AUR-PACKAGE-INSTALL-INTERNET"       "Internet check failed."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "AUR-PACKAGE-INSTALL-UPDATE"         "Updating"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "AUR-PACKAGE-INSTALL-NOT-INSTALLED"  "Package(s) Not Installed"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "AUR-PACKAGE-INSTALL-COMPLETE"       "AUR Package Manager Completed"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "AUR-PACKAGE-INSTALL-TRY-AGAIN"      "Try install again" 
# -------------------------------------
aur_package_install()
{
    if [[ "$REFRESH_AUR" -eq 1 ]]; then
        REFRESH_AUR=0
        su - "${USERNAME}" -c "$AUR_HELPER --noconfirm -Syu" # Run as User
    fi
    local -i retry_times=0
    local -i total_packages=$(echo "$1" | wc -w)
    local -i number_installed=0
    local -i number_failed=0
    local -i current=0
    # install package from aur
    for PACKAGE in $1; do
        ((current++))
        if ! check_package "$PACKAGE" ; then
            AUR_CONFIRM="--noconfirm"
            retry_times=0
            YN_OPTION=1
            while [[ "$YN_OPTION" -ne 0 ]]; do
                print_this "AUR-PACKAGE-INSTALL-WORKING-ON" ": $AUR_HELPER $PACKAGE $(localize "AUR-PACKAGE-INSTALL-CURRENTLY") $current $(localize "AUR-PACKAGE-INSTALL-OF") $total_packages $(localize "AUR-PACKAGE-INSTALL-PACKAGES"), $(localize "AUR-PACKAGE-INSTALL-INSTALLED") $number_installed - $(localize "AUR-PACKAGE-INSTALL-FAILS") $number_failed -> $(localize "AUR-PACKAGE-INSTALL-RETRIES") = ${retry_times}."
                install_download "${PACKAGE}" "$AUR_CONFIRM"
                # check if the package was not installed
                # some packages do not register, i.e. mate and mate-extras, so this is a work around; so you do not get stuck in a loop @FIX make a list
                if ! check_package "$PACKAGE" ; then
                    print_warning "AUR-PACKAGE-INSTALL-REFRESH" ": $AUR_HELPER $PACKAGE $(localize "AUR-PACKAGE-INSTALL-CURRENTLY") $current $(localize "AUR-PACKAGE-INSTALL-OF") $total_packages $(localize "AUR-PACKAGE-INSTALL-PACKAGES"), $(localize "AUR-PACKAGE-INSTALL-INSTALLED") $number_installed - $(localize "AUR-PACKAGE-INSTALL-FAILS") $number_failed -> $(localize "AUR-PACKAGE-INSTALL-RETRIES") = ${retry_times}."
                    $AUR_HELPER -Syu
                    # Manual Intervention may resolve this issue
                    install_download "${PACKAGE}" "$AUR_CONFIRM --force"
                    if ! check_package "$PACKAGE" ; then
                        if is_in_array "PACKAGE_CHECK_FAILURES[@]" "$PACKAGE" ; then
                            # @FIX try to find solution to why this is happening and put it here
                            if [[ "$INSTALL_NO_INTERNET" -eq 0 ]]; then
                                if ! is_internet ; then
                                   restart_internet
                                   sleep 13
                                   if ! is_internet ; then
                                       failed_install_core "$PACKAGE"
                                       write_error   "AUR-PACKAGE-INSTALL-ERROR-1" ": $AUR_HELPER - $PACKAGE - $(localize "AUR-PACKAGE-INSTALL-ERROR-2"): $2 - $(localize "AUR-PACKAGE-INSTALL-INTERNET") - $(basename $BASH_SOURCE) : $LINENO"
                                       print_warning "AUR-PACKAGE-INSTALL-ERROR-1" ": $AUR_HELPER - $PACKAGE - $(localize "AUR-PACKAGE-INSTALL-ERROR-2"): $2 - $(localize "AUR-PACKAGE-INSTALL-INTERNET") - $(basename $BASH_SOURCE) : $LINENO"
                                       if [[ "$DEBUGGING" -eq 1 ]]; then pause_function "aur_package_install @ $(basename $BASH_SOURCE) : $LINENO"; fi
                                       # @FIX what to do now
                                       abort_install
                                   fi
                               fi             
                           fi
                           print_this "AUR-PACKAGE-INSTALL-REFRESH" " - $(localize "AUR-PACKAGE-INSTALL-UPDATE"): $AUR_HELPER $PACKAGE $(localize "AUR-PACKAGE-INSTALL-CURRENTLY") $current $(localize "AUR-PACKAGE-INSTALL-OF") $total_packages $(localize "AUR-PACKAGE-INSTALL-PACKAGES"), $(localize "AUR-PACKAGE-INSTALL-INSTALLED") $number_installed - $(localize "AUR-PACKAGE-INSTALL-FAILS") $number_failed -> $(localize "AUR-PACKAGE-INSTALL-RETRIES") = ${retry_times}."
                           su "${USERNAME}" -c "$AUR_HELPER --noconfirm -Syu" # Run as User
                           # Force install
                           install_download "${PACKAGE}" "$AUR_CONFIRM --force"
                           if ! check_package "$PACKAGE" ; then
                               print_info "AUR-PACKAGE-INSTALL-NOT-INSTALLED" ": $PACKAGE -> $2"
                               if [[ "$retry_times" -ge 1 ]]; then
                                   read_input_yn "AUR-PACKAGE-INSTALL-TRY-AGAIN" " " 0
                               else
                                   read_input_yn "AUR-PACKAGE-INSTALL-TRY-AGAIN" " " 1
                               fi
                               if [[ "$YN_OPTION" -eq 0 ]]; then
                                   failed_install_aur "$PACKAGE"
                               fi
                           else
                               installed_aur "$PACKAGE"
                               ((number_installed++)) # increment number installed
                               YN_OPTION=0 # Exit Loop
                           fi
                        else
                           # @FIX we don't know if its installed or not; this happens, its a bug
                           ((number_failed++)) # increment number installed
                           YN_OPTION=0 # Exit Loop
                        fi
                    else
                        installed_aur "$PACKAGE"
                        ((number_installed++)) # increment number installed
                        YN_OPTION=0 # Exit Loop
                    fi
                    # Manual Intervention may resolve this issue
                    AUR_CONFIRM=" "
                    ((retry_times++))
                    #sleep 30
                    #if [[ "$((retry_times))" -gt 3 ]]; then
                    #    write_error "$AUR_HELPER did not install package $PACKAGE" "$(basename $BASH_SOURCE) : $LINENO"
                    #    print_warning "$AUR_HELPER did not install package $PACKAGE; Retrying $retry_times of 3 times."
                    #    YN_OPTION=0
                    #fi
                else
                    installed_aur "$PACKAGE"
                    ((number_installed++)) # increment number installed
                    YN_OPTION=0 # Exit Loop
                fi
            done
        else
            installed_aur "$PACKAGE"
            ((number_installed++)) # increment number installed
        fi
    done
    echo "AUR-PACKAGE-INSTALL-COMPLETE" ": $2"
    if [[ "$number_installed" -eq "$total_packages" ]]; then
        return 0
    else
        print_warning "AUR-PACKAGE-INSTALL-WORKING-ON" " - $AUR_HELPER - $total_packages $(localize "AUR-PACKAGE-INSTALL-PACKAGES"), $(localize "AUR-PACKAGE-INSTALL-INSTALLED") $number_installed - $(localize "AUR-PACKAGE-INSTALL-FAILS") $number_failed @ $(basename $BASH_SOURCE) : $LINENO"
        write_error   "AUR-PACKAGE-INSTALL-WORKING-ON" " - $AUR_HELPER - $total_packages $(localize "AUR-PACKAGE-INSTALL-PACKAGES"), $(localize "AUR-PACKAGE-INSTALL-INSTALLED") $number_installed - $(localize "AUR-PACKAGE-INSTALL-FAILS") $number_failed @ $(basename $BASH_SOURCE) : $LINENO"
        if [[ "$DEBUGGING" -eq 1 ]]; then pause_function "aur_package_install @ $(basename $BASH_SOURCE) : $LINENO"; fi
        return 1
    fi
} 
#}}}
# -----------------------------------------------------------------------------
# PACKMAN PACKAGE SIGNING {{{
NAME="configure_pacman_package_signing"
USAGE="configure_pacman_package_signing"
DESCRIPTION=$(localize "PACKMAN-PACKAGE-SIGNING-DESC")
NOTES=$(localize "NONE")
AUTHOR="helmuthdu and Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "PACKMAN-PACKAGE-SIGNING-DESC"      "Configure pacman package signing."
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "PACKMAN-PACKAGE-SIGNING-TITLE"     "PACMAN PACKAGE SIGNING"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "PACKMAN-PACKAGE-SIGNING-INFO"      "Pacman-key is a new tool available with pacman 4. It allows the user to manage pacmans list of trusted keys in the new package signing implementation."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "PACKMAN-PACKAGE-SIGNING-COMPLETE"  "Pacman Package Signing Configured"
# -------------------------------------
configure_pacman_package_signing()
{
    if [ ! -d /etc/pacman.d/gnupg ]; then
        print_title "PACKMAN-PACKAGE-SIGNING-TITLE" " - https://wiki.archlinux.org/index.php/Pacman-key"
        print_info  "PACKMAN-PACKAGE-SIGNING-INFO"
        haveged -w 1024 # adding during pacstrap
        pacman-key --init --keyserver pgp.mit.edu
        pacman-key --populate archlinux
        killall haveged
        #package_remove 'haveged' "REMOVE-HAVEGED"
    fi
    print_this "PACKMAN-PACKAGE-SIGNING-COMPLETE"
}
#}}}
# -----------------------------------------------------------------------------
# CONFIG XINITRC {{{
NAME="config_xinitrc"
USAGE="config_xinitrc 1->(module name)"
DESCRIPTION=$(localize "CONFIG-XINITRC-DESC")
NOTES=$(localize "CONFIG-XINITRC-NOTES")
AUTHOR="helmuthdu and Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CONFIG-XINITRC-DESC"  "Edit .xinitrc file for manual start of Desktop"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CONFIG-XINITRC-NOTES" "Info: https://wiki.archlinux.org/index.php/Xinitrc"
# -------------------------------------
config_xinitrc()
{ 
    # create a xinitrc file in home user directory
    # exec gnome-session-cinnamon
    echo $("echo -e \"exec ck-launch-session $1\" >> /home/\${USERNAME}/.xinitrc; chown -R \${USERNAME}:\${USERNAME} /home/\${USERNAME}/.xinitrc")
} 
#}}}
# -----------------------------------------------------------------------------
# CHOOSE AUR HELPER {{{
NAME="choose_aurhelper"
USAGE="choose_aurhelper"
DESCRIPTION=$(localize "CHOOSE-AUR-HELPER-DESC")
NOTES=$(localize "NONE")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CHOOSE-AUR-HELPER-DESC"   "Choose AUR Helper"
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CHOOSE-AUR-HELPER-TITLE"   "AUR HELPER"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CHOOSE-AUR-HELPER-INFO-1"  "AUR Helpers are written to make using the Arch User Repository more comfortable."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CHOOSE-AUR-HELPER-INFO-2"  "YAOURT"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CHOOSE-AUR-HELPER-INFO-3"  "Yaourt (Yet AnOther User Repository Tool) is a community-contributed wrapper for pacman which adds seamless access to the AUR, allowing and automating package compilation and installation from your choice of the thousands of PKGBUILDs in the AUR, in addition to the many thousands of available Arch Linux binary packages."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CHOOSE-AUR-HELPER-INFO-4"  "Yaourt is Recommended."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CHOOSE-AUR-HELPER-INFO-5"  "List of AUR Helpers: yaourt, packer and pacaur."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CHOOSE-AUR-HELPER-INFO-6"  "None of these tools are officially supported by Arch devs."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CHOOSE-AUR-HELPER-SELECT"  "Choose your default AUR helper to install"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "Change-AUR-Helper"         "Do you wish to change the Default Editor" 
# -------------------------------------
choose_aurhelper()
{
    print_title    "CHOOSE-AUR-HELPER-TITLE" " - https://wiki.archlinux.org/index.php/AUR_Helpers"
    print_info    "CHOOSE-AUR-HELPER-INFO-1"
    print_info    "CHOOSE-AUR-HELPER-INFO-2" " - https://wiki.archlinux.org/index.php/Yaourt"
    print_info    "CHOOSE-AUR-HELPER-INFO-3"
    print_info    "CHOOSE-AUR-HELPER-INFO-4"
    print_info    "CHOOSE-AUR-HELPER-INFO-5"
    print_warning "CHOOSE-AUR-HELPER-INFO-6"
    read_input_yn "Change-AUR-Helper" "$AUR_HELPER" 0
    if [[ "$YN_OPTION" -eq 1 ]]; then
        PS3="$prompt1"
        print_info "CHOOSE-AUR-HELPER-SELECT"
        select OPT in "${AUR_HELPERS[@]}"; do
            case "$REPLY" in
                1)
                    AUR_HELPER="yaourt"
                    break
                    ;;
                2)
                    AUR_HELPER="packer"
                    break
                    ;;
                3)
                    AUR_HELPER="pacaur"
                    break
                    ;;
                *)
                    invalid_option "$REPLY"
                    ;;
            esac
        done
    fi
}
#}}}
# -----------------------------------------------------------------------------
# LOAD CUSTOM SOFTWARE {{{
NAME="load_custom_software"
USAGE="load_custom_software"
DESCRIPTION=$(localize "LOAD-CUSTOM-SOFTWARE-DESC")
NOTES=$(localize "LOAD-CUSTOM-SOFTWARE-NOTES")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "LOAD-CUSTOM-SOFTWARE-DESC"  "load custom software"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "LOAD-CUSTOM-SOFTWARE-NOTES" "@FIX write function"
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "LOAD-CUSTOM-SOFTWARE-INFO"  "Edit or review file first."
# -------------------------------------
load_custom_software()
{
    # Hand edited list of software not in Script
    if [[ -f "${CONFIG_PATH}/custom-software-list.txt" ]]; then
        print_info "LOAD-CUSTOM-SOFTWARE-INFO"
        $EDITOR "${CONFIG_PATH}/custom-software-list.txt"
        # @FIX add name section to file
        # Name
        # software-2-install more and-more
        # like load_last-config
        while read line; do 
            add_packagemanager "package_install '$line" "NAME" # @FIX
        done < "${CONFIG_PATH}/custom-software-list.txt"
    else
        echo "No ${CONFIG_PATH}/custom-software-list.txt file found!"
        pause_function "load_custom_software $(basename $BASH_SOURCE) : $LINENO"
    fi
}
#}}}
# -----------------------------------------------------------------------------
# GET MIRRORLIST {{{
NAME="get_mirrorlist"
USAGE=$(localize "GET-MIRRORLIST-USAGE")
DESCRIPTION=$(localize "GET-MIRRORLIST-DESC")
NOTES=$(localize "NONE")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-MIRRORLIST-USAGE" "get_mirrorlist 1->(Country Code)"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-MIRRORLIST-DESC"  "get mirrorlist"
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-MIRRORLIST-DOWNLOADING"  "Downloading pacman Mirror"
# -------------------------------------
get_mirrorlist() 
{
    if [[ "$CUSTOM_MIRRORLIST" -eq 1 && -f "${FULL_SCRIPT_PATH}/mirrorlist" ]]; then
        copy_file "${FULL_SCRIPT_PATH}/mirrorlist" "/etc/pacman.d/mirrorlist" "$(basename $BASH_SOURCE) : $LINENO"
    else
        url="https://www.archlinux.org/mirrorlist/?country=${1}&protocol=http&ip_version=4&use_mirror_status=on"
        print_info "GET-MIRRORLIST-DOWNLOADING" " ${url}..."
        # Backup and replace current mirrorlist file on running OS
        mv -if /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.orig
        # Get latest mirror list and save to tmpfile
        wget -qO- "$url" | sed 's/^#Server/Server/g' > /etc/pacman.d/mirrorlist 
    fi
    return "$?"
}
#}}}
# -----------------------------------------------------------------------------
# CONFIGURE MIRRORLIST {{{
NAME="configure_mirrorlist"
USAGE="configure_mirrorlist"
DESCRIPTION=$(localize "CONFIGURE-MIRRORLIST-DESC")
NOTES=$(localize "NONE")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CONFIGURE-MIRRORLIST-DESC"  "Configure mirrorlist"
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CONFIGURE-MIRRORLIST-FOUND"  "Mirrorlist found on"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CONFIGURE-MIRRORLIST-MIRRORS"  "MIRRORS"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CONFIGURE-MIRRORLIST-INFO"  "Edit or Review your mirrorlist and exit to continue."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "Use-Mirrorlist" "Do you wish to use" 
# -------------------------------------
configure_mirrorlist()
{
    if [ -f "${FULL_SCRIPT_PATH}/mirrorlist" ]; then
        print_info "CONFIGURE-MIRRORLIST-FOUND" ": ${FULL_SCRIPT_PATH}"
        read_input_yn "Use-Mirrorlist" "${FULL_SCRIPT_PATH}/mirrorlist" 1
        if [[ "YN_OPTION" -eq 1 ]]; then
            CUSTOM_MIRRORLIST=1
        fi
    fi
    if [[ "$CUSTOM_MIRRORLIST" -eq 0 ]]; then
        get_country_code
        get_mirrorlist $OPTION
        #
        print_title "CONFIGURE-MIRRORLIST-MIRRORS" " - https://wiki.archlinux.org/index.php/Mirrors"
        print_info "CONFIGURE-MIRRORLIST-MIRRORS" "https://www.archlinux.org/mirrorlist/?country=${OPTION}&protocol=http&ip_version=4&use_mirror_status=on"
        print_info "CONFIGURE-MIRRORLIST-INFO"
        pause_function "configure_mirrorlist $(basename $BASH_SOURCE) : $LINENO"
        $EDITOR /etc/pacman.d/mirrorlist
    fi
    # Lets copy all config files to Device where this script ran from
    # pacstrap will overwrite mirror list so create temp files on media script ran from
    make_dir "${FULL_SCRIPT_PATH}/etc/pacman.d" "$(basename $BASH_SOURCE) : $LINENO"
    copy_file "/etc/pacman.d/mirrorlist" "${FULL_SCRIPT_PATH}/etc/pacman.d/mirrorlist" "$(basename $BASH_SOURCE) : $LINENO"
}
#}}}
# -----------------------------------------------------------------------------
# READ NAMESERVERS {{{
NAME="read_nameserver"
USAGE="read_nameserver"
DESCRIPTION=$(localize "READ-NAMESERVERS-DESC")
NOTES=$(localize "NONE")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "READ-NAMESERVERS-DESC"  "Read Nameserver"
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "READ-NAMESERVERS-ERROR"  "Missing"
# -------------------------------------
read_nameserver()
{
    CUSTOM_NS1=" "; CUSTOM_NS2=" "; CUSTOM_NS_SEARCH=" "
    if [[ -f "$FULL_SCRIPT_PATH/nameservers.txt" ]]; then
        N=1
        while read line; do 
            case "$N" in
                1)
                    CUSTOM_NS1="$line"
                    ;;
                2)
                    CUSTOM_NS2="$line"
                    ;;
                3)
                    CUSTOM_NS_SEARCH="$line"
                    break;
                    ;;
               *)
                    break;
                    ;;
            esac                                        
            N=$(( N + 1 ))
        done < "${FULL_SCRIPT_PATH}/nameservers.txt"
    else
        write_error   "READ-NAMESERVERS-ERROR" " nameservers.txt - $(basename $BASH_SOURCE) : $LINENO"
        print_warning "READ-NAMESERVERS-ERROR" " nameservers.txt - $(basename $BASH_SOURCE) : $LINENO"
        CUSTOM_NS1=" "
        CUSTOM_NS2=" "
        CUSTOM_NS_SEARCH=" "
    fi
}
#}}}
# -----------------------------------------------------------------------------
# CUSTOM NAMESERVERS {{{
NAME="custom_nameservers"
USAGE="custom_nameservers"
DESCRIPTION=$(localize "CUSTOM-NAMESERVERS-DESC")
NOTES=$(localize "NONE")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CUSTOM-NAMESERVERS-DESC"       "Custom Nameservers"
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "Use-custom-nameserers"         "Use custom nameserers" 
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CORRECT" "Is this correct"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CUSTOM-NAMESERVERS-INFO-1"     "The resolver is a set of routines in the C library that provide access to the Internet Domain Name System (DNS)."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CUSTOM-NAMESERVERS-INFO-2"     "The resolver configuration file contains information that is read by the resolver routines the first time they are invoked by a process."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CUSTOM-NAMESERVERS-INFO-3"     "The file is designed to be human readable and contains a list of keywords with values that provide various types of resolver information."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CUSTOM-NAMESERVERS-INFO-4"     "On a normally configured system this file should not be necessary."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CUSTOM-NAMESERVERS-INFO-5"     "The only name server to be queried will be on the local machine; the domain name is determined from the host name and the domain search path is constructed from the domain name."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CUSTOM-NAMESERVERS-INFO-6"     "OpenDNS servers 208.67.222.222 and 208.67.220.220"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CUSTOM-NAMESERVERS-INFO-7"     "Google nameservers 8.8.8.8 and 8.8.4.4"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CUSTOM-NAMESERVERS-INFO-8"     "Or use the ones form your Local ISP, or own DNS Servers."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CUSTOM-NAMESERVERS-WARN-1"     "You must enter two nameservers correctly, no validation is done!"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CUSTOM-NAMESERVERS-DEFAULT-1"  "Enter NAMESERVER 1 (123.123.123.123): "
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CUSTOM-NAMESERVERS-DEFAULT-2"  "Enter Search (ex: (sub-domain.)url.tdl or Blank (enter) for none): "
# -------------------------------------
custom_nameservers()
{
    write_nameserver()
    {
        # Write settings
        chattr -i ${FULL_SCRIPT_PATH}/etc/resolv.conf
        touch "${FULL_SCRIPT_PATH}/nameservers.txt" # Create if not exist, then update it
        #
        echo "# Created: $DATE_TIME"      > "${FULL_SCRIPT_PATH}/etc/resolv.conf"
        echo "# /etc/resolv.conf"        >> "${FULL_SCRIPT_PATH}/etc/resolv.conf"
        echo "#"                         >> "${FULL_SCRIPT_PATH}/etc/resolv.conf"
        echo "# search <yourdomain.tld>" >> "${FULL_SCRIPT_PATH}/etc/resolv.conf"
        echo "# nameserver <ip>"         >> "${FULL_SCRIPT_PATH}/etc/resolv.conf"
        echo "#"                         >> "${FULL_SCRIPT_PATH}/etc/resolv.conf"
        if [ -n "$CUSTOM_NS1" ]; then
            echo "$CUSTOM_NS1"             > "${FULL_SCRIPT_PATH}/nameservers.txt"
            echo "nameserver $CUSTOM_NS1" >> "${FULL_SCRIPT_PATH}/etc/resolv.conf"
        fi
        if [ -n "$CUSTOM_NS2" ]; then
            echo "$CUSTOM_NS2"            >> "${FULL_SCRIPT_PATH}/nameservers.txt"
            echo "nameserver $CUSTOM_NS2" >> "${FULL_SCRIPT_PATH}/etc/resolv.conf"
        fi
        if [ -n "$CUSTOM_NS_SEARCH" ]; then
            echo "$CUSTOM_NS_SEARCH"        >> "${FULL_SCRIPT_PATH}/nameservers.txt"
            echo "search $CUSTOM_NS_SEARCH" >> "${FULL_SCRIPT_PATH}/etc/resolv.conf"
        fi
        echo "# End of file" >> "${FULL_SCRIPT_PATH}/etc/resolv.conf"
        # 
        chattr +i ${FULL_SCRIPT_PATH}/etc/resolv.conf
    }
    #
    while [[ 1 ]]; do
        print_title " " "https://wiki.archlinux.org/index.php/Resolv.conf"
        print_info "CUSTOM-NAMESERVERS-INFO-1"
        print_info "CUSTOM-NAMESERVERS-INFO-2"
        print_info "CUSTOM-NAMESERVERS-INFO-3"
        print_info "CUSTOM-NAMESERVERS-INFO-4"
        print_info "CUSTOM-NAMESERVERS-INFO-5"
        print_info "CUSTOM-NAMESERVERS-INFO-6"
        print_info "CUSTOM-NAMESERVERS-INFO-7"
        print_info "CUSTOM-NAMESERVERS-INFO-8"
        print_warning "CUSTOM-NAMESERVERS-WARN-1"
        #
        read_input_yn "Use-custom-nameserers" " " 1
        #
        if [[ "$YN_OPTION" -eq 1 ]]; then
            IS_CUSTOM_NAMESERVER=1
            read_nameserver
            read_input_default "CUSTOM-NAMESERVERS-DEFAULT-1" "$CUSTOM_NS1"
            CUSTOM_NS1=$(trim "$OPTION")
            read_input_default "Enter NAMESERVER 2 [123.123.123.123]: " "$CUSTOM_NS2"
            CUSTOM_NS2=$(trim "$OPTION")
            read_input_default "CUSTOM-NAMESERVERS-DEFAULT-2" "$CUSTOM_NS_SEARCH"
            CUSTOM_NS_SEARCH=$(trim "$OPTION")
            read_input_yn "CORRECT" " " 1
            if [[ "$YN_OPTION" -eq 1 ]]; then
                write_nameserver
                cat "${FULL_SCRIPT_PATH}"/etc/resolv.conf
                break
            fi
        else
            if [[ "$RUNTIME_MODE" -eq 1 ]]; then
                copy_file "/etc/resolv.conf" ${MOUNTPOINT}/etc/resolv.conf "$(basename $BASH_SOURCE) : $LINENO"
            fi
            break
        fi
    done
}
#}}}
# -----------------------------------------------------------------------------
# GET FLESH {{{
NAME="get_flesh"
USAGE="get_flesh"
DESCRIPTION=$(localize "GET-FLESH-DESC")
NOTES=$(localize "NONE")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-FLESH-DESC"     "Set FLESH, so Custom User Settings can be Created, add some Flesh to this Bare Bones Skeleton"
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-FLESH-TITLE"    "Pacman Tips"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-FLESH-INFO"     "The Basic Bare Bones Skeleton install is good, but its best to add some Flesh to it, by Customizing the user folder with some extra Configuration from helmuthdu, and Flesher."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-FLESH-INSTALL"  "Install Flesh"
# -------------------------------------
get_flesh()
{
    print_title "GET-FLESH-TITLE" "https://wiki.archlinux.org/index.php/Pacman_Tips"
    print_info "GET-FLESH-INFO"
    read_input_yn "GET-FLESH-INSTALL" " " 1
    if [[ "$YN_OPTION" -eq 1 ]]; then
        FLESH=1
    else
        FLESH=0
    fi
}
#}}}
# -----------------------------------------------------------------------------
# CUSTOM REPOSITORIES {{{
NAME="add_custom_repositories"
USAGE="add_custom_repositories"
DESCRIPTION=$(localize "CUSTOM-REPOSITORIES-DESC")
NOTES=$(localize "NONE")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CUSTOM-REPOSITORIES-DESC"  "Add Custom Repositories"
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CUSTOM-REPOSITORIES-ADD-REPO"     "Add custom Repositories"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CUSTOM-REPOSITORIES-TITLE"        "CUSTOM REPOSITORIES"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CUSTOM-REPOSITORIES-INFO"         "Do not add &#36;arch to the end, the script will do that for you."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CUSTOM-REPOSITORIES-NEW"          "Add new repository"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CUSTOM-REPOSITORIES-MENU"         "D. DONE"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CUSTOM-REPOSITORIES-REPO-NAME"    "Repository Name (ex: custom): "
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CUSTOM-REPOSITORIES-REPO-ADDRESS" "Repository Address (ex: http://domain.url.tdl/archlinux): "
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CUSTOM-REPOSITORIES-TRUST-LEVEL"  "Select your Trust Level:"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CUSTOM-REPOSITORIES-APPEND-ARCH"  "Append arch to end of url for auto detect Architecture: 64 or 32 bit."
# -------------------------------------
add_custom_repositories()
{
    # ENABLE MULTILIB REPOSITORY {{{
    # this option will avoid any problem with packages install
    if [[ "$ARCHI" == x86_64 ]]; then
        multilib=`grep -n "\[multilib\]" "${MOUNTPOINT}/etc/pacman.conf" | cut -f1 -d:`
        if $multilib &> /dev/null; then
            echo -e "\n[multilib]\nInclude = /etc/pacman.d/mirrorlist" >> "${MOUNTPOINT}/etc/pacman.conf"
            echo -e '\nMultilib repository added into pacman.conf file'
        else
            sed -i "${multilib}s/^#//" "${MOUNTPOINT}/etc/pacman.conf"
            multilib=$(( $multilib + 2 ))
            sed -i "${multilib}s/^#//" "${MOUNTPOINT}/etc/pacman.conf"
        fi
    fi
    #}}}
    print_title "CUSTOM REPOSITORIES - https://wiki.archlinux.org/index.php/Unofficial_User_Repositories"
    read_input_yn "CUSTOM-REPOSITORIES-ADD-REPO" " " 0
    if [[ "$YN_OPTION" -eq 1 ]]; then
        while [[ 1 ]]; do
            print_title "CUSTOM-REPOSITORIES-TITLE" " - https://wiki.archlinux.org/index.php/Unofficial_User_Repositories"
            print_info  "CUSTOM-REPOSITORIES-INFO" 
            print_this  "CUSTOM-REPOSITORIES-NEW"
            echo ""
            print_this "CUSTOM-REPOSITORIES-MENU"
            echo ""
            read -p "$prompt1" OPTION
            case $OPTION in
                1)
                    # @FIX Test and add error handling and exit without changes
                    read_input_data "CUSTOM-REPOSITORIES-REPO-NAME" 
                    REPONAME="$OPTION"
                    read_input_data "CUSTOM-REPOSITORIES-REPO-ADDRESS" 
                    REPOADDRESS="$OPTION"
                    read_input_yn "CUSTOM-REPOSITORIES-APPEND-ARCH" "" 1
                    local -a trust_levels=( "Optional TrustAll" "PackageRequired" "Never")
                    PS3="$prompt1"
                    echo "CUSTOM-REPOSITORIES-TRUST-LEVEL"
                    select trust_level in "${trust_levels[@]}"; do
                        if contains_element "$trust_level" "${trust_levels[@]}"; then
                          break
                        else
                          invalid_option "$REPLY"
                        fi
                    done
                    add_repo "$REPONAME" "$REPOADDRESS" "${trust_levels[((REPLY - 1))]}" "$YN_OPTION"
                    pause_function "add_custom_repositories $(basename $BASH_SOURCE) : $LINENO"
                    ;;
              "d")
                    break
                    ;;
                *)
                    invalid_option "$OPTION"
                    ;;
            esac
        done
    fi
    # pacstrap will overwrite pacman.conf so copy it to temp 
    copy_file "${MOUNTPOINT}/etc/pacman.conf" "${FULL_SCRIPT_PATH}/etc/pacman.conf" "$(basename $BASH_SOURCE) : $LINENO"
}
#}}}
# -----------------------------------------------------------------------------
# BACKUP FILES {{{
NAME="backup_files"
USAGE="backup_files"
DESCRIPTION=$(localize "BACKUP-FILES-DESC")
NOTES=$(localize "NONE")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "BACKUP-FILES-DESC"  "Backup files"
# -------------------------------------
backup_files()
{
    # backup old configs
    [[ ! -f /etc/pacman.conf.aui ]] && copy_file "/etc/pacman.conf" "/etc/pacman.conf.aui" "$(basename $BASH_SOURCE) : $LINENO" || echo "/etc/pacman.conf.aui";
    [[ -f /etc/ssh/sshd_config.aui ]] && echo "/etc/ssh/sshd_conf.aui";
    [[ -f /etc/X11/xorg.conf.d/10-evdev.conf.aui ]] && echo "/etc/X11/xorg.conf.d/10-evdev.conf.aui";
}
#}}}
# -----------------------------------------------------------------------------
# CREATE CONFIG {{{
NAME="create_config"
USAGE="create_config"
DESCRIPTION=$(localize "CREATE-CONFIG-DESC")
NOTES=$(localize "NONE")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CREATE-CONFIG-DESC"  "Create Configuration files for Last Config."
# -------------------------------------
create_config()
{
    get_hostname              # $CONFIG_HOSTNAME
    if [[ "$DEBUGGING" -eq 1 ]]; then pause_function "create_config get_hostname @ $(basename $BASH_SOURCE) : $LINENO"; fi
    get_user_name             # $USERNAME
    if [[ "$DEBUGGING" -eq 1 ]]; then pause_function "create_config get_user_name @ $(basename $BASH_SOURCE) : $LINENO"; fi
    get_editor                # $EDITOR
    if [[ "$DEBUGGING" -eq 1 ]]; then pause_function "create_config get_editor @ $(basename $BASH_SOURCE) : $LINENO"; fi
    configure_keymap          # $KEYMAP
    if [[ "$DEBUGGING" -eq 1 ]]; then pause_function "create_config configure_keymap  @ $(basename $BASH_SOURCE) : $LINENO"; fi
    get_keyboard_layout       # $KEYBOARD
    if [[ "$DEBUGGING" -eq 1 ]]; then pause_function "create_config get_keyboard_layout @ $(basename $BASH_SOURCE) : $LINENO"; fi
    get_country_code          # $COUNTRY_CODE and $COUNTRY
    if [[ "$DEBUGGING" -eq 1 ]]; then pause_function "create_config get_country_code @ $(basename $BASH_SOURCE) : $LINENO"; fi
    configure_timezone        # $ZONE and $SUBZONE
    if [[ "$DEBUGGING" -eq 1 ]]; then pause_function "create_config configure_timezone @ $(basename $BASH_SOURCE) : $LINENO"; fi
    get_locale                # $LOCALE
    if [[ "$DEBUGGING" -eq 1 ]]; then pause_function "create_config get_locale @ $(basename $BASH_SOURCE) : $LINENO"; fi
    choose_aurhelper          # $AUR_HELPER
    if [[ "$DEBUGGING" -eq 1 ]]; then pause_function "create_config choose_aurhelper @ $(basename $BASH_SOURCE) : $LINENO"; fi
    custom_nameservers        # $IS_CUSTOM_NAMESERVER
    if [[ "$DEBUGGING" -eq 1 ]]; then pause_function "create_config custom_nameservers @ $(basename $BASH_SOURCE) : $LINENO"; fi
    get_flesh                 # $FLESH
    if [[ "$DEBUGGING" -eq 1 ]]; then pause_function "create_config get_flesh @ $(basename $BASH_SOURCE) : $LINENO"; fi
    get_aur_package_folder    # $AUR_REPO_NAME and $AUR_REPO
    if [[ "$DEBUGGING" -eq 1 ]]; then pause_function "create_config get_aur_package_folder @ $(basename $BASH_SOURCE) : $LINENO"; fi
    save_last_config
}
#}}}
# -----------------------------------------------------------------------------
# CHANGE USER {{{
NAME="change_user"
USAGE="change_user"
DESCRIPTION=$(localize "CHANGE-USER-DESC")
NOTES=$(localize "NONE")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CHANGE-USER-DESC"  "Change user in Configuration files."
# -------------------------------------
change_user()
{
    load_last_config
    get_hostname              # $CONFIG_HOSTNAME
    get_user_name             # $USERNAME
    get_aur_package_folder    # $AUR_REPO_NAME and $AUR_REPO
    save_last_config
}
#}}}
# -----------------------------------------------------------------------------
# EDIT DISK {{{
NAME="edit_disk"
USAGE="edit_disk"
DESCRIPTION=$(localize "EDIT-DISK-DESC")
NOTES=$(localize "NONE")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "EDIT-DISK-DESC"  "Edit Disk Configuration files."
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "EDIT-DISK-EDIT-DRIVE" "Edit Drive with gdisk" 
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "EDIT-DISK-IS-SSD-DISK" "Is this an SSD Disk" 
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "EDIT-DISK-INFO-1"  "After Drive is formated, you can edit it using gdisk."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "EDIT-DISK-INFO-2"  "Special Settings can help with SSD Drives."
# -------------------------------------
edit_disk()
{
    get_boot_type      # $UEFI and $UEFI_SIZE 
    get_boot_partition # $IS_BOOT_PARTITION, $BOOT_SYSTEM_TYPE and $BOOT_SIZE
    get_swap_partition # $IS_SWAP_PARTITION and $SWAP_SIZE
    get_root_size      # $ROOT_SIZE and ROOT_FORMAT
    get_home_partition # $IS_HOME_PARTITION, $HOME_SIZE, $HOME_FORMAT and $IS_HOME_DRIVE
    get_var_partition  # $IS_VAR_PARTITION, $VAR_SIZE, $VAR_FORMAT and $IS_VAR_DRIVE
    get_tmp_partition  # IS_TMP_PARTITION IS_TMP_SIZE TMP_SIZE TMP_FORMAT
    #
    print_info "EDIT-DISK-INFO-1"
    read_input_yn "EDIT-DISK-EDIT-DRIVE" " " 0
    if [[ "$YN_OPTION" -eq 1 ]]; then
        EDIT_GDISK=1
    else
        EDIT_GDISK=0
    fi
    # @FIX add SSD optimization
    print_info "EDIT-DISK-INFO-2"
    read_input_yn "EDIT-DISK-IS-SSD-DISK" " " 0
    if [[ "$YN_OPTION" -eq 1 ]]; then
        IS_SSD=1
    else
        IS_SSD=0
    fi
    save_disk_config
}
#}}}
# -----------------------------------------------------------------------------
# SHOW PACKMANAGER {{{
NAME="show_packmanager"
USAGE="show_packmanager"
DESCRIPTION=$(localize "SHOW-PACKMANAGER-DESC")
NOTES=$(localize "NONE")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "SHOW-PACKMANAGER-DESC"  "Show All Packages to Manage"
# -------------------------------------
show_packmanager()
{
    total="${#PACKMANAGER[@]}"
    for (( index=0; index<${total}; index++ )); do
        # @FIX more; figure out how many lines to show
        echo -e "${PACKMANAGER[$index]}"
    done
}
#}}}
# -----------------------------------------------------------------------------
# SHOW SOFTWARE {{{
NAME="show_software"
USAGE="show_software"
DESCRIPTION=$(localize "SHOW-SOFTWARE-DESC")
NOTES=$(localize "SHOW-SOFTWARE-NOTES")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "SHOW-SOFTWARE-DESC"  "Show Loaded Variables for Software Configuration"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "SHOW-SOFTWARE-NOTES" "Configuration files exist"
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "SHOW-SOFTWARE-INFO-1"        "Software Configuration Database is built using the Full install menu; then saved to this file; the menu settings are store also, so you can visually see what you installed."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "SHOW-SOFTWARE-INFO-2"        "If the Menu's get out of sync with the Database, they will have to be deleted; the software handles this automatically; but if you know the Database is out of sync; create a new one."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "SHOW-SOFTWARE-INFO-3"        "If you want to create a New Software Configuration file; you must not load the last one."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "SHOW-SOFTWARE-LOAD-SOFTWARE" "Load Software Configuration Database" 
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "View-Package-Manager"        "View Package Manager Commands: " 
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "SCROLL-INFO"                 "Use Shift-PageUp and Down if scrolls off screen"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CREATE-NEW-CONFIG"           "Do you wish to Create a New Software Configuration File"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "SHOW-SOFTWARE-INFO-ERROR"    "Software Config failed to load"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "SHOW-SOFTWARE-INFO-VAR"      "Configuration and Software Install Variables:"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "SHOW-SOFTWARE-INFO-4"        "The Menus shows you what you installed last time; the configuration will be overwritten; as such, it does not save what you have, unless you loaded it earlier; which is the case to get here."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "SHOW-SOFTWARE-INFO-5"        "You have two Options; Create a New Software Configuration File, or edit this one; which relies on the Menu System and Menu Database being in sync."
# -------------------------------------
show_software()
{
    print_this "SHOW-SOFTWARE-INFO-1"
    print_this "SHOW-SOFTWARE-INFO-2"
    print_this "SHOW-SOFTWARE-INFO-3"
    read_input_yn "SHOW-SOFTWARE-LOAD-SOFTWARE" " " 1 
    if [[ "YN_OPTION" -eq 1 ]]; then
        load_software
        if [[ "$IS_SOFTWARE_CONFIG_LOADED" -eq 0 ]]; then
            print_warning "SHOW-SOFTWARE-INFO-ERROR" " @ $(basename $BASH_SOURCE) : $LINENO"
            abort_install
        fi
        print_title "SHOW-SOFTWARE-INFO-VAR"
        print_this "$TEXT_SCRIPT_ID"
        echo -e "WEBSERVER            = ${BWhite}$WEBSERVER${White}"
        echo -e "CONFIG_ORPHAN        = ${BWhite}$(yes_no $CONFIG_ORPHAN) ${White}"
        echo -e "CONFIG_XORG          = ${BWhite}$(yes_no $CONFIG_XORG)   ${White}"
        echo -e "CONFIG_SSH           = ${BWhite}$(yes_no $CONFIG_SSH)    ${White}"
        echo -e "CONFIG_TOR           = ${BWhite}$(yes_no $CONFIG_TOR)    ${White}"
        echo -e "CONFIG_KDE           = ${BWhite}$(yes_no $CONFIG_KDE)    ${White}"
        echo -e "USER_GROUPS          = ${BWhite}${USER_GROUPS[*]}        ${White}"
        echo -e "VIDEO_CARD           = ${BWhite}${VIDEO_CARDS[$(( $VIDEO_CARD - 1 ))]} ${White}"
        echo -e "MATE INSTALLED       = ${BWhite}$(yes_no $MATE_INSTALLED)     ${White}"
        echo -e "GNOME INSTALL        = ${BWhite}$(yes_no $GNOME_INSTALL)      ${White}"
        echo -e "XFCE INSTALLED       = ${BWhite}$(yes_no $XFCE_INSTALLED)     ${White}"
        echo -e "E17 INSTALLED        = ${BWhite}$(yes_no $E17_INSTALLED)      ${White}"
        echo -e "KDE INSTALLED        = ${BWhite}$(yes_no $KDE_INSTALLED)      ${White}"
        echo -e "LXDE INSTALLED       = ${BWhite}$(yes_no $LXDE_INSTALLED)     ${White}"
        echo -e "OPENBOX INSTALLED    = ${BWhite}$(yes_no $OPENBOX_INSTALLED)  ${White}"
        echo -e "AWESOME INSTALLED    = ${BWhite}$(yes_no $AWESOME_INSTALLED)  ${White}"
        echo -e "GNOME INSTALLED      = ${BWhite}$(yes_no $GNOME_INSTALLED)    ${White}"
        echo -e "CINNAMON INSTALLED   = ${BWhite}$(yes_no $CINNAMON_INSTALLED) ${White}"
        echo -e "UNITY INSTALLED      = ${BWhite}$(yes_no $UNITY_INSTALLED)    ${White}"
        echo -e " "
        print_this "SCROLL-INFO"
        read_input_yn "View-Package-Manager" " " 1 
        if [[ "YN_OPTION" -eq 1 ]]; then
            show_packmanager
        fi      
        echo -e " "
        #
        #
        print_this "SHOW-SOFTWARE-INFO-4"
        print_this "SHOW-SOFTWARE-INFO-5"
        read_input_yn "CREATE-NEW-CONFIG" " " 0
        if [[ "$YN_OPTION" -eq 1 ]]; then
            clear_software
            install_menu
        fi
    else
        clear_software
        install_menu
    fi
}
#}}}
# -----------------------------------------------------------------------------
# SHOW LOADED {{{
NAME="show_last_config"
USAGE="show_last_config"
DESCRIPTION=$(localize "SHOW-LOADED-DESC")
NOTES=$(localize "SHOW-LOADED-NOTES")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="12 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "SHOW-LOADED-DESC"  "Show Loaded Variables"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "SHOW-LOADED-NOTES" "Localized."
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "Last-Config"                    "Last Configuration Database contain User specific Settings."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "Load-User-Config"               "Load User Configuration Database"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "Last-Config-Failed"             "Last Config Failed to load at line"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "The-below-Config"               "The below Configuration Settings can be changed without re-running Software install."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "Change-UserName"                "You can just change User Name (Y), or whole configuration (N)."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "Do-You-Want-To-Change-UserName" "Do you wish to change User Name"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "Edit-Settings"                  "Do you wish to edit these settings"
# -------------------------------------
show_last_config()
{
    print_this "Last-Config"
    read_input_yn "Load-User-Config" " " 1 
    if [[ "YN_OPTION" -eq 1 ]]; then
        load_last_config
        if [[ "$IS_LAST_CONFIG_LOADED" -eq 0 ]]; then
            print_warning "Last-Config-Failed" "$(basename $BASH_SOURCE) : $LINENO"
            create_config
        fi
        echo -e " "
        echo -e "$(localize "The-below-Config")"
        echo -e ""
        echo -e "FLESH                    = ${BWhite} $(yes_no "${FLESH}") ${White}"
        echo -e "CUSTOM_MIRRORLIST        = ${BWhite} $(yes_no "${CUSTOM_MIRRORLIST}") ${White}"
        echo -e "NETWORK_MANAGER          = ${BWhite} ${NETWORK_MANAGER} ${White}"
        echo -e "FSTAB_CONFIG             = ${BWhite} ${FSTAB[$(( FSTAB_CONFIG - 1 ))]} ${White}"
        echo -e "FSTAB_EDIT               = ${BWhite} $(yes_no "${FSTAB_EDIT}") ${White}"
        echo -e "Time ZONE/SUBZONE        = ${BWhite} ${ZONE}/${SUBZONE} ${White}"
        echo -e "COUNTRY_CODE             = ${BWhite} ${COUNTRY_CODE} ${White}"
        echo -e "COUNTRY                  = ${BWhite} ${COUNTRY} ${White}"
        echo -e "KEYMAP                   = ${BWhite} ${KEYMAP} ${White}"
        echo -e "KEYBOARD                 = ${BWhite} ${KEYBOARD} ${White}"
        echo -e "IS_CUSTOM_NAMESERVER     = ${BWhite} $(yes_no "${IS_CUSTOM_NAMESERVER}") DNS1=${CUSTOM_NS1} DNS2=${CUSTOM_NS1} Search=${CUSTOM_NS_SEARCH} ${White}"
        echo -e "AUR_HELPER               = ${BWhite} ${AUR_HELPER} ${White}" 
        echo -e "AUR_REPO_NAME            = ${BWhite} ${AUR_REPO_NAME} ${White}" 
        echo -e "AUR_REPO                 = ${BWhite} $(yes_no "${AUR_REPO}") ${White}" 
        echo -e "PACMAN_OPTIMIZER         = ${BWhite} $(yes_no "${PACMAN_OPTIMIZER}") ${White}" 
        local -a PACMAN_REPO_TYPES=( "None" "Server" "Client")
        echo -e "PACMAN_REPO_TYPE         = ${BWhite} ${PACMAN_REPO_TYPES[$PACMAN_REPO_TYPE]} ${White}" 
        local -i total="${#LOCALE_ARRAY[@]}"
        local -i index=0
        for (( index=0; index<${total}; index++ )); do
            echo -e "LOCALE $index                 = ${BWhite} ${LOCALE_ARRAY[$index]} ${White}"
        done
        echo -e "CONFIG_HOSTNAME          = ${BWhite} ${CONFIG_HOSTNAME} ${White}"
        echo -e "EDITOR                   = ${BWhite} ${EDITOR} ${White}"
        echo -e "USERNAME                 = ${BWhite} ${USERNAME}${White}"
        echo -e " "
        #
        print_info "Change-UserName"
        read_input_yn "Do-You-Want-To-Change-UserName" " " 0
        if [[ "$YN_OPTION" -eq 1 ]]; then
            change_user
            show_last_config
        fi       
        read_input_yn "Edit-Settings" " " 0
        if [[ "$YN_OPTION" -eq 1 ]]; then
            create_config
            show_last_config
            pause_function "show_last_config $(basename $BASH_SOURCE) : $LINENO"
        fi
    else
        create_config
        show_last_config
        pause_function "show_last_config $(basename $BASH_SOURCE) : $LINENO"
    fi
}
#}}}
# -----------------------------------------------------------------------------
# SHOW DISK PROFILE {{{
NAME="show_disk_profile"
USAGE="show_disk_profile"
DESCRIPTION=$(localize "SHOW-DISK-PROFILE-DESC")
NOTES=$(localize "NONE")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "SHOW-DISK-PROFILE-DESC"  "Show Disk Profile"
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "SHOW-DISK-PROFILE-TITLE"  "Disk Profile: Configuration Variables:"
# -------------------------------------
show_disk_profile()
{
    load_disk_config
    print_title "SHOW-DISK-PROFILE-TITLE"
    print_this "$TEXT_SCRIPT_ID"
    echo -e "Boot Mode:           = ${BWhite} ${BIOS_SYSTEM_TYPES[$UEFI]} ${White}"
    if [[ "$UEFI" -eq 0 ]]; then # UEFI=0
        echo -e "UEFI_SIZE            = ${BWhite} $UEFI_SIZE ${White}"
    fi
    echo -e "IS_BOOT_PARTITION    = ${BWhite} $(yes_no $IS_BOOT_PARTITION) ${White}"
    if [[ "$IS_BOOT_PARTITION" -eq 1 ]]; then
        echo -e "BOOT_SIZE            = ${BWhite} $BOOT_SIZE ${White}"
    fi
    echo -e "IS_SWAP_PARTITION    = ${BWhite} $(yes_no $IS_SWAP_PARTITION) ${White}"
    if [[ "$IS_SWAP_PARTITION" -eq 1 ]]; then
        echo -e "SWAP_SIZE            = ${BWhite} $SWAP_SIZE ${White}"
    fi
    echo -e "ROOT_SIZE            = ${BWhite} $ROOT_SIZE ${White}"
    echo -e "ROOT_FORMAT          = ${BWhite} $ROOT_FORMAT ${White}"
    echo -e "IS_HOME_PARTITION    = ${BWhite} $(yes_no $IS_HOME_PARTITION) ${White}"
    if [[ "$IS_HOME_PARTITION" -eq 1 ]]; then
        echo -e "HOME_SIZE            = ${BWhite} $HOME_SIZE ${White}"
        echo -e "HOME_FORMAT          = ${BWhite} $HOME_FORMAT ${White}"
        echo -e "IS_HOME_DRIVE        = ${BWhite} $(yes_no $IS_HOME_DRIVE) ${White}"
    fi
    echo -e "IS_VAR_PARTITION     = ${BWhite} $(yes_no $IS_VAR_PARTITION) ${White}"
    if [[ "$IS_VAR_PARTITION" -eq 1 ]]; then
        echo -e "VAR_SIZE             = ${BWhite} $VAR_SIZE ${White}"
        echo -e "VAR_FORMAT           = ${BWhite} $VAR_FORMAT ${White}"
        echo -e "IS_VAR_DRIVE         = ${BWhite} $(yes_no $IS_VAR_DRIVE) ${White}"
    fi
    echo -e "IS_TMP_PARTITION     = ${BWhite} $(yes_no $IS_TMP_PARTITION) ${White}"
    if [[ "$IS_TMP_PARTITION" -eq 1 ]]; then
        echo -e "IS_TMP_SIZE          = ${BWhite} $(yes_no $IS_TMP_SIZE ) ${White}"
        echo -e "TMP_SIZE             = ${BWhite} $TMP_SIZE ${White}"
        echo -e "TMP_FORMAT           = ${BWhite} $TMP_FORMAT ${White}"
    fi
}
#}}}
# -----------------------------------------------------------------------------
# GET INSTALL MODE {{{
NAME="get_install_mode"
USAGE="get_install_mode 1->(1=Install OS, 2=Install Software)"
DESCRIPTION=$(localize "GET-INSTALL-MODE-DESC")
NOTES=$(localize "Localized.")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-INSTALL-MODE-DESC"  "Change MOUNTPOINT"
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "Install-Mode"         "Install mode has two options: Boot and Live:"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "Boot-Mode"            "Boot mode is when you Boot from an Arch ISO to install OS for first time, not to be confused with LIVE CD."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "Live-Mode"            "Live mode is after you install Boot, and then reboot into Live mode, i.e. Active Installed OS."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "Is-Install-Mode-Live" "Is Install Mode Live"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "BOOT-MODE-DETECTED"   "Boot Mode Detected."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "LIVE-MODE-DETECTED"   "Live Mode Detected."
# -------------------------------------
get_install_mode()
{
    print_info "Install-Mode"
    print_info "Boot-Mode"
    print_info "Live-Mode"    
    if [ -d "/home/arch/" ]; then
        print_caution "BOOT-MODE-DETECTED"
        read_input_yn "Is-Install-Mode-Live" " " 0
    else
        print_caution "LIVE-MODE-DETECTED"
        if [[ "$1" -eq 1 ]]; then
            read_input_yn "Is-Install-Mode-Live" " " 0
        else
            read_input_yn "Is-Install-Mode-Live" " " 1
        fi
    fi
    if [[ "$YN_OPTION" -eq 1 ]]; then
        MOUNTPOINT=" "
        RUNTIME_MODE=2
        DRIVE_FORMATED=1
    else
        RUNTIME_MODE=1
    fi
}
#}}}
# -----------------------------------------------------------------------------
# VERIFY CONFIG {{{
NAME="verify_config"
USAGE="verify_config $(localize "VERIFY-CONFIG-USAGE")"
DESCRIPTION=$(localize "VERIFY-CONFIG-DESC")
NOTES=$(localize "NONE")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "VERIFY-CONFIG-USAGE" " 1->(1=Install OS, 2=Install Software)" 
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "VERIFY-CONFIG-DESC"  "Verify Configuration settings and load all files or create new ones."
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "VERIFY-CONFIG-Optimization"          "Do you wish to Configure pacman Optimization" 
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "Create-New-Software-Config"          "Do you wish to Create a New Software Configuration File" 
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "Disk-Profile"                        "Do you wish change Disk Profile" 
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "KEEP-Disk-Profile"                   "Do you wish to continue with this Disk Profile" 
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "VERIFY-CONFIG-Import-User-Folder-settings" "Import User Folder settings" 
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "COPY-FOLDER"                         "Do you wish to Copy saved Flash Folder /etc/ to /" 
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "VERIFY-CONFIG-PACMAN-OPTIMIZATION"   "pacman Optimization will configure system to use aria2 reflector and pm2ml; it will also configure a local repository which can be share across a local Network; this will help download files faster."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "VERIFY-CONFIG-CHECKING-OPTIMIZE"      "Checking for pacman Optimization"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "VERIFY-CONFIG-NO-OPTIMIZE"           "No Optimized pacman!"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "VERIFY-CONFIG-NO-CONFIG"             "No Configuration file found."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "VERIFY-CONFIG-SOFTWARE-CONFIG-FOUND" "A Software Configuration file has not been detected, you can Create a New one."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "VERIFY-CONFIG-VERIFY-DISK-SETTINGS"  "You now need to verify the Disk Settings"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "VERIFY-CONFIG-RUN-SCRIPT-AGAIN"      "Run Script again, after you decide on a Disk Profile."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "VERIFY-CONFIG-FOLDER-ETC-HOLDS"      "The Folder etc holds various configurations files like: pacman.conf, fstab, hostname, hosts, resolve.conf, sudoers, timezone, vconsole.conf, and mirrorlist."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "VERIFY-CONFIG-CONFIG-COMPLETED"      "Configuration File Check Completed..."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "VERIFY-CONFIG-USER-FOLDER-SETTINGS"  "User Folder Settings are stored on Disk; they are part of the Flesh, to add to the Bare Bones install and add customization to user settings."
verify_config()
{
    if [[ "$CONFIG_VERIFIED" -eq 1 ]]; then return 0; fi
    CONFIG_VERIFIED=1
    get_install_mode "$1"
    if [[ "$RUNTIME_MODE" -eq 2 ]]; then
        # @FIX test to see if this is done
        print_this "VERIFY-CONFIG-PACMAN-OPTIMIZATION"
        read_input_yn "VERIFY-CONFIG-Optimization" " " 0
        if [[ "$YN_OPTION" -eq 1 ]]; then
            print_info "VERIFY-CONFIG-CHECKING-OPTIMIZE"
            if check_package "pm2ml" ; then
                echo "VERIFY-CONFIG-NO-OPTIMIZE"
                USE_PACMAN=0
            else
                PACMAN_OPTIMIZER=1
            fi
        fi
    fi
    # Last Configuarion Files
    if is_last_config_files ; then
        show_last_config
    else
        print_info "VERIFY-CONFIG-NO-CONFIG"
        create_config
        show_last_config
        pause_function "verify_config $(basename $BASH_SOURCE) : $LINENO"
    fi        
    # Software Configuration Files
    if is_software_files ; then            
        print_info "VERIFY-CONFIG-SOFTWARE-CONFIG-FOUND"
        show_software "$1" # Ask if you wish to load Software and Last Config
    else
        if [[ "$1" -eq 1 ]]; then # Boot Mode
            print_info "VERIFY-CONFIG-SOFTWARE-CONFIG-FOUND"
            read_input_yn "Create-New-Software-Config" " " 1
            if [[ "$YN_OPTION" -eq 1 ]]; then
                install_menu
            fi
        else
            install_menu
        fi
    fi
    # Disk Configuration Files
    if [[ "$1" -eq 1 ]]; then # Boot Mode
        if [[ -f "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db" && "$BOOT_MODE" -eq 1 ]]; then
            print_info "VERIFY-CONFIG-VERIFY-DISK-SETTINGS"
            show_disk_profile
            read_input_yn "Disk-Profile" " " 0
            if [[ "$YN_OPTION" -eq 1 ]]; then
                edit_disk
                show_disk_profile
            else
                read_input_yn "KEEP-Disk-Profile" " " 1
                if [[ "$YN_OPTION" -eq 0 ]]; then
                    print_warning "VERIFY-CONFIG-RUN-SCRIPT-AGAIN"
                    abort_install
                else
                    DISK_PROFILE=1
                fi
            fi
        fi
    fi
    # User Configuration Files
    if [[ -f "${USER_FOLDER}/.xinitrc" && ! -f "/home/${USERNAME}/.xinitrc" && "$RUNTIME_MODE" -eq 2 ]]; then  # USER_FOLDER = "${FULL_SCRIPT_PATH}/USER"
        print_info "VERIFY-CONFIG-USER-FOLDER-SETTINGS"
        read_input_yn "VERIFY-CONFIG-Import-User-Folder-settings" " " 1
        if [[ "$YN_OPTION" -eq 1 ]]; then
            copy_files "${USER_FOLDER}/" " " "/home/${USERNAME}/" "$(basename $BASH_SOURCE) : $LINENO"
        fi
    else
        if [[ "$RUNTIME_MODE" -eq 1 ]]; then
            USER_FOLDER="${FULL_SCRIPT_PATH}/USER"
            make_dir "${USER_FOLDER}/" "$(basename $BASH_SOURCE) : $LINENO"
        else
            USER_FOLDER="/home/${USERNAME}"
        fi
        if [ ! -f "${USER_FOLDER}/.xinitrc" ]; then
            if [ ! -f /etc/skel/.xinitrc ]; then                    # Create .xinitrc file in user folder
                echo "#!/bin/sh"                                    > "${USER_FOLDER}/.xinitrc"
                echo "if [ -d /etc/X11/xinit/xinitrc.d ]; then"    >> "${USER_FOLDER}/.xinitrc"
                echo "    for f in /etc/X11/xinit/xinitrc.d/*; do" >> "${USER_FOLDER}/.xinitrc"
                echo "        [ -x \"\$f\" ] && . \"\$f\""         >> "${USER_FOLDER}/.xinitrc"
                echo "    done"                                    >> "${USER_FOLDER}/.xinitrc"
                echo "    unset f"                                 >> "${USER_FOLDER}/.xinitrc"
                echo "fi"                                          >> "${USER_FOLDER}/.xinitrc"
                echo " "                                           >> "${USER_FOLDER}/.xinitrc"
            else
                copy_file "/etc/skel/.xinitrc" "${USER_FOLDER}/" "$(basename $BASH_SOURCE) : $LINENO"
            fi
        fi
        if  [[ ! -f "/home/${USERNAME}/.xinitrc" && "$RUNTIME_MODE" -eq 2  ]]; then
            copy_files "${USER_FOLDER}/" " " "/home/${USERNAME}/" "$(basename $BASH_SOURCE) : $LINENO"
        fi
    fi
    if [[ "$1" -eq 2 ]]; then
        if [ -d "${FULL_SCRIPT_PATH}/etc/" ]; then
            print_info "VERIFY-CONFIG-FOLDER-ETC-HOLDS"
            read_input_yn "COPY-FOLDER" " " 0
            if [[ "$YN_OPTION" -eq 0 ]]; then
                 # copy_dir "${FULL_SCRIPT_PATH}/etc/" "/" "$(basename $BASH_SOURCE) : $LINENO" # runs out of space
                 copy_dir "${FULL_SCRIPT_PATH}/etc/" "${MOUNTPOINT}/" "$(basename $BASH_SOURCE) : $LINENO"
            fi
        fi
    fi
    print_info "VERIFY-CONFIG-CONFIG-COMPLETED"
    pause_function "verify_config :> $(basename $BASH_SOURCE) -> $LINENO"
    return 0
}
#}}}
# -----------------------------------------------------------------------------
# CLEAR SOFTWARE {{{
NAME="clear_software"
USAGE="clear_software"
DESCRIPTION=$(localize "CLEAR-SOFTWARE-DESC")
NOTES=$(localize "NONE")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CLEAR-SOFTWARE-DESC"      "Clear All variables that effect Software"
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CLEAR-SOFTWARE-ERROR"     "No Menus found"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CLEAR-SOFTWARE-INFO"      "Removed Menus"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CLEAR-SOFTWARE-COMPLETE"  "Removed Software Configuration"
# -------------------------------------
clear_software()
{
    CORE_INSTALL=( "" )
    AUR_INSTALL=( "" )
    FAILED_CORE_INSTALL=( "" )
    FAILED_AUR_INSTALL=( "" )
    TASKMANAGER_NAME=( "" )
    TASKMANAGER=( "" )
    #
    PACKAGES=( "" )
    AUR_PACKAGES=( "" )
    PACKMANAGER_NAME=( "" )
    PACKMANAGER=( "" )
    #
    USER_GROUPS=( "" )
    #
    WEBSERVER=0
    CONFIG_ORPHAN=0
    CONFIG_XORG=0
    CONFIG_SSH=0
    CONFIG_TOR=0
    CONFIG_KDE=0
    VIDEO_CARD=7
    MATE_INSTALLED=0
    GNOME_INSTALL=0
    XFCE_INSTALLED=0
    E17_INSTALLED=0
    KDE_INSTALLED=0
    LXDE_INSTALLED=0
    OPENBOX_INSTALLED=0
    AWESOME_INSTALLED=0
    GNOME_INSTALLED=0
    CINNAMON_INSTALLED=0
    UNITY_INSTALLED=0
    #
    remove_file "${CONFIG_PATH}/${CONFIG_NAME}-taskmanager.db"         "$(basename $BASH_SOURCE) : $LINENO"
    remove_file "${CONFIG_PATH}/${CONFIG_NAME}-taskmanager-name.db"    "$(basename $BASH_SOURCE) : $LINENO"
    remove_file "${CONFIG_PATH}/${CONFIG_NAME}-packagemanager.db"      "$(basename $BASH_SOURCE) : $LINENO"
    remove_file "${CONFIG_PATH}/${CONFIG_NAME}-packagemanager-name.db" "$(basename $BASH_SOURCE) : $LINENO"
    remove_file "${CONFIG_PATH}/${CONFIG_NAME}-packages.db"            "$(basename $BASH_SOURCE) : $LINENO"
    remove_file "${CONFIG_PATH}/${CONFIG_NAME}-aur-packages.db"        "$(basename $BASH_SOURCE) : $LINENO"
    remove_file "${CONFIG_PATH}/${CONFIG_NAME}-user-groups.db"         "$(basename $BASH_SOURCE) : $LINENO"
    remove_file "${CONFIG_PATH}/${CONFIG_NAME}-failed-aur-install.db"  "$(basename $BASH_SOURCE) : $LINENO"
    remove_file "${CONFIG_PATH}/${CONFIG_NAME}-core-installed.db"      "$(basename $BASH_SOURCE) : $LINENO"
    remove_file "${CONFIG_PATH}/${CONFIG_NAME}-aur-installed.db"       "$(basename $BASH_SOURCE) : $LINENO"
    remove_file "${CONFIG_PATH}/${CONFIG_NAME}-failed-core-install.db" "$(basename $BASH_SOURCE) : $LINENO"
    remove_file "${CONFIG_PATH}/${CONFIG_NAME}-software-config.db"     "$(basename $BASH_SOURCE) : $LINENO"
    #
    if is_wildcard_file "${MENU_PATH}/" "db" ; then # " " | "ext" 
        rm -r "${MENU_PATH}"/*.db
        print_warning "CLEAR-SOFTWARE-INFO" "$(basename $BASH_SOURCE) : $LINENO"
        write_log     "CLEAR-SOFTWARE-INFO" "$(basename $BASH_SOURCE) : $LINENO"
    else
        print_this  "CLEAR-SOFTWARE-ERROR" ": ${MENU_PATH}/*.db - $(basename $BASH_SOURCE) : $LINENO"
        write_error "CLEAR-SOFTWARE-ERROR" ": ${MENU_PATH}/*.db - $(basename $BASH_SOURCE) : $LINENO"
    fi
    print_warning "CLEAR-SOFTWARE-COMPLETE"
    if [[ "$DEBUGGING" -eq 1 ]]; then pause_function "clear_software at line @ $(basename $BASH_SOURCE) : $LINENO"; fi
}
#}}}
# -----------------------------------------------------------------------------
# SAVE INSTALL {{{
NAME="save_install"
USAGE="save_install"
DESCRIPTION=$(localize "SAVE-INSTALL-DESC")
NOTES=$(localize "NONE")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "SAVE-INSTALL-DESC"  "Save Install"
# -------------------------------------
save_install()
{
    # CORE_INSTALL
    if [[ "${#CORE_INSTALL}" -ne 0 ]]; then
        if [ -f "${CONFIG_PATH}/${CONFIG_NAME}-core-installed.db" ]; then
            copy_file "${CONFIG_PATH}/${CONFIG_NAME}-core-installed.db" "${CONFIG_PATH}/${CONFIG_NAME}-core-installed-old.db" "$(basename $BASH_SOURCE) : $LINENO"
        fi
        total="${#CORE_INSTALL[@]}"
        for (( i=0; i<${total}; i++ )); do
            if [[ "$i" == 0 ]]; then
                echo "${CORE_INSTALL[$i]}"        >  "${CONFIG_PATH}/${CONFIG_NAME}-core-installed.db"      # installed_core  - array
            else
                echo "${CORE_INSTALL[$i]}"        >> "${CONFIG_PATH}/${CONFIG_NAME}-core-installed.db"      # installed_core  - array
            fi
        done
    fi
    # AUR_INSTALL
    if [[ "${#AUR_INSTALL}" -ne 0 ]]; then
        if [ -f "${CONFIG_PATH}/${CONFIG_NAME}-aur-core-installed.db" ]; then
            copy_file "${CONFIG_PATH}/${CONFIG_NAME}-aur-installed.db" "${CONFIG_PATH}/${CONFIG_NAME}-aur-installed-old.db" "$(basename $BASH_SOURCE) : $LINENO"
        fi
        total="${#AUR_INSTALL[@]}"
        for (( i=0; i<${total}; i++ )); do
            if [[ "$i" == 0 ]]; then
                echo "${AUR_INSTALL[$i]}"         >  "${CONFIG_PATH}/${CONFIG_NAME}-aur-installed.db"       # installed_aur - array
            else
                echo "${AUR_INSTALL[$i]}"         >> "${CONFIG_PATH}/${CONFIG_NAME}-aur-installed.db"       # installed_aur - array
            fi
        done
    fi
    # FAILED_CORE_INSTALL
    if [[ "${#FAILED_CORE_INSTALL}" -ne 0 ]]; then
        if [ -f "${CONFIG_PATH}/${CONFIG_NAME}-failed-core-installed.db" ]; then
            copy_file "${CONFIG_PATH}/${CONFIG_NAME}-failed-core-installed.db" "${CONFIG_PATH}/${CONFIG_NAME}-failed-core-installed-old.db" "$(basename $BASH_SOURCE) : $LINENO"
        fi
        total="${#FAILED_CORE_INSTALL[@]}"
        for (( i=0; i<${total}; i++ )); do
            if [[ "$i" == 0 ]]; then
                echo "${FAILED_CORE_INSTALL[$i]}" >  "${CONFIG_PATH}/${CONFIG_NAME}-failed-core-install.db" # failed_install_core  - array
            else
                echo "${FAILED_CORE_INSTALL[$i]}" >> "${CONFIG_PATH}/${CONFIG_NAME}-failed-core-install.db" # failed_install_core  - array
            fi
        done
    fi
    # FAILED_AUR_INSTALL
    if [[ "${#FAILED_AUR_INSTALL}" -ne 0 ]]; then
        if [ -f "${CONFIG_PATH}/${CONFIG_NAME}-failed-aur-core-installed.db" ]; then
            copy_file "${CONFIG_PATH}/${CONFIG_NAME}-failed-aur-installed.db" "${CONFIG_PATH}/${CONFIG_NAME}-failed-aur-installed-old.db" "$(basename $BASH_SOURCE) : $LINENO"
        fi
        total="${#FAILED_AUR_INSTALL[@]}"
        for (( i=0; i<${total}; i++ )); do
            if [[ "$i" == 0 ]]; then
                echo "${FAILED_AUR_INSTALL[$i]}"  >  "${CONFIG_PATH}/${CONFIG_NAME}-failed-aur-install.db"  # failed_install_aur - array
            else
                echo "${FAILED_AUR_INSTALL[$i]}"  >> "${CONFIG_PATH}/${CONFIG_NAME}-failed-aur-install.db"  # failed_install_aur - array
            fi
        done
    fi
    return 0
}
#}}}
# -----------------------------------------------------------------------------
# SAVE SOFTWARE {{{
NAME="save_software"
USAGE="save_software"
DESCRIPTION=$(localize "SAVE-SOFTWARE-DESC")
NOTES=$(localize "NONE")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "SAVE-SOFTWARE-DESC"  "Save Software Configuration: All variables that effect PACKMANAGER"
# -------------------------------------
save_software()
{
    # 
    # add_packagemanager TASKMANAGER TASKMANAGER_NAME
    # TASKMANAGER_NAME
    copy_file "${CONFIG_PATH}/${CONFIG_NAME}-taskmanager-name.db" "${CONFIG_PATH}/${CONFIG_NAME}-taskmanager-name-old.db" "$(basename $BASH_SOURCE) : $LINENO"
    local -i total="${#TASKMANAGER_NAME[@]}"
    for (( i=0; i<${total}; i++ )); do
        if [[ "$i" == 0 ]]; then
            echo "${TASKMANAGER_NAME[$i]}"  > "${CONFIG_PATH}/${CONFIG_NAME}-taskmanager-name.db" # add_taskmanager  - array
        else
            echo "${TASKMANAGER_NAME[$i]}" >> "${CONFIG_PATH}/${CONFIG_NAME}-taskmanager-name.db" # add_taskmanager  - array
        fi
    done
    # TASKMANAGER
    copy_file "${CONFIG_PATH}/${CONFIG_NAME}-taskmanager.db" "${CONFIG_PATH}/${CONFIG_NAME}-taskmanager-old.db" "$(basename $BASH_SOURCE) : $LINENO"
    local -i total="${#TASKMANAGER[@]}"
    for (( i=0; i<${total}; i++ )); do
        if [[ "$i" == 0 ]]; then
            echo "${TASKMANAGER[$i]}"       > "${CONFIG_PATH}/${CONFIG_NAME}-taskmanager.db"      # add_taskmanager  - array
        else
            echo "${TASKMANAGER[$i]}"      >> "${CONFIG_PATH}/${CONFIG_NAME}-taskmanager.db"      # add_taskmanager  - array
        fi
    done
    #    
    # add_packagemanager PACKMANAGER PACKMANAGER_NAME
    # PACKMANAGER_NAME
    copy_file "${CONFIG_PATH}/${CONFIG_NAME}-packagemanager-name.db" "${CONFIG_PATH}/${CONFIG_NAME}-packagemanager-name-old.db" "$(basename $BASH_SOURCE) : $LINENO"
    local -i total="${#PACKMANAGER_NAME[@]}"
    for (( i=0; i<${total}; i++ )); do
        if [[ "$i" == 0 ]]; then
            echo "${PACKMANAGER_NAME[$i]}"  > "${CONFIG_PATH}/${CONFIG_NAME}-packagemanager-name.db" # add_packagemanager  - array
        else
            echo "${PACKMANAGER_NAME[$i]}" >> "${CONFIG_PATH}/${CONFIG_NAME}-packagemanager-name.db" # add_packagemanager  - array
        fi
    done
    # PACKMANAGER
    copy_file "${CONFIG_PATH}/${CONFIG_NAME}-packagemanager.db" "${CONFIG_PATH}/${CONFIG_NAME}-packagemanager-old.db" "$(basename $BASH_SOURCE) : $LINENO"
    local -i total="${#PACKMANAGER[@]}"
    for (( i=0; i<${total}; i++ )); do
        if [[ "$i" == 0 ]]; then
            echo "${PACKMANAGER[$i]}"       > "${CONFIG_PATH}/${CONFIG_NAME}-packagemanager.db"      # add_packagemanager  - array
        else
            echo "${PACKMANAGER[$i]}"      >> "${CONFIG_PATH}/${CONFIG_NAME}-packagemanager.db"      # add_packagemanager  - array
        fi
    done
    #
    # PACKAGES
    copy_file "${CONFIG_PATH}/${CONFIG_NAME}-packages.db" "${CONFIG_PATH}/${CONFIG_NAME}-packages-old.db" "$(basename $BASH_SOURCE) : $LINENO"
    local -i total="${#PACKAGES[@]}"
    for (( i=0; i<${total}; i++ )); do
        if [[ "$i" == 0 ]]; then
            echo "${PACKAGES[$i]}"         > "${CONFIG_PATH}/${CONFIG_NAME}-packages.db"             # add_package         - array
        else
            echo "${PACKAGES[$i]}"        >> "${CONFIG_PATH}/${CONFIG_NAME}-packages.db"             # add_package         - array
        fi
    done
    #
    # AUR_PACKAGES
    copy_file "${CONFIG_PATH}/${CONFIG_NAME}-aur-packages.db" "${CONFIG_PATH}/${CONFIG_NAME}-aur-packages-old.db" "$(basename $BASH_SOURCE) : $LINENO"
    local -i total="${#AUR_PACKAGES[@]}"
    for (( i=0; i<${total}; i++ )); do
        if [[ "$i" == 0 ]]; then
            echo "${AUR_PACKAGES[$i]}"   > "${CONFIG_PATH}/${CONFIG_NAME}-aur-packages.db"           # add_aur_package  - array
        else
            echo "${AUR_PACKAGES[$i]}"  >> "${CONFIG_PATH}/${CONFIG_NAME}-aur-packages.db"           # add_aur_package  - array
        fi
    done
    # USER_GROUPS
    copy_file "${CONFIG_PATH}/${CONFIG_NAME}-user-groups.db" "${CONFIG_PATH}/${CONFIG_NAME}-user-groups-old.db" "$(basename $BASH_SOURCE) : $LINENO"
    total="${#USER_GROUPS[@]}"
    for (( i=0; i<${total}; i++ )); do
        if [[ "$i" == 0 ]]; then
            echo "${USER_GROUPS[$i]}"      >  "${CONFIG_PATH}/${CONFIG_NAME}-user-groups.db"         # add_user_group      - array
        else
            echo "${USER_GROUPS[$i]}"      >> "${CONFIG_PATH}/${CONFIG_NAME}-user-groups.db"         # add_user_group      - array
        fi
    done
    copy_file "${CONFIG_PATH}/${CONFIG_NAME}-software-config.db" "${CONFIG_PATH}/${CONFIG_NAME}-software-config-old.db" "$(basename $BASH_SOURCE) : $LINENO"
    # WEBSERVER
    echo "?WEBSERVER"           > "${CONFIG_PATH}/${CONFIG_NAME}-software-config.db"
    echo "$WEBSERVER"          >> "${CONFIG_PATH}/${CONFIG_NAME}-software-config.db"
    # CONFIG_ORPHAN
    echo "?CONFIG_ORPHAN"      >> "${CONFIG_PATH}/${CONFIG_NAME}-software-config.db"
    echo "$CONFIG_ORPHAN"      >> "${CONFIG_PATH}/${CONFIG_NAME}-software-config.db"
    # CONFIG_XORG
    echo "?CONFIG_XORG"        >> "${CONFIG_PATH}/${CONFIG_NAME}-software-config.db"
    echo "$CONFIG_XORG"        >> "${CONFIG_PATH}/${CONFIG_NAME}-software-config.db"
    # CONFIG_SSH
    echo "?CONFIG_SSH"         >> "${CONFIG_PATH}/${CONFIG_NAME}-software-config.db"
    echo "$CONFIG_SSH"         >> "${CONFIG_PATH}/${CONFIG_NAME}-software-config.db"
    # CONFIG_TOR
    echo "?CONFIG_TOR"         >> "${CONFIG_PATH}/${CONFIG_NAME}-software-config.db"
    echo "$CONFIG_TOR"         >> "${CONFIG_PATH}/${CONFIG_NAME}-software-config.db"
    # CONFIG_KDE
    echo "?CONFIG_KDE"         >> "${CONFIG_PATH}/${CONFIG_NAME}-software-config.db"
    echo "$CONFIG_KDE"         >> "${CONFIG_PATH}/${CONFIG_NAME}-software-config.db"
    # VIDEO_CARD
    echo "?VIDEO_CARD"         >> "${CONFIG_PATH}/${CONFIG_NAME}-software-config.db"
    echo "$VIDEO_CARD"         >> "${CONFIG_PATH}/${CONFIG_NAME}-software-config.db"
    # MATE_INSTALLED
    echo "?MATE_INSTALLED"     >> "${CONFIG_PATH}/${CONFIG_NAME}-software-config.db"
    echo "$MATE_INSTALLED"     >> "${CONFIG_PATH}/${CONFIG_NAME}-software-config.db"
    # GNOME_INSTALL
    echo "?GNOME_INSTALL"      >> "${CONFIG_PATH}/${CONFIG_NAME}-software-config.db"
    echo "$GNOME_INSTALL"      >> "${CONFIG_PATH}/${CONFIG_NAME}-software-config.db"
    # XFCE_INSTALLED
    echo "?XFCE_INSTALLED"     >> "${CONFIG_PATH}/${CONFIG_NAME}-software-config.db"
    echo "$XFCE_INSTALLED"     >> "${CONFIG_PATH}/${CONFIG_NAME}-software-config.db"
    # E17_INSTALLED
    echo "?E17_INSTALLED"      >> "${CONFIG_PATH}/${CONFIG_NAME}-software-config.db"
    echo "$E17_INSTALLED"      >> "${CONFIG_PATH}/${CONFIG_NAME}-software-config.db"
    # KDE_INSTALLED
    echo "?KDE_INSTALLED"      >> "${CONFIG_PATH}/${CONFIG_NAME}-software-config.db"
    echo "$KDE_INSTALLED"      >> "${CONFIG_PATH}/${CONFIG_NAME}-software-config.db"
    # LXDE_INSTALLED
    echo "?LXDE_INSTALLED"     >> "${CONFIG_PATH}/${CONFIG_NAME}-software-config.db"
    echo "$LXDE_INSTALLED"     >> "${CONFIG_PATH}/${CONFIG_NAME}-software-config.db"
    # OPENBOX_INSTALLED
    echo "?OPENBOX_INSTALLED"  >> "${CONFIG_PATH}/${CONFIG_NAME}-software-config.db"
    echo "$OPENBOX_INSTALLED"  >> "${CONFIG_PATH}/${CONFIG_NAME}-software-config.db"
    # AWESOME_INSTALLED
    echo "?AWESOME_INSTALLED"  >> "${CONFIG_PATH}/${CONFIG_NAME}-software-config.db"
    echo "$AWESOME_INSTALLED"  >> "${CONFIG_PATH}/${CONFIG_NAME}-software-config.db"
    # GNOME_INSTALLED
    echo "?GNOME_INSTALLED"    >> "${CONFIG_PATH}/${CONFIG_NAME}-software-config.db"
    echo "$GNOME_INSTALLED"    >> "${CONFIG_PATH}/${CONFIG_NAME}-software-config.db"
    # CINNAMON_INSTALLED
    echo "?CINNAMON_INSTALLED" >> "${CONFIG_PATH}/${CONFIG_NAME}-software-config.db"
    echo "$CINNAMON_INSTALLED" >> "${CONFIG_PATH}/${CONFIG_NAME}-software-config.db"
    # UNITY_INSTALLED
    echo "?UNITY_INSTALLED"    >> "${CONFIG_PATH}/${CONFIG_NAME}-software-config.db"
    echo "$UNITY_INSTALLED"    >> "${CONFIG_PATH}/${CONFIG_NAME}-software-config.db"
    #
    save_last_config
}
#}}}
# -----------------------------------------------------------------------------
# SAVE LAST CONFIG {{{
NAME="save_last_config"
USAGE="save_last_config"
DESCRIPTION=$(localize "SAVE-LAST-CONFIG-DESC")
NOTES=$(localize "NONE")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "SAVE-LAST-CONFIG-DESC"  "Save Last Config"
# -------------------------------------
save_last_config()
{
    if [ "${#LOCALE_ARRAY}" -eq 0 ]; then
        print_warning "Nothing has been configured yet! LOCALE_ARRAY=${LOCALE_ARRAY[*]} is empty on line $(basename $BASH_SOURCE) : $LINENO"
        abort_install
    fi
    # 
    copy_file "${CONFIG_PATH}/${CONFIG_NAME}-last-config.db" "${CONFIG_PATH}/${CONFIG_NAME}-last-config-old.db" "$(basename $BASH_SOURCE) : $LINENO"
    # CONFIG_HOSTNAME
    echo "?CONFIG_HOSTNAME"      >  "${CONFIG_PATH}/${CONFIG_NAME}-last-config.db"
    echo "$CONFIG_HOSTNAME"      >> "${CONFIG_PATH}/${CONFIG_NAME}-last-config.db"
    # USERNAME
    echo "?USERNAME"             >> "${CONFIG_PATH}/${CONFIG_NAME}-last-config.db"
    echo "${USERNAME}"           >> "${CONFIG_PATH}/${CONFIG_NAME}-last-config.db"
    # KEYBOARD
    echo "?KEYBOARD"             >> "${CONFIG_PATH}/${CONFIG_NAME}-last-config.db"
    echo "$KEYBOARD"             >> "${CONFIG_PATH}/${CONFIG_NAME}-last-config.db"
    # NETWORK_MANAGER
    echo "?NETWORK_MANAGER"      >> "${CONFIG_PATH}/${CONFIG_NAME}-last-config.db"
    echo "$NETWORK_MANAGER"      >> "${CONFIG_PATH}/${CONFIG_NAME}-last-config.db"
    # EDITOR
    echo "?EDITOR"               >> "${CONFIG_PATH}/${CONFIG_NAME}-last-config.db"
    echo "$EDITOR"               >> "${CONFIG_PATH}/${CONFIG_NAME}-last-config.db"
    # KEYMAP
    echo "?KEYMAP"               >> "${CONFIG_PATH}/${CONFIG_NAME}-last-config.db"
    echo "$KEYMAP"               >> "${CONFIG_PATH}/${CONFIG_NAME}-last-config.db"
    # COUNTRY_CODE
    echo "?COUNTRY_CODE"         >> "${CONFIG_PATH}/${CONFIG_NAME}-last-config.db"
    echo "$COUNTRY_CODE"         >> "${CONFIG_PATH}/${CONFIG_NAME}-last-config.db"
    # COUNTRY
    echo "?COUNTRY"              >> "${CONFIG_PATH}/${CONFIG_NAME}-last-config.db"
    echo "$COUNTRY"              >> "${CONFIG_PATH}/${CONFIG_NAME}-last-config.db"
    # FSTAB_CONFIG
    echo "?FSTAB_CONFIG"         >> "${CONFIG_PATH}/${CONFIG_NAME}-last-config.db"
    echo "$FSTAB_CONFIG"         >> "${CONFIG_PATH}/${CONFIG_NAME}-last-config.db"
    # FSTAB_EDIT
    echo "?FSTAB_EDIT"           >> "${CONFIG_PATH}/${CONFIG_NAME}-last-config.db"
    echo "$FSTAB_EDIT"           >> "${CONFIG_PATH}/${CONFIG_NAME}-last-config.db"
    # LOCALE
    echo "?LOCALE"               >> "${CONFIG_PATH}/${CONFIG_NAME}-last-config.db"
    echo "$LOCALE"               >> "${CONFIG_PATH}/${CONFIG_NAME}-last-config.db"
    # AUR_HELPER
    echo "?AUR_HELPER"           >> "${CONFIG_PATH}/${CONFIG_NAME}-last-config.db"
    echo "$AUR_HELPER"           >> "${CONFIG_PATH}/${CONFIG_NAME}-last-config.db"
    # AUR_REPO_NAME
    echo "?AUR_REPO_NAME"        >> "${CONFIG_PATH}/${CONFIG_NAME}-last-config.db"
    echo "$AUR_REPO_NAME"        >> "${CONFIG_PATH}/${CONFIG_NAME}-last-config.db"
    # AUR_REPO
    echo "?AUR_REPO"             >> "${CONFIG_PATH}/${CONFIG_NAME}-last-config.db"
    echo "$AUR_REPO"             >> "${CONFIG_PATH}/${CONFIG_NAME}-last-config.db"
    # PACMAN_OPTIMIZER
    echo "?PACMAN_OPTIMIZER"     >> "${CONFIG_PATH}/${CONFIG_NAME}-last-config.db"
    echo "$PACMAN_OPTIMIZER"     >> "${CONFIG_PATH}/${CONFIG_NAME}-last-config.db"
    # PACMAN_REPO_TYPE
    echo "?PACMAN_REPO_TYPE"     >> "${CONFIG_PATH}/${CONFIG_NAME}-last-config.db"
    echo "$PACMAN_REPO_TYPE"     >> "${CONFIG_PATH}/${CONFIG_NAME}-last-config.db"
    # IS_CUSTOM_NAMESERVER
    echo "?IS_CUSTOM_NAMESERVER" >> "${CONFIG_PATH}/${CONFIG_NAME}-last-config.db"
    echo "$IS_CUSTOM_NAMESERVER" >> "${CONFIG_PATH}/${CONFIG_NAME}-last-config.db"
    # CUSTOM_MIRRORLIST
    echo "?CUSTOM_MIRRORLIST"    >> "${CONFIG_PATH}/${CONFIG_NAME}-last-config.db"
    echo "$CUSTOM_MIRRORLIST"    >> "${CONFIG_PATH}/${CONFIG_NAME}-last-config.db"
    # FLESH
    echo "?FLESH"                >> "${CONFIG_PATH}/${CONFIG_NAME}-last-config.db"
    echo "$FLESH"                >> "${CONFIG_PATH}/${CONFIG_NAME}-last-config.db"
    # ZONE
    echo "?ZONE"                 >> "${CONFIG_PATH}/${CONFIG_NAME}-last-config.db"
    echo "$ZONE"                 >> "${CONFIG_PATH}/${CONFIG_NAME}-last-config.db"
    # SUBZONE
    echo "?SUBZONE"              >> "${CONFIG_PATH}/${CONFIG_NAME}-last-config.db"
    echo "$SUBZONE"              >> "${CONFIG_PATH}/${CONFIG_NAME}-last-config.db"
    # LOCALE_ARRAY
    copy_file "${CONFIG_PATH}/${CONFIG_NAME}-locale.db" "${CONFIG_PATH}/${CONFIG_NAME}-locale-old.db" "$(basename $BASH_SOURCE) : $LINENO"
    # ${#LOCALE_ARRAY[*]}
    total="${#LOCALE_ARRAY[@]}"
    for (( i=0; i<${total}; i++ )); do
        if [[ "$i" == 0 ]]; then
            echo "${LOCALE_ARRAY[$i]}"         >  "${CONFIG_PATH}/${CONFIG_NAME}-locale.db"       #   - array
        else
            echo "${LOCALE_ARRAY[$i]}"         >> "${CONFIG_PATH}/${CONFIG_NAME}-locale.db"       #   - array
        fi
    done
    #
    IS_LAST_CONFIG_LOADED=1
}
#}}}
# -----------------------------------------------------------------------------
# SAVE DISK CONFIG {{{
NAME="save_disk_config"
USAGE="save_disk_config"
DESCRIPTION=$(localize "SAVE-DISK-CONFIG-DESC")
NOTES=$(localize "NONE")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "SAVE-DISK-CONFIG-DESC"  "Save Disk Configuration"
# -------------------------------------
save_disk_config()
{
    copy_file "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db" "${CONFIG_PATH}/${CONFIG_NAME}-disk-config-old.db" "$(basename $BASH_SOURCE) : $LINENO"
    # 
    # UEFI
    echo "?UEFI"              >  "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db" # Clear File
    echo "$UEFI"              >> "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db"
    # UEFI_SIZE
    echo "?UEFI_SIZE"         >> "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db"
    echo "$UEFI_SIZE"         >> "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db"
    # IS_BOOT_PARTITION
    echo "?IS_BOOT_PARTITION" >> "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db"
    echo "$IS_BOOT_PARTITION" >> "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db"
    # BOOT_SYSTEM_TYPE
    echo "?BOOT_SYSTEM_TYPE"  >> "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db"
    echo "$BOOT_SYSTEM_TYPE"  >> "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db"
    # BOOT_SIZE
    echo "?BOOT_SIZE"         >> "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db"
    echo "$BOOT_SIZE"         >> "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db"
    # IS_SWAP_PARTITION
    echo "?IS_SWAP_PARTITION" >> "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db"
    echo "$IS_SWAP_PARTITION" >> "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db"
    # SWAP_SIZE
    echo "?SWAP_SIZE"         >> "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db"
    echo "$SWAP_SIZE"         >> "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db"
    # ROOT_SIZE
    echo "?ROOT_SIZE"         >> "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db"
    echo "$ROOT_SIZE"         >> "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db"
    # ROOT_FORMAT
    echo "?ROOT_FORMAT"       >> "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db"
    echo "$ROOT_FORMAT"       >> "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db"
    # IS_HOME_PARTITION
    echo "?IS_HOME_PARTITION" >> "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db"
    echo "$IS_HOME_PARTITION" >> "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db"
    # HOME_SIZE
    echo "?HOME_SIZE"         >> "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db"
    echo "$HOME_SIZE"         >> "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db"
    # HOME_FORMAT
    echo "?HOME_FORMAT"       >> "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db"
    echo "$HOME_FORMAT"       >> "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db"
    # IS_HOME_DRIVE
    echo "?IS_HOME_DRIVE"     >> "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db"
    echo "$IS_HOME_DRIVE"     >> "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db"
    # IS_VAR_PARTITION
    echo "?IS_VAR_PARTITION"  >> "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db"
    echo "$IS_VAR_PARTITION"  >> "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db"
    # VAR_SIZE
    echo "?VAR_SIZE"          >> "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db"
    echo "$VAR_SIZE"          >> "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db"
    # VAR_FORMAT
    echo "?VAR_FORMAT"        >> "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db"
    echo "$VAR_FORMAT"        >> "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db"
    # IS_VAR_DRIVE
    echo "?IS_VAR_DRIVE"      >> "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db"
    echo "$IS_VAR_DRIVE"      >> "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db"
    # IS_TMP_PARTITION
    echo "?IS_TMP_PARTITION"  >> "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db"
    echo "$IS_TMP_PARTITION"  >> "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db"
    # IS_TMP_SIZE
    echo "?IS_TMP_SIZE"       >> "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db"
    echo "$IS_TMP_SIZE"       >> "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db"
    # TMP_SIZE
    echo "?TMP_SIZE"          >> "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db"
    echo "$TMP_SIZE"          >> "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db"
    # TMP_FORMAT
    echo "?TMP_FORMAT"        >> "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db"
    echo "$TMP_FORMAT"        >> "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db"
    # EDIT_GDISK
    echo "?EDIT_GDISK"        >> "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db"
    echo "$EDIT_GDISK"        >> "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db"
    # IS_SSD
    echo "?IS_SSD"            >> "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db"
    echo "$IS_SSD"            >> "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db"
}
#}}}
# -----------------------------------------------------------------------------
# IS SOFTWARE FILES {{{
NAME="is_software_files"
USAGE="is_software_files"
DESCRIPTION=$(localize "IS-SOFTWARE-FILES-DESC")
NOTES=$(localize "NONE")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "IS-SOFTWARE-FILES-DESC"  "Test if all Config files exist"
# -------------------------------------
is_software_files()
{
    declare -a test_file_names=( "packagemanager-name.db" "packagemanager.db" "packages.db" "aur-packages.db" "user-groups.db" "software-config.db" )
    declare -i test_passed=1
    total="${#test_file_names[@]}"
    for (( i=0; i<${total}; i++ )); do
        if [ ! -f "${CONFIG_PATH}/${CONFIG_NAME}-${test_file_names[$i]}" ]; then
            print_warning "${CONFIG_PATH}/${CONFIG_NAME}-${test_file_names[$i]} File Missing! Will create new one."
            if [[ "$DEBUGGING" -eq 1 ]]; then pause_function "is_software_files @ $(basename $BASH_SOURCE) : $LINENO"; fi
            test_passed=0
            break;
        fi
    done
    if [[ "$test_passed" -eq 1 ]]; then
        return 0
    else
        return 1
    fi
}
#}}}
# -----------------------------------------------------------------------------
# LOAD SOFTWARE {{{
NAME="load_software"
USAGE="load_software"
DESCRIPTION=$(localize "LOAD-SOFTWARE-DESC")
NOTES=$(localize "NONE")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "LOAD-SOFTWARE-DESC"  "Load Software Configuration files"
# -------------------------------------
load_software()
{
    # Test each file
    local -i TEST_1=0
    local -i TEST_2=0
    local -i TEST_3=0
    local -i TEST_4=0
    local -i TEST_5=0
    local -i TEST_6=0
    local -i TEST_7=0
    local -i TEST_8=0
    # TASKMANAGER
    # TASKMANAGER_NAME - add_taskmanager - array
    if [[ -f "${CONFIG_PATH}/${CONFIG_NAME}-taskmanager-name.db" ]]; then
        i=0
        while read line; do 
            TASKMANAGER_NAME[$((i++))]="$line"
        done < "${CONFIG_PATH}/${CONFIG_NAME}-taskmanager-name.db"
        TEST_1=1
    else
        echo "No ${CONFIG_PATH}/${CONFIG_NAME}-taskmanager-name.db"
        pause_function "load_software $(basename $BASH_SOURCE) : $LINENO"
    fi
    # TASKMANAGER - add_taskmanager - array
    if [[ -f "${CONFIG_PATH}/${CONFIG_NAME}-taskmanager.db" ]]; then
        i=0
        while read line; do 
            TASKMANAGER[$((i++))]="$line"
        done < "${CONFIG_PATH}/${CONFIG_NAME}-taskmanager.db"
        TEST_2=1
    else
        echo "No ${CONFIG_PATH}/${CONFIG_NAME}-taskmanager.db"
        pause_function "load_software $(basename $BASH_SOURCE) : $LINENO"
    fi
    # PACKMANAGER_NAME - add_packagemanager - array
    if [[ -f "${CONFIG_PATH}/${CONFIG_NAME}-packagemanager-name.db" ]]; then
        i=0
        while read line; do 
            PACKMANAGER_NAME[$((i++))]="$line"
        done < "${CONFIG_PATH}/${CONFIG_NAME}-packagemanager-name.db"
        TEST_3=1
    else
        echo "No ${CONFIG_PATH}/${CONFIG_NAME}-packagemanager-name.db"
        pause_function "load_software $(basename $BASH_SOURCE) : $LINENO"
    fi
    # PACKMANAGER - add_packagemanager - array
    if [[ -f "${CONFIG_PATH}/${CONFIG_NAME}-packagemanager.db" ]]; then
        i=0
        while read line; do 
            PACKMANAGER[$((i++))]="$line"
        done < "${CONFIG_PATH}/${CONFIG_NAME}-packagemanager.db"
        TEST_4=1
    else
        echo "No ${CONFIG_PATH}/${CONFIG_NAME}-packagemanager.db"
        pause_function "load_software $(basename $BASH_SOURCE) : $LINENO"
    fi
    # PACKAGES
    if [[ -f "${CONFIG_PATH}/${CONFIG_NAME}-packages.db" ]]; then
        i=0
        while read line; do 
            PACKAGES[$((i++))]="$line"
        done < "${CONFIG_PATH}/${CONFIG_NAME}-packages.db"
        TEST_5=1
    else
        echo "No ${CONFIG_PATH}/${CONFIG_NAME}-packages.db"
        pause_function "load_software $(basename $BASH_SOURCE) : $LINENO"
    fi
    # AUR_PACKAGES
    if [[ -f "${CONFIG_PATH}/${CONFIG_NAME}-aur-packages.db" ]]; then
        i=0
        while read line; do 
            AUR_PACKAGES[$((i++))]="$line"
        done < "${CONFIG_PATH}/${CONFIG_NAME}-aur-packages.db"
        TEST_6=1
    else
        echo "No ${CONFIG_PATH}/${CONFIG_NAME}-aur-packages.db"
        pause_function "load_software $(basename $BASH_SOURCE) : $LINENO"
    fi
    #
    # users - add_user_group - array
    if [[ -f "${CONFIG_PATH}/${CONFIG_NAME}-user-groups.db" ]]; then
        while read line; do 
            add_user_group "$line"
        done < "${CONFIG_PATH}/${CONFIG_NAME}-user-groups.db"
        TEST_7=1
    else
        echo "No ${CONFIG_PATH}/${CONFIG_NAME}-user-groups.db"
        pause_function "load_software $(basename $BASH_SOURCE) : $LINENO"
    fi
    # Store only if 1
    if [[ -f "${CONFIG_PATH}/${CONFIG_NAME}-software-config.db" ]]; then
        while read line; do 
            if [[ "${line:0:1}" == "?" ]]; then
                THE_VAR="${line:1}"
            else
                case "$THE_VAR" in
                    "WEBSERVER")   
                        WEBSERVER="$line"    
                        ;;
                    "CONFIG_ORPHAN")
                        CONFIG_ORPHAN="$line"
                        ;;
                    "CONFIG_XORG")
                        CONFIG_XORG="$line"
                        ;;
                    "CONFIG_SSH")
                        CONFIG_SSH="$line"
                        ;;
                    "CONFIG_TOR")
                        CONFIG_TOR="$line"
                        ;;
                    "CONFIG_KDE")
                        CONFIG_KDE="$line"
                        ;;
                    "VIDEO_CARD")
                        VIDEO_CARD="$line"
                        ;;
                    "MATE_INSTALLED")   
                        MATE_INSTALLED="$line"    
                        ;;
                    "GNOME_INSTALL")   
                        GNOME_INSTALL="$line"    
                        ;;
                    "XFCE_INSTALLED")   
                        XFCE_INSTALLED="$line"    
                        ;;
                    "E17_INSTALLED")   
                        E17_INSTALLED="$line"    
                        ;;
                    "KDE_INSTALLED")   
                        KDE_INSTALLED="$line"    
                        ;;
                    "LXDE_INSTALLED")   
                        LXDE_INSTALLED="$line"    
                        ;;
                    "OPENBOX_INSTALLED")   
                        OPENBOX_INSTALLED="$line"    
                        ;;
                    "AWESOME_INSTALLED")   
                        AWESOME_INSTALLED="$line"    
                        ;;
                    "GNOME_INSTALLED")   
                        GNOME_INSTALLED="$line"    
                        ;;
                    "CINNAMON_INSTALLED")   
                        CINNAMON_INSTALLED="$line"    
                        ;;
                    "UNITY_INSTALLED")   
                        UNITY_INSTALLED="$line"    
                        ;;
               esac
            fi
        done < "${CONFIG_PATH}/${CONFIG_NAME}-software-config.db"
        TEST_8=1
    else
        echo "No ${CONFIG_PATH}/${CONFIG_NAME}-software-config.db"
        pause_function "load_software $(basename $BASH_SOURCE) : $LINENO"
    fi
    
    if [[ "$TEST_1" -eq 1 && "$TEST_2" -eq 1 && "$TEST_3" -eq 1 && "$TEST_4" -eq 1 && "$TEST_5" -eq 1 && "$TEST_6" -eq 1 && "$TEST_7" -eq 1 && "$TEST_8" -eq 1 ]]; then
        IS_SOFTWARE_CONFIG_LOADED=1
    fi
    unset TEST_1
    unset TEST_2
    unset TEST_3
    unset TEST_4
    unset TEST_5
    unset TEST_6
    unset TEST_7
    unset TEST_8
}
#}}}
# -----------------------------------------------------------------------------
# IS LAST CONFIG FILES {{{
NAME="is_last_config_files"
USAGE="is_last_config_files"
DESCRIPTION=$(localize "IS-LAST-CONFIG-FILES-DESC")
NOTES=$(localize "NONE")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "IS-LAST-CONFIG-FILES-DESC"  "Test if all Config files exist"
# -------------------------------------
is_last_config_files()
{
    declare -a test_file_names=( "last-config.db" "locale.db" )
    declare -i test_passed=1
    total="${#test_file_names[@]}"
    for (( i=0; i<${total}; i++ )); do
        if [ ! -f "${CONFIG_PATH}/${CONFIG_NAME}-${test_file_names[$i]}" ]; then
            print_warning "${CONFIG_PATH}/${CONFIG_NAME}-${test_file_names[$i]} File Missing! Will create new one."
            if [[ "$DEBUGGING" -eq 1 ]]; then pause_function "is_last_config_files @ $(basename $BASH_SOURCE) : $LINENO"; fi
            test_passed=0
            break;
        fi
    done
    if [[ "$test_passed" -eq 1 ]]; then
        return 0
    else
        return 1
    fi
}
#}}}
# -----------------------------------------------------------------------------
# LOAD LAST CONFIG {{{
NAME="load_last_config"
USAGE="load_last_config"
DESCRIPTION=$(localize "LOAD-LAST-CONFIG-DESC")
NOTES=$(localize "NONE")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "LOAD-LAST-CONFIG-DESC"  "Last Configuration is User Specific Settings like USERNAME, LOCALE, HOSTNAME, KEYMAP COUNTRY, TIMEZONE and more."
# -------------------------------------
load_last_config()
{
    # CONFIG_HOSTNAME USERNAME KEYBOARD
    # 
    if [[ -f "${CONFIG_PATH}/${CONFIG_NAME}-last-config.db" ]]; then
        while read line; do 
            if [[ "${line:0:1}" == "?" ]]; then
                THE_VAR="${line:1}"
            else
                case "$THE_VAR" in
                    "CONFIG_HOSTNAME")
                        CONFIG_HOSTNAME="$line"
                        ;;
                    "USERNAME")
                        USERNAME="$line"
                        ;;
                    "KEYBOARD")
                        KEYBOARD="$line"
                        ;;
                    "NETWORK_MANAGER")
                        NETWORK_MANAGER="$line"
                        ;;
                    "EDITOR")
                        EDITOR="$line"
                        ;;
                    "KEYMAP")
                        KEYMAP="$line"
                        ;;
                    "COUNTRY_CODE")
                        COUNTRY_CODE="$line"
                        ;;
                    "COUNTRY")
                        COUNTRY="$line"
                        ;;
                    "FSTAB_CONFIG")
                        FSTAB_CONFIG="$line"
                        ;;
                    "FSTAB_EDIT")
                        FSTAB_EDIT="$line"
                        ;;
                    "LOCALE")
                        LOCALE="$line"
                        set_language "$LOCALE"
                        ;;
                    "IS_CUSTOM_NAMESERVER")
                        IS_CUSTOM_NAMESERVER="$line"
                        ;;
                    "CUSTOM_MIRRORLIST")
                        CUSTOM_MIRRORLIST="$line"
                        ;;
                    "FLESH")
                        FLESH="$line"
                        ;;
                    "ZONE")
                        ZONE="$line"
                        ;;
                    "SUBZONE")
                        SUBZONE="$line"
                        ;;
                    "AUR_HELPER")
                        AUR_HELPER="$line"
                        ;;
                    "AUR_REPO_NAME")
                        AUR_REPO_NAME="$line"
                        ;;
                    "AUR_REPO")
                        AUR_REPO="$line"
                        ;;
                    "PACMAN_OPTIMIZER")   
                        PACMAN_OPTIMIZER="$line"    
                        ;;
                    "PACMAN_REPO_TYPE")   
                        PACMAN_REPO_TYPE="$line"    
                        ;;
               esac
            fi
        done < "${CONFIG_PATH}/${CONFIG_NAME}-last-config.db"
        IS_LAST_CONFIG_LOADED=1
    else
        echo "No ${CONFIG_PATH}/${CONFIG_NAME}-last-config.db"
        pause_function "load_last_config $(basename $BASH_SOURCE) : $LINENO"
    fi
    if [[ "$IS_CUSTOM_NAMESERVER" -eq 1 ]]; then
        read_nameserver
    fi
    # LOCALE_ARRAY
    declare -i i=0
    if [[ -f "${CONFIG_PATH}/${CONFIG_NAME}-locale.db" ]]; then
        while read line; do 
            LOCALE_ARRAY[$((i++))]="$line"
        done < "${CONFIG_PATH}/${CONFIG_NAME}-locale.db"
    else
        IS_LAST_CONFIG_LOADED=0
        echo "No ${CONFIG_PATH}/${CONFIG_NAME}-locale.db"
        pause_function "load_last_config $(basename $BASH_SOURCE) : $LINENO"
    fi
}
#}}}
# -----------------------------------------------------------------------------
# LOAD DISK CONFIG {{{
NAME="load_disk_config"
USAGE="load_disk_config"
DESCRIPTION=$(localize "LOAD-DISK-CONFIG-DESC")
NOTES=$(localize "NONE")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "LOAD-DISK-CONFIG-DESC"  "Load Disk Configuration"
# -------------------------------------
load_disk_config()
{
    if [[ -f "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db" ]]; then
        while read line; do 
            if [[ "${line:0:1}" == "?" ]]; then
                THE_VAR="${line:1}"
            else
                case "$THE_VAR" in
                    "UEFI")
                        UEFI="$line"
                        ;;
                    "UEFI_SIZE")
                        UEFI_SIZE="$line"
                        ;;
                    "IS_BOOT_PARTITION")
                        IS_BOOT_PARTITION="$line"
                        ;;
                    "BOOT_SYSTEM_TYPE")
                        BOOT_SYSTEM_TYPE="$line"
                        ;;
                    "BOOT_SIZE")
                        BOOT_SIZE="$line"
                        ;;
                    "IS_SWAP_PARTITION")
                        IS_SWAP_PARTITION="$line"
                        ;;
                    "SWAP_SIZE")
                        SWAP_SIZE="$line"
                        ;;
                    "ROOT_SIZE")
                        ROOT_SIZE="$line"
                        ;;
                    "ROOT_FORMAT")
                        ROOT_FORMAT="$line"
                        ;;
                    "IS_HOME_PARTITION")
                        IS_HOME_PARTITION="$line"
                        ;;
                    "HOME_SIZE")
                        HOME_SIZE="$line"
                        ;;
                    "HOME_FORMAT")
                        HOME_FORMAT="$line"
                        ;;
                    "IS_HOME_DRIVE")
                        IS_HOME_DRIVE="$line"
                        ;;
                    "IS_VAR_PARTITION")
                        IS_VAR_PARTITION="$line"
                        ;;
                    "VAR_SIZE")
                        VAR_SIZE="$line"
                        ;;
                    "VAR_FORMAT")
                        VAR_FORMAT="$line"
                        ;;
                    "IS_VAR_DRIVE")
                        IS_VAR_DRIVE="$line"
                        ;;
                    "IS_TMP_PARTITION")
                        IS_TMP_PARTITION="$line"
                        ;;
                    "IS_TMP_SIZE")
                        IS_TMP_SIZE="$line"
                        ;;
                    "TMP_SIZE")
                        TMP_SIZE="$line"
                        ;;
                    "TMP_FORMAT")
                        TMP_FORMAT="$line"
                        ;;
                    "EDIT_GDISK")
                        EDIT_GDISK="$line"
                        ;;
                    "IS_SSD")
                        IS_SSD="$line"
                        ;;
               esac
            fi
        done < "${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db"
        IS_DISK_CONFIG_LOADED=1
    else
        echo "No ${CONFIG_PATH}/${CONFIG_NAME}-disk-config.db"
        pause_function "load_disk_config $(basename $BASH_SOURCE) : $LINENO"
    fi
}
#}}}
# -----------------------------------------------------------------------------
# ADD PACKAGEMANAGER {{{
NAME="add_packagemanager"
USAGE=$(localize "ADD-PACKAGEMANAGER-USAGE")
DESCRIPTION=$(localize "ADD-PACKAGEMANAGER-DESC")
NOTES=$(localize "ADD-PACKAGEMANAGER-NOTES")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "ADD-PACKAGEMANAGER-USAGE" "add_packagemanager 1->(COMMAND-LINE) 2->(NAME-OF-PACKAGE)"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "ADD-PACKAGEMANAGER-DESC"  "Add A Package to the Manager"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "ADD-PACKAGEMANAGER-NOTES" "Hart of System."
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "ADD-PACKAGEMANAGER-ERROR"  "Wrong Parameters passed to add_packagemanager"
# -------------------------------------
add_packagemanager()
{
    check_arg "add_packagemanager" "2" "${#@}" "$(basename $BASH_SOURCE) : $LINENO"
    if [ -z "$2" ]; then
        print_warning "ADD-PACKAGEMANAGER-ERROR"
        abort_install
    fi
    CMD="$(rtrim $1)"
    if [[ -z "$CMD" || "$CMD" == "" ]]; then
        return 1
    fi
    # Check to see if its in Array    
    if ! is_in_array "PACKMANAGER_NAME[@]" "$2" ; then
        if [ "${#PACKMANAGER}" -eq 0 ]; then
            PACKMANAGER[0]="$1"
        else
            PACKMANAGER[${#PACKMANAGER[*]}]="$1"
        fi
        if [ "${#PACKMANAGER_NAME}" -eq 0 ]; then
            PACKMANAGER_NAME[0]="$2"
        else
            PACKMANAGER_NAME[${#PACKMANAGER_NAME[*]}]="$2"
        fi
    fi
    return 0
}
#}}}
# -----------------------------------------------------------------------------
# REMOVE PACKAGEMANAGER {{{
NAME="remove_packagemanager"
USAGE=$(localize "REMOVE-PACKAGEMANAGER-USAGE")
DESCRIPTION=$(localize "REMOVE-PACKAGEMANAGER-DESC")
NOTES=$(localize "REMOVE-PACKAGEMANAGER-NOTES")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "REMOVE-PACKAGEMANAGER-USAGE" "remove_packagemanager 1->(NAME-OF-PACKAGE)"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "REMOVE-PACKAGEMANAGER-DESC"  "Remove A Package to the Manager"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "REMOVE-PACKAGEMANAGER-NOTES" "Hart of System."
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "REMOVE-PACKAGEMANAGER-ERROR"  "Wrong Parameters to add_packagemanager"
# -------------------------------------
remove_packagemanager()
{

    if is_in_array "PACKMANAGER_NAME[@]" "$1" ; then
        remove_from_array "PACKMANAGER_NAME" "$1"
        remove_from_array "PACKMANAGER" "$1"
    fi
}
#}}}
# -----------------------------------------------------------------------------
# ADD TASKMANAGER {{{
NAME="add_taskmanager"
USAGE=$(localize "ADD-TASKMANAGER-USAGE")
DESCRIPTION=$(localize "ADD-TASKMANAGER-DESC")
NOTES=$(localize "NONE")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "ADD-TASKMANAGER-USAGE" "add_taskmanager 1->(COMMAND-LINE) 2->(NAME-OF-PACKAGE)"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "ADD-TASKMANAGER-DESC"  "Add A Task to the Manager"
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "ADD-TASKMANAGER-ERROR"  "Wrong Parameters to add_taskmanager"
# -------------------------------------
add_taskmanager()
{
    check_arg "add_taskmanager" "2" "${#@}" "$(basename $BASH_SOURCE) : $LINENO"
    if [ -z "$2" ]; then
        print_warning "ADD-TASKMANAGER-ERROR"
        abort_install
    fi
    CMD="$(rtrim $1)"
    if [[ -z "$CMD" || "$CMD" == "" ]]; then
        return 1
    fi
    # Check to see if its in Array    
    if ! is_in_array "TASKMANAGER_NAME[@]" "$2" ; then
        if [ "${#TASKMANAGER}" -eq 0 ]; then
            TASKMANAGER[0]="$1"
        else
            TASKMANAGER[${#TASKMANAGER[*]}]="$1"
        fi
        if [ "${#TASKMANAGER_NAME}" -eq 0 ]; then
            TASKMANAGER_NAME[0]="$2"
        else
            TASKMANAGER_NAME[${#TASKMANAGER_NAME[*]}]="$2"
        fi
    fi
    return 0
}
#}}}
# -----------------------------------------------------------------------------
# 
# ADD PACKAGE {{{
NAME="add_package"
USAGE="ADD-PACKAGE-USAGE"
DESCRIPTION=$(localize "ADD-PACKAGE-DESC")
NOTES=$(localize "ADD-PACKAGE-NOTES")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "ADD-PACKAGE-USAGE" "add_package 1->(package)"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "ADD-PACKAGE-DESC"  "Add Package to PACKAGES array; for testing and building cache folder"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "ADD-PACKAGE-NOTES" "Call per Package Manager"
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "ADD-PACKAGE-ERROR"  "Wrong Parameters to add_package"
# -------------------------------------
add_package()
{ 
    check_arg "add_package" "1" "${#@}" "$(basename $BASH_SOURCE) : $LINENO"
    if [ -z "$1" ]; then
        print_warning "ADD-PACKAGE-ERROR" " @ $(basename $BASH_SOURCE) : $LINENO"
        abort_install
    fi
    CMD="$(rtrim $1)"
    if [[ -z "$CMD" || "$CMD" == "" ]]; then
        return 1
    fi
    for PACKAGE in $1; do
        if ! is_in_array "PACKAGES[@]" "$PACKAGE" ; then
            if [ "${#PACKAGES}" -eq 0 ]; then
                PACKAGES[0]="$PACKAGE"
            else
                PACKAGES[${#PACKAGES[*]}]="$PACKAGE"
            fi
        fi
    done
    return 0
} 
#}}}
# -----------------------------------------------------------------------------
# 
# REMOVE PACKAGE {{{
NAME="remove_package"
USAGE="REMOVE-PACKAGE-USAGE"
DESCRIPTION=$(localize "REMOVE-PACKAGE-DESC")
NOTES=$(localize "REMOVE-PACKAGE-NOTES")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "REMOVE-PACKAGE-USAGE" "remove_package 1->(package)"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "REMOVE-PACKAGE-DESC"  "Remove Package from PACKAGES array; for testing and building cache folder"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "REMOVE-PACKAGE-NOTES" "Call per Package Manager"
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "REMOVE-PACKAGE-ERROR"  "Wrong Parameters to remove_package"
# -------------------------------------
remove_package()
{ 
    check_arg "remove_package" "1" "${#@}" "$(basename $BASH_SOURCE) : $LINENO"
    if [ -z "$1" ]; then
        print_warning "REMOVE-PACKAGE-ERROR" " @ $(basename $BASH_SOURCE) : $LINENO"
        abort_install
    fi
    CMD="$(rtrim $1)"
    if [[ -z "$CMD" || "$CMD" == "" ]]; then
        return 1
    fi
    for PACKAGE in $1; do
        if ! is_in_array "PACKAGES[@]" "$PACKAGE" ; then
            remove_from_array "PACKAGES" "$PACKAGE"
        fi
    done
    return 0
} 
#}}}
# -----------------------------------------------------------------------------
# 
# ADD AUR PACKAGE {{{
NAME="add_aur_package"
USAGE=$(localize "ADD-AUR-PACKAGE-USAGE")
DESCRIPTION=$(localize "ADD-AUR-PACKAGE-DESC")
NOTES=$(localize "ADD-AUR-PACKAGE-NOTES")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "ADD-AUR-PACKAGE-USAGE" "add_aur_package 1->(package)"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "ADD-AUR-PACKAGE-DESC"  "Add AUR Package to PACKAGES array; for testing and building cache folder."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "ADD-AUR-PACKAGE-NOTES" "Call per AUR Package Manager"
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "ADD-AUR-PACKAGE-ERROR"  "Wrong Parameters to"
# -------------------------------------
add_aur_package()
{ 
    check_arg "add_aur_package" "1" "${#@}" "$(basename $BASH_SOURCE) : $LINENO"
    if [ -z "$1" ]; then
        print_warning "ADD-AUR-PACKAGE-ERROR" " add_aur_package @ $(basename $BASH_SOURCE) : $LINENO"
        abort_install
    fi
    CMD="$(rtrim $1)"
    if [[ -z "$CMD" || "$CMD" == "" ]]; then
        return 1
    fi
    for PACKAGE in $1; do
        if ! is_in_array "AUR_PACKAGES[@]" "$PACKAGE" ; then
            if [ "${#AUR_PACKAGES}" -eq 0 ]; then
                AUR_PACKAGES[0]="$PACKAGE"
            else
                AUR_PACKAGES[${#AUR_PACKAGES[*]}]="$PACKAGE"
            fi
        fi
    done
    return 0
} 
#}}}
# -----------------------------------------------------------------------------
# 
# REMOVE AUR PACKAGE {{{
NAME="remove_aur_package"
USAGE=$(localize "REMOVE-AUR-PACKAGE-USAGE")
DESCRIPTION=$(localize "REMOVE-AUR-PACKAGE-DESC")
NOTES=$(localize "REMOVE-AUR-PACKAGE-NOTES")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "REMOVE-AUR-PACKAGE-USAGE" "remove_aur_package 1->(package)"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "REMOVE-AUR-PACKAGE-DESC"  "Remove AUR Package from PACKAGES array."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "REMOVE-AUR-PACKAGE-NOTES" "Call per AUR Package Manager"
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "REMOVE-AUR-PACKAGE-ERROR"  "Wrong Parameters to"
# -------------------------------------
remove_aur_package()
{ 
    check_arg "remove_aur_package" "1" "${#@}" "$(basename $BASH_SOURCE) : $LINENO"
    if [ -z "$1" ]; then
        print_warning "REMOVE-AUR-PACKAGE-ERROR" " @ $(basename $BASH_SOURCE) : $LINENO"
        abort_install
    fi
    CMD="$(rtrim $1)"
    if [[ -z "$CMD" || "$CMD" == "" ]]; then
        return 1
    fi
    for PACKAGE in $1; do
        if ! is_in_array "AUR_PACKAGES[@]" "$PACKAGE" ; then
            remove_from_array "AUR_PACKAGES" "$PACKAGE"
        fi
    done
    return 0
} 
#}}}
# -----------------------------------------------------------------------------
# 
# ADD MODULE {{{
NAME="add_module"
USAGE=$(localize "ADD-MODULE-USAGE")
DESCRIPTION=$(localize "ADD-MODULE-DESC")
NOTES=$(localize "ADD-MODULE-NOTES")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "ADD-MODULE-USAGE" "add_module 1->(Name of Module) 2->(Package Manager)"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "ADD-MODULE-DESC"  "Add Module to Package Manager."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "ADD-MODULE-NOTES" "Call per Module"
# -------------------------------------
add_module()
{ 
    add_packagemanager "echo \"# Load $1 at boot\" > /etc/modules-load.d/${1}.conf; echo \"${1}\" >> /etc/modules-load.d/${1}.conf; modprobe $1" "$2"
} 
#}}}
# -----------------------------------------------------------------------------
# 
# REMOVE MODULE {{{
NAME="remove_module"
USAGE=$(localize "REMOVE-MODULE-USAGE")
DESCRIPTION=$(localize "REMOVE-MODULE-DESC")
NOTES=$(localize "REMOVE-MODULE-NOTES")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "REMOVE-MODULE-USAGE" "remove_module 1->(Package Manager)"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "REMOVE-MODULE-DESC"  "Remove Module from Package Manager."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "REMOVE-MODULE-NOTES" "Call per Module"
# -------------------------------------
remove_module()
{ 
    remove_packagemanager "$1"
} 
#}}}
# -----------------------------------------------------------------------------
# USER CONFIG {{{
NAME="user_config"
USAGE=$(localize "USER-CONFIG-USAGE")
DESCRIPTION=$(localize "USER-CONFIG-DESC")
NOTES=$(localize "USER-CONFIG-NOTES")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "USER-CONFIG-USAGE" "user_config 1->(USERNAME)"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "USER-CONFIG-DESC"  "User Configuration settings."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "USER-CONFIG-NOTES" "This is run by User, Library is unavailable, unless you export all the functions to use it."
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "USER-CONFIG-TITLE"      "Configuring User:"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "USER-CONFIG-COMPLETED"  "User Configuration Completed."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "USER-CONFIG-ERROR-1"    "Failure in creating .Xauthority; try generate new one."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "USER-CONFIG-ERROR-2"    "Failure in creating .Xauthority; try add new one."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "USER-CONFIG-ERROR-3"    "Failure in creating .Xauthority, giving up and creating file."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "USER-CONFIG-ERROR-4"    "User Configuration Completed with Errors."
# -------------------------------------
user_config()
{
    # Must define here or export before coming in
    BRed='\e[1;31m'         # Red
    BWhite='\e[1;37m'       # White
    White='\e[0;37m'        # White
    # cd /home/${USERNAME} or cd ~
    echo -e "\t${BWhite} $(gettext -s "USER-CONFIG-TITLE") $1 ${White}"
    if [[ ! -f "/home/$1/.Xauthority" && ! -h "/home/$1/.Xauthority" ]]; then # if its not a file or a link
        echo ""
        ln -sv `dirname $(xauth info | awk '/Authority file/{print $3}')` /home/$1/.Xauthority
    fi
    if [[ ! -f "/home/$1/.Xauthority" && ! -h "/home/$1/.Xauthority" ]]; then # just in case failure;
        echo -e "${BRed} $(gettext -s "USER-CONFIG-ERROR-1") ${White}"
        xauth generate :0 . trusted # I get no display on 0
    fi
    if [[ ! -f "/home/$1/.Xauthority" && ! -h "/home/$1/.Xauthority" ]]; then # just in case failure;
        echo -e "${BRed} $(gettext -s "USER-CONFIG-ERROR-2") ${White}"
        xauth add `echo "${DISPLAY}" | sed 's/.*\(:.*\)/\1/'` . `mcookie` # Bug in empty DISPLAY, fix in dbus-core-systemd-user-sessions
    fi
    if [[ ! -f "/home/$1/.Xauthority" && ! -h "/home/$1/.Xauthority" ]]; then # just in case failure; last resort
        echo -e "${BRed} $(gettext -s "USER-CONFIG-ERROR-3") ${White}"
        touch /home/$1/.Xauthority
        echo -e "\t${BWhite} $(gettext -s "USER-CONFIG-ERROR-4") ${White}"
        return 1
    fi
    #
    echo -e "${BRed} $(gettext -s "USER-CONFIG-COMPLETED") ${White}"
    return 0
}
#}}}
# -----------------------------------------------------------------------------
export -f user_config # need to export so if we are running as user it will find it
# CONFIGURE USER ACCOUNT {{{
NAME="configure_user_account"
USAGE="configure_user_account"
DESCRIPTION=$(localize "CONFIGURE-USER-ACCOUNT-DESC")
NOTES=$(localize "NONE")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CONFIGURE-USER-ACCOUNT-DESC"  "This function gets called after software is installed, so configure what is needed here."
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CONFIGURE-USER-ACCOUNT-TITLE"     "Configuring User Account"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CONFIGURE-USER-ACCOUNT-CONFIG"    "Configuring :"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CONFIGURE-USER-ACCOUNT-INFO"      "BASHRC"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CONFIGURE-USER-ACCOUNT-ERROR-1"   "configure_user_account: vim failed to Download"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CONFIGURE-USER-ACCOUNT-ERROR-2"   "configure_user_account: pentadactyl failed to Download"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CONFIGURE-USER-ACCOUNT-ERROR-3"   "configure_user_account: dotfiles failed to Download"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CONFIGURE-USER-ACCOUNT-ERROR-4"   "configure_user_account: Failure in creating .Xauthority for user"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CONFIGURE-USER-ACCOUNT-COMPLETED" "Configuring User Account Completed."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CONFIGURE-USER-ACCOUNT-CONFIG"    "Configuring Dot Files..."
# -------------------------------------
configure_user_account()
{
    print_info "CONFIGURE-USER-ACCOUNT-TITLE" " ${USERNAME}..."
    print_info "CONFIGURE-USER-ACCOUNT-INFO" " - https://wiki.archlinux.org/index.php/Bashrc"
    #
    make_dir "/home/${USERNAME}/.config"  "$(basename $BASH_SOURCE) : $LINENO"   # Just checking
    chown "${USERNAME}:${USERNAME}" "/home/${USERNAME}/.config"
    chmod 755 /home/${USERNAME}/.config
    make_dir "/home/${USERNAME}/.cache"   "$(basename $BASH_SOURCE) : $LINENO"   # Just checking
    chmod 755 "/home/${USERNAME}/.cache"
    make_dir "/home/${USERNAME}/.config/fontconfig" "$(basename $BASH_SOURCE) : $LINENO"
    #
    # @FIX helmuthdu replace with custom repo
    #
    if [[ "$EDITOR" == "vim" ]]; then
        package_install "vim ctags ack" "CONFIG-USER-VIM" 
        git clone https://github.com/helmuthdu/vim /home/${USERNAME}/vim
        if [ ! -d "/home/${USERNAME}/vim" ]; then
            print_warning "CONFIGURE-USER-ACCOUNT-ERROR-1" " @ ($(basename $BASH_SOURCE) : $LINENO)"
            write_error   "CONFIGURE-USER-ACCOUNT-ERROR-1" " @ ($(basename $BASH_SOURCE) : $LINENO)"
            if [[ "$DEBUGGING" -eq 1 ]]; then pause_function "configure_user_account @ $(basename $BASH_SOURCE) : $LINENO"; fi
        else
            mv vim "/home/${USERNAME}/.vim"
            ln -sf "/home/${USERNAME}/.vim/vimrc" "/home/${USERNAME}/.vimrc"
        fi
        git clone https://github.com/helmuthdu/pentadactyl /home/${USERNAME}/pentadactyl
        if [ ! -d "/home/${USERNAME}/pentadactyl" ]; then
            print_warning "CONFIGURE-USER-ACCOUNT-ERROR-2" " @ ($(basename $BASH_SOURCE) : $LINENO)"
            write_error   "CONFIGURE-USER-ACCOUNT-ERROR-2" " @ ($(basename $BASH_SOURCE) : $LINENO)"
            if [[ "$DEBUGGING" -eq 1 ]]; then pause_function "configure_user_account @ $(basename $BASH_SOURCE) : $LINENO"; fi
        else
            # PENTADACTYL [FIREFOX]
            mv "/home/${USERNAME}/pentadactyl" "/home/${USERNAME}/.pentadactyl"
            ln -sf "/home/${USERNAME}/.pentadactyl/pentadactylrc" "/home/${USERNAME}/.pentadactylrc"
        fi
    elif [[ "$EDITOR" == "emacs" ]]; then
        package_install "emacs" "CONFIG-USER-EMACS"
    fi
    git clone https://github.com/helmuthdu/dotfiles "/home/${USERNAME}/dotfiles"
    if [ ! -d "/home/${USERNAME}/dotfiles" ]; then
        print_warning "CONFIGURE-USER-ACCOUNT-ERROR-3" ": git clone https://github.com/helmuthdu/dotfiles /home/${USERNAME} @ ($(basename $BASH_SOURCE) : $LINENO)"
        write_error   "CONFIGURE-USER-ACCOUNT-ERROR-3" ": git clone https://github.com/helmuthdu/dotfiles /home/${USERNAME} @ ($(basename $BASH_SOURCE) : $LINENO)"
        if [[ "$DEBUGGING" -eq 1 ]]; then pause_function "configure_user_account @ $(basename $BASH_SOURCE) : $LINENO"; fi
    else
        cp -f "/home/${USERNAME}/dotfiles/.bashrc" "/home/${USERNAME}/dotfiles/.dircolors" "/home/${USERNAME}/dotfiles/.dircolors_256" "/home/${USERNAME}/dotfiles/.nanorc" ~/  # should be root
        cp -f "/home/${USERNAME}/dotfiles/.bashrc" "/home/${USERNAME}/dotfiles/.dircolors" "/home/${USERNAME}/dotfiles/.dircolors_256" "/home/${USERNAME}/dotfiles/.nanorc" "/home/${USERNAME}/"   # USERNAME
        cp -f "/home/${USERNAME}/dotfiles/fonts.conf" "/home/${USERNAME}/.config/fontconfig"
        rm -fr "/home/${USERNAME}/dotfiles"
    fi
    print_this "CONFIGURE-USER-ACCOUNT-CONFIG"
    if [[ "$EDITOR" == "nano" ]]; then
        print_this "CONFIGURE-USER-ACCOUNT-CONFIG" " Nano..."
        sed -i '/EDITOR/s/vim/nano/' "/home/${USERNAME}/.bashrc"
        sed -i '/VISUAL/s/vim/nano/' "/home/${USERNAME}/.bashrc"
        sed -i '/EDITOR/s/vim/nano/' ~/.bashrc
        sed -i '/VISUAL/s/vim/nano/' ~/.bashrc
    elif [[ "$EDITOR" == "vim" ]]; then
        print_this "CONFIGURE-USER-ACCOUNT-CONFIG" " Vim..."
        # VIM
        # VIMRC
    elif [[ "$EDITOR" == "joe" ]]; then
        print_this "CONFIGURE-USER-ACCOUNT-CONFIG" " Joe..."
        sed -i '/EDITOR/s/vim/joe/' "/home/${USERNAME}/.bashrc"
        sed -i '/VISUAL/s/vim/joe/' "/home/${USERNAME}/.bashrc"
        sed -i '/EDITOR/s/vim/joe/' ~/.bashrc
        sed -i '/VISUAL/s/vim/joe/' ~/.bashrc
    elif [[ "$EDITOR" == "emacs" ]]; then
        print_this "CONFIGURE-USER-ACCOUNT-CONFIG" " Emacs..."
        sed -i '/EDITOR/s/vim/emacs\ -nw/' "/home/${USERNAME}/.bashrc"
        sed -i '/VISUAL/s/vim/emacs\ -nw/' "/home/${USERNAME}/.bashrc"
        sed -i '/EDITOR/s/vim/emacs\ -nw/' ~/.bashrc
        sed -i '/VISUAL/s/vim/emacs\ -nw/' ~/.bashrc
    fi
    #    
    make_dir "/home/${USERNAME}/Downloads" "$(basename $BASH_SOURCE) : $LINENO"
    make_dir "/home/${USERNAME}/Documents" "$(basename $BASH_SOURCE) : $LINENO"
    make_dir "/home/${USERNAME}/Pictures"  "$(basename $BASH_SOURCE) : $LINENO"
    make_dir "/home/${USERNAME}/Videos"    "$(basename $BASH_SOURCE) : $LINENO"
    make_dir "/home/${USERNAME}/Music"     "$(basename $BASH_SOURCE) : $LINENO"
    #
    copy_file "/etc/skel/.bash_logout"  "/home/${USERNAME}/.bash_logout"  "$(basename $BASH_SOURCE) : $LINENO"
    copy_file "/etc/skel/.bash_profile" "/home/${USERNAME}/.bash_profile" "$(basename $BASH_SOURCE) : $LINENO"
    copy_file "/etc/skel/.bashrc"       "/home/${USERNAME}/.bashrc"       "$(basename $BASH_SOURCE) : $LINENO"
    #copy_file "/etc/skel/.zshrc"        "/home/${USERNAME}/.zshrc"      "$(basename $BASH_SOURCE) : $LINENO"
    #copy_file "/etc/skel/.xinitrc"      "/home/${USERNAME}/.xinitrc"      "$(basename $BASH_SOURCE) : $LINENO"
    #copy_file "/etc/skel/.xsession"     "/home/${USERNAME}/.xsession"     "$(basename $BASH_SOURCE) : $LINENO"
    # @FIX add all others
    if [[ "$MATE_INSTALLED" -eq 1 ]]; then
        touch "/home/${USERNAME}/.dmrc"
        echo "[Desktop]" >> "/home/${USERNAME}/.dmrc"
        echo "Session=mate" >> "/home/${USERNAME}/.dmrc"
    elif [[ "$CINNAMON_INSTALLED" -eq 1 ]]; then
        touch "/home/${USERNAME}/.dmrc"
        echo "[Desktop]" >> "/home/${USERNAME}/.dmrc"
        echo "Session=cinnamon" >> "/home/${USERNAME}/.dmrc"
    fi
    #
    chown -R "${USERNAME}:${USERNAME}" "/home/${USERNAME}"
    #chmod -R 775 /home/${USERNAME}/  # User=RWX, Group=RWX and Others=R
    #
    chmod 770 "/home/${USERNAME}/.bash_logout"  # User=RWX, Group=RWX and Others=None
    chmod 770 "/home/${USERNAME}/.bash_profile" # User=RWX, Group=RWX and Others=None
    chmod 770 "/home/${USERNAME}/.bashrc"       # User=RWX, Group=RWX and Others=None
    #chmod 770 /home/${USERNAME}/.xinitrc       # User=RWX, Group=RWX and Others=None
    #chmod 770 /home/${USERNAME}/.xsession      # User=RWX, Group=RWX and Others=None
    #
#    pause_function "about to execute user_config $(basename $BASH_SOURCE) : $LINENO"
    # @FIX
    return 0
    
    # skip this; left here to show how I trid to fix this; turns out to be a bug in systemd
    echo "export XAUTHORITY=/home/${USERNAME}/.Xauthority" >> /etc/profile
    cd "/home/${USERNAME}/"
    su "${USERNAME}" -c "user_config \"${USERNAME}\"" # Must run as User
    if [ "$?" -eq 0 ]; then
        write_error   "CONFIGURE-USER-ACCOUNT-ERROR-4" ": ${USERNAME} function: user_config - $(basename $BASH_SOURCE) : $LINENO"
        print_warning "CONFIGURE-USER-ACCOUNT-ERROR-4" ": ${USERNAME} function: user_config - $(basename $BASH_SOURCE) : $LINENO"
        if [[ "$DEBUGGING" -eq 1 ]]; then pause_function "Failed for XAUTHORITY at line @ $(basename $BASH_SOURCE) : $LINENO"; fi
    fi
    cd /"$FULL_SCRIPT_PATH" # Is this required, if cd from within a su, it shouldn't leave the pwd there, it should revert back, as if it never happened.
    chmod 600 "/home/${USERNAME}/.Xauthority" # User=RW, Group and Others=None
    chown -R "${USERNAME}:${USERNAME}" "/home/${USERNAME}/.Xauthority"
    #
    print_info "CONFIGURE-USER-ACCOUNT-COMPLETED"
} 
#}}}
# -----------------------------------------------------------------------------
# GET AUR PACKAGE FOLDER {{{
NAME="get_aur_package_folder"
USAGE="get_aur_package_folder"
DESCRIPTION=$(localize "GET-AUR-PACKAGE-FOLDER-DESC")
NOTES=$(localize "GET-AUR-PACKAGE-FOLDER-NOTES")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-AUR-PACKAGE-FOLDER-DESC"  "Get AUR package folder and AUR Repository Setting."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-AUR-PACKAGE-FOLDER-NOTES" "Notes."
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "Use-AUR-Repository" "Use AUR Repository"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "Enter-Name-for-AUR-Packages" "Enter Name for AUR Packages"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-AUR-PACKAGE-FOLDER-INFO-1" "This is the Folder where AUR Projects get Downloaded into and Compiled At."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-AUR-PACKAGE-FOLDER-INFO-2" "This will create a folder in your /mnt folder, to give you an Option to Share (Server) or Mount (Client) as a share drive; where it will be compiled, then the Package will be copied over into the Custom Packages Folder, so we can create a Custom Repository to install the Package from."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-AUR-PACKAGE-FOLDER-INFO-3" "Even if you do not use the Repository, you still have to download and compile AUR projects here."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-AUR-PACKAGE-FOLDER-INFO-4" "The reason I chose /mnt is obvious, /mnt is owned by the root, so its chained to that folder, even though this folder will have User r/w/x Permissions; so its more Secure; and can be Shared with just as much Security."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-AUR-PACKAGE-FOLDER-INFO-5" "AUR Repository allows you to share your AUR Packages in your Local Network; it can also make updates easier."
get_aur_package_folder()
{
    print_title "Use-AUR-Repository" "https://aur.archlinux.org/ and https://wiki.archlinux.org/index.php/AUR_User_Guidelines"
    print_info  "GET-AUR-PACKAGE-FOLDER-INFO-1"
    print_info  "GET-AUR-PACKAGE-FOLDER-INFO-2"
    print_info  "GET-AUR-PACKAGE-FOLDER-INFO-3"
    print_info  "GET-AUR-PACKAGE-FOLDER-INFO-4"
    #
    read_input_default "Enter-Name-for-AUR-Packages" "AUR-Packages"
    #
    AUR_REPO_NAME="$OPTION"
    #    
    print_info  "GET-AUR-PACKAGE-FOLDER-INFO-5"    
    #
    read_input_yn "Use-AUR-Repository" " " 1
    #
    AUR_REPO="$YN_OPTION"
}
#}}}
# -----------------------------------------------------------------------------
# GET FSTAB CONFIG  {{{
NAME="get_fstab_config"
USAGE="get_fstab_config"
DESCRIPTION=$(localize "GET-FSTAB-CONFIG-DESC")
NOTES=$(localize "NONE")
AUTHOR="helmuthdu and Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-FSTAB-CONFIG-DESC"  "Get fstab config"
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-FSTAB-CONFIG-TITLE"      "FSTAB"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-FSTAB-CONFIG-INFO"       "The /etc/fstab file contains static filesystem information. It defines how storage devices and partitions are to be mounted and integrated into the overall system. It is read by the mount command to determine which options to use when mounting a specific device or partition."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-FSTAB-CONFIG-RECOMMEND"  "UUID is the preferred way to create fstab."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-FSTAB-CONFIG-CONFIGURE"  "Configure fstab based on:"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-FSTAB-CONFIG-EDIT"       "Edit fstab file" 
# -------------------------------------
get_fstab_config()
{
    print_title "GET-FSTAB-CONFIG-TITLE" " - https://wiki.archlinux.org/index.php/Fstab"
    print_info "GET-FSTAB-CONFIG-INFO"
    print_info "GET-FSTAB-CONFIG-RECOMMEND"
    PS3="$prompt1"
    print_this "GET-FSTAB-CONFIG-CONFIGURE"
    select OPT in "${FSTAB[@]}"; do
        case "$REPLY" in
            1)
                FSTAB_CONFIG=1
                break
                ;;
            2)
                FSTAB_CONFIG=2
                break
                ;;
            3)
                FSTAB_CONFIG=3
                break
                ;;
            *)
                invalid_option "$REPLY"
                ;;
        esac
    done
    read_input_yn "GET-FSTAB-CONFIG-EDIT" " " 0
    if [[ "$YN_OPTION" -eq 1 ]]; then
        FSTAB_EDIT=1
    fi
}
#}}}
# -----------------------------------------------------------------------------
# CONFIGURE FSTAB {{{
NAME="configure_fstab"
USAGE="configure_fstab"
DESCRIPTION=$(localize "CONFIGURE-FSTAB-DESC")
NOTES=$(localize "CONFIGURE-FSTAB-NOTES")
AUTHOR="helmuthdu and Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CONFIGURE-FSTAB-DESC"  "Configure fstab"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CONFIGURE-FSTAB-NOTES" "Localized."
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "Configuring-fstab" "Configuring fstab..."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "Edit-fstab" "The /etc/fstab file contains static filesystem information. It defines how storage devices and partitions are to be mounted and integrated into the overall system. It is read by the mount command to determine which options to use when mounting a specific device or partition."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "Review-fstab" "Review your fstab."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "fstab-complete" "fstab configuration complete."
# -------------------------------------
configure_fstab()
{
    print_info "Configuring-fstab"
    if [[ ! -f ${MOUNTPOINT}/etc/fstab.aui && -f ${MOUNTPOINT}/etc/fstab ]]; then
        copy_file ${MOUNTPOINT}/etc/fstab ${MOUNTPOINT}/etc/fstab.aui "$(basename $BASH_SOURCE) : $LINENO"
    fi
    if [[ "$FSTAB_CONFIG" -eq 1 ]]; then                        # UUIDs
        genfstab -U "${MOUNTPOINT}" > ${MOUNTPOINT}/etc/fstab 
    elif [[ "$FSTAB_CONFIG" -eq 2 ]]; then                      # Device
        genfstab -p "${MOUNTPOINT}" > ${MOUNTPOINT}/etc/fstab
    elif [[ "$FSTAB_CONFIG" -eq 3 ]]; then                      # Labels
        genfstab -L "${MOUNTPOINT}" > ${MOUNTPOINT}/etc/fstab 
    fi
    if [[ "$IS_HOME_DRIVE" -eq 1 ]]; then
        # @FIX get more info so you can add it here; popup list of drives maybe
        echo "#UUID=(Your UUID)       /home  (FS type)    rw,errors=remount-ro,nofail    0       1" >> ${MOUNTPOINT}/etc/fstab
    fi
    if [[ "$IS_VAR_DRIVE" -eq 1 ]]; then
        # @FIX get more info so you can add it here
        echo "#UUID=(Your UUID)       /var   (FS type)    rw,errors=remount-ro,nofail    0       1" >> ${MOUNTPOINT}/etc/fstab
    fi
    echo "# You might want to add this to home to have it automount by systemd, delay for fsck: noauto,x-systemd.automount" >> ${MOUNTPOINT}/etc/fstab
    if [[ "$FSTAB_EDIT" -eq 1 ]]; then
        print_title "FSTAB - https://wiki.archlinux.org/index.php/Fstab"
        print_info "Edit-fstab"
        #
        echo "Review-fstab"
        pause_function "configure_fstab $(basename $BASH_SOURCE) : $LINENO"
        $EDITOR ${MOUNTPOINT}/etc/fstab
    fi
    # pacstrap will overwrite fstab so copy it to temp 
    copy_file ${MOUNTPOINT}/etc/fstab "${FULL_SCRIPT_PATH}/etc/fstab" "$(basename $BASH_SOURCE) : $LINENO"
    echo "fstab-complete"
    if [[ "$DEBUGGING" -eq 1 ]]; then pause_function "configure_fstab @ $(basename $BASH_SOURCE) : $LINENO"; fi
}
#}}}
# -----------------------------------------------------------------------------
# CONFIGURE HOSTNAME {{{
NAME="configure_hostname"
USAGE="configure_hostname"
DESCRIPTION=$(localize "CONFIGURE-HOSTNAME-DESC")
NOTES=$(localize "NONE")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CONFIGURE-HOSTNAME-DESC"  "Configure hostname"
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CONFIGURE-HOSTNAME-COMPLETE"  "Configured Hostname..."
# -------------------------------------
configure_hostname()
{
    echo "$CONFIG_HOSTNAME" > ${MOUNTPOINT}/etc/hostname
    #
    echo "#" > ${MOUNTPOINT}/etc/hosts
    echo "# /etc/hosts: static lookup table for host names" >> ${MOUNTPOINT}/etc/hosts
    echo "#" >> ${MOUNTPOINT}/etc/hosts
    echo "#<ip-address>	<hostname.domain.org>	<hostname>" >> ${MOUNTPOINT}/etc/hosts
    echo "127.0.0.1	    localhost.localdomain	localhost $CONFIG_HOSTNAME" >> ${MOUNTPOINT}/etc/hosts
    echo "::1		    localhost.localdomain	localhost $CONFIG_HOSTNAME" >> ${MOUNTPOINT}/etc/hosts
    echo "#192.168.1.100 $CONFIG_HOSTNAME.domain.com $CONFIG_HOSTNAME   # Uncomment if you use a static IP and remove this comment." >> ${MOUNTPOINT}/etc/hosts
    echo "# End of file" >> ${MOUNTPOINT}/etc/hosts
    # 
    # pacstrap will overwrite hosts so copy it to temp 
    copy_file ${MOUNTPOINT}/etc/hostname "${FULL_SCRIPT_PATH}/etc/hostname" "$(basename $BASH_SOURCE) : $LINENO"
    copy_file ${MOUNTPOINT}/etc/hosts    "${FULL_SCRIPT_PATH}/etc/hosts"    "$(basename $BASH_SOURCE) : $LINENO"
    echo "CONFIGURE-HOSTNAME-COMPLETE"
    if [[ "$DEBUGGING" -eq 1 ]]; then pause_function "configure_hostname @ $(basename $BASH_SOURCE) : $LINENO"; fi
}
#}}}
# -----------------------------------------------------------------------------
# GET HOSTNAME {{{
NAME="get_hostname"
USAGE="get_hostname"
DESCRIPTION=$(localize "GET-HOSTNAME-DESC")
NOTES=$(localize "NONE")
AUTHOR="helmuthdu and Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-HOSTNAME-DESC"    "Get hostname"
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-HOSTNAME-TITLE"   "HOSTNAME"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-HOSTNAME-INFO-1"  "A host name is a unique name created to identify a machine on a network.Host names are restricted to alphanumeric characters."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-HOSTNAME-INFO-2"  "The hyphen (-) can be used, but a host name cannot start or end with it. Length is restricted to 63 characters."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-HOSTNAME-INFO-3"  "Do not add any comments or empty lines."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-HOSTNAME-INFO-4"  "Do not use a domain name."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-HOSTNAME-DEFAULT" "Hostname (ex: archlinux)"
# -------------------------------------
get_hostname()
{
    print_title "GET-HOSTNAME-TITLE" " - https://wiki.archlinux.org/index.php/HOSTNAME"
    print_this "GET-HOSTNAME-INFO-1"
    print_this "GET-HOSTNAME-INFO-2"
    print_this "GET-HOSTNAME-INFO-3"
    print_this "GET-HOSTNAME-INFO-4"
    read_input_default "GET-HOSTNAME-DEFAULT" "$CONFIG_HOSTNAME"
    CONFIG_HOSTNAME="$OPTION"
}
#}}}

# -----------------------------------------------------------------------------
# ABORT INSTALL {{{
NAME="abort_install"
USAGE=$(localize "ABORT-INSTALL-USAGE")
DESCRIPTION=$(localize "ABORT-INSTALL-DESC")
NOTES=$(localize "NONE")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "ABORT-INSTALL-USAGE" "abort_install 1->(1=Boot OS Install, 2=Install Software)"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "ABORT-INSTALL-DESC"  "Finish with script; clean up and do backups"
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "ABORT-INSTALL-INFO-1"  "I made a back copy of the profile in /root; you can delete these files."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "ABORT-INSTALL-ERROR"   "Drive is now ready to install Software, reboot, and remount Flash Drive with Script, cd /Path2Profile, load saved profile, or create a new one."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "ABORT-INSTALL-INFO-2"  "You should now have a full system install, just reboot and you are ready to go."
# -------------------------------------
abort_install()
{
    save_install
    save_software
    save_disk_config
    save_last_config
    if [[ "$1" -eq 1 ]]; then
        print_info    "ABORT-INSTALL-INFO-1"
        print_warning "ABORT-INSTALL-ERROR"
        copy_dir   "$FULL_SCRIPT_PATH/etc/"        ${MOUNTPOINT}/root/        "$(basename $BASH_SOURCE) : $LINENO"
        copy_files "${CONFIG_PATH}/" "db"          ${MOUNTPOINT}/root/CONFIG/ "$(basename $BASH_SOURCE) : $LINENO"
        copy_files "$LOG_PATH/"      "log"         ${MOUNTPOINT}/root/LOG/    "$(basename $BASH_SOURCE) : $LINENO"
        copy_file  "$FULL_SCRIPT_PATH/arch-wiz.sh" ${MOUNTPOINT}/root/        "$(basename $BASH_SOURCE) : $LINENO"
    else
        print_info "ABORT-INSTALL-INFO-2"
    fi
    # @FIX, where to save it to
    chown -R ${USERNAME}:${USERNAME} "${CONFIG_PATH}/"
    chown -R ${USERNAME}:${USERNAME} "${LOG_PATH}/"
    chown -R ${USERNAME}:${USERNAME} "${FULL_SCRIPT_PATH}/etc/"
    chown -R ${USERNAME}:${USERNAME} "${MENU_PATH}/"
    exit 1
}
#}}}
# -----------------------------------------------------------------------------
# FINISH {{{
NAME="finish"
USAGE=$(localize "FINISH-USAGE")
DESCRIPTION=$(localize "FINISH-DESC")
NOTES=$(localize "NONE")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "FINISH-USAGE"   "finish 1->(1=Boot OS Install, 2=Install Software)"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "FINISH-DESC"    "Finish with script; clean up and do backups"
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "FINISH-TITLE"   "Finish"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "FINISH-INFO-1"  "INSTALL COMPLETED"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "FINISH-INFO-2"  "If all went right you should be able to reboot into a fully functioning Desktop."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "FINISH-INFO-3"  "Make sure to check the root for install files like install_scripts, install_scripts_root_secrets, install_scripts_user_secrets, you can also delete /boot/grub_uefi.log."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "FINISH-INFO-4"  "I made a back copy of the profile in /root; you can delete these files."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "FINISH-ERROR"   "Drive is now ready to install Software, reboot, and remount Flash Drive with Script, cd /Path2Profile, load saved profile, or create a new one."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "FINISH-INFO-5"  "You should now have a full system install, just reboot and you are ready to go."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "FINISH-REBOOT"  "Reboot system" 
# -------------------------------------
finish()
{
    save_install
    print_title "FINISH-TITLE" ' - https://wiki.archlinux.org/index.php/Beginners%27_Guide#Boot_Arch_Linux_Installation_Media'
    print_info  "FINISH-INFO-1"
    print_info  "FINISH-INFO-2"
    print_info  "FINISH-INFO-3" " - ${SCRIPT_LOG}"
    # COPY SCRIPT TO ROOT FOLDER IN THE NEW SYSTEM
    if [[ "$1" -eq 1 ]]; then
        print_info    "FINISH-INFO-4"
        print_warning "FINISH-ERROR"
        copy_dir   "$FULL_SCRIPT_PATH/etc/"        ${MOUNTPOINT}/${USERNAME}/        "$(basename $BASH_SOURCE) : $LINENO"
        copy_files "${CONFIG_PATH}/" "db"          ${MOUNTPOINT}/${USERNAME}/CONFIG/ "$(basename $BASH_SOURCE) : $LINENO"
        copy_files "$LOG_PATH/"      "log"         ${MOUNTPOINT}/${USERNAME}/LOG/    "$(basename $BASH_SOURCE) : $LINENO"
        copy_file  "$FULL_SCRIPT_PATH/arch-wiz.sh" ${MOUNTPOINT}/${USERNAME}/        "$(basename $BASH_SOURCE) : $LINENO"
    else
        print_info "FINISH-INFO-5"
        if is_string_in_file "${MOUNTPOINT}/etc/sudoers" "$FILE_SIGNATURE COMMENT-OUT" ; then # Only make changes once
            comment_file "Defaults:${USERNAME}   !authenticate" "${MOUNTPOINT}/etc/sudoers"
            cat "${MOUNTPOINT}/etc/sudoers"
        fi
    fi
    # @FIX, where to save it to
    chown -R ${USERNAME}:${USERNAME} "${CONFIG_PATH}/"
    chown -R ${USERNAME}:${USERNAME} "${LOG_PATH}/"
    chown -R ${USERNAME}:${USERNAME} "${FULL_SCRIPT_PATH}/etc/"
    chown -R ${USERNAME}:${USERNAME} "${MENU_PATH}/"
    #
    read_input_yn "FINISH-REBOOT" " " 1
    if [[ "$YN_OPTION" -eq 1 ]]; then
        reboot
    fi
    exit 0
}
#}}}
# -----------------------------------------------------------------------------
# IS UEFI MODE {{{
NAME="is_uefi_mode"
USAGE="is_uefi_mode"
DESCRIPTION=$(localize "IS-UEFI-MODE-DESC")
NOTES=$(localize "NONE")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "IS-UEFI-MODE-DESC"  "Is UEFI Mode will return True (0), if it is in UEFI Mode"
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "IS-UEFI-MODE-INFO"  "UEFI Mode Test Passed."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "IS-UEFI-MODE-WARN"  "UEFI Mode Test Failed! UEFI Installation will not work correctly, switching to BIOS mode."
# -------------------------------------
is_uefi_mode()
{
    if [[ "$(cat /sys/class/dmi/id/sys_vendor)" == 'Apple Inc.' ]] || [[ "$(cat /sys/class/dmi/id/sys_vendor)" == 'Apple Computer, Inc.' ]]; then 
        modprobe -r -q efivars || true  # if MAC
    else
        modprobe -q efivars             # all others    
    fi
    if [ -d "/sys/firmware/efi/vars/" ]; then
        UEFI=0 # UEFI=0
        print_info "IS-UEFI-MODE-INFO"
        return 0
    else
        UEFI=1 # BIOS=1
        print_warning "IS-UEFI-MODE-WARN"
        modprobe dm-mod
        return 1
   fi
}
#}}}
# -----------------------------------------------------------------------------
# SET LOG DRIVE {{{
NAME="set_log_drive"
USAGE="set_log_drive"
DESCRIPTION=$(localize "SET-LOG-DRIVE-DESC")
NOTES=$(localize "SET-LOG-DRIVE-NOTES")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "SET-LOG-DRIVE-DESC"  "Get Device that Script is running from."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "SET-LOG-DRIVE-NOTES" "Localized."
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "Correct-Device"        "Is this the Correct Device that this Script is running from" 
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "Device-Script"         "Device Script is running from, used to Copy Profile (Logs, Configuration and Database files) to Drive, this is normally the Flash Drive you use to run this Script from."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "Device-Script-running" "What Device is Script running from"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "Copying-Device"        "Copying to Device"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "Device-does-not-exist" "Device does not exist! Try running script again using correct device name, run fdisk -l for a list of Device names."
# -------------------------------------
set_log_drive()
{
    print_info "Device-Script"
    read_input_yn "Correct-Device" "[$SCRIPT_DEVICE]" 1
    if [[ "$YN_OPTION" -eq 0 ]]; then
        read_input_default "Device-Script-running" "$SCRIPT_DEVICE"
        SCRIPT_DEVICE="$OPTION"
    fi
    if [[ -b "/dev/$SCRIPT_DEVICE" ]]; then
        print_info "Copying-Device" "/dev/$SCRIPT_DEVICE @ $(basename $BASH_SOURCE) : $LINENO"
        write_log  "Copying-Device" "/dev/$SCRIPT_DEVICE @ $(basename $BASH_SOURCE) : $LINENO"
    else
        print_warning "Device-does-not-exist" "/dev/$SCRIPT_DEVICE"
        lsblk
        exit # @FIX test before passing it in; make a list and have them pick from it
    fi
}
#}}}
# -----------------------------------------------------------------------------
#
# FIX REPO {{{
NAME="fix_repo"
USAGE="fix_repo"
DESCRIPTION=$(localize "FIX-REPO-DESC")
NOTES=$(localize "NONE")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "FIX-REPO-DESC"  "Fix Repository in pacman configure."
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "FIX-REPO-INFO-1"  "Edit"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "FIX-REPO-INFO-2"  "Put Mate into"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "FIX-REPO-INFO-3"  "Copy"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "FIX-REPO-INFO-4"  "Quit."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "FIX-REPO-SELECT"  "Select a Repository to fix :"
# -------------------------------------
fix_repo()
{
    print_info "FIX-REPO-INFO-1" " /etc/pacman.conf."
    print_info "FIX-REPO-INFO-2" " /etc/pacman.conf."
    print_info "FIX-REPO-INFO-3" " ${FULL_SCRIPT_PATH}/etc/* to /etc/*."
    print_info "FIX-REPO-INFO-4"
    SYSTEM_TYPES=("Edit" "MATE" "Copy" "Quit");
    PS3="$prompt1"
    print_this "FIX-REPO-SELECT"
    select OPT in "${SYSTEM_TYPES[@]}"; do
        case "$REPLY" in
            1)
                $($EDITOR /ect/pacman.conf)
                break
                ;;
            2)
                add_repo "mate" "http://repo.mate-desktop.org/archlinux/" "Optional TrustedOnly" 1
                break
                ;;
            3)
                copy_dir "${FULL_SCRIPT_PATH}/etc/" "/" "$(basename $BASH_SOURCE) : $LINENO"
                pause_function "fix_repo $(basename $BASH_SOURCE) : $LINENO"
                break
                ;;
            4)
                break
                ;;
           *)
                invalid_option "$REPLY"
                ;;
                esac
    done
}
#}}}
# -----------------------------------------------------------------------------
# GET FORMAT TYPE {{{
NAME="get_format_type"
USAGE="get_format_type"
DESCRIPTION=$(localize "GET-FORMAT-TYPE-DESC")
NOTES=$(localize "NONE")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-FORMAT-TYPE-DESC"  "Get format type"
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-FORMAT-TYPE-ERROR"  "format not recognized."
# -------------------------------------
get_format_type()
{
   case "$1" in
       ext4)
           OPTION="8300" # Linux System
           ;;
       ext3)
           OPTION="8300"
           ;;
       ext2)
           OPTION="8300"
           ;;
       Btrfs)
           OPTION="8300"
           ;;
       vfat)
           OPTION="0700" # Windoze System
           ;;
       NTFS)
           OPTION="0700"
           ;;
       *)
           echo "GET-FORMAT-TYPE-ERROR"
           OPTION="8300"
           ;;
   esac 
}
#}}}
# -----------------------------------------------------------------------------
# GET FORMAT SYSTEM {{{
NAME="get_format_system"
USAGE="get_format_system"
DESCRIPTION=$(localize "GET-FORMAT-SYSTEM-DESC")
NOTES=$(localize "NONE")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-FORMAT-SYSTEM-DESC"  "Get format system"
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-FORMAT-SYSTEM-TITLE"    "Get File Format System: "
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-FORMAT-SYSTEM-INFO-1"   "ext2  Second Extended Filesystem is an established, mature GNU/Linux filesystem that is very stable."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-FORMAT-SYSTEM-INFO-2"   "A drawback is that it does not have journaling support or barriers."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-FORMAT-SYSTEM-INFO-3"   "Lack of journaling can result in data loss in the event of a power failure or system crash."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-FORMAT-SYSTEM-INFO-4"   "It may also be inconvenient for root (/) and /home partitions because file-system checks can take a long time."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-FORMAT-SYSTEM-INFO-5"   "An ext2 filesystem can be converted to ext3."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-FORMAT-SYSTEM-INFO-6"   "ext3  Third Extended Filesystem is essentially the ext2 system with journaling support and write barriers."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-FORMAT-SYSTEM-INFO-7"   "It is backward compatible with ext2, well tested, and extremely stable."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-FORMAT-SYSTEM-INFO-8"   "ext4  Fourth Extended Filesystem is a newer filesystem that is also compatible with ext2 and ext3."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-FORMAT-SYSTEM-INFO-9"   "It provides support for volumes with sizes up to 1 exabyte (i.e. 1,048,576 terabytes) and files sizes up to 16 terabytes."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-FORMAT-SYSTEM-INFO-10"  "It increases the 32,000 subdirectory limit in ext3 to 64,000. It also offers online defragmentation capability."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-FORMAT-SYSTEM-INFO-11"  "Btrfs Also known as 'Better FS', Btrfs is a new filesystem with powerful features similar to Sun/Oracle's excellent ZFS."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-FORMAT-SYSTEM-INFO-12"  "These include snapshots, multi-disk striping and mirroring (software RAID without mdadm), checksums, incremental backup, and on-the-fly compression that can give a significant performance boost as well as save space."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-FORMAT-SYSTEM-INFO-13"  "As of January 2011, Btrfs is considered unstable although it has been merged into the mainline kernel with an experimental status."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-FORMAT-SYSTEM-INFO-14"  "Btrfs appears to be the future of GNU/Linux filesystems and is offered as a root filesystem option in all major distribution installers."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-FORMAT-SYSTEM-INFO-15"  "vfat  or Virtual File Allocation Table is technically simple and supported by virtually all existing operating systems."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-FORMAT-SYSTEM-INFO-16"  "This makes it a useful format for solid-state memory cards and a convenient way to share data between operating systems."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-FORMAT-SYSTEM-INFO-17"  "VFAT supports long file names."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-FORMAT-SYSTEM-INFO-18"  "NTFS  File system used by windows. Mountable with many utilities (e.g. NTFS-3G)."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-FORMAT-SYSTEM-SELECT"   "Select Format Type:"
# -------------------------------------
get_format_system()
{
    print_info "GET-FORMAT-SYSTEM-TITLE" "https://wiki.archlinux.org/index.php/File_Systems"
    print_info "GET-FORMAT-SYSTEM-INFO-1"
    print_that "GET-FORMAT-SYSTEM-INFO-2"
    print_that "GET-FORMAT-SYSTEM-INFO-3"
    print_that "GET-FORMAT-SYSTEM-INFO-4"
    print_that "GET-FORMAT-SYSTEM-INFO-5"
    print_info "GET-FORMAT-SYSTEM-INFO-6"
    print_that "GET-FORMAT-SYSTEM-INFO-7"
    print_info "GET-FORMAT-SYSTEM-INFO-8"
    print_that "GET-FORMAT-SYSTEM-INFO-9"
    print_that "GET-FORMAT-SYSTEM-INFO-10"
    print_info "GET-FORMAT-SYSTEM-INFO-11"
    print_that "GET-FORMAT-SYSTEM-INFO-12"
    print_that "*"
    print_that "GET-FORMAT-SYSTEM-INFO-13"
    print_that "GET-FORMAT-SYSTEM-INFO-14"
    print_info "GET-FORMAT-SYSTEM-INFO-15"
    print_that "GET-FORMAT-SYSTEM-INFO-16"
    print_that "GET-FORMAT-SYSTEM-INFO-17"
    print_info "GET-FORMAT-SYSTEM-INFO-18"
    echo ""
    PS3="$prompt1"
    echo "GET-FORMAT-SYSTEM-SELECT"
    declare -a FILE_SYSTEMS=("ext4" "ext3" "ext2" "btrfs" "vfat" "ntfs");
    select FILE_SYSTEM in "${FILE_SYSTEMS[@]}"; do
        if contains_element "$FILE_SYSTEM" ${FILE_SYSTEMS[@]}; then
            OPTION="$FILE_SYSTEM"
            break
        else
            invalid_option "$FILE_SYSTEM"
        fi
    done
}
#}}}
# -----------------------------------------------------------------------------
# GET BOOT TYPE {{{
NAME="get_boot_type"
USAGE="get_boot_type"
DESCRIPTION=$(localize "GET-BOOT-TYPE-DESC")
NOTES=$(localize "NONE")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-BOOT-TYPE-DESC"  "Get boot type"
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-BOOT-TYPE-TITLE"       "Get BIOS Size of GPT."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-BOOT-TYPE-INFO-1"      "GRUB2 in BIOS-GPT configuration requires a BIOS Boot Partition to embed its core.img in the absence of post-MBR gap in GPT partitioned systems (which is taken over by the GPT Primary Header and Primary Partition table)."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-BOOT-TYPE-INFO-2"      "This partition is used by GRUB2 only in BIOS-GPT setups."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-BOOT-TYPE-INFO-3"      "No such partition type exists in case of MBR partitioning (at least not for GRUB2)."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-BOOT-TYPE-INFO-4"      "This partition is also not required if the system is UEFI based, as no embedding of boot sectors takes place in that case."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-BOOT-TYPE-INFO-5"      "Syslinux does not require this partition."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-BOOT-TYPE-INFO-6"      "You can boot using BIOS or UEFI if you have a UEFI BIOS, setup depends on type of Boot System."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-BOOT-TYPE-SELECT"      "Select a Boot BIOS System Type:"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-BOOT-TYPE-SPECIFY"     "Specify BIOS Partition size as such: 1M or 1G"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-BOOT-TYPE-DEFAULT"     "BIOS Recommend Size: (2M) "
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-BOOT-TYPE-INFO-7"      "The UEFISYS partition can be of any size supported by FAT32 filesystem."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-BOOT-TYPE-INFO-8"      "According to Microsuck Documentation, the minimum partition/volume size for FAT32 is 512 MiB."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-BOOT-TYPE-INFO-9"      "Therefore it is recommended for UEFISYS partition to be at least 512 MiB."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-BOOT-TYPE-INFO-10"     "Higher partition sizes are fine, especially if you use multiple UEFI boot loaders, or multiple OSes booting via UEFI, so that there is enough space to hold all the related files."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-BOOT-TYPE-INFO-11"     "If you are using Linux EFISTUB booting, then you need to make sure there is adequate space available for keeping the Kernel and Initramfs files in the UEFISYS partition."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-BOOT-TYPE-INFO-12"     "Specify UEFI Partition size as such: 512M or 1G"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-BOOT-TYPE-UEFI-MIN"    "UEFI Minimal Size: (512M)"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-BOOT-TYPE-SELECT-BIOS" "Select a Boot BIOS System Type:"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-BOOT-TYPE-TITLE-2"     "UEFI Boot Loader"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-BOOT-TYPE-INFO-13"     "Unified Extensible Firmware Interface (or UEFI for short) is a new type of firmware that was initially designed by Intel (known as EFI then) mainly for its Itanium based systems."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-BOOT-TYPE-INFO-14"     "It introduces new ways of booting an OS that is distinct from the commonly used 'MBR boot code' method followed for BIOS systems."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-BOOT-TYPE-INFO-15"     "It started as Intel's EFI in versions 1.x and then a group of companies called the UEFI Forum took over its development from which it was called Unified EFI starting with version 2.0 ."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-BOOT-TYPE-INFO-16"     "As of 23 May 2012, UEFI Specification 2.3.1 is the most recent version."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-BOOT-TYPE-INFO-17"     "The NONE Option will not create a Boot Partition, it will install a Bootloader on the root partition."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-BOOT-TYPE-INFO-18"     "You have 3 Options for Boot Mode: UEFI (if you have a UEFI BIOS, Recommended), BIOS, or None (Installing to root, not recommended)."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "Default-Boot-Mode"          "Do you wish to change the Default Boot Mode: " 
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-BOOT-TYPE-INFO-WARN-1" "Your Motherboard failed to register in UEFI Mode, so this script will only be able to use BIOS Mode or None."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-BOOT-TYPE-INFO-WARN-2" "You do not have a UEFI BIOS, switching to BIOS Mode."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-BOOT-TYPE-INFO-WARN-3" "You have an Option have no partition for Boot, this will force it to load to the Root, this is not recommended, but an option."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "DEFAULT-NONE"              "Default is BIOS mode, do you wish to change Boot to NONE" 
# -------------------------------------
get_boot_type()
{
    # GET BIOS SIZE {{{
    get_bios_size()
    {
        print_this "GET-BOOT-TYPE-TITLE" " - https://wiki.archlinux.org/index.php/GRUB2#GPT_specific_instructions"
        print_this "GET-BOOT-TYPE-INFO-1"
        print_this "GET-BOOT-TYPE-INFO-2"
        print_this "GET-BOOT-TYPE-INFO-3"
        print_this "GET-BOOT-TYPE-INFO-4"
        print_this "GET-BOOT-TYPE-INFO-5"
        print_this "GET-BOOT-TYPE-INFO-6"
        local -a BOOT_SYSTEM_TYPES=("Grub2" "Syslinux" "Skip");
        PS3="$prompt1"
        print_info "GET-BOOT-TYPE-SELECT"
        select OPT in "${BOOT_SYSTEM_TYPES[@]}"; do
            case "$REPLY" in
                1)
                    BOOT_SYSTEM_TYPE=0
                    print_info "GET-BOOT-TYPE-SPECIFY"
                    read_input_default "GET-BOOT-TYPE-DEFAULT" "2M"
                    BIOS_SIZE="$OPTION"
                    break
                    ;;
                2)
                    BOOT_SYSTEM_TYPE=1
                    break
                    ;;
                3)
                    BOOT_SYSTEM_TYPE=2
                    break
                    ;;
                *)
                    invalid_option "$REPLY"
                    ;;
                    esac
        done
        unset BOOT_SYSTEM_TYPES
    }
    #}}}
    # GET UEFI SIZE {{{
    get_uefi_size()
    {
        print_this "GET-BOOT-TYPE-INFO-7"
        print_this "GET-BOOT-TYPE-INFO-8"
        print_this "GET-BOOT-TYPE-INFO-9"
        print_this "GET-BOOT-TYPE-INFO-10"
        print_this "GET-BOOT-TYPE-INFO-11"
        print_this "GET-BOOT-TYPE-INFO-12"
        read_input_default "GET-BOOT-TYPE-UEFI-MIN" "512M"
        UEFI_SIZE="$OPTION"
    }
    #}}}
    # GET UEFI TYPE {{{
    get_boot_menu()
    {
        PS3="$prompt1"
        print_this "GET-BOOT-TYPE-SELECT-BIOS"
        select OPT in "${BIOS_SYSTEM_TYPES[@]}"; do
            case "$REPLY" in
                1)
                    UEFI=0 # UEFI=0
                    break
                    ;;
                2)
                    UEFI=1 # BIOS=1 
                    break
                    ;;
                3)
                    UEFI=2 # NONE=2
                    break
                    ;;
               *)
                    invalid_option "$REPLY"
                    ;;
                    esac
        done
        unset BIOS_SYSTEM_TYPES
    }
    #}}}
    print_title "GET-BOOT-TYPE-TITLE-2" "https://wiki.archlinux.org/index.php/Unified_Extensible_Firmware_Interface and https://wiki.archlinux.org/index.php/UEFI_Bootloaders"
    print_info "GET-BOOT-TYPE-INFO-13"
    print_this "GET-BOOT-TYPE-INFO-14"
    print_this "GET-BOOT-TYPE-INFO-15"
    print_this "GET-BOOT-TYPE-INFO-16"
    echo ""
    print_this "GET-BOOT-TYPE-INFO-17"
    print_this "GET-BOOT-TYPE-INFO-18"
    echo ""
    if is_uefi_mode ; then
        read_input_yn "Default-Boot-Mode" "${BIOS_SYSTEM_TYPES[$UEFI]}" 0
        if [[ "$YN_OPTION" -eq 1 ]]; then
            get_boot_menu
        fi
    else
        UEFI=1
        print_warning "GET-BOOT-TYPE-INFO-WARN-1"
        print_warning "GET-BOOT-TYPE-INFO-WARN-2"
        print_warning "GET-BOOT-TYPE-INFO-WARN-3"
        read_input_yn "DEFAULT-NONE" " " 0
        if [[ "$YN_OPTION" -eq 1 ]]; then
            UEFI=2
        fi
    fi
    if [[ "$UEFI" -eq 0 ]]; then # UEFI=0
        get_uefi_size    # BOOT_SYSTEM_TYPE and BIOS_SIZE
    elif [[ "$UEFI" -eq 1 ]]; then  # BIOS=1
        get_bios_size    # BOOT_SYSTEM_TYPE and BIOS_SIZE
    fi
}
#}}}
# -----------------------------------------------------------------------------
# GET BOOT PARTITION {{{
NAME="get_boot_partition"
USAGE="get_boot_partition"
DESCRIPTION=$(localize "GET-BOOT-PARTITION-DESC")
NOTES=$(localize "NONE")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-BOOT-PARTITION-DESC"          "Get boot partition"
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-BOOT-PARTITION-TITLE"         "Get Boot Partition"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-BOOT-PARTITION-INFO-1"        "The /boot directory contains the kernel and ramdisk images as well as the bootloader configuration file and bootloader stages."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-BOOT-PARTITION-INFO-2"        "It also stores data that is used before the kernel begins executing user-space programs."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-BOOT-PARTITION-INFO-3"        "/boot is not required for normal system operation, but only during boot and kernel upgrades (when regenerating the initial ramdisk)."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-BOOT-PARTITION-INFO-4"        "If kept on a separate partition, /boot does not require a journaled file system."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-BOOT-PARTITION-INFO-5"        "A separate /boot partition is needed if installing a software RAID0 (stripe) system."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-BOOT-PARTITION-INFO-6"        "Do not confuse BOOT with UEFI or BIOS Boot strap, where as BOOT contains the Kernels, UEFI and BIOS contain Grub only."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-BOOT-PARTITION-SEPARATE-PART" "Use boot on a separate Partition" 
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-BOOT-PARTITION-SPECIFY"       "Specify BOOT Partition size as such: 100M or 1G"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-BOOT-PARTITION-BOOT-SIZE"     "BOOT Size: (100M)"
# -------------------------------------
get_boot_partition()
{
    print_title "GET-BOOT-PARTITION-TITLE" " - https://wiki.archlinux.org/index.php/Partitioning#.2Fboot"
    print_info  "GET-BOOT-PARTITION-INFO-1"
    print_info  "GET-BOOT-PARTITION-INFO-2"
    print_info  "GET-BOOT-PARTITION-INFO-3"
    print_info  "GET-BOOT-PARTITION-INFO-4"
    print_info  "GET-BOOT-PARTITION-INFO-5"
    print_info  "GET-BOOT-PARTITION-INFO-6"
    IS_BOOT_PARTITION=0
    read_input_yn "GET-BOOT-PARTITION-SEPARATE-PART" " " 1
    if [[ "$YN_OPTION" -eq 1 ]]; then
        IS_BOOT_PARTITION=1
        # Ask for Boot Size
        print_info "GET-BOOT-PARTITION-SPECIFY"
        read_input_default "GET-BOOT-PARTITION-BOOT-SIZE" "100M"
        BOOT_SIZE="$OPTION"
    fi
}
#}}}
# -----------------------------------------------------------------------------
# GET SWAP PARTITION {{{ 
NAME="get_swap_partition"
USAGE="get_swap_partition"
DESCRIPTION=$(localize "GET-SWAP-PARTITION-DESC")
NOTES=$(localize "NONE")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-SWAP-PARTITION-DESC"           "Get swap partition"
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-SWAP-PARTITION-TITLE"          "Get swap partition"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-SWAP-PARTITION-INFO-1"         "The swap partition provides memory that can be used as virtual RAM. It is recommended for PCs with 1GB or less of physical RAM."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-SWAP-PARTITION-INFO-2"         "Historically, the general rule for swap partition size was to allocate twice the amount of physical RAM."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-SWAP-PARTITION-INFO-3"         "As computers have gained ever larger memory capacities, this rule has become deprecated."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-SWAP-PARTITION-INFO-4"         "On machines with up to 512MB RAM, the 2x rule is usually adequate."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-SWAP-PARTITION-INFO-5"         "If a sufficient amount of RAM (more than 1024MB) is available, it may be possible to have a smaller swap partition or even eliminate it."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-SWAP-PARTITION-INFO-6"         "With more than 2 GB of physical RAM, one can generally expect good performance without a swap partition."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-SWAP-PARTITION-INFO-7"         "There is always an option to create a swap file after the system is setup."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-SWAP-PARTITION-SWAP"           "Use SWAP" 
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-SWAP-PARTITION-RAM"            "RAM size is"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-SWAP-PARTITION-RECOMMEND"      "Recommended"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-SWAP-PARTITION-RECOMMEND-MIN"  "Recommended Minimum"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-SWAP-PARTITION-SPECIFY"        "Specify SWAP size as such: 512M or 16G"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-SWAP-PARTITION-SIZE"           "SWAP Size: "
# -------------------------------------
get_swap_partition()
{
    print_title "GET-SWAP-PARTITION-TITLE" "https://wiki.archlinux.org/index.php/Partitioning#Swap"
    print_this "GET-SWAP-PARTITION-INFO-1"
    print_this "GET-SWAP-PARTITION-INFO-2"
    print_this "GET-SWAP-PARTITION-INFO-3"
    print_this "GET-SWAP-PARTITION-INFO-4"
    print_this "GET-SWAP-PARTITION-INFO-5"
    print_this "GET-SWAP-PARTITION-INFO-6"
    print_info "GET-SWAP-PARTITION-INFO-7"
    IS_SWAP_PARTITION=0
    read_input_yn "GET-SWAP-PARTITION-SWAP" " " 1
    if [[ "$YN_OPTION" -eq 1 ]]; then
        IS_SWAP_PARTITION=1
        RAM=$(grep MemTotal /proc/meminfo | awk '{print $2}')
        # 16434612 kb
        if [[ "$RAM" -le 1048576 ]]; then  # 1 GB
            SWAP_SIZE_MIN="512M"
            SWAP_SIZE="1G"
        elif [[ "$RAM" -le 2097152 ]]; then  # 2 GB
            SWAP_SIZE_MIN="1G"
            SWAP_SIZE="2G"
        elif [[ "$RAM" -le 4194304 ]]; then  # 4 GB
            SWAP_SIZE_MIN="2G"
            SWAP_SIZE="4G"
        elif [[ "$RAM" -le 8388608 ]]; then  # 8 GB
            SWAP_SIZE_MIN="4G"
            SWAP_SIZE="8G"
        elif [[ "$RAM" -le 16434612 ]]; then  # 16 GB
            SWAP_SIZE_MIN="8G"
            SWAP_SIZE="16G"
        elif [[ "$RAM" -le 33554432 ]]; then  # 32 GB
            SWAP_SIZE_MIN="16G"
            SWAP_SIZE="32G"
        elif [[ "$RAM" -le 67108864 ]]; then  # 64 GB
            SWAP_SIZE_MIN="32G"
            SWAP_SIZE="64G"
        fi
        
        echo ""
        print_info "GET-SWAP-PARTITION-RAM" ": $RAM"
        print_info "GET-SWAP-PARTITION-RECOMMEND" ": [$SWAP_SIZE] $(localize "GET-SWAP-PARTITION-RECOMMEND-MIN") [$SWAP_SIZE_MIN]"
        print_info "GET-SWAP-PARTITION-SPECIFY"
        read_input_default "GET-SWAP-PARTITION-SIZE" "$SWAP_SIZE"
        SWAP_SIZE="$OPTION"
    fi
}
#}}}
# -----------------------------------------------------------------------------
# GET HOME PARTITION {{{
NAME="get_home_partition"
USAGE="get_home_partition"
DESCRIPTION=$(localize "GET-HOME-PARTITION-DESC")
NOTES=$(localize "NONE")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-HOME-PARTITION-DESC"      "Get home Partition"
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-HOME-PARTITION-TITLE"     "HOME"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-HOME-PARTITION-INFO-1"    "Specify HOME Partition size as such: 512M or 50G"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-HOME-PARTITION-INFO-2"    "Specify 0 for all remaining space on drive, if no more partitions, use 0."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-HOME-PARTITION-SIZE"      "HOME Size: (50G)"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-HOME-PARTITION-INFO-3"    "The /home directory stores personal files in different folders."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-HOME-PARTITION-INFO-4"    "It holds miscellaneous personal data as well as user-specific configuration files for applications."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-HOME-PARTITION-INFO-5"    "Keeping it in a separate partition can be very useful for backup: it often requires the most disk space (for desktop users) and may need to be expanded at a later date."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-HOME-PARTITION-INFO-6"    "You can also use HOME on a Separate Drive, in this case pick N, and  choose Y for home on a separate Drive and the below will be commented in your fstab for later editing."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-HOME-PARTITION-PARTITION" "Use home on a separate Partition" 
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-HOME-PARTITION-DRIVE"     "Use home on a separate Drive" 
# -------------------------------------
get_home_partition()
{
    # GET HOME SIZE {{{
    get_home_size()
    {
        print_title "GET-HOME-PARTITION-TITLE" " - https://wiki.archlinux.org/index.php/Partitioning"
        print_info "GET-HOME-PARTITION-INFO-1"
        print_info "GET-HOME-PARTITION-INFO-2"
        read_input_default "GET-HOME-PARTITION-SIZE" "50G"
        HOME_SIZE="$OPTION"
    }
    #}}}
    print_title "GET-HOME-PARTITION-TITLE" " - https://wiki.archlinux.org/index.php/Partitioning#.2Fhome"
    print_info "GET-HOME-PARTITION-INFO-3"
    print_info "GET-HOME-PARTITION-INFO-4"
    print_info "GET-HOME-PARTITION-INFO-5"
    print_info "GET-HOME-PARTITION-INFO-6"
    print_info " " "UUID=(Your UUID)       /home   (FS type)    rw,errors=remount-ro    0       1"
    print_info " " "UUID=(Your UUID)       /home   ext4         defaults,noatime        0       2"
    IS_HOME_PARTITION=0
    IS_HOME_DRIVE=0
    read_input_yn "GET-HOME-PARTITION-PARTITION" " " 0
    if [[ "$YN_OPTION" -eq 0 ]]; then
        read_input_yn "GET-HOME-PARTITION-DRIVE" " " 0
        [[ $YN_OPTION -eq 1 ]] && IS_HOME_DRIVE=1 
    else
        IS_HOME_PARTITION=1
        get_home_size     # Ask for HOME Size return HOME_SIZE
        get_format_system # Ask for Format Type
        HOME_FORMAT="$OPTION"
    fi
}
#}}}
# -----------------------------------------------------------------------------
# GET VAR PARTITION {{{
NAME="get_var_partition"
USAGE="get_var_partition"
DESCRIPTION=$(localize "GET-VAR-PARTITION-DESC")
NOTES=$(localize "NONE")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-VAR-PARTITION-DESC"         "Get var partition"
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-VAR-PARTITION-TITLE"        "var Size"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-VAR-PARTITION-SPECIFY-VAR"  "Specify VAR Partition size as such: Minimum: 8-12 GB"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-VAR-PARTITION-VAR-SIZE"     "VAR Size: (13G)"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-VAR-PARTITION-INFO-1"       "The /var directory stores Contains variable data such as spool directories and files, administrative and logging data, pacman's cache, the ABS tree, etc."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-VAR-PARTITION-INFO-2"       "It is used for example for caching and logging, and hence frequently read or written."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-VAR-PARTITION-INFO-3"       "Keeping it in a separate partition avoids running out of disk space due to flunky logs, etc."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-VAR-PARTITION-INFO-4"       "It exists to make it possible to mount /usr as read-only. Everything that historically went into /usr that is written to during system operation (as opposed to installation and software maintenance) must reside under /var."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-VAR-PARTITION-INFO-5"       "You can also use VAR on a Separate Drive, good for Webservers, in this case pick N, and  choose Y for VAR on a separate Drive and the below will be commented in your fstab for later editing."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-VAR-PARTITION-PARTITION"    "Use var on a separate Partition" 
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-VAR-PARTITION-DRIVE"        "Use var on a separate Drive" 
# -------------------------------------
get_var_partition()
{
    # GET VAR SIZE {{{
    get_var_size()
    {
        print_info "GET-VAR-PARTITION-TITLE" "https://wiki.archlinux.org/index.php/Partitioning#.2Fvar"
        print_info "GET-VAR-PARTITION-SPECIFY-VAR"
        read_input_default "GET-VAR-PARTITION-VAR-SIZE" "13G"
        VAR_SIZE="$OPTION"
    }
    #}}}
    print_title "GET-VAR-PARTITION-TITLE" "https://wiki.archlinux.org/index.php/Partitioning#.2Fvar"
    print_info "GET-VAR-PARTITION-INFO-1"
    print_info "GET-VAR-PARTITION-INFO-2"
    print_info "GET-VAR-PARTITION-INFO-3"
    print_info "GET-VAR-PARTITION-INFO-4"
    print_info "GET-VAR-PARTITION-INFO-5"
    print_info " " "UUID=(Your UUID)       /var   (FS type)    rw,errors=remount-ro    0       1"
    print_info " " "UUID=(Your UUID)       /var   ext4         defaults,noatime        0       2"
    IS_VAR_PARTITION=0
    IS_VAR_DRIVE=0
    read_input_yn "GET-VAR-PARTITION-PARTITION" " " 0
    if [[ "$YN_OPTION" -eq 0 ]]; then
        read_input_yn "GET-VAR-PARTITION-DRIVE" " " 0
        [[ $YN_OPTION -eq 1 ]] && IS_VAR_DRIVE=1 
    else
        IS_VAR_PARTITION=1
        get_var_size     # Ask for VAR Size return VAR_SIZE
        get_format_system # Ask for Format Type
        VAR_FORMAT="$OPTION"
    fi
}
#}}}
# -----------------------------------------------------------------------------
# GET TMP PARTITION {{{
NAME="get_tmp_partition"
USAGE="get_tmp_partition"
DESCRIPTION=$(localize "GET-TMP-PARTITION-DESC")
NOTES=$(localize "GET-TMP-PARTITION-NOTES")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-TMP-PARTITION-DESC"       "Get tmp partition"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-TMP-PARTITION-NOTES"      "@FIX need to fully implement this."
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-TMP-PARTITION-TITLE"      "Get tmp partition"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-TMP-PARTITION-INFO-1"     "By default, a tmpfs partition has its maximum size set to half your total RAM, but this can be customized."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-TMP-PARTITION-INFO-2"     "Note that the actual memory/swap consumption depends on how much you fill it up, as tmpfs partitions do not consume any memory until it is actually needed."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-TMP-PARTITION-INFO-3"     "Specify TMP Partition size as such: Current RAM size is"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-TMP-PARTITION-INFO-4"     "half of that is"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-TMP-PARTITION-TMP-SIZE"   "TMP Size: "
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-TMP-PARTITION-INFO-6"     "Directory for programs that require temporary storage of files such as .lck , which can be used to prevent multiple instances of their respective program until a task is completed. Upon completion, the .lck file will be automatically removed."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-TMP-PARTITION-INFO-7"     "Programs must not assume that any files or directories in /tmp are preserved between invocations of the program and files and directories located under /tmp will typically be deleted whenever the system is booted."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-TMP-PARTITION-INFO-8"     "tmpfs:"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-TMP-PARTITION-INFO-9"     "tmpfs is a temporary filesystem that resides in memory and/or your swap partition(s), depending on how much you fill it up."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-TMP-PARTITION-INFO-10"    "Mounting directories as tmpfs can be an effective way of speeding up accesses to their files, or to ensure that their contents are automatically cleared upon reboot."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-TMP-PARTITION-INFO-11"    "Some directories where tmpfs is commonly used are /tmp, /var/lock and /var/run."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-TMP-PARTITION-INFO-12"    "Do NOT use it on /var/tmp, because that folder is meant for temporary files that are preserved across reboots."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-TMP-PARTITION-INFO-13"    "Arch uses a tmpfs /run directory, with /var/run and /var/lock simply existing as symlinks for compatibility."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-TMP-PARTITION-INFO-14"    "It is also used for /tmp in the default /etc/fstab."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-TMP-PARTITION-INFO-15"    "By default, a tmpfs partition has its maximum size set to half your total RAM, but this can be customized."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-TMP-PARTITION-INFO-16"    "Note that the actual memory/swap consumption depends on how much you fill it up, as tmpfs partitions do not consume any memory until it is actually needed."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-TMP-PARTITION-INFO-17"    "To use tmpfs for /tmp, add this line to /etc/fstab:"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-TMP-PARTITION-INFO-18"    "You may or may not wish to specify the size here, but you should leave the mode option alone in these cases to ensure that they have the correct permissions (1777)."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-TMP-PARTITION-INFO-19"    "In the example above, /tmp will be set to use up to half of your total RAM. To explicitly set a maximum size, use the size mount option:"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-TMP-PARTITION-INFO-20"    "Here is a more advanced example showing how to add tmpfs mounts for users. This is useful for websites, mysql tmp files, ~/.vim/, and more."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-TMP-PARTITION-INFO-21"    "It is important to try and get the ideal mount options for what you are trying to accomplish."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-TMP-PARTITION-INFO-22"    "The goal is to have as secure settings as possible to prevent abuse. Limiting the size, and specifying uid and gid + mode is very secure."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-TMP-PARTITION-INFO-23"    "The Default is to use tmpfs."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-TMP-PARTITION-tmpfs"      "Use tmp as tmpfs" 
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-TMP-PARTITION-SIZE-TMPFS" "Set size of tmpfs" 
# -------------------------------------
get_tmp_partition()
{
    # GET TMP SIZE {{{
    get_tmp_size()
    {
        RAM=$(grep MemTotal /proc/meminfo | awk '{print $2}')
        let HALF_RAM=RAM/2
        print_info "GET-TMP-PARTITION-TITLE" "https://wiki.archlinux.org/index.php/Fstab#tmpfs"
        print_info "GET-TMP-PARTITION-INFO-1"
        print_info "GET-TMP-PARTITION-INFO-2"
        print_info "GET-TMP-PARTITION-INFO-3" " $RAM, $(localize "GET-TMP-PARTITION-INFO-4") $HALF_RAM"
        read_input_default "GET-TMP-PARTITION-TMP-SIZE" "${HALF_RAM}"
        TMP_SIZE="$OPTION"
    }
    #}}}
    print_title "GET-TMP-PARTITION-TITLE" "https://wiki.archlinux.org/index.php/Partitioning#.2Ftmp"
    print_this  "GET-TMP-PARTITION-INFO-6"
    print_this  "GET-TMP-PARTITION-INFO-7"
    print_this  "GET-TMP-PARTITION-INFO-8" "https://wiki.archlinux.org/index.php/Fstab#tmpfs"
    print_this  "GET-TMP-PARTITION-INFO-9"
    print_this  "GET-TMP-PARTITION-INFO-10"
    print_this  "GET-TMP-PARTITION-INFO-11"
    print_this  "GET-TMP-PARTITION-INFO-12"
    print_this  "GET-TMP-PARTITION-INFO-13"
    print_this  "GET-TMP-PARTITION-INFO-14"
    print_this  "GET-TMP-PARTITION-INFO-15"
    print_this  "GET-TMP-PARTITION-INFO-16"
    print_this  "GET-TMP-PARTITION-INFO-17"
    print_this  " " "tmpfs                  /tmp     tmpfs      nodev,nosuid            0       0"
    print_this  "GET-TMP-PARTITION-INFO-18"
    print_this  "GET-TMP-PARTITION-INFO-19"
    print_this  " " "tmpfs   /tmp         tmpfs   nodev,nosuid,size=2G          0  0"
    print_this  "GET-TMP-PARTITION-INFO-20"
    print_this  "GET-TMP-PARTITION-INFO-21"
    print_this  "GET-TMP-PARTITION-INFO-22"
    print_this  " " "tmpfs   /www/cache    tmpfs  rw,size=1G,nr_inodes=5k,noexec,nodev,nosuid,uid=648,gid=648,mode=1700   0  0"
    print_this  ""
    print_this  "GET-TMP-PARTITION-INFO-23"
    read_input_yn "GET-TMP-PARTITION-tmpfs" " " 1
    if [[ "$YN_OPTION" -eq 1 ]]; then
        read_input_yn "GET-TMP-PARTITION-SIZE-TMPFS" " " 0
        if [[ "$YN_OPTION" -eq 1 ]]; then
            IS_TMP_PARTITION=0
            get_TMP_size     # Ask for TMP Size return TMP_SIZE
            IS_TMP_SIZE=1
        fi
    else
        # @FIX now what
        IS_TMP_PARTITION=1
        get_TMP_size     # Ask for TMP Size return TMP_SIZE
        get_format_system # Ask for Format Type
        TMP_FORMAT="$OPTION"
    fi
}
#}}}
# -----------------------------------------------------------------------------
# GET ROOT SIZE {{{
NAME="get_root_size"
USAGE="get_root_size"
DESCRIPTION=$(localize "GET-ROOT-SIZE-DESC")
NOTES=$(localize "NONE")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-ROOT-SIZE-DESC"    "Get the Size of the Root"
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-ROOT-SIZE-TITLE"   "Get the Size of the Root"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-ROOT-SIZE-INFO-1"  "The root directory is the top of the hierarchy, the point where the primary filesystem is mounted and from which all other filesystems stem."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-ROOT-SIZE-INFO-2"  "All files and directories appear under the root directory /, even if they are stored on different physical devices."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-ROOT-SIZE-INFO-3"  "The contents of the root filesystem must be adequate to boot, restore, recover, and/or repair the system."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-ROOT-SIZE-INFO-4"  "Therefore, certain directories under / are not candidates for separate partitions."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-ROOT-SIZE-INFO-5"  "The / partition or root partition is necessary and it is the most important."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-ROOT-SIZE-INFO-6"  "The other partitions can be replaced by it, even though having different partitions is recommended."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-ROOT-SIZE-INFO-7"  "Specify ROOT Partition size as such: 512M or 50G"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-ROOT-SIZE-INFO-8"  "Specify 0 for all remaining space on drive, if no more partitions, use 0."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-ROOT-SIZE-SIZE"    "ROOT Size: Default is remaining space (0)"
# -------------------------------------
get_root_size()
{
    print_title "GET-ROOT-SIZE-TITLE" " - https://wiki.archlinux.org/index.php/Partitioning#.2F_.28root.29"
    print_this  "GET-ROOT-SIZE-INFO-1"
    print_this  "GET-ROOT-SIZE-INFO-2"
    print_this  "GET-ROOT-SIZE-INFO-3"
    print_this  "GET-ROOT-SIZE-INFO-4"
    print_this  "GET-ROOT-SIZE-INFO-5"
    print_this  "GET-ROOT-SIZE-INFO-6"
    print_this  "GET-ROOT-SIZE-INFO-7"
    print_info  "GET-ROOT-SIZE-INFO-8"
    #
    read_input_default "GET-ROOT-SIZE-SIZE" "0"
    ROOT_SIZE="$OPTION"
    get_root_format
}
#}}}
# -----------------------------------------------------------------------------
# GET ROOT FORMAT {{{
NAME="get_root_format"
USAGE="get_root_format"
DESCRIPTION=$(localize "GET-ROOT-FORMAT-DESC")
NOTES=$(localize "NONE")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-ROOT-FORMAT-DESC"    "Get the Format of the Root"
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-ROOT-FORMAT-TITLE"   "Get the Format of the Root"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-ROOT-FORMAT-INFO-1"  "The root directory is the top of the hierarchy, the point where the primary filesystem is mounted and from which all other filesystems stem."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-ROOT-FORMAT-INFO-2"  "All files and directories appear under the root directory /, even if they are stored on different physical devices."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-ROOT-FORMAT-INFO-3"  "The contents of the root filesystem must be adequate to boot, restore, recover, and/or repair the system."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-ROOT-FORMAT-INFO-4"  "Therefore, certain directories under / are not candidates for separate partitions."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-ROOT-FORMAT-INFO-5"  "The / partition or root partition is necessary and it is the most important."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "GET-ROOT-FORMAT-INFO-6"  "The other partitions can be replaced by it, even though having different partitions is recommended."
# -------------------------------------
get_root_format()
{
    print_title "GET-ROOT-FORMAT-TITLE" " - https://wiki.archlinux.org/index.php/Partitioning#.2F_.28root.29"
    print_info  "GET-ROOT-FORMAT-INFO-1"
    print_info  "GET-ROOT-FORMAT-INFO-2"
    print_info  "GET-ROOT-FORMAT-INFO-3"
    print_info  "GET-ROOT-FORMAT-INFO-4"
    print_info  "GET-ROOT-FORMAT-INFO-5"
    print_info  "GET-ROOT-FORMAT-INFO-6"
    #
    get_format_system # Ask for Format Type
    ROOT_FORMAT="$OPTION"
}
#}}}
# -----------------------------------------------------------------------------
# STATIC IP {{{
NAME="static_ip"
USAGE="static_ip"
DESCRIPTION=$(localize "STATIC-IP-DESC")
NOTES=$(localize "STATIC-IP-NOTES")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "STATIC-IP-DESC"  "Static IP Address."
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "STATIC-IP-NOTES" "Not yet implemented"
#
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "STATIC-IP-TITLE"  "Static IP Address"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "STATIC-IP-INFO"   "Available NICs"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "STATIC-IP-NIC-0"  "device eth0 active"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "STATIC-IP-NIC-1"  "device eth1 active"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "STATIC-IP-NIC-2"  "device eth2 active"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "STATIC-IP-STATIC"  "Enter Static IP Address:  [123.123.123.123]: "
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "CORRECT" "Is this correct" 
# -------------------------------------
static_ip()
{
    while [[ 1 ]]; do
        print_title "STATIC-IP-TITLE" "https://wiki.archlinux.org/index.php/Configuring_Network#Static_IP_address"
        print_info  "STATIC-IP-INFO"
        if [[ -n $check_eth0  ]]; then
            print_this "STATIC-IP-NIC-0" ": $check_eth0"
        fi
        if [[ -n $check_eth1  ]]; then
            print_this "STATIC-IP-NIC-1" ": $check_eth1"
        fi
        if [[ -n $check_eth2  ]]; then
            print_this "STATIC-IP-NIC-2" ": $check_eth2"
        fi
        read_input_data "STATIC-IP-STATIC" 

        read_input_yn "CORRECT" "$OPTION" 1
        if [[ "$YN_OPTION" -eq 1 ]]; then
            STATIC_IP="$OPTION"
            break
        fi
    done    
}
#}}}
# -----------------------------------------------------------------------------
# ESCAPE SED {{{
NAME="escape_sed"
USAGE="escape_sed"
DESCRIPTION=$(localize "ESCAPE-SED-DESC")
NOTES=$(localize "NONE")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "ESCAPE-SED-DESC"  "escape sed"
# -------------------------------------
escape_sed() 
{
    sed -e 's/\//\\\//g' -e 's/\&/\\\&/g'
}
# -----------------------------------------------------------------------------
# ESCAPE SPECIAL CHARACTERS  {{{
NAME="escape_special_characters"
USAGE=$(localize "ESCAPE-SPECIAL-CHARACTERS-USAGE")
DESCRIPTION=$(localize "ESCAPE-SPECIAL-CHARACTERS-DESC")
NOTES=$(localize "ESCAPE-SPECIAL-CHARACTERS-NOTES")
AUTHOR="Flesher"
VERSION="1.0"
CREATED="11 SEP 2012"
REVISION="5 Dec 2012"
[[ "$RUN_HELP" -eq 1 ]] && create_help "$NAME" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename $BASH_SOURCE) : $LINENO"
# Help file Localization
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "ESCAPE-SPECIAL-CHARACTERS-USAGE" "escape_special_characters"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "ESCAPE-SPECIAL-CHARACTERS-DESC"  "escape special characters"
[[ "$RUN_LOCALIZER" -eq 1 ]] && localize_info "ESCAPE-SPECIAL-CHARACTERS-NOTES" "Not yet Implemented."
# -------------------------------------
escape_special_characters()
{
    # Pass in string, iterate it and replace all special characters with escape
    total="${#1}"
    for (( index=0; index<${total}; index++ )); do
        case \"$LANGUAGE\" in
            de_DE)
            ;;
        esac
        
    done
}
#}}}
# -----------------------------------------------------------------------------
# ************************************* END OF SCRIPT *************************

