#!/bin/bash
#INSTALL@ /usr/local/bin/upload_all
pwd=`pwd`
wd=`basename $pwd`
host=shell.xs4all.nl
dest=xs4all
verbose=0
type=scp

if [ -f destination ] ; then
	. destination
else
	echo "No destination file"
	exit
fi
hellup(){
cat <<EOF
$0: upload to the internet
The file `destination' must exist, variables must be set in that file:
remote_dir : directory where the files should be installed
             default is the name of the current directory.
host       : destination host. 
dest       : destination; should match the host.
verbose    : be more informative; default: 0.
type       : scp or ftp
user       : the user ID (possibly with ,passwd)

EOF
}

uploads=''
for argument in $* ; do
	case a$argument in
	(a-h*)	hellup
			exit 0
		;;
	(a-v*)	verbose=1
		;;
	(*)	uploads="$uploads $argument"
		;;
	
	esac
done

if [ "$uploads" = "" ] ; then
	if [ -f UPLOAD ] ; then
		uploads=`paste -d' ' -s <UPLOAD`
	else
		echo "No files to upload"
		exit
	fi

fi

if [ $verbose = 1 ] ; then
cat <<EOF
#  Starting upload with:
#    verbose    = $verbose
#    host       = $host
#    remote_dir = $remote_dir
#    pwd        = $pwd
#    wd         = $wd
#    type       = $type
#    uploads    = $uploads
EOF
fi
  
	

case $type in
(scp)		ssh $host rm -rf $remote_dir/$wd
		ssh $host mkdir $remote_dir/$wd
		ssh $host chmod a+rx $remote_dir/$wd
		scp $uploads $host:$remote_dir/$wd
		ssh $host chmod a+r -R $remote_dir/$wd/*

	;;

(ftp)
		lftp -u $user $host <<EOF
		cd $remote_dir
		rm -rf $wd
		mkdir $wd
EOF
		for f in $uploads ; do
			if [ -d $f ] ; then
				echo "Mkdir $f"
				lftp -u $user $host <<EOF
				cd $wd
				mkdir $f
EOF
			else
				if [ ${f%/*} = $f ] ; then
					nwd=$wd
				else
					nwd=$wd/${f%/*}
				fi
				echo "Put $f to $nwd"
				lftp -u $user $host <<EOF
				cd $nwd
				put $f
EOF
			fi
		done
	;;
(*)	echo '************************************************'
	echo "Unknown $type (must be scp or ftp)"
	echo '************************************************'
	;;
esac


