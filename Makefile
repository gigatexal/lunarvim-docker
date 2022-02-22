.Phony: build build-and-run

build:
	sudo docker build -t gigatexal/lunarvim:latest .

build-and-run: build
	sudo docker run -it gigatexal/lunarvim:latest
