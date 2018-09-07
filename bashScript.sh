function timeFunc {
  echo " "
  echo "Current Time"
  echo "------------"
  date +"%T"
  echo " "
  echo "Timezone"
  echo "--------"
  date +"%:z %Z"
  echo " "
  echo "Uptime"
  echo "------"
  uptime | awk -F'( |,|:)+' '{if ($7=="min") m=$6; else {if ($7~/^day/) {d=$6;h=$8;m=$9} else {h=$6;m=$7}}} {print d+0,"days,",h+0,"hours,",m+0,"minutes."}'
  #or uptime -p

}

function osVer {
  echo " "
  echo "Typical Name"
  echo "------------"
  uname -o
  echo " "
  echo "Kernel Version"
  echo "--------------"
  uname -r 
}

function SysHardware {
  echo " "
  echo "CPU Brand and Type" 
  echo "------------------"
  cat /proc/cpuinfo | grep 'vendor' | uniq
  cat /proc/cpuinfo | grep 'model name' | uniq
  echo " "
  echo "RAM Amount"
  echo "----------"
  cat /proc/meminfo | grep 'MemTotal'
  echo " "
  echo "HDD Amount"
  echo "----------"
  df -H

}

function hostName {
  echo " "
  echo "Hostname"
  echo "--------"
  hostname
}

function getUsers {
  echo " "
  echo "Users"
  echo "-----"
  cat /etc/passwd
}

function startAtBoot {
  echo " "
  echo "Start at Boot Programs"
  echo "----------------------"
  initctl list
  echo " "
  echo "Start at Boot Services"
  echo "----------------------"
  ls /etc/init.d/
  
}

function scheduledTasks {
  echo " "
  echo "Daily Tasks"
  echo "----------"
  ls -la /etc/cron.daily/
  echo " "
  echo "Weekly Tasks"
  echo "----------"
  ls -la /etc/cron.weekly/
  echo " "
  echo "Monthly Tasks"
  echo "----------"
  ls -la /etc/cron.monthly/
}

function networkInfo {
  echo " "
  echo "ARP Table"
  echo "---------"
  arp -a
  echo " "
  echo "MAC Address for all Interfaces"
  echo "------------------------------"
  ip -o link  | awk '{print $2,$(NF-2)}' 
  echo " "
  echo "Routing Table"
  echo "-------------"
  route -n
  echo " "
  echo "IP Address for all Interfaces"
  echo "-----------------------------"
  ip addr | awk '/^[0-9]+/ { currentinterface=$2 } $1 == "inet" { split( $2, foo, "/" ); print currentinterface ,foo[1] }'
  echo " "
  ip addr | awk '/^[0-9]+/ { currentinterface=$2 } $1 == "inet6" { split( $2, foo, "/" ); print currentinterface ,foo[1] }'
  echo " "
  echo "DHCP Server Address"
  echo "-------------------"
  cat /var/lib/dhcp/dhclient.eth0.leases | grep "option dhcp-server-identifier"
  echo " "
  echo "DNS Server Address"
  echo "-------------------"
  cat /etc/resolv.conf | grep "nameserver"

  ####Finish Get Default Gateways####

  echo " "
  echo "Listening Services"
  echo "------------------"
  sudo netstat -plnt
  echo " "
  echo "Established connections" 
  echo "-----------------------"
  netstat -anp | grep 'ESTABLISHED'
}

function extraNetworkInfo {
  echo " "
  echo "Network Shares"
  echo "--------------"
  sudo smbstatus --shares
  echo " "
  echo "Printers"
  echo "--------"
  lpstat -p
  echo " "
  echo "Wifi Access Profiles"
  echo "--------------------"
  ls /etc/NetworkManager/system-connections
}

function listInstalledSoftware {
  echo " "
  echo "Installed Softare"
  echo "-----------------"
  ls /usr/share/applications | awk -F '.desktop' ' { print $1}' -

}

function processList {
  echo " "
  echo "Process List"
  echo "------------"
  ps -aux
}

function driverList {
  echo " "
  echo "Driver List"
  echo "-----------"
  cat /proc/modules
}

function downloadsAndDocs {
  echo " "
  echo "Downloads and Documents"
  echo "-----------------------"
  ls /home/*/Downloads
  ls /home/*/Documents
}

echo "1) Time"
echo "2) OS Version"
echo "3) System Hardware Specs"
echo "4) Hostname and Domain"
echo "5) List of users"
echo "6) Start at Boot"
echo "7) List of scheduled tasks"
echo "8) Network"
echo "9) Network shares, printers, and wifi access profiles"
echo "10) List of installed programs"
echo "11) Process List"
echo "12) Drivers List"
echo "13) List of files in Downloads and Documents for each user"
read OPTION

case $OPTION in
    1)
     timeFunc
     ;;
    2)
     osVer
     ;;
    3)
     SysHardware
     ;;
    4)
     hostName
     ;;
    5)
     getUsers
     ;;
    6)
     startAtBoot
     ;;
    7)
     scheduledTasks
     ;;
    8)
     networkInfo
     ;;
    9)
     extraNetworkInfo
     ;;
    10)
     listInstalledSoftware
     ;;
    11)
     processList
     ;;
    12)
     driverList
     ;;
    13)
     downloadsAndDocs
     ;;
esac
	






