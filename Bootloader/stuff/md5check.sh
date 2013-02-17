#!/system/bin/busybox sh

# Get a list of files in a directory without the .md5 extension
# Note the ticks
cd /data/local/tmp/pwn

LIST=`find . -name "*.img" -a ! -name '.md5'`
     
# For each file in the list, generate an MD5sum and
# the place the sum inside of a file of the same name, but with
# the extension.md5
for FILE in $LIST;
do
	echo
    echo "Checking: $FILE"
	echo "Using md5 from: $FILE.md5"
	echo
	echo
	md5sum -c $FILE.md5
	echo
	md5sum $FILE
	cat $FILE.md5
	echo
done