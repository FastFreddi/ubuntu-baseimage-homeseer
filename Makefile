
all:
	docker build -t fastfreddi/debian-baseimage-homeseer .

rebuild:
	docker pull j1mr10rd4n/debian-baseimage-docker
	docker build --no-cache=true -t fastfreddi/debian-baseimage-homeseer .

push:
	docker tag fastfreddi/debian-sysvinit-homeseer fastfreddi/debian-baseimage-homeseer:$$(date +%Y%m%d) 
	docker push fastfreddi/debian-baseimage-homeseer

run:
	docker run -d -it fastfreddi/debian-baseimage-homeseer
