# fedora-snmpdv3
Docker image to provide snmpd in situations where it's difficult (like CoreOS)

# How-to deploy
Launch listening on "public" like this:

docker run -d -v /proc:/host_proc \
  --privileged \
  --read-only \
  -p 161:161/udp \
  --name snmpd \
  -e LOCATION= location -e NAME=name MAIL=mail
  bushidosan/snmpd
  
# Important notes
Containers don't have access to /proc - so you must provide it per the examples above. snmpd has been modified to use /host_proc for your convenience.