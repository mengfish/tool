#!/bin/bash
#sed -i '$ a\\ export https_proxy=https://proxy-prc.intel.com:911\n export http_proxy=http://proxy-prc.intel.com:911' ~/.bashrc

export https_proxy=https://proxy-prc.intel.com:911
export http_proxy=http://proxy-prc.intel.com:911

yum install -y gcc make git expect

yum install -y samba samba-client samba-common
		echo "$?"
		sed -i '$ a\\[media]\ncomment = media\npath = /home/\nbrowseable = yes\nwritable = yes\nvalid users = media' /etc/samba/smb.conf
	expect -c"
		set timeout 3;
		spawn	smbpasswd -a media;
		expect	*assword:*;
		send	intel123\r;
		expect *assword:*;
		send	intel123\r;
		interact;";
	
		
		systemctl enable smb.service
		systemctl enable nmb.service
		systemctl restart smb.service
		systemctl restart nmb.service
		firewall-cmd --permanent --zone=public --add-service=samba
		firewall-cmd --reload
		sed -i "s/SELINUX=enforcing/SELINUX=disabled/" /etc/sysconfig/selinux	
		sed -i "s/SELINUX=enforcing/SELINUX=disabled/" /etc/selinux/config
		setenforce 0

