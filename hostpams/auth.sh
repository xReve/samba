#! /bin/bash
# @edt ASIX-M06
# -----------------
authconfig  --enableshadow --enablelocauthorize --enableldap  --ldapserver='ldapserver' --ldapbase='dc=edt,dc=org' --enableldapauth  --updateall



