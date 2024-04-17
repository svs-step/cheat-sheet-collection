
## Bash & utilitaires

### Historique des commandes
```sh
history           
!<num_command>
!!      # Exécuter la dernière commande
```
### Informations sur les fichiers
```sh
pwd         	# Emplacement actuel

ls      		# Liste des fichiers
ls -a|--all 	# Liste de tous les dossiers et fichiers (dont cachés)
ls -l 			# Liste format long dossiers et fichiers
ls -l -h    	# h pour --human-readable 
ls -t			# t pour classés par modification time, newest first

stat my_file 	# size, date creation acces modification 

tree 			# List directory and file tree
tree -a 		# List directory and file tree including hidden
tree -d 		# List directory tree
tree -L 1		# L pour level - Profondeur de l'arbre

exa 			# remplacement tree - https://the.exa.website/

cd mon_dossier 	# Go to foo sub-directory
cd 				# Go to home
cd ~ 			# Go to home
cd - 			# Go to last directory

pushd foo 		# Go to foo sub-directory and add previous directory to stack
popd 			# Go back to directory in stack saved by `pushd`

```
## Création de dossier
```sh
mkdir mon_dossier # Create a directory
mkdir -p|--parents foo/bar # Create nested directory
mkdir -p|--parents {foo,bar}/baz # Create multiple nested directories

mktemp -d|--directory # Create a temporary directory
```
## Déplacements et copies
```sh
cp -R|--recursive dir_1 dir_2 # Copy directory
mv foo bar 		# Déplacement vs renommage

# Copie distante
rsync -z|--compress -v|--verbose /foo /bar # Copy directory, overwrites destination

rsync -a|--archive -z|--compress -v|--verbose /foo /bar # Copy directory, without overwriting destination

rsync -avz /foo username@hostname:/bar # Copy local directory to remote directory

rsync -avz username@hostname:/foo /bar # Copy remote directory to local directory

```
## Supprimer dossier
```sh
rmdir dir_1 # Delete empty directory

rm -r|--recursive foo # Delete directory including contents

rm -r|--recursive -f|--force foo # Delete directory including contents, ignore nonexistent files and never prompt

```
## Création fichier
```sh
touch foo.txt # Create file or update existing files modified timestamp
touch foo.txt bar.txt # Create multiple files
touch {foo,bar}.txt # Create multiple files
touch test{1..3} # Create test1, test2 and test3 files
touch test{a..c} # Create testa, testb and testc files

mktemp # Create a temporary file
```
## Sorties Standard Error & entrée Input
```sh
echo "foo" > bar.txt # Overwrite file with content
echo "foo" >> bar.txt # Append to file with content

ls exists 1> stdout.txt # Redirect the standard output to a file
ls noexist 2> stderror.txt # Redirect the standard error output to a file
ls 2>&1 > out.txt # Redirect standard output and error to a file
ls > /dev/null # Discard standard output and error

read foo # Read from standard input and write to the variable foo
```
## Déplacement fichier
```sh
cp foo.txt bar.txt # Copy file

mv foo.txt bar.txt # Move file

rsync -z|--compress -v|--verbose /foo.txt /bar # Copy file quickly if not changed

rsync z|--compress -v|--verbose /foo.txt /bar.txt # Copy and rename file quickly if not changed
```
## Suppression fihier
```sh
rm foo.txt # Delete file

rm -f|--force foo.txt # Delete file, ignore nonexistent files and never prompt
```
## Lire des fichiers
```sh
cat foo.txt # Print all contents

less foo.txt # Print some contents at a time (g - go to top of file, SHIFT+g, go to bottom of file, /foo to search for 'foo')

head foo.txt # Print top 10 lines of file
head -n n fichier_1

tail foo.txt # Print bottom 10 lines of file
tail -n n fichier_1

open foo.txt # Open file in the default editor

update-alternatives --display editor
sudo update-alternatives --config editor

wc fichier.txt # List number of lines words and characters in the file

```
## File Permissions

| # | Permission | rwx | Binary |

| - | - | - | - |

| 7 | read, write and execute | rwx | 111 |

| 6 | read and write | rw- | 110 |

| 5 | read and execute | r-x | 101 |

| 4 | read only | r-- | 100 |

| 3 | write and execute | -wx | 011 |

