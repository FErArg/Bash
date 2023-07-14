#!/bin/bash

# Get the installed version of Calibre
calibre=$(which calibre)
installed_version=$($calibre --version | awk '{ print substr( $3, 1, length($3)-1 ) }')

# Get the latest version of Calibre from the web
latest_version=$(curl -s https://calibre-ebook.com/whats-new | grep -oP --max-count=1 'Release: \K[\d.]+')

echo "Installed: $installed_version - Latest: $latest_version"

# Compare the versions ${FOO%.*}
if [ "$installed_version" = "$latest_version" ];then
    # TRUE
    echo "You have the latest version of Calibre ($installed_version)."
else
    # FALSE
    echo "Your installed version of Calibre is $installed_version, and the latest version is $latest_version."
    sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin
fi