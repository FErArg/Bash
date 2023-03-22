#!/bin/sh
SIDSAMBA=2071848175-3198401325-766608638

groupdel ntadmin
groupdel ntadmindom
groupdel ntduplicadores
groupdel ntinvdom
groupdel ntinvitados
groupdel ntopecopias
groupdel ntopecuentas
groupdel ntopeimpresion
groupdel ntopesistema
groupdel ntusravanzados
groupdel ntusudom
groupdel ntusuarios

net groupmap delete sid="S-1-5-32-544"
net groupmap delete sid="S-1-5-21-$SIDSAMBA-512"
net groupmap delete sid="S-1-5-32-552"
net groupmap delete sid="S-1-5-21-$SIDSAMBA-514"
net groupmap delete sid="S-1-5-32-546"
net groupmap delete sid="S-1-5-32-551"
net groupmap delete sid="S-1-5-32-548"
net groupmap delete sid="S-1-5-32-550"
net groupmap delete sid="S-1-5-32-549"
net groupmap delete sid="S-1-5-32-547"
net groupmap delete sid="S-1-5-21-$SIDSAMBA-513"
net groupmap delete sid="S-1-5-32-545"