| 2 | write only | -w- | 010 |

| 1 | execute only | --x | 001 |

| 0 | none | --- | 000 |

For a directory, execute means you can enter a directory.

| User | Group | Others | Description |

| - | - | - | - |

| 6 | 4 | 4 | User can read and write, everyone else can read (Default file permissions) |

| 7 | 5 | 5 | User can read, write and execute, everyone else can read and execute (Default directory permissions) |

- u - User

- g - Group

- o - Others

- a - All of the above

```sh
ls -l /foo.sh # List file permissions

chmod +100 foo.sh 	# Add 1 to the user permission
chmod -100 foo.sh 	# Subtract 1 from the user permission
chmod u+x foo.sh 	# Give the user execute permission
chmod g+x foo.sh 	# Give the group execute permission
chmod u-x,g-x foo.sh # Take away the user and group execute permission
chmod u+x,g+x,o+x foo.sh # Give everybody execute permission
chmod a+x foo.sh 	# Give everybody execute permission
chmod +x foo.sh 	# Give everybody execute permission
```
## Finding Files
```sh
type wget 			# Find the binary

which wget 			# Find the binary

whereis wget 		# Find the binary, source, and manual page files
```

`locate` uses an index and is fast (à installer)
```sh
updatedb 			# Update the index

locate foo.txt 		# Find a file
locate --ignore-case # Find a file and ignore case
locate f*.txt 		# Find a text file starting with 'f'
```

