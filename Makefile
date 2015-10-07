tests/%.out: tests/%.litcoffee
	coffee $< >$@
