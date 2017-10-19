#!/bin/bash
# ------------------------------------------------------------------
# [Author] Semen Zhydenko
#          TODO: 
# 				- optimize search
# 				- add more typos
#
# ------------------------------------------------------------------

if [ $# -eq 0 ]
  then
    echo "No arguments supplied, please provide path."
    echo "Usage: $0 path"
    exit 1
fi

readonly path=$1

wrong_words=()
while IFS= read -r line
do
	wrong_words+=("$line")
done < "typos.txt"

wrong_words=($(for l in ${wrong_words[@]}; do echo $l; done | sort))

pattern=${wrong_words[0]}

for i in "${wrong_words[@]:1}"
do
	pattern=$pattern"\|"$i
done

echo "Search typos in $path"
if ! grep --color -r "$pattern" $path
then
	echo "No typos found."
fi
