#!/bin/bash
WATCHPATH="/var/www/src"
DESTPATH="/var/www/html"

if [ ! -d "$WATCHPATH" ];
then
    echo "FATAL: Watchpath $WATCHPATH does not exist. Exiting." > /dev/stderr
    exit 1
fi

if [ ! -d "$DESTPATH" ];
then
    echo "FATAL: Destination path $DESTPATH does not exist. Exiting." > /dev/stderr
    exit 1
fi

echo "Initially syncing $WATCHPATH to $DESTPATH..." > /dev/stdout
cp -R $WATCHPATH/. $DESTPATH
echo "Done." > /dev/stdout

inotifywait -mr -e modify -e close_write -e move -e create -e delete --timefmt '%d/%m/%y %H:%M' --format '%e %T %w %f' \
$WATCHPATH | while read event date time dir file; 
do
    ABSPATH=${dir}${file}
    # Convert absolute path to relative
    RELPATH=`echo "$ABSPATH" | sed 's_'$WATCHPATH'/__'`
    echo "Event $event triggered on $FILECHANGE (rel: $RELPATH)"

    if [[ "$event" == *"DELETE"* ]] || [[ "$event" == "MOVED_FROM" ]]
    then
        echo "rm -r $DESTPATH/$RELPATH" > /dev/stdout
        rm -r $DESTPATH/$RELPATH;
    else
        echo "cp -R $ABSPATH $DESTPATH/$RELPATH" > /dev/stdout
        cp -R $ABSPATH $DESTPATH/$RELPATH
    fi
done