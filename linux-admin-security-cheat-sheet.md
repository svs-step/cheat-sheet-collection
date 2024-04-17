

Références:
- Security checklist for servers
( https://medium.com/@narendirand11/security-checklist-for-linux-server-f2baa1319223 )
- Ignite IR cheat sheet


1. Remove unnecessary services
Hardening systems by eliminating unnecessary services can enhance security
and improve overall system performance. To begin, you first need to know
which services are running on your system. Since services run in various ways, there are several places to check.


$ ps –ax   (will list all currently running processes)
$ ls –l /etc/rc.d/rc3.d/S*  (will show all start-up scripts (if you boot into graphics mode, replace rc3.d with rc5.d))
$ netstat –a   (will list all open ports)
$ chkconfig –list   (will show the current startup status of all processes known by chkconfig)
Ideally, you should see only those ports that must be open to provide the
functionality required by the system.

2. Check for security on key files
/etc/fstab: make sure the owner & group are set to root.root and the
permissions are set to 0644 (-rw-r — r — )
verify that /etc/passwd, /etc/shadow & /etc/group are all owned by ‘root’
verify that permissions on /etc/passwd & /etc/group are rw-r — r — (644)
verify that permissions on /etc/shadow are r — — — — (400)
3. Set strong password policy
Ensure the default system password policy matches your organization
password policy. These settings are stored in /etc/login.defs and should
minimally contain settings for the following.
PASS_MAX_DAYS 90
PASS_MIN_DAYS 6
PASS_MIN_LEN 14
PASS_WARN_AGE 7

4. Limit root access using SUDO
Sudo allows an administrator to provide certain users the ability to run some
commands as root, while logging all sudo activity. Sudo operates on a percommand basis. The sudoers file controls command access.

5. Only allow root to access CRON
The cron daemon is used to schedule processes. The crontab command is
used to create personal crontab entries for users or the root account. To
enhance security of the cron scheduler, you can establish the cron.deny and
cron.allow files to control use of the crontab. The following commands will
establish root as the only user with permission to add cron jobs.

$ cd /etc/
$ /bin/rm -f cron.deny at.deny
$ echo root >cron.allow
$ echo root >at.allow
$ /bin/chown root:root cron.allow at.allow
$ /bin/chmod 400 cron.allow at.allow
6. Remote access and SSH basic settings
Telnet is not recommended for remote access. Secure Shell (SSH) provides
encrypted telnet-like access and is considered a secure alternative to telnet.
However, older versions of SSH have vulnerabilities and should not be used.
To disable SSH version 1 and enhance the overall security of SSH, consider
making the following changes to your sshd_config file:

Protocol 2
PermitRootLogin no
PermitEmptyPasswords no
Banner /etc/issue
IgnoreRhosts yes
RhostsAuthentication no
RhostsRSAAuthentication no
HostbasedAuthentication no
LoginGraceTime 1m (or less — default is 2 minutes)
SyslogFacility AUTH (provides logging under syslog AUTH)
AllowUser [list of users allowed access]
DenyUser [list of system accounts and others not allowed]
MaxStartups 10 (or less — use 1/3 the total number of remote users)
Note: MaxStartups refers to the max number of simultaneous unauthenticated connections. This setting can be helpful against a bruteforce
script that performs forking.

Running ssh on an alternate port will help you avoid port scanners that are looking for open port. You can block such brute-force ssh attacks with a package like denyhosts, which utilizes tcpwrappers.

Alternatively, use your iptables firewall (see below) to limit access by IP
address or host/domain name.

7. Disable Xwindow
X window can be a large security risk considering the many exploits for the
product and since its data flows unencrypted across networks. There is no need to run X Window desktops like KDE or GNOME on your dedicated LAMP server. To disable X11, open the file ‘/etc/inittab‘ and set run level to 3. If you wish to remove it completely from the system use the below command.

$ yum groupremove “X Window System”
8. Selinux
The Security-enhanced Linux kernel enforces mandatory access control
policies that confine user programs and system servers to the minimum amount of privilege they require to do their jobs. . This confinement mechanism operates independently of the traditional Linux access control mechanisms. Implementing SE Linux can have unexpected effects on a system, and you may find standard daemons won’t run properly, or at all, or logfiles may not be writable, or other similar effects that require detailed configuration of SE Linux Currently.

9. Minimize package installation
It’s recommended to avoid installing useless packages to avoid vulnerabilities in packages. This may minimize risk that compromise of one service may lead to compromise of other services. Find and remove or disable unwanted services from the server to minimize vulnerability.

10. Checking accounts for empty passwords
Any account having an empty password means its opened for unauthorized access to anyone on the web and it’s a part of security within a Linux server. So, you must make sure all accounts have strong passwords and no one has any authorized access. Empty password accounts are security risks and that can be easily hackable. To check if there were any accounts with empty password, use the following command.

$ cat /etc/shadow | awk -F: ‘($2==””){print $1}’
11. Monitor user activities
Its important to collect the information of each user activities and processes consumed by them and analyse them at a later time or in case if any kind of performance, security issues. But how we can monitor and collect user activities information.

There are two useful tools called ‘psacct‘ and ‘acct‘ are used for monitoring user activities and processes on a system. These tools runs in a system background and continuously tracks each user activity on a system and resources consumed by services such as Apache, MySQL, SSH, FTP, etc.

12. Install and configure fail2ban
Any service that is exposed to the network is a potential target in this way. Most Linux servers offer an SSH login via Port 22 for remote administration purposes. This port is a well-known port, therefore, it is often attacked by brute force attacks. If you pay attention to application logs for these services, you will often see repeated, systematic login attempts that represent brute-force attacks by users and bots alike. Fail2ban can mitigate this problem by creating rules that automatically alter your iptables firewall configuration based on a predefined number of unsuccessful login attempts.

13. Rootkit detection
There are many ways that your server can be compromised by remote systems and malicious softwares. It’s important that once you discovered the attack, you try to find out how. Knowing how the attacker got in can help you reduce the risk of future compromises. Few such Malwares and vulnerabilities are Rootkit, Backdoor and Exploit. Following blog will guide you on the configuration of Rootkit hunter.

https://medium.com/logistimo-engineering-blog/a-way-to-detect-the-rootkits-and-exploits-in-centos-rhel-5b125a8d6a25

14. Monitor system logs
Logwatch is an application that helps with simple log management by daily analysing and reporting a short digest from activities taking place on your machine. This tool analyzes and generates daily reports on your system’s log activity.

15. Enable 2-factor authentication
Enabling 2-factor authentication for all the servers is not advisable. It can be configured on the jump host ( login box ) of the infrastructure. It acts as an additional security layer for your business, helping to address the vulnerabilities of a standard password-only approach

--- 

