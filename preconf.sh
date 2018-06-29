#!/bin/bash

HOSTNAME=ambev-google-budweiser-lp-beat-russia-app

ENV_PUPPET=ambev

hostname ${HOSTNAME}

hostname -b ${HOSTNAME}

hostnamectl set-hostname ${HOSTNAME}

sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config

setenforce 0

echo -e "n\np\n1\n\n\nw" | fdisk /dev/xvdb

sleep 3

mkfs.ext4 -N 10000000 /dev/xvdb1

echo -e "n\np\n1\n\n\nw" | fdisk /dev/xvdc

sleep 3

mkfs.ext4 -N 10000000 /dev/xvdc1

mkdir -p /data/backup

echo "$(blkid | grep xvdb1 | sed 's/"//g' | awk '{print $2}') /data                   ext4    defaults        0 0" >> /etc/fstab

mount -a

mkdir /data/backup

echo "$(blkid | grep xvdc1 | sed 's/"//g' | awk '{print $2}') /data/backup            ext4    defaults        0 0" >> /etc/fstab

mount -a

rpm -Uvh http://yum.puppetlabs.com/puppet5/puppet5-release-el-7.noarch.rpm

yum install puppet-agent -y

echo -e "[main]\nenvironment = ${ENV_PUPPET}\nserver = puppet.adtsys.com.br" >> /etc/puppetlabs/puppet/puppet.conf

/opt/puppetlabs/bin/puppet agent -t --noop

#Ir no Puppet server e executar "puppet cert sign NOME-DA-MAQUINA"


