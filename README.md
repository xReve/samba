# SERVIDOR SSHD
## @edt ASIX M06-ASO Curs 2018-2019

CREACIO SERVIDOR LDAP + SSHD AMB DOCKER

**2 dockers que estan connectats entre si en la red LDAPNET**
El servidor LDAP s'anomena **ldap**
El servidor SSHD s'anomena **sshd**

###SERVER

x_definir


###CLIENT

x_definir


###EXECUCIO

docker run --rm -it --privileged --name sshd -h sshd --network ldapnet -p 1022:22 serversshd:base



docker run --name ldap -h ldap --network ldapnet -p 389:389 -d servidorldap:base 


