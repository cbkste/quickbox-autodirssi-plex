#!/bin/bash
#
# Script to add add torrent file to plex
OUTTO=/srv/rutorrent/home/db/output.log
TORRENTLOCATION=/mnt/torrents
PLEXLOCATION=/mnt/Plex/Movies

function _mvfile {
declare -i count=$1
#let count--
        echo $count
        content=$(sed -n "$count"'p' /home/mod/.autodl/DownloadHistory.txt)
        echo "$content"
        location=$(echo "$content" | grep -o -P '^(.+?(?=[0-9]{13}))')
        location=${location// /.}
        fullLocation=$TORRENTLOCATION"/"$location
        echo $location
        echo $fullLocation
        echo "Moving File '$location' to Plex Folder " >>"${OUTTO}" 2>&1;
        cd $fullLocation

myarray=(`find ./ -maxdepth 1 -name "*.r00"`)
if [ ${#myarray[@]} -gt 0 ]; then
    echo "rar found extracting rar" >>"${OUTTO}" 2>&1;
    rarFile="$(find ./ -type f -name "*.r00" -printf "%f\n")"
    echo "This may take up to 5minutes(depending on file size)" >>"${OUTTO}" 2>&1;
    echo "Dont close this box...." >>"${OUTTO}" 2>&1;
    OUTPUT="$(unrar e "$rarFile" >>"${OUTTO}" 2>&1;)"
    echo "${OUTPUT}" >>"${OUTTO}" 2>&1;
    echo >>"${OUTTO}" 2>&1;
    echo "File Extracted, Moving to Plex Folder" >>"${OUTTO}" 2>&1;
    newLocation=$PLEXLOCATION"/"$mkvFile
    checkForFileCopyAndMove "mv"
    echo "File Moved, Go check Plex. Close and Refresh" >>"${OUTTO}" 2>&1;
else
    echo >>"${OUTTO}" 2>&1;
    echo "No rars found, checking for video file" >>"${OUTTO}" 2>&1;
    echo >>"${OUTTO}" 2>&1;
    checkForFileCopyAndMove cp
fi

}

function checkForFileCopyAndMove {
    FOUNDFILE="na"
    wmvFile="$(find ./ -type f -name "*.wmv" -printf "%f\n")"
    mp4File="$(find ./ -type f -name "*.mp4" -printf "%f\n")"
    mkvFile="$(find ./ -type f -name "*.mkv" -printf "%f\n")"
    aviFile="$(find ./ -type f -name "*.avi" -printf "%f\n")"
if [ ! -z "$mkvFile" ]; then
    echo "mkv File"
    echo "File Found mkv" >>"${OUTTO}" 2>&1;
    echo "Moving File, this may take up to 5minutes(depending on file size)" >>"${OUTTO}" 2>&1;
    echo "Dont close this box...." >>"${OUTTO}" 2>&1;
    FOUNDFILE="mkv"
elif [ ! -z "$mp4File" ]; then
    echo "mp4 File";
    echo "File Found mp4" >>"${OUTTO}" 2>&1;
    echo "Moving File, this may take up to 5minutes(depending on file size)" >>"${OUTTO}" 2>&1;
    echo "Dont close this box...." >>"${OUTTO}" 2>&1;
    FOUNDFILE="mp4"
elif [ ! -z "$wmvFile" ]; then
    echo "wmv File"
    echo "File Found wmv" >>"${OUTTO}" 2>&1;
    echo "Moving File, this may take up to 5minutes(depending on file size)" >>"${OUTTO}" 2>&1;
    echo "Dont close this box...." >>"${OUTTO}" 2>&1;
    FOUNDFILE="wmv"
elif [ ! -z "$aviFile" ]; then
    echo "avi File"
    echo "File Found avi" >>"${OUTTO}" 2>&1;
    echo "Moving File, this may take up to 5minutes(depending on file size)" >>"${OUTTO}" 2>&1;
    echo "Dont close this box...." >>"${OUTTO}" 2>&1;
    FOUNDFILE="avi"
else
   echo "Cant find Video File"
   return 1
fi


case $FOUNDFILE in
     mkv)
          eval "$1 "$mkvFile" $PLEXLOCATION"
          echo "mkv"
          ;;
     mp4)
          eval "$1 "$mp4File" $PLEXLOCATION"
          echo "mp4"
          ;;
     wmv)
          eval "$1 "$wmvFile" $PLEXLOCATION"
          echo "wmv"
          ;;
     avi)
          eval "$1 "$aviFile" $PLEXLOCATION"
          echo "avi"
         ;;
     *)
          echo "unsupported filetype for now"
          ;;
esac

    echo >>"${OUTTO}" 2>&1;
    echo "Moved to Plex Folder, Go check Plex. Close and Refresh" >>"${OUTTO}" 2>&1;
}

_mvfile $1