`find` doesn't use an index and is slow.
```bash
find /path -name foo.txt 	# Find a file
find /path -iname foo.txt 	# Find a file with case insensitive search
find /path -name "*.txt" 	# Find all text files
find /path -name foo.txt -delete # Find a file and delete it
find /path -name "*.png" -exec pngquant {} # Find all .png files and execute pngquant on it
find /path -type f -name foo.txt # Find a file
find /path -type d -name foo # Find a directory
find /path -type l -name foo.txt # Find a symbolic link
find /path -type f -mtime +30 # Find files that haven't been modified in 30 days
find /path -type f -mtime +30 -delete # Delete files that haven't been modified in 30 days
```
## Find in Files
```sh
grep 'foo' /bar.txt 	# Search for 'foo' in file 'bar.txt'
grep 'foo' /ba
grep 'foo' /bar -R|--dereference-recursive # Search for 'foo' in directory 'bar' and follow symbolic links
grep 'foo' /bar -l|--files-with-matches # Show only files that match
grep 'foo' /bar -L|--files-without-match # Show only files that don't match
grep 'Foo' /bar -i|--ignore-case # Case insensitive search
grep 'foo' /bar -x|--line-regexp # Match the entire line
grep 'foo' /bar -C|--context 1 # Add N line of context above and below each search result
grep 'foo' /bar -v|--invert-match # Show only lines that don't match
grep 'foo' /bar -c|--count # Count the number lines that match
grep 'foo' /bar -n|--line-number # Add line numbers
grep 'foo' /bar --colour # Add colour to output
grep 'foo\|bar' /baz -R # Search for 'foo' or 'bar' in directory 'baz'
grep --extended-regexp|-E 'foo|bar' /baz -R # Use regular expressions
egrep 'foo|bar' /baz -R # Use regular expressions
```
### Replace in Files
```sh
sed 's/fox/bear/g' foo.txt # Replace fox with bear in foo.txt and output to console
sed 's/fox/bear/gi' foo.txt # Replace fox (case insensitive) with bear in foo.txt and output to console
sed 's/red fox/blue bear/g' foo.txt # Replace red with blue and fox with bear in foo.txt and output to console
sed 's/fox/bear/g' foo.txt > bar.txt # Replace fox with bear in foo.txt and save in bar.txt
sed 's/fox/bear/g' foo.txt -i|--in-place # Replace fox with bear and overwrite foo.txt
```
## Symbolic Links
```sh
ln -s|--symbolic foo bar # Create a link 'bar' to the 'foo' folder
ln -s|--symbolic -f|--force foo bar # Overwrite an existing symbolic link 'bar'

ls -l # Show where symbolic links are pointing
```
## Compressing Files
### zip
Compresses one or more files into *.zip files.
```sh
zip foo.zip /bar.txt # Compress bar.txt into foo.zip
zip foo.zip /bar.txt /baz.txt # Compress bar.txt and baz.txt into foo.zip
zip foo.zip /{bar,baz}.txt # Compress bar.txt and baz.txt into foo.zip
zip -r|--recurse-paths foo.zip /bar # Compress directory bar into foo.zip
```
### gzip
Compresses a single file into *.gz files.
```sh
gzip /bar.txt foo.gz # Compress bar.txt into foo.gz and then delete bar.txt
gzip -k|--keep /bar.txt foo.gz # Compress bar.txt into foo.gz
```
### tar -c
Compresses (optionally) and combines one or more files into a single *.tar, *.tar.gz, *.tpz or *.tgz file.
```sh
tar -c|--create -z|--gzip -f|--file=foo.tgz /bar.txt /baz.txt # Compress bar.txt and baz.txt into foo.tgz
tar -c|--create -z|--gzip -f|--file=foo.tgz /{bar,baz}.txt # Compress bar.txt and baz.txt into foo.tgz
tar -c|--create -z|--gzip -f|--file=foo.tgz /bar # Compress directory bar into foo.tgz
```
## Decompressing Files
### unzip
```sh
unzip foo.zip # Unzip foo.zip into current directory
```
### gunzip
```sh
gunzip foo.gz # Unzip foo.gz into current directory and delete foo.gz
gunzip -k|--keep foo.gz # Unzip foo.gz into current directory
```
### tar -x
```sh
tar -x|--extract -z|--gzip -f|--file=foo.tar.gz # Un-compress foo.tar.gz into current directory
tar -x|--extract -f|--file=foo.tar # Un-combine foo.tar into current directory
```
## Disk Usage
```sh
df # List disks, size, used and available space
df -h|--human-readable # List disks, size, used and available space in a human readable format

du # List current directory, subdirectories and file sizes
du /foo/bar # List specified directory, subdirectories and file sizes
du -h|--human-readable # List current directory, subdirectories and file sizes in a human readable format
du -d|--max-depth # List current directory, subdirectories and file sizes within the max depth
du -d 0 # List current directory size
```
## Memory Usage
```sh
free # Show memory usage
free -h|--human # Show human readable memory usage
free -h|--human --si # Show human readable memory usage in power of 1000 instead of 1024
free -s|--seconds 5 # Show memory usage and update continuously every five seconds

# Exécution périodique commande
watch -n 1 -d commande
```
## Packages
```sh
apt update # Refreshes repository index
apt search wget # Search for a package
apt show wget # List information about the wget package
apt list --all-versions wget # List all versions of the package
apt install wget # Install the latest version of the wget package
apt install wget=1.2.3 # Install a specific version of the wget package
apt remove wget # Removes the wget package

apt upgrade # Upgrades all upgradable packages

apt-cache 

apt autoremove
apt autoclean

dpkg (à compléter)
```
### Librairies linux utiles
- bash-completion
  
## Shutdown and Reboot
```sh
shutdown # Shutdown in 1 minute
shutdown now "Cya later" # Immediately shut down
shutdown +5 "Cya later" # Shutdown in 5 minutes
shutdown --reboot # Reboot in 1 minute
shutdown -r now "Cya later" # Immediately reboot
shutdown -r +5 "Cya later" # Reboot in 5 minutes
shutdown -c # Cancel a shutdown or reboot

reboot # Reboot now
reboot -f # Force a reboot
```

## Identifying Processes
```sh
top 		# List all processes interactively

htop 		# List all processes interactively

bpytop  	# (à installer)

ps all 		# List all processes

pidof foo 	# Return the PID of all foo processes

CTRL+Z 		# Suspend a process running in the foreground

bg 			# Resume a suspended process and run in the background

fg 			# Bring the last background process to the foreground
fg 1 		# Bring the background process with the PID to the foreground

sleep 30 & # Sleep for 30 seconds and move the process into the background

jobs 		# List all background jobs
jobs -p 	# List all background jobs with their PID

lsof 		# List all open files and the process using them
lsof -itcp:4000 # Return the process listening on port 4000
```

## Process Priority
Process priorities go from -20 (highest) to 19 (lowest).
```sh
nice -n -20 foo # Change process priority by name
renice 20 PID # Change process priority by PID
ps -o ni PID # Return the process priority of PID
```

