#!/bin/bash

# CHECK USER ACCOUNTS - /etc/passwd

printf '\033[1;34;43m Liste des utilisateurs \033[0m\n'
cat /etc/passwd

printf '\033[1;34;43m root - uid 0 \033[0m\n'
grep :0: /etc/passwd

printf '\033[1;34;43m Temporary users \033[0m\n'
find / -nouser -print

printf '\033[1;34;43m Mots de passe \033[0m\n'
cat /etc/shadow

printf '\033[1;34;43m Groupes d'utilisateurs \033[0m\n'
cat /etc/group 

printf '\033[1;34;43m Sudoers \033[0m\n'
cat /etc/sudoers

# CHECK CONNEXIONS

printf '\033[1;34;43m Dernière connexion des utilisateurs \033[0m\n'
lastlog

printf '\033[1;34;43m Connexions réussies \033[0m\n'
last

printf '\033[1;34;43m Connexions échouées \033[0m\n'
lastb

# possibilité d'utiliser ac si acct est installée

printf '\033[1;34;43m Connexions locales et distantes \033[0m\n'
tail /var/log/auth.log   # nombre de ligne avec -n

cat /var/log/syslog
cat /var/log/syslog | less
tail -f -n 5 /var/log/syslog
cat /var/log/syslog | grep fail
tail -f /var/log/syslog

# HISTORIQUE DES COMMANDES
history| less 

# RESSOURCES

printf '\033[1;34;43m Uptime \033[0m\n'
uptime  # nombre de ligne avec -n

printf '\033[1;34;43m Memoire \033[0m\n'
free

cat /proc/meminfo

printf '\033[1;34;43m Partition \033[0m\n'
cat /proc/mounts

cat /etc/mtab

printf '\033[1;34;43m Processus \033[0m\n'
top

ps aux

# Plus de detail sur un processus
# lsof -p [pid]

printf '\033[1;34;43m Services \033[0m\n'
service --status-all
# systemctl list-units --type=service

printf '\033[1;34;43m Travaux planifiés \033[0m\n'
cat /etc/crontab
crontab -u user -l

# RESEAU

w

who

printf '\033[1;34;43m DNS \033[0m\n'
more /etc/resolv.conf 

printf '\033[1;34;43m Hostnames & ip \033[0m\n'
more /etc/hosts

printf '\033[1;34;43m Liste des règles du firewall \033[0m\n'
iptables -L -n

# Fichiers

printf '\033[1;34;43m Gros fichiers \033[0m\n'
find /home/ -type f -size +512k -exec ls -lh {} \;

printf '\033[1;34;43m Fichiers créés < 2 jours \033[0m\n'
find / -mtime -2 -ls
find / -mtime -2 -ctime -2 # modifiés ou crées
find / -mmin -1 # dans la dernière minute

printf '\033[1;34;43m Configuration réseau \033[0m\n'
ifconfig -a

ip a
ip route

printf '\033[1;34;43m Fichiers ouverts \033[0m\n'
lsof -i

printf '\033[1;34;43m Liste des ports ouverts \033[0m\n'
netstat -nap
netstat -lntup (liste les ports TCP/UDP exposés avec les services)
netstat -r (liste les routes)
netstat -s (affiche les stats des cartes)

ss -lntup
ss -s (affiche les stats de la carte)

arp -a

echo $PATH

# Vérifier les clés ssh
cat /root/.ssh/authorized_keys
cat /home/debian/.ssh/authorized_keys
cat /home/user1/.ssh/authorized_keys

# Fichiers temporaires
ls /tmp
ls -la /tmp
ls -la /tmp | more
less /tmp
ls -la /tmp | grep xxx


# apt-get install tripwire  - analyse intégrité
# configuration dans le fichier /etc/tripwrie/twpol.txt et une fois 
# vous pouvez l’installer en tapant :
twadmin -m P /etc/tripwire/twpol.txt
# créer la base de données initiale contenant l’état actuel des fichiers 
tripwire -m i 2
# vérifier l’intégrité du système de fichiers
tripwire -m c

# apt-get install logcheck 
"
Logcheck.sh,
Un script contenant la configuration de base.
Logcheck.hacking,
Contient les règles définissant les niveaux d’activité.
Logcheck.ignore,
Contient les expressions à ignorer.
Logcheck.violations,
Contient les expressions pouvant être considérées comme des violations de sécurité.
Logcheck.violations.ignore,
Les expressions présentes dans ce fichier sont destinées à être ignorées.
Vous pouvez utiliser cron pour lancer logcheck toutes les heures : 0 * * * * /bin/sh
/usr/local/etc/logcheck.sh 
"

apt-get install chkrootkit 
lynis
rkhunter