# Install snmpv3 on fedora using docker/podman containers! 
Docker image to provide snmpdv3 in situations where it's difficult (like fedoraOS) 

Automated AES en SHA512 keygen. 

Make your own read-only user.

Describe location + admin contact information

Easy to deploy and secure

Make sure u read the files to get a fully understanding about what u are deploying!

Stuck on some part ? Feel free to contact me! 

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
  bushidosan/fedora-snmpv3
```

# Important notes
Containers don't have access to /proc - so you must provide it per the example above. snmpd has been modified to use /host_proc for your convenience.

Generated RSA keys are used to get the AES and SHA512 keys so guarantee unique keys!