## Killing Processes
```sh
CTRL+C # Kill a process running in the foreground

kill PID # Shut down process by PID gracefully. Sends TERM signal.
kill -9 PID # Force shut down of process by PID. Sends SIGKILL signal.

pkill foo # Shut down process by name gracefully. Sends TERM signal.
pkill -9 foo # force shut down process by name. Sends SIGKILL signal.

killall foo # Kill all process with the specified name gracefully.
```

## Date & Time
```sh
date # Print the date and time
date --iso-8601 # Print the ISO8601 date
date --iso-8601=ns # Print the ISO8601 date and time

time tree # Time how long the tree command takes to execute
```

## Scheduled Tasks
```pre

* * * * *
Minute, Hour, Day of month, Month, Day of the week

```

```sh
crontab -l # List cron tab
crontab -e # Edit cron tab in Vim
crontab /path/crontab # Load cron tab from a file
crontab -l > /path/crontab # Save cron tab to a file

* * * * * foo # Run foo every minute
*/15 * * * * foo # Run foo every 15 minutes
0 * * * * foo # Run foo every hour
15 6 * * * foo # Run foo daily at 6:15 AM
44 4 * * 5 foo # Run foo every Friday at 4:44 AM
0 0 1 * * foo # Run foo at midnight on the first of the month
0 0 1 1 * foo # Run foo at midnight on the first of the year

at -l # List scheduled tasks
at -c 1 # Show task with ID 1
at -r 1 # Remove task with ID 1
at now + 2 minutes # Create a task in Vim to execute in 2 minutes
at 12:34 PM next month # Create a task in Vim to execute at 12:34 PM next month
at tomorrow # Create a task in Vim to execute tomorrow
```

## HTTP Requests
```sh
curl https://example.com # Return response body
curl -i|--include https://example.com # Include status code and HTTP headers
curl -L|--location https://example.com # Follow redirects
curl -o|--remote-name foo.txt https://example.com # Output to a text file
curl -H|--header "User-Agent: Foo" https://example.com # Add a HTTP header
curl -X|--request POST -H "Content-Type: application/json" -d|--data '{"foo":"bar"}' https://example.com # POST JSON
curl -X POST -H --data-urlencode foo="bar" http://example.com # POST URL Form Encoded

wget https://example.com/file.txt . # Download a file to the current directory
wget -O|--output-document foo.txt https://example.com/file.txt # Output to a file with the specified name
```

## Network Troubleshooting
```sh
ping example.com # Send multiple ping requests using the ICMP protocol
ping -c 10 -i 5 example.com # Make 10 attempts, 5 seconds apart

ip addr # List IP addresses on the system
ip route show # Show IP addresses to router

netstat -i|--interfaces # List all network interfaces and in/out usage
netstat -l|--listening # List all open ports

traceroute example.com # List all servers the network traffic goes through

mtr -w|--report-wide example.com # Continually list all servers the network traffic goes through
mtr -r|--report -w|--report-wide -c|--report-cycles 100 example.com # Output a report that lists network traffic 100 times

nmap 0.0.0.0 # Scan for the 1000 most common open ports on localhost
nmap 0.0.0.0 -p1-65535 # Scan for open ports on localhost between 1 and 65535
nmap 192.168.4.3 # Scan for the 1000 most common open ports on a remote IP address
nmap -sP 192.168.1.1/24 # Discover all machines on the network by ping'ing them
```

## DNS
```sh
host example.com # Show the IPv4 and IPv6 addresses

dig example.com # Show complete DNS information

cat /etc/resolv.conf # resolv.conf lists nameservers
```

## Hardware
```sh
lsusb # List USB devices

lspci # List PCI hardware

lshw # List all hardware
```

## Terminal Multiplexers
Start multiple terminal sessions. Active sessions persist reboots. `tmux` is more modern than `screen`.
```sh
tmux # Start a new session (CTRL-b + d to detach)
tmux ls # List all sessions
tmux attach -t 0 # Reattach to a session

screen # Start a new session (CTRL-a + d to detach)
screen -ls # List all sessions
screen -R 31166 # Reattach to a session

exit # Exit a session
```

