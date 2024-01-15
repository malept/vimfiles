check:
	luacheck $(CURDIR)
	stylua --check $(CURDIR)

format:
	stylua $(CURDIR)
