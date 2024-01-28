microdnf update -y
microdnf clean all
mkdir -p ${HOME}
mkdir -p /usr/local/bin
chgrp -R 0 /home
chmod +x /entrypoint.sh
chmod -R g=u /home