## Secure Shell Protocol (SSH)
```sh
ssh hostname # Connect to hostname using your current user name over the default SSH port 22
ssh -i foo.pem hostname # Connect to hostname using the identity file
ssh user@hostname # Connect to hostname using the user over the default SSH port 22
ssh user@hostname -p 8765 # Connect to hostname using the user over a custom port
ssh ssh://user@hostname:8765 # Connect to hostname using the user over a custom port
```

Set default user and port in `~/.ssh/config`, so you can just enter the name next time:
```sh
$ cat ~/.ssh/config

Host name

User foo

Hostname 127.0.0.1

Port 8765

$ ssh name
```

## Secure Copy
```sh
scp foo.txt ubuntu@hostname:/home/ubuntu # Copy foo.txt into the specified remote directory
```

---

## Systemd
### systemctl
systemd est un gestionnaire de systèmes d’initialisation et de systèmes.
#### Gestion de service
L’objectif fondamental d’un système d’initialisation est d’initialiser les composants qui doivent être démarrés une fois que le noyau Linux est lancé (traditionnellement connus sous le nom de composants « userland »). De plus, le système d’initialisation vous permet de gérer à tout moment les services et les démons du serveur alors que le système est en marche. Dans cette optique, nous allons commencer par certaines des opérations de base de gestion de service.
```sh
# Démarrage et arrêt des services
sudo systemctl start application[.service]
sudo systemctl stop application.service
sudo systemctl restart application.service
sudo systemctl reload application.service
sudo systemctl reload-or-restart application.service # si doute sur implémentation reload

# Activation et désactivation des services
sudo systemctl enable application.service
sudo systemctl disable application.service

# Vérification de l’état des services
systemctl status application.service
systemctl is-active application.service
systemctl is-enabled application.service
systemctl is-failed application.service
```
#### État du système
```sh
# Liste des unités en cours d’utilisation
systemctl list-units   # Affiche uniquement les unités actives par défaut # systemctl 
"UNIT : le nom de l’unité systemd
LOAD : si la configuration de l’unité a été analysée par systemd. La configuration des unités chargées est gardée en mémoire.
ACTIVE : résumé indiquant si l’unité est active
SUB : état de niveau inférieur qui donne des informations plus détaillées sur l’unité
DESCRIPTION : courte description textuelle de ce que l’unité est/fait."

systemctl list-units --all
"En sysV"
service --status-all

systemctl list-units --all --state=inactive
systemctl list-units --type=service

# Liste de tous les fichiers de l’unité
systemctl list-unit-files
```
#### Gestion de l’unité
```sh
# Affichage du fichier de l’unité
systemctl cat atd.service
#Affichage des dépendances
systemctl list-dependencies sshd.service
# Vérification des propriétés de l’unité
systemctl show sshd.service
systemctl show sshd.service -p Conflicts
# Masquage et affichage des unités
sudo systemctl mask nginx.service
sudo systemctl unmask nginx.service

# Modification des fichiers de l’unité
sudo systemctl edit nginx.service
sudo systemctl edit --full nginx.service
" Supprimer tous les ajouts effectués => supprimer soit le répertoire de configuration de l’unité .d ou le fichier de service modifié de /etc/systemd/system. 
Par exemple, pour supprimer un fragment de code, nous pourrions saisir :"
sudo rm -r /etc/systemd/system/nginx.service.d
"Pour supprimer un fichier complet de l’unité modifié, il faudrait entrer :"
sudo rm /etc/systemd/system/nginx.service
"Recharger le processus systemd pour qu’il ne tente plus de référencer ces fichiers et réutilise les copies du système. Vous pouvez le faire en tapant :"
sudo systemctl daemon-reload
```
#### Réglage état du système avec des cibles
(niveau d’exécution) 
```
systemctl list-unit-files --type=target
systemctl list-units --type=target
systemctl get-default
sudo systemctl set-default multi-user.target 

# Isolation des cibles
systemctl list-dependencies multi-user.target
sudo systemctl isolate multi-user.target

# Utilisation de raccourcis pour les événements importants
"Mettre le système en mode sauvetage (utilisateur unique)"
sudo systemctl rescue
sudo systemctl halt
sudo systemctl poweroff
sudo systemctl reboot
```

### timedatectl
```sh 
timedatectl list-timezones

sudo timedatectl set-timezone zone

timedatectl status
```

