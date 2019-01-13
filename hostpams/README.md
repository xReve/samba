# pam

## @edt ASIX M06 2018-2019


Podeu trobar les imatges docker al Dockehub de [edtasixm06](https://hub.docker.com/u/edtasixm06/)

ASIX M06-ASO Escola del treball de barcelona

### Imatges:

* **pamhost:18base** host pam que autentica els usuaris contra ldap. Usar el container *ldapserver:18group*.

* **pamhost:18auth** host pam amb authenticació ldap. utilitza l'ordre authconfig per configurar l'autenticació.

 * **hostpam:18mount** host pam amb authenticació ldap. utilitza l'ordre authconfig per
configurar l'autenticació i a més a més crea els home dels usuaris i munta un tmpfs als usuaris.
Atenció, per poder realitzar el mount cal que el container es generi amb l'opció **--privileged**.


#### Execució

```
docker run --rm --name host -h host --net ldapnet -it edtasixm06/hostpam:18base 
```

#### Utilització

```
getnet passwd local01
getent passwd pau
getent passwd

getent group localgrp01
getent group 2asix
getent group
```

