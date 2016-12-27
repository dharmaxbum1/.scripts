 #!/bin/bash

toilet xToNouSou > /etc/motd

echo -e "
\033[0;35m+++++++++++++++++: \033[0;37mSystem Data\033[0;35m :+++++++++++++++++++++
\033[0;35m+ \033[0;37mDate and Time \033[0;35m= \033[1;32m`date`
\033[0;35m+      \033[0;37mHostname \033[0;35m= \033[1;32m`hostname`
\033[0;35m+       \033[0;37mAddress \033[0;35m= \033[1;32m`IP=$(curl -s ip.vostron.net |  awk '{print $NF}'); echo -n "$IP <-> "; IP=$(ship -4 | awk '{print $2}'); echo -n "$IP"`
\033[0;35m+        \033[0;37mKernel \033[0;35m= \033[1;32m`uname -r`
\033[0;35m+        \033[0;37mUptime \033[0;35m=\033[1;32m`uptime | cut -d "l" -f 1`
\033[0;35m+          \033[0;37mLoad \033[0;35m= \033[1;32m`uptime | cut -d ":" -f 4`
\033[0;35m+           \033[0;37mCPU \033[0;35m= \033[1;32m`cat /proc/cpuinfo | grep -m 1 "model name" | awk -F ": " '{print $2}'`
\033[0;35m+        \033[0;37mMemory \033[0;35m= \033[1;32mUsed `free -m | head -n 2 | tail -n 1 | awk '{print $3}'`MB out of `free -m | head -n 2 | tail -n 1 | awk '{print $2}'`MB
\033[0;35m+           \033[0;37mHDD \033[0;35m= \033[1;32mUsed `df -h /dev/sda6 | tail -n 1 | awk '{print $3}'` out of `df -h /dev/sda6 | tail -n 1 | awk '{print $2}'`
\033[0;35m++++++++++++++++++: \033[0;37mUser Data\033[0;35m :++++++++++++++++++++++
\033[0;35m+      \033[0;37mUsername \033[0;35m= \033[1;32m`whoami`
\033[0;35m+     \033[0;37mProcesses \033[0;35m= \033[1;32m`ps aux | grep $USER | wc -l` of `ulimit -u` MAX
\033[0;35m+++++++++++++++++++++++++++++++++++++++++++++++++++++
" >> /etc/motd

tput sgr0 