### journalctl

```
journalctl
```

```
Output-- Logs begin at Tue 2015-02-03 21:48:52 UTC, end at Tue 2015-02-03 22:29:38 UTC. --
Feb 03 21:48:52 localhost.localdomain systemd-journal[243]: Runtime journal is using 6.2M (max allowed 49.
Feb 03 21:48:52 localhost.localdomain systemd-journal[243]: Runtime journal is using 6.2M (max allowed 49.
Feb 03 21:48:52 localhost.localdomain systemd-journald[139]: Received SIGTERM from PID 1 (systemd).
Feb 03 21:48:52 localhost.localdomain kernel: audit: type=1404 audit(1423000132.274:2): enforcing=1 old_en
Feb 03 21:48:52 localhost.localdomain kernel: SELinux: 2048 avtab hash slots, 104131 rules.
Feb 03 21:48:52 localhost.localdomain kernel: SELinux: 2048 avtab hash slots, 104131 rules.
Feb 03 21:48:52 localhost.localdomain kernel: input: ImExPS/2 Generic Explorer Mouse as /devices/platform/
Feb 03 21:48:52 localhost.localdomain kernel: SELinux:  8 users, 102 roles, 4976 types, 294 bools, 1 sens,
Feb 03 21:48:52 localhost.localdomain kernel: SELinux:  83 classes, 104131 rules

. . .
```

```
journalctl --utc
```



####  Journal Filtering by Time
##### Displaying Logs from the Current Boot
```
journalctl -b
```

##### Past Boots
```
sudo mkdir -p /var/log/journal
```

Or you can edit the journal configuration file:

```
sudo nano /etc/systemd/journald.conf
```

```
journalctl --list-boots
```

```
Output-2 caf0524a1d394ce0bdbcff75b94444fe Tue 2015-02-03 21:48:52 UTC—Tue 2015-02-03 22:17:00 UTC
-1 13883d180dc0420db0abcb5fa26d6198 Tue 2015-02-03 22:17:03 UTC—Tue 2015-02-03 22:19:08 UTC
 0 bed718b17a73415fade0e4e7f4bea609 Tue 2015-02-03 22:19:12 UTC—Tue 2015-02-03 23:01:01 UTC
```

For instance, to see the journal from the previous boot, use the `-1` relative pointer with the `-b` flag:
```
journalctl -b -1
```

You can also use the boot ID to call back the data from a boot:
```
journalctl -b caf0524a1d394ce0bdbcff75b94444fe
```

##### Time Windows

```
YYYY-MM-DD HH:MM:SS
```

```
journalctl --since "2015-01-10 17:15:00"
```

```
journalctl --since "2015-01-10" --until "2015-01-11 03:00"
```

```
journalctl --since yesterday
```

```
journalctl --since 09:00 --until "1 hour ago"
```

##### By Unit
```
journalctl -u nginx.service
```

```
journalctl -u nginx.service --since today
```

```
journalctl -u nginx.service -u php-fpm.service --since today
```

### By Process, User, or Group ID
```
journalctl _PID=8088
```

```
id -u www-data
```

```
Output33
```

```
journalctl _UID=33 --since today
```

```
man systemd.journal-fields
```

The `-F` option can be used to show all of the available values for a given journal field.
```
journalctl -F _GID
```

```
Output32
99
102
133
81
84
100
0
124
87
```

##### By Component Path

```
journalctl /usr/bin/bash
```
##### Displaying Kernel Messages
```
journalctl -k
```

```
journalctl -k -b -5
```

##### By Priority
```
journalctl -p err -b
```

- **0**: emerg
- **1**: alert
- **2**: crit
- **3**: err
- **4**: warning
- **5**: notice
- **6**: info
- **7**: debug
##### Modifying the Journal Display
###### Truncate or Expand Output

```
journalctl --no-full
```

```
Output. . .

Feb 04 20:54:13 journalme sshd[937]: Failed password for root from 83.234.207.60...h2
Feb 04 20:54:13 journalme sshd[937]: Connection closed by 83.234.207.60 [preauth]
Feb 04 20:54:13 journalme sshd[937]: PAM 2 more authentication failures; logname...ot
```

