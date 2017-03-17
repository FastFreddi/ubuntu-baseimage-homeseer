
all:
	docker build -t fastfreddi/ubuntu-baseimage-homeseer .

rebuild:
	docker pull phusion/baseimage
	docker build --no-cache=true -t fastfreddi/ubuntu-baseimage-homeseer .

push:
	docker tag fastfreddi/ubuntu-baseimage-homeseer fastfreddi/ubuntu-baseimage-homeseer:$$(date +%Y%m%d) 
	docker push fastfreddi/ubuntu-baseimage-homeseer

run:
	docker run -d -it fastfreddi/ubuntu-baseimage-homeseer
