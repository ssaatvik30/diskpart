#!/bin/bash

#Entry Point
main() {
        diskpart "$@" #Calling the diskpart function and passing all the arguments to it
}

usage() {
	echo "Diskpart requires a valid option, arguments
	      Usage -n: for new partition table
	      	    -e: for partition on existing table
	      Or check man page for diskpart."

}

#Getopts Function for parsing arguments as options
diskpart() {
        while getopts ":ne" opt; do
                case $opt in
                        n) new_part "$@" ;;
                        e) exist_part "$@" ;;
			\?) usage "$@" ;;
                esac
        done

}

#Partition functin for a new partition table on drive, make a filesystem and mount it
new_part() {
        parted --script /dev/$2 mklabel $3 mkpart $4 $5 $6 $7 2> /dev/null
	sleep 1 #sleep for 1 second to give time for partitioning as not to throw error on screen
        
	mkfs.$5 /dev/$8
	sleep 1 #sleep for 1 second to give time for partitioning as not to throw error on screen

	if [ -n "$9" ];
	then
        	mount /dev/$8 $9 2> /dev/null
        	if [ $? -ne 0 ];
        	then
                	mkdir -p $9
                	mount /dev/$8 $9
        	fi
	fi

}

#Partition function for partitioning on existing partition table, make a filesystem and mount it
exist_part() {
	parted --script /dev/$2 mkpart $3 $4 $5 $6 2> /dev/null
        sleep 1 #sleep for 1 second to give time for partitioning as not to throw error on screen 
	
	mkfs.$4 /dev/$7
	sleep 1 #sleep for 1 second to give time for partitioning as not to throw error on screen
        
	if [ -n "$8" ];
	then
		mount /dev/$7 $8 2> /dev/null
        	if [ $? -ne 0 ];
        	then
                	mkdir -p $8
                	mount /dev/$7 $8
        	fi
	fi
}

#Calling the main function with all the arguments
main "$@"

