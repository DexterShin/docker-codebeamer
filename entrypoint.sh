#!/bin/bash
#
set -o errexit

if [ -f "/opt/codebeamer/install_codebeamer.sh" ];
then

	rm /opt/codebeamer/install_codebeamer.sh
	rm /opt/codebeamer/cb.bin
	chmod +x /opt/codebeamer/dist/bin/cb

fi

cd /opt/codebeamer/dist
bin/cb
