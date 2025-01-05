# Mikrotik Configuration!

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

# Configure MikroTik Router
/interface vlan
add interface=ether1 name=vlan10 vlan-id=10

/ip address
# Assign IP for VLAN 10 interface
add address=192.168.16.3/24 interface=vlan10
# Assign IP for ether2
add address=192.168.200.1/24 interface=ether2

/ip dhcp-client
# Enable DHCP client on VLAN 10
add interface=vlan10

/ip dhcp-server
# Configure DHCP server for ether2
add name=dhcp2 interface=ether2 address-pool=dhcp_pool

/ip pool
# Create IP pool for ether2
add name=dhcp_pool ranges=192.168.200.2-192.168.200.254

/ip dhcp-server network
# Set DHCP network for ether2
add address=192.168.200.0/24 gateway=192.168.200.1 dns-server=8.8.8.8

# Save configuration
/system script add name="save" source="system script run save"
