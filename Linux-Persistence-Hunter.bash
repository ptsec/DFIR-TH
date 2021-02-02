"========================="
"========================="
"searching Linux persistence Mechanisms"
 "========================="
 "========================="
 mkdir persistence
 "========================="
 "========================="
 "0.collecting process and network artifacts"
 "========================="
 "========================="
 ps -auxwe > persistence/processes
 netstat -antp > persistence/network
 "========================="
 "========================="
 "1.searching authorized keys"
 "========================="
 "========================="
 mkdir persistence/ssh_keys
 find / -name .ssh > persistence/ssh_keys/results
 "========================="
 "========================="
 "2.searching web shell"
 "========================="
 "========================="
 mkdir persistence/web_shells
 find /var/www/ -type f - grep -l "(" {} \; > persistence/web_shell
 xargs -a persistence/web_shell cp -t persistence/web_shells/ 
 "========================="
 "========================="
 "3.searching saved php sessions"
 "========================="
 "========================="
 test -d "/var/lib/php/sessions" &&  cp -r /var/lib/php/sessions persistence/ ||  echo "php/sessions Folder Does not exist" 
 "========================="
 "========================="
 "4.coping crontab"
 "========================="
 "========================="
 cp -r /etc/*cron* persistence/
 "========================="
 "========================="
 "5.Apache mod_rootme"
 "========================="
 "========================="
 test -d "/usr/lib/apache2/modules" &&  cp -r /usr/lib/apache2/modules persistence/ ||  echo "apache moduled Folder Does not exist" > persistence/modules_results
 "========================="
 "========================="
 "6.bashrc"
 "========================="
 "========================="
 cp ~/.bashrc persistence/ ||  echo "bashrc Does not exist" > persistence/bashrc_results
 "========================="
 "========================="
 "7.Services"
 "========================="
 "========================="
 mkdir persistence/services
 netstat -tulpn > persistence/services/services_ports
 service --status-all > persistence/services/all_services
 ls -la /etc/init.d/ > persistence/services/etc.init.d
 "========================="
 "========================="
 "8.sudoers"
 "========================="
 "========================="
 cp /etc/sudoers persistence/
 "========================="
 "========================="
 "9.coping suid files"
 "========================="
 "========================="
 mkdir persistence/suid_files
 find / -perm -4000 -user root -type f > persistence/suid
 xargs -a persistence/suid cp -t persistence/suid_files/
