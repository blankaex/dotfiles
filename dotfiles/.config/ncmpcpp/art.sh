#!/bin/sh

MUSIC_DIR="$HOME/Music"
COVER="$XDG_CACHE_HOME/cover.png"
COVER_SIZE=285

BORDERS=false
BORDER_WIDTH=5
BORDER_COLOR="5f4040"

function ffmpeg_cover {
    if $BORDERS; then
        ffmpeg -loglevel 0 -y -i "$1" -vf "scale=$COVER_SIZE:-1,pad=$COVER_SIZE+$BORDER_WIDTH:ow:(ow-iw)/2:(oh-ih)/2:$BORDER_COLOR" "$COVER"
    else
        ffmpeg -loglevel 0 -y -i "$1" -vf "scale=$COVER_SIZE:-1" "$COVER"
    fi
}

function fallback_find_cover {
    album="${file%/*}"
    album_cover="$(find "$album" -type d -exec find {} -maxdepth 1 -type f -iregex ".*\(cover\|folder\|artwork\|front\|scan\).*[.]\(jpe?g\|png\|gif\|bmp\)" \;)"
    if [ "$album_cover" == "" ]; then
        album_cover="$(find "$album" -type d -exec find {} -maxdepth 1 -type f -iregex ".*[.]\(jpe?g\|png\|gif\|bmp\)" \;)"
    fi
    if [ "$album_cover" == "" ]; then
        album_cover="$XDG_CONFIG_HOME/ncmpcpp/cover.png"
    fi
    album_cover="$(echo -n "$album_cover" | head -n1)"
}

{
    file="$MUSIC_DIR/$(mpc --format %file% current)"

    if [[ -n "$file" ]] ; then
        if ffmpeg_cover "$file"; then
            exit
        else
            fallback_find_cover
            ffmpeg_cover "$album_cover"
        fi
    fi
} &
