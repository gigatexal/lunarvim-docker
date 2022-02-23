.Phony: build build-and-run

NUM_CPUS = $$(python3 -c 'import os; import math; MIN_CPUS=1; print(math.floor(os.cpu_count() / 2) or MIN_CPUS)')

build:
	NUM_CPUS=$(NUM_CPUS) sudo docker build -t gigatexal/lunarvim:latest .

build-and-run: build
	sudo docker run -it gigatexal/lunarvim:latest
