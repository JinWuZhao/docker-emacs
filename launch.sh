#!/bin/bash

# setup timezone
TZFILE=/usr/share/zoneinfo/$TIMEZONE

if [ -f "$TZFILE" ];
then
    cp -f $TZFILE /etc/localtime
    echo $TIMEZONE > /etc/timezone
fi

unset TIMEZONE
unset TZFILE

# setup user
NAME=root
MY_UID=`ls -nd /mnt/share/Documents | awk '{print $3}'`
if [ "$MY_UID" != `id -u` ];
then
    NAME='me'
    useradd $NAME -s /bin/bash -u $MY_UID -m
    passwd -u -d $NAME >/dev/null 2>&1
    echo "$NAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
    if [ -f "/root/.emacs" ];
    then
        cp -f /root/.emacs /home/$NAME/
    fi
    if [ -d "/root/.emacs.d" ];
    then
        cp -rf /root/.emacs.d /home/$NAME/
    fi
    chown -R "$NAME:$NAME" /home/$NAME
fi
unset MY_UID

CONFDIR=/mnt/share/configs

if [ -f "$CONFDIR/setup.sh" ];
then
    cd $CONFDIR
    bash -euo pipefail $CONFDIR/setup.sh
fi

su -c 'cd /mnt/share/Documents && if [ -f "./.setup.sh" ]; then bash -euo pipefail ./.setup.sh; fi' $NAME

if [ -f "$CONFDIR/launch.sh" ];
then
    printf "#!/bin/bash\ncd /mnt/share/Documents && bash -euo pipefail $CONFDIR/launch.sh $*\n" > /tmp/run_emacs.sh
    chmod +x /tmp/run_emacs.sh
    runuser -u $NAME /tmp/run_emacs.sh
else
    printf "#!/bin/bash\ncd /mnt/share/Documents && emacs .\n" > /tmp/run_emacs.sh
    chmod +x /tmp/run_emacs.sh
    runuser -u $NAME /tmp/run_emacs.sh
fi
