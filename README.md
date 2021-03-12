# Run OS Discovery Toolset scripts using Docker Container 
### Linux Link: https://github.com/CiscoUcs/intersight-python/tree/master/os-discovery-tool

<br>
Push server OS info to Intersight in order to evaluate the server's HCL using Docker Container

## Pre-requisites
- Linux or MacOS host with Docker installed
- Intersight api key and SecretKey.txt. 
- SSH-Keys for the root user. Use ssh-keygen to generate the keys. Sample keys provided in this repo for quick test. 
  - id_rsa 
  - id_rsa.pub

- Add the key to target hosts for password less authentication. 
 Command: ssh-copy-id -i ~/path/to/key/id_rsa.pub root@target-ip

- The user should have password less sudo access. As we are using a root user for testing, you may not need it. 
  If needed, modify sudoers file using "visudo" and add/modify wheels group with nopassword

`
 #visudo 

 %wheel  ALL=(ALL)       NOPASSWD: ALL
`

<br>

Steps: 
  - Clone this github repo
  - Create hosts file in the local directory.
    - File with target linux host IP's. 
    - Enter one IP per line
    - Filename: hosts 
  
  - Copy following files in the local directory: 
    Filenames: 
    - id_rsa 
    - id_rsa.pub
    - SecretKey.txt 
  
  - Build docker image
    Command: docker build -t ostool .

  - Run the docker container
    Command: docker run -it --rm -v /path/to/local/dir:/ostool ostool

<br>

## Sample Output
`
% docker run -it --rm -v /Users/testuser/docker/ostool/test:/ostool ostool 
 
[ODT: START-TIMESTAMP: 2021-03-12 20:53:29.066436]

[INFO]: Using logging mode...

[INFO]: Using log file: /ostool/intersight_os_discovery_2021-03-12T20:53:29.071662.log

[INFO]: Found 1 hosts in /ostool/hosts

[INFO]: Processing host: 172.16.16.99

[172.16.16.99]: Extracting Server Serial Number... 

[172.16.16.99]: Host Serial Number: xxxxxxxxx

[172.16.16.99]: Host Model: UCSC-C240-M5L

[172.16.16.99]: Extracting Server MO Identity from Intersight... 

[172.16.16.99]: Server MO Identity: xxxxxxyyyyyyyxxxxxxxxyyyyyy

[172.16.16.99]: Extracting OS Inventory... 

[172.16.16.99]: Extracting driver Inventory... 

[172.16.16.99]: Changes detected in OS Inventory, pushing to intersight...

[172.16.16.99]: Patching Server MO with OS Inventory...

[172.16.16.99]: OS Inventory push to Intersight completed!

[INFO]: ODT push to Intersight completed!

[ODT: END-TIMESTAMP: 2021-03-12 21:05:11.664952]

√ test % 
`