# Install snmpv3 on fedora using docker/podman containers! 
Docker image to provide snmpdv3 in situations where it's difficult (like fedoraOS) 

Automated AES en SHA512 keygen. 

Make your own read-only user.

Describe location + admin contact information

Easy to deploy and secure

# How-to deploy
Make sure u change the env variables to the desired information!
```
  docker run -d -v /
  proc:/host_proc \
  --privileged \
  --read-only \
  -p 161:161/udp \
  --name snmpd \	
  -e LOCATION=location -e NAME=name -e MAIL=mail -e USER=rouser \	
  bushidosan/snmpd
```

# Important notes
Containers don't have access to /proc - so you must provide it per the example above. snmpd has been modified to use /host_proc for your convenience.
