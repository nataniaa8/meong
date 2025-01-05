#!/bin/bash

#               .-') _   .-') _       ('-.          .-') _               ('-.     
#              ( OO ) ) (  OO) )     ( OO ).-.     ( OO ) )             ( OO ).-. 
#  ,-.-')  ,--./ ,--,'  /     '._    / . --. / ,--./ ,--,'    ,-.-')    / . --. / 
#  |  |OO) |   \ |  |\  |'--...__)   | \-.  \  |   \ |  |\    |  |OO)   | \-.  \  
#  |  |  \ |    \|  | ) '--.  .--' .-'-'  |  | |    \|  | )   |  |  \ .-'-'  |  | 
#  |  |(_/ |  .     |/     |  |     \| |_.'  | |  .     |/    |  |(_/  \| |_.'  | 
# ,|  |_.' |  |\    |      |  |      |  .-.  | |  |\    |    ,|  |_.'   |  .-.  | 
#(_|  |    |  | \   |      |  |      |  | |  | |  | \   |   (_|  |      |  | |  | 
#  `--'    `--'  `--'      `--'      `--' `--' `--'  `--'     `--'      `-' `--'

# Otomasi by Intania ⋆.˚🦋༘⋆

echo "Configuring VLAN and DHCP on Ubuntu Server with Kartolo Datautama repository..."

# Menambahkan repository Kartolo Datautama
echo "Adding Kartolo Datautama repository..."
echo "deb [trusted=yes] http://kartolo.sby.datautama.net.id/ubuntu focal main universe restricted multiverse" | tee /etc/apt/sources.list.d/kartolo-datautama.list

# Update package index
apt update

# Assign IP address to VLAN interface
ip link add link eth1 name eth1.10 type vlan id 10
ip addr add 192.168.16.1/24 dev eth1.10
ip link set up eth1.10

# Install and configure DHCP server
apt install -y isc-dhcp-server

# Configure DHCP for VLAN 10
cat <<EOL > /etc/dhcp/dhcpd.conf
# Watermark: niaaa
subnet 192.168.16.0 netmask 255.255.255.0 {
  range 192.168.16.10 192.168.16.100;
  option routers 192.168.16.1;
  option domain-name-servers 8.8.8.8, 8.8.4.4;
}
EOL

# Set the DHCP server to listen on eth1.10
echo "INTERFACESv4=\"eth1.10\"" > /etc/default/isc-dhcp-server

# Restart DHCP service
systemctl restart isc-dhcp-server
systemctl enable isc-dhcp-server

echo "Ubuntu Server configuration completed!"
