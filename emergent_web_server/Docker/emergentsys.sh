#!/bin/bash
cd /home/nashid/dana/
chmod +x dana dnc
cd /home/nashid/emergent_web_server/pal/
dnc ./../make.dn
dana ./../make.o -l all
dana -sp "../repository" EmergentSys.o > em.log