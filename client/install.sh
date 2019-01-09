#! /bin/bash
# @edt ASIX M06 2018-2019
# instal.lacio
#  - crear usuaris locals
# -------------------------------------
groupadd groupexam
useradd -g users -G groupexam exam01
useradd -g users -G groupexam exam02
useradd -g users -G groupexam exam03
echo "exam01" | passwd --stdin exam01
echo "exam02" | passwd --stdin exam02
echo "exam03" | passwd --stdin exam03

bash /opt/docker/auth.sh
cp /opt/docker/pam_mount.conf.xml /etc/security/pam_mount.conf.xml
cp /opt/docker/system-auth-eric   /etc/pam.d/system-auth-eric
cp /etc/pam.d/system-auth-eric	 /etc/pam.d/system-auth
cp /opt/docker/sshd_config 	/etc/ssh/sshd_config

