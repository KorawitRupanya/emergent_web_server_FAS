#!/bin/bash
cd /home/nashid/dana/
chmod +x dana dnc
cd /home/nashid/emergent_web_server/
dnc make.dn
sleep 5
dana make.o -l all
sleep 20
cd pal/
dana -sp "../repository" EmergentSys.o > em.log