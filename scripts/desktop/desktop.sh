#!/bin/bash
rpm --import http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7
rpm -ivh http://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-11.noarch.rpm
yum -y install net-tools bind-utils vim wget policycoreutils-python krb5-workstation acl --nogpg
echo "vagrant:vagrant" | chpasswd
echo "root:centos" | chpasswd
hostnamectl set-hostname desktop1
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
systemctl restart sshd
sed -i "s/NM_CONTROLLED=no/NM_CONTROLLED=yes/g" /etc/sysconfig/network-scripts/ifcfg-eth1
systemctl restart network
cat > /etc/resolv.conf << EOF
nameserver 192.168.33.254
domain example.com
EOF
sed -i 's/TLS_CACERTDIR.*/TLS_CACERTDIR \/etc\/pki\/nssdb/g' /etc/openldap/ldap.conf
echo "PEERDNS=no" >> /etc/sysconfig/network-scripts/ifcfg-eth0
wget http://192.168.122.254/pki/example_ca.crt
certutil -d /etc/pki/nssdb -A -n "rootca" -t CT -a -i example_ca.crt
sed -i.old s/^#//g /etc/krb5.conf
sed -i s/kerberos/classroom/g /etc/krb5.conf
systemctl enable firewalld
systemctl restart firewalld
