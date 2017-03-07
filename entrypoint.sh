#!/bin/bash
#
set -o errexit

sudo own-volume

if [ -f "/opt/codebeamer/first_time" ];
then

	rm /opt/codebeamer/first_time
	rm /opt/codebeamer/cb.bin
	chmod +x /opt/codebeamer/dist/bin/cb

fi

cd /opt/codebeamer/dist
bin/cb
