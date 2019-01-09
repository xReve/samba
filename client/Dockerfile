# Version: 0.0.1
# @edt M06 2018-2019
# hostpam
# -------------------------------------
FROM docker.io/edtasixm06/exam:latest 
LABEL author="@edt ASIX M06-ASO"
LABEL description="host PAM 2018-2019"
<<<<<<< HEAD
RUN dnf -y install procps passwd openldap-clients nss-pam-ldapd authconfig pam_mount cifs-utils
=======
RUN dnf -y install procps passwd openldap-clients nss-pam-ldapd authconfig pam_mount openssh-server 
RUN ssh-keygen -A
>>>>>>> 0331c929ce4ad56dc7ab2d7d93756a3d0c365340
RUN mkdir /opt/docker
COPY * /opt/docker/
RUN chmod +x /opt/docker/install.sh /opt/docker/startup.sh
WORKDIR /opt/docker
CMD ["/opt/docker/startup.sh"]
