#!/bin/bash
version=$(vboxmanage -v)
echo version1 $version

var1=$(echo $version | cut -d 'r' -f 1)
echo version2 $var1

sufijo="_Ubuntu"
var2=$(echo "$var1" | sed -e "s/$sufijo$//")
echo version3 $var2

var3=$(echo $version | cut -d 'r' -f 2)
echo version $var3


file="Oracle_VM_VirtualBox_Extension_Pack-$var2-$var3.vbox-extpack"
echo file $file

#wget https://download.virtualbox.org/virtualbox/6.0.12/Oracle_VM_VirtualBox_Extension_Pack-6.0.12.vbox-extpack
wget https://download.virtualbox.org/virtualbox/$var2/$file -O /tmp/$file

#sudo VBoxManage extpack uninstall "Oracle VM VirtualBox Extension Pack"
sudo VBoxManage extpack install /tmp/$file --replace