You can also go in the opposite direction with this and tell `journalctl` to display all of its information, regardless of whether it includes unprintable characters. We can do this with the `-a` flag:
```
journalctl -a
```

###### Output to Standard Out
By default, `journalctl` displays output in a pager for easier consumption. If you are planning on processing the data with text manipulation tools, however, you probably want to be able to output to standard output.

You can do this with the `--no-pager` option:

```
journalctl --no-pager
```

##### Output Formats
If you are processing journal entries, as mentioned above, you most likely will have an easier time parsing the data if it is in a more consumable format. Luckily, the journal can be displayed in a variety of formats as needed. You can do this using the `-o` option with a format specifier.

For instance, you can output the journal entries in JSON by typing:
```
journalctl -b -u nginx -o json
```

```
Output{ "__CURSOR" : "s=13a21661cf4948289c63075db6c25c00;i=116f1;b=81b58db8fd9046ab9f847ddb82a2fa2d;m=19f0daa;t=50e33c33587ae;x=e307daadb4858635", "__REALTIME_TIMESTAMP" : "1422990364739502", "__MONOTONIC_TIMESTAMP" : "27200938", "_BOOT_ID" : "81b58db8fd9046ab9f847ddb82a2fa2d", "PRIORITY" : "6", "_UID" : "0", "_GID" : "0", "_CAP_EFFECTIVE" : "3fffffffff", "_MACHINE_ID" : "752737531a9d1a9c1e3cb52a4ab967ee", "_HOSTNAME" : "desktop", "SYSLOG_FACILITY" : "3", "CODE_FILE" : "src/core/unit.c", "CODE_LINE" : "1402", "CODE_FUNCTION" : "unit_status_log_starting_stopping_reloading", "SYSLOG_IDENTIFIER" : "systemd", "MESSAGE_ID" : "7d4958e842da4a758f6c1cdc7b36dcc5", "_TRANSPORT" : "journal", "_PID" : "1", "_COMM" : "systemd", "_EXE" : "/usr/lib/systemd/systemd", "_CMDLINE" : "/usr/lib/systemd/systemd", "_SYSTEMD_CGROUP" : "/", "UNIT" : "nginx.service", "MESSAGE" : "Starting A high performance web server and a reverse proxy server...", "_SOURCE_REALTIME_TIMESTAMP" : "1422990364737973" }

. . .
```

This is useful for parsing with utilities. You could use the `json-pretty` format to get a better handle on the data structure before passing it off to the JSON consumer:
```
journalctl -b -u nginx -o json-pretty
```

```
Output{
	"__CURSOR" : "s=13a21661cf4948289c63075db6c25c00;i=116f1;b=81b58db8fd9046ab9f847ddb82a2fa2d;m=19f0daa;t=50e33c33587ae;x=e307daadb4858635",
	"__REALTIME_TIMESTAMP" : "1422990364739502",
	"__MONOTONIC_TIMESTAMP" : "27200938",
	"_BOOT_ID" : "81b58db8fd9046ab9f847ddb82a2fa2d",
	"PRIORITY" : "6",
	"_UID" : "0",
	"_GID" : "0",
	"_CAP_EFFECTIVE" : "3fffffffff",
	"_MACHINE_ID" : "752737531a9d1a9c1e3cb52a4ab967ee",
	"_HOSTNAME" : "desktop",
	"SYSLOG_FACILITY" : "3",
	"CODE_FILE" : "src/core/unit.c",
	"CODE_LINE" : "1402",
	"CODE_FUNCTION" : "unit_status_log_starting_stopping_reloading",
	"SYSLOG_IDENTIFIER" : "systemd",
	"MESSAGE_ID" : "7d4958e842da4a758f6c1cdc7b36dcc5",
	"_TRANSPORT" : "journal",
	"_PID" : "1",
	"_COMM" : "systemd",
	"_EXE" : "/usr/lib/systemd/systemd",
	"_CMDLINE" : "/usr/lib/systemd/systemd",
	"_SYSTEMD_CGROUP" : "/",
	"UNIT" : "nginx.service",
	"MESSAGE" : "Starting A high performance web server and a reverse proxy server...",
	"_SOURCE_REALTIME_TIMESTAMP" : "1422990364737973"
}

. . .
```

