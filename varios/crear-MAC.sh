#!/usr/bin/env python
# Author: Mario Scondo
# Web site: http://www.linux-support.com
#
# Generate a random MAC address for virtualization guests or virtual
# network devices.
#
 
import random
 
def randomMAC():
    mac = [ 0x00,
      random.randint(0x00, 0xff),
      random.randint(0x00, 0xff),
      random.randint(0x00, 0xff),
      random.randint(0x00, 0xff),
      random.randint(0x00, 0xff) ]
    return ':'.join(map(lambda x: "%02x" % x, mac))
 
print( randomMAC() )```