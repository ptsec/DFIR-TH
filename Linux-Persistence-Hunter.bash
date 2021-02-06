 echo " "
 echo " ******************************************************"
 echo " ******** Linux Persistence Mechanisms Hunter *********"
 echo " ******************************************************"
 echo " "


 mkdir persistence
 chmod 600 persistence
 echo "========================="
 echo "========================="
 echo "0.collecting process and network artifacts"
 echo "========================="
 echo "========================="
 ps -auxwe > persistence/processes
 netstat -antp > persistence/network
 echo "========================="
 echo "========================="
 "1.searching authorized keys"
 echo "========================="
 echo "========================="
 mkdir persistence/ssh_keys
 find / -name .ssh > persistence/ssh_keys/results
 echo "========================="
 echo "========================="
 "2.searching web shell"
 echo "========================="
 echo "========================="
 mkdir persistence/web_shells
 find /var/www/ -type f - grep -l "(" {} \; > persistence/web_shell
 xargs -a persistence/web_shell cp -t persistence/web_shells/ 
 echo "========================="
 echo "========================="
 "3.searching saved php sessions"
 echo "========================="
 echo "========================="
 test -d "/var/lib/php/sessions" &&  cp -r /var/lib/php/sessions persistence/ ||  echo "php/sessions Folder Does not exist" 
 echo "========================="
 echo "========================="
 "4.coping crontab"
 echo "========================="
 echo "========================="
 cp -r /etc/*cron* persistence/
 echo "========================="
 echo "========================="
 "5.Apache mod_rootme"
 echo "========================="
 echo "========================="
 test -d "/usr/lib/apache2/modules" &&  cp -r /usr/lib/apache2/modules persistence/ ||  echo "apache moduled Folder Does not exist" > persistence/modules_results
 echo "========================="
 echo "========================="
 "6.bashrc"
 echo "========================="
 echo "========================="
 cp ~/.bashrc persistence/ ||  echo "bashrc Does not exist" > persistence/bashrc_results
 echo "========================="
 echo "========================="
 "7.Services"
 echo "========================="
 echo "========================="
 mkdir persistence/services
 netstat -tulpn > persistence/services/services_ports
 service --status-all > persistence/services/all_services
 ls -la /etc/init.d/ > persistence/services/etc.init.d
 echo "========================="
 echo "========================="
 "8.sudoers"
 echo "========================="
 echo "========================="
 cp /etc/sudoers persistence/
 echo "========================="
 echo "========================="
 "9.coping suid files"
 echo "========================="
 echo "========================="
 mkdir persistence/suid_files
 find / -perm -4000 -user root -type f > persistence/suid
 xargs -a persistence/suid cp -t persistence/suid_files/
