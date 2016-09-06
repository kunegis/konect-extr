#!/bin/bash 
totimestamp()
{
while read line
do
        echo -n $(echo $line | cut -d" " -f4 --complement)
        echo " $(date --utc --date $(echo $line | cut -d' ' -f4) \+\%s)"
done < "$1"
}

find "$1/download" -regextype posix-awk -regex '.*\.(7z|7z.001)$' -print0 | while read -d $'\0' f
do
        NAME=stackexchange-$(echo $f | sed -ne 's/\(.*\/\)\(.*\)\(\.7z\)\(.001\)*/\2/p')
        7zr e -y -o"$1/extract" "$f"
        if [ "$?" != 0 ]; then
                exit 1
        fi
        VOTEXML=$(find "$1/extract" -iname "votes.xml")
        if [ "$VOTEXML" != "" ]; then

                (sed -ne 's/\(.*PostId="\)\([0-9]*\)\(".*VoteTypeId=\"5\"\)\(.*UserId="\)\([0-9]*\)\(.*CreationDate="\)\([0-9\-]*\)\(".*\)/'$2'\2 '$2'\5 1 \7/p' | ../mkuniq ) < "$VOTEXML" > "$3/out_tmp.$NAME"

           
		NAME2=$(echo "$NAME" | sed -e 's/\./_/g')

		echo "% bip unweighted" > "$3/out.$NAME2"
		../mkcount "$3/out_tmp.$NAME" 0 >> "$3/out.$NAME2"
                totimestamp "$3/out_tmp.$NAME" >> "$3/out.$NAME2"
                rm "$3/out_tmp.$NAME"
        fi
        rm -rf "$1/extract/*"
done


