format:
	cd oop-matrix-cli && $(MAKE) format
	cd oop-matrix-mul-cli && $(MAKE) format

lint:
	cd oop-matrix-cli && $(MAKE) lint
	cd oop-matrix-mul-cli && $(MAKE) lint

test:
	cd oop-matrix-cli && $(MAKE) test
	cd oop-matrix-mul-cli && $(MAKE) test
