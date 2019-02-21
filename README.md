# SAMBA SERVER WITH LDAP

## Eric Escriba CURS 2018/2019 M06

Les imatges es troben disponibles a [eescriba](https://hub.docker.com/u/eescriba/)


### EXPLICACIÓ

Pràctica d'integració de les tecnologies PAM, LDAP i SAMBA. En aquesta part hem creat un servidor SAMBA capaç de connectar a un servidor LDAP i exportar directoris HOME d'usuaris locals i LDAP.
Per a això necessitem un servidor LDAP (el mateix usat en pràctiques anteriors), un servidor SAMBA i un client amb LDAP i PAM configurats

Aquests 3 dockers estan communicats entre si a traves de la xarxa **sambanet**.

**NOTA**

Aquesta activitat ha estat realitzat sobre la xarxa sambanet, aixo no impedeix que l'arquitectura no pugi funcionar sobre una altra xarxa personlitzada de l'usuari.

**QUICK TUTORIAL**

Generem 3 imatges a traves dels Dockerfiles correctament configurats un per cada tasca: ldap,client i samba.

Configurem la connexió al servidor LDAP (ldap.conf,slapd.conf) i afegim dades (populate)

Preparem el docker client per poder establir connexió amb LDAP mitjançant els fitxers `nslcd.conf`,`nsswitch.conf` i `ldap.conf`

Configurem perque aquest pugi montar homes mitjançant els fitxers `system-auth` i `pam_mount.conf.xml`

Creem la configuració de SAMBA `/etc/samba/smb.conf`

Creem els usuaris SAMBA, els directoris que es van a compartir i els assignem els permisos adequats.

Finalment arranquem els dimonis...

Per al Client:

**/usr/sbin/nslcd**

**/usr/sbin/nscd**

Per a Samba:

**/usr/sbin/smbd**

**/usr/sbin/nmbd**

Per a LDAP

**/sbin/slapd** 



### IMATGES


**eescriba/ldapserver:18samba**   Servidor LDAP que te emmagatzemats els usuaris 

**eescriba/sambahost:18homes**   Maquina client per treballar

**eescriba/samba:18homes**  Servidor Samba que comparteix els homes dels usuaris LDAP i locals.


### EXECUCIÓ

```

**LDAP**
docker run --rm --name ldap -h ldap --network sambanet -d eescriba/ldapserver:18samba

**HOST**
docker run --rm --privileged --name host -h host --network sambanet -it eescriba/sambahost:18homes

**SAMBA**
docker run --rm --name samba -h samba --network sambanet -it eescriba/samba:18homes


```

### COMPROVACIÓ

**EXEMPLES:**

- ENTRAR AL HOST COM UN USUARI LDAP

```

[root@host docker]# su - pau
Creating directory '/tmp/home/pau'.
reenter password for pam_mount:
[pau@host ~]$ df -h
Filesystem      Size  Used Avail Use% Mounted on
overlay         370G   52G  300G  15% /
tmpfs            64M     0   64M   0% /dev
tmpfs           3.9G     0  3.9G   0% /sys/fs/cgroup
/dev/sda5       370G   52G  300G  15% /etc/hosts
shm              64M     0   64M   0% /dev/shm
//samba/pau     370G   71G  300G  19% /tmp/home/pau/pau
[pau@host ~]$ mount -t cifs
//samba/pau on /tmp/home/pau/pau type cifs (rw,relatime,vers=default,cache=strict,username=pau,uid=5000,forceuid,gid=100,forcegid,addr=172.20.0.4,file_mode=0755,dir_mode=0755,soft,nounix,serverino,mapposix,rsize=1048576,wsize=1048576,echo_interval=60,actimeo=1)


```

- ENTRAR AL HOST COM UN USUARI LOCAL

```
[local01@host ~]$ mount -t cifs
//samba/local01 on /home/local01/local01 type cifs (rw,relatime,vers=default,cache=strict,username=local01,uid=1000,forceuid,gid=100,forcegid,addr=172.20.0.4,file_mode=0755,dir_mode=0755,soft,nounix,serverino,mapposix,rsize=1048576,wsize=1048576,echo_interval=60,actimeo=1)


```

- MONTAR EL HOME DE UN USUARI A /mnt

**NOTA**

Montem el recurs a traves del servidor anomenat **samba** pero això no es pot fer si no tens un DNS que apunti a la direcció en que esta el servidor samba. 
És a dir afegim la següent linia al fitxer `/etc/hosts`:

```
#IP_SAMBA_SERVER    samba

```


```
root@xarlio:~/samba_homes# mount -t cifs -o "user=marta" //samba/marta /tmp
Password for marta@//samba/marta:  # La passwd es smbmarta 

root@xarlio:~/samba_homes# mount -t cifs
//samba/marta on /tmp type cifs (rw,relatime,vers=default,cache=strict,username=marta,uid=0,noforceuid,gid=0,noforcegid,addr=172.20.0.4,file_mode=0755,dir_mode=0755,soft,nounix,serverino,mapposix,rsize=1048576,wsize=1048576,echo_interval=60,actimeo=1,user=marta)


```
