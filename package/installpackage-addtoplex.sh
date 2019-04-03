#!/bin/bash
#
# Script to add torrent file to plex

OUTTO=/srv/rutorrent/home/db/output.log
TORRENTLOCATION=/mnt/torrents
PLEXMOVIELOCATION=/mnt/Plex/Movies
PLEXTVLOCATION=/mnt/Plex/Tv\ Shows

MOVELOCATION=''

function _mvfile {
declare -i count=$1
        echo $count
        content=$(sed -n "$count"'p' /home/mod/.autodl/DownloadHistory.txt)
        location=$(echo "$content" | grep -o -P '^(.+?(?=[0-9]{13}))')
        decideIfMovieOrTvShow "$location"
        location=${location// /.}
        fullLocation=$TORRENTLOCATION"/"$location
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
          eval "$1 "$mkvFile" $MOVELOCATION"
          echo "mkv"
          ;;
     mp4)
          eval "$1 "$mp4File" $MOVELOCATION"
          echo "mp4"
          ;;
     wmv)
          eval "$1 "$wmvFile" $MOVELOCATION"
          echo "wmv"
          ;;
     avi)
          eval "$1 "$aviFile" $MOVELOCATION"
          echo "avi"
         ;;
     *)
          echo "unsupported filetype for now"
          ;;
esac

    echo >>"${OUTTO}" 2>&1;
    echo "Moved to Plex Folder, Go check Plex. Close and Refresh" >>"${OUTTO}" 2>&1;
}

function decideIfMovieOrTvShow {
    MOVELOCATION=$PLEXMOVIELOCATION
    filename=/usr/local/bin/quickbox/package/extensions/tvshowdata.txt
    while read -r line; do
        name="$line"
        echo $name
        if [[ "$1" == *"$name"* ]]; then
            MOVELOCATION=$PLEXTVLOCATION
        fi
    done < "$filename"

    echo $MOVELOCATION
}

_mvfile $1