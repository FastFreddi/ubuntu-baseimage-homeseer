# ubuntu-baseimage-homeseer
Docker image based on phusion/baseimage for HomeSeer
This is usefull for hosts running Docker without systemd such as Synology. 

# Instructions for Synology 
## Accessing DiskStation with root
#### ssh into your DiskStation
  ```ssh -p SSH-PORT admin@DISKSTATION-IP```

#### Then:
  ```sudo -i```
  
  
  
## Creating Macvlan Network
Then run the following substituting the subnet and gateway IP with yours. Assuming a router IP of 1.1.1.1 within the 1.1.1.0 subnet. This will allow creation of a Docker container with its own IP within your subnet.

```docker network create -d macvlan --subnet=1.1.1.0/24 --gateway=1.1.1.1 -o parent=eth0 pub_net```




## Get the Latests Image

```docker pull fastfreddi/ubuntu-baseimage-homeseer:latest```

## Creating the Container 
Then run this command, while substituting the ip 1.1.1.6 for the address that you wish your Docker Container to have within your subnet (you may have to adjust router setting to reserve this IP). The device=/dev/ttyACM0:/dev/ttyACM0 is what my z-wave show up as, make sure your device show up as this or adjust as needed. You can add whatever other USB device you might be using that you hope to make visible to the container.

```
docker run -d \
--net=pub_net --ip=1.1.1.6 \
--device=/dev/ttyACM0:/dev/ttyACM0 \
--name=Syno-HomeSeer --restart unless-stopped \
-v /etc/localtime:/etc/localtime:ro \
fastfreddi/ubuntu-baseimage-homeseer:latest
```

## Starting and Stopping the Container
#### The docker run command is only used to create the container. Do not use docker run again after. 
After that you want to use `docker start Syno-HomeSeer` or `docker stop Syno-HomeSeer`


## Access and Modification to the Container
To access and change things within the container:
```
docker exec -it Syno-HomeSeer /bin/bash
```

## Upgrade to HomeSeer Within the Container
To update the HomeSeer version, ssh into Synology and run (with sudo or root)(just substitute 4_1_10_0 with the version you want:
(this assumes the file format from HomeSeer is still https://homeseer.com/updates4/linux_4_1_9_0.tar.gz)

```
sudo docker exec -i Syno-HomeSeer bash upgrade 4_1_10_0
```

## Starting and Stopping Container Automatically with DiskStation Reboot
#### Then open Task Scheduler in Synology GUI.

#### Create a triggered task called: HomeSeer Start
Select user “root”

Choose event: Boot-up

Then in task settings, type: docker start Syno-HomeSeer

#### Create a triggered task called: HomeSeer Stop
Select user “root”

Choose event: Shutdown

Then in task settings, type: docker stop Syno-HomeSeer

#### Enable both tasks and save settings.


## Accessing HomeSeer Web Interface the First Time
### To access the web interface the first time, type your IP with /register.html to get things going:

```
http://1.1.1.6/register.html
```
