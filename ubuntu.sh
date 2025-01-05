#!/bin/bash

#               .-') _   .-') _       ('-.          .-') _               ('-.     
#             ( OO ) ) (  OO) )     ( OO ).-.     ( OO ) )             ( OO ).-. 
#  ,-.-')  ,--./ ,--,'  /     '._    / . --. / ,--./ ,--,'    ,-.-')    / . --. / 
#  |  |OO) |   \ |  |\  |'--...__)   | \-.  \  |   \ |  |\    |  |OO)   | \-.  \  
#  |  |  \ |    \|  | ) '--.  .--' .-'-'  |  | |    \|  | )   |  |  \ .-'-'  |  | 
#  |  |(_/ |  .     |/     |  |     \| |_.'  | |  .     |/    |  |(_/  \| |_.'  | 
# ,|  |_.' |  |\    |      |  |      |  .-.  | |  |\    |    ,|  |_.'   |  .-.  | 
#(_|  |    |  | \   |      |  |      |  | |  | |  | \   |   (_|  |      |  | |  | 
#  `--'    `--'  `--'      `--'      `--' `--' `--'  `--'     `--'      `-' `--'

echo "=============================================="
echo "   🦋 Welcome to Natania's Automation 🦋   "
echo "=============================================="

echo "Configuring Ubuntu Server"

# Manambahkan Repository
cat <<EOF > /etc/apt/sources.list
deb http://kartolo.sby.datautama.net.id/ubuntu/ focal main restricted universe multiverse
deb http://kartolo.sby.datautama.net.id/ubuntu/ focal-updates main restricted universe multiverse
deb http://kartolo.sby.datautama.net.id/ubuntu/ focal-security main restricted universe multiverse
deb http://kartolo.sby.datautama.net.id/ubuntu/ focal-backports main restricted universe multiverse
deb http://kartolo.sby.datautama.net.id/ubuntu/ focal-proposed main restricted universe multiverse

# Pasang DHCP server
apt update && apt install -y isc-dhcp-server

# Konfigurasi VLAN dan IP
cat <<EOF > /etc/netplan/01-netcfg.yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:
      dhcp4: true
    eth1:
      addresses: []
  vlans:
    eth1.10:
      id: 10
      link: eth1
      addresses:
        - 192.168.16.1/24
EOF

netplan apply

# Konfigurasi DHCP server
cat <<EOF > /etc/dhcp/dhcpd.conf
subnet 192.168.16.0 netmask 255.255.255.0 {
  range 192.168.16.10 192.168.16.100;
  option routers 192.168.16.1;
  option domain-name-servers 8.8.8.8, 8.8.4.4;
}
EOF

systemctl restart isc-dhcp-server
echo "[Natania] VLAN and network configuration applied."
echo "🎉 Otomasi selesai oleh Intania bersama meong!"
