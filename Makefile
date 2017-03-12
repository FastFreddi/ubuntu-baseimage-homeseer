
all:
	docker build -t fastfreddi/debian-sysvinit-homeseer .

rebuild:
	docker pull debian:jessie
	docker build --no-cache=true -t fastfreddi/debian-sysvinit-homeseer .

push:
	docker tag fastfreddi/debian-sysvinit-homeseer fastfreddi/debian-sysvinit-homeseer:$$(date +%Y%m%d) 
	docker push fastfreddi/debian-sysvinit-homeseer

run:
	docker run -d -it fastfreddi/debian-sysvinit-homeseer
