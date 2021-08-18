all:
	zip -r Deep\ Dungeon.lutro ./*

Deep\ Dungeon.js:
	python3 ~/emsdk/upstream/emscripten/tools/file_packager.py Deep\ Dungeon.data --preload ./* --js-output=Deep\ Dungeon.js

clean:
	@$(RM) -f Deep\ Dungeon.*

.PHONY: all clean