The following formats can be used for display:
- **cat**: Displays only the message field itself.
- **export**: A binary format suitable for transferring or backing up.
- **json**: Standard JSON with one entry per line.
- **json-pretty**: JSON formatted for better human-readability
- **json-sse**: JSON formatted output wrapped to make add server-sent event compatible
- **short**: The default `syslog` style output
- **short-iso**: The default format augmented to show ISO 8601 wallclock timestamps.
- **short-monotonic**: The default format with monotonic timestamps.
- **short-precise**: The default format with microsecond precision
- **verbose**: Shows every journal field available for the entry, including those usually hidden internally.
""
##### Active Process Monitoring
The `journalctl` command imitates how many administrators use `tail` for monitoring active or recent activity. This functionality is built into `journalctl`, allowing you to access these features without having to pipe to another tool.

##### Displaying Recent Logs
To display a set amount of records, you can use the `-n` option, which works exactly as `tail -n`.

By default, it will display the most recent 10 entries:
```
journalctl -n
```

You can specify the number of entries you’d like to see with a number after the `-n`:
```
journalctl -n 20
```

##### Following Logs
To actively follow the logs as they are being written, you can use the `-f` flag. Again, this works as you might expect if you have experience using `tail -f`:
```
journalctl -f
```

##### Journal Maintenance
You may be wondering about the cost is of storing all of the data we’ve seen so far. Furthermore, you may be interesting in cleaning up some older logs and freeing up space.

###### Finding Current Disk Usage
You can find out the amount of space that the journal is currently occupying on disk by using the `--disk-usage` flag:
```
journalctl --disk-usage
```
###### Deleting Old Logs
If you wish to shrink your journal, you can do that in two different ways (available with `systemd` version 218 and later).

If you use the `--vacuum-size` option, you can shrink your journal by indicating a size. This will remove old entries until the total journal space taken up on disk is at the requested size:
```
sudo journalctl --vacuum-size=1G
```

Another way that you can shrink the journal is providing a cutoff time with the `--vacuum-time` option. Any entries beyond that time are deleted. This allows you to keep the entries that have been created after a specific time.

For instance, to keep entries from the last year, you can type:
```
sudo journalctl --vacuum-time=1years
```

###### Limiting Journal Expansion
You can configure your server to place limits on how much space the journal can take up. This can be done by editing the `/etc/systemd/journald.conf` file.

The following items can be used to limit the journal growth:

- `SystemMaxUse=`: Specifies the maximum disk space that can be used by the journal in persistent storage.
- `SystemKeepFree=`: Specifies the amount of space that the journal should leave free when adding journal entries to persistent storage.
- `SystemMaxFileSize=`: Controls how large individual journal files can grow to in persistent storage before being rotated.
- `RuntimeMaxUse=`: Specifies the maximum disk space that can be used in volatile storage (within the `/run` filesystem).
- `RuntimeKeepFree=`: Specifies the amount of space to be set aside for other uses when writing data to volatile storage (within the `/run` filesystem).
- `RuntimeMaxFileSize=`: Specifies the amount of space that an individual journal file can take up in volatile storage (within the `/run` filesystem) before being rotated.

By setting these values, you can control how `journald` consumes and preserves space on your server. Keep in mind that `SystemMaxFileSize` and `RuntimeMaxFileSize` will target archived files to reach stated limits. This is important to remember when interpreting file counts after a vacuuming operation.

## Recherche fichier
```sh

# FIND - Recherche de fichiers
find / -name 'messages'
# -atime n ou +n ou -n = fichiers auxquels on a accédé il y a strictement n jours, ou plus de n jours, ou moins de n jours
# -mtime n ou +n ou -n = fichiers modifiés il y a strictement n jours, ou plus de n jours, ou moins de n jours
# -maxdepth n = niveau maximum de sous-répertoire à explorer
# -type l ou d ou f = type de fichier à rechercher (l pour lien symbolique, d pour répertoire (directory), f pour fichier)
# -name = recherche par motif en respectant la casse
# -iname = recherche par motif sans respecter la casse


# GREP - Recherche récursive (-r) mot dans un dossier
grep -r "mot à rechercher" /chemin/vers/le/dossier
# Grep options utiles
# -i = insensible à la casse
# -l = afficher seulement les noms de fichier
# -n = afficher n° de ligne  

```