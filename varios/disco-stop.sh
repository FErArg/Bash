#!/bin/bash

# md4 : active raid1 sda1[0] sde1[1]
#       488383936 blocks [2/2] [UU]
      
# md3 : active raid1 sdb4[0] sdd4[1]
#       2008000 blocks [2/2] [UU]
      
# md2 : active raid1 sdd3[0] sdb3[1]
#       183590720 blocks [2/2] [UU]
      
# md1 : active raid1 sdd2[0] sdb2[1]
#       48829440 blocks [2/2] [UU]
      
# md0 : active raid1 sdb1[0] sdd1[1]
#       9767424 blocks [2/2] [UU]


#Discos Multimedia MD4
hdparm -B 254 /dev/sda
hdparm -S 50 /dev/sda
hdparm -B 254 /dev/sde
hdparm -S 50 /dev/sde

# Disco Bkp
hdparm -B 254 /dev/sdc
hdparm -S 50 /dev/sdc


#hdparm -B 254 /dev/sdb
#hdparm -S 50 /dev/sddb

#hdparm -B 254 /dev/sdc
#hdparm -S 50 /dev/sdc

#Disco Principal
#hdparm -S 200 /dev/sdb