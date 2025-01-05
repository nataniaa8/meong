# Cisco Configuration!

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

enable
configure terminal

# Create VLAN 10
vlan 10
name VLAN_10

# Assign VLAN to port
interface ethernet 0/1
switchport mode access
switchport access vlan 10

# Assign IP address to VLAN interface
interface vlan 10
ip address 192.168.16.2 255.255.255.0
no shutdown

# Save configuration
end
write memory
