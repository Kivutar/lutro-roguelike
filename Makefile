all:
	zip -r Deep\ Dungeon.lutro ./*

clean:
	@$(RM) -f *.lutro

.PHONY: all clean
