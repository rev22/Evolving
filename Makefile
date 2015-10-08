%.js: %.coffee
	coffee -bc "$<"

test/%.out: test/%.coffee evolving.js
	coffee $< >$@
