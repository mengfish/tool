#!/bin/bash
component=(decode encode cp vp kernel mdf)
#component=(decode encode)

for i in ${component[@]}

do
        echo "we will copy the $i config file."
        echo "processing......"
        echo "Copying devtoolconfig.$i"
	dir=$(find ./ -name $i)	

	for j in ${dir[*]}
	do
		
		echo "Let's copy the devtoolconfig.$i to $j"
		cp -u -f devtoolconfig.$i $j/devtoolconfig

	done

        echo "Done"

done

sync

exit $?
