#!/bin/bash
#
FULL_SCRIPT_PATH=$(dirname $(readlink -f "$0"))
if [ -f "${FULL_SCRIPT_PATH}/wizard.sh" ]; then
    declare -i RUN_LOCALIZER=0
    declare -r LOCALIZED_PATH="${FULL_SCRIPT_PATH}/locale-go"
    declare LOCALIZED_FILE="go-wizard.sh"
    #. "${FULL_SCRIPT_PATH}/wizard.sh"
    source "${FULL_SCRIPT_PATH}/wizard.sh"
else
    echo "ERROR - ${FULL_SCRIPT_PATH}/wizard.sh NOT FOUND"
    exit 1
fi

LOG_PATH="${SCRIPT_DIR}/LOG"
CONFIG_NAME="go"
ERROR_LOG="${LOG_PATH}/${CONFIG_NAME}-error.log"
ACTIVITY_LOG="${LOG_PATH}/${CONFIG_NAME}-activity.log"

copy2flash()
{
    #
    cp -fv wiz            /media/jflesher/ArchWiz/
    cp -fv wizard.sh      /media/jflesher/ArchWiz/
    cp -fv common-wiz.sh  /media/jflesher/ArchWiz/
    cp -fv package-wiz.sh /media/jflesher/ArchWiz/
    cp -fv arch-wiz.sh    /media/jflesher/ArchWiz/
    cp -fv packages.sh    /media/jflesher/ArchWiz/
    cp -fv bashtest       /media/jflesher/ArchWiz/
    cp -fv help.html      /media/jflesher/ArchWiz/
    cp -rfv locale/       /media/jflesher/ArchWiz/
}

backup()
{
    # Backup
    cp -fv /home/jflesher/Downloads/archwiz/wiz            /home/jflesher/Downloads/archwiz/wiz-old
    cp -fv /home/jflesher/Downloads/archwiz/wizard.sh      /home/jflesher/Downloads/archwiz/wizard-old.sh
    cp -fv /home/jflesher/Downloads/archwiz/common-wiz.sh  /home/jflesher/Downloads/archwiz/common-wiz-old.sh
    cp -fv /home/jflesher/Downloads/archwiz/package-wiz.sh /home/jflesher/Downloads/archwiz/package-wiz-old.sh
    cp -fv /home/jflesher/Downloads/archwiz/arch-wiz.sh    /home/jflesher/Downloads/archwiz/arch-wiz-old.sh
    cp -fv /home/jflesher/Downloads/archwiz/packages.sh    /home/jflesher/Downloads/archwiz/packages-old.sh
    cp -fv /home/jflesher/Downloads/archwiz/bashtest       /home/jflesher/Downloads/archwiz/bashtest-old
    # Backup to hard drive
    cp -fv wiz            /home/jflesher/Downloads/archwiz/
    cp -fv wizard.sh      /home/jflesher/Downloads/archwiz/
    cp -fv common-wiz.sh  /home/jflesher/Downloads/archwiz/
    cp -fv package-wiz.sh /home/jflesher/Downloads/archwiz/
    cp -fv arch-wiz.sh    /home/jflesher/Downloads/archwiz/
    cp -fv packages.sh    /home/jflesher/Downloads/archwiz/
    cp -fv bashtest       /home/jflesher/Downloads/archwiz/
    #
    cp -rfv /media/jflesher/ArchWiz/CONFIG/       /home/jflesher/Downloads/archwiz
    cp -rfv /media/jflesher/ArchWiz/LOG/          /home/jflesher/Downloads/archwiz
    cp -rfv /media/jflesher/ArchWiz/locale/       /home/jflesher/Downloads/archwiz
}
#

all_packages()
{
    while getopts ":a" M_OPTION; do
        case $M_OPTION in
            a)
                cp -rfv /media/jflesher/ArchWiz/Packages/     /home/jflesher/Downloads/archwiz
                cp -rfv /media/jflesher/ArchWiz/AUR-Packages/ /home/jflesher/Downloads/archwiz
                cp -rfv /media/jflesher/ArchWiz/Sync/         /home/jflesher/Downloads/archwiz
                cp -rfv /media/jflesher/ArchWiz/etc           /home/jflesher/Downloads/archwiz
                cp -rfv /media/jflesher/ArchWiz/MENU/         /home/jflesher/Downloads/archwiz
                cp -rfv /media/jflesher/ArchWiz/USER/         /home/jflesher/Downloads/archwiz
                cp -rfv /media/jflesher/ArchWiz/mateconf/     /home/jflesher/Downloads/archwiz
                break;
                ;;
        esac
    done
}
#
localize_info "CHANGE-OWNER" "Change Owner on Flash Drive"
localize_info "" ""
#
if [[ "$RUN_LOCALIZER" -eq 1 ]]; then
    localize_save
    #print_help
else
    #
    ./bashtest
    #
    pause_function "Press any key to continue" "$LINENO"
    #
    read_input_yn "CHANGE-OWNER" " " 0
    if [[ "$YN_OPTION" -eq 1 ]]; then
        sudo chown -R jflesher:jflesher /media/jflesher/ArchWiz
        backup
        all_packages
    fi
    copy2flash
    #
    sync
    #
fi
#
echo "Completed"
