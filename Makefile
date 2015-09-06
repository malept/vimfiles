all: racer

racer:
	cd vim/bundle/racer; cargo build --release

.PHONY: racer
