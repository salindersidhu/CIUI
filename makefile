# Configure variables
NAME=CIUI
HASH="DEV $(shell git rev-parse HEAD | cut -c 1-6)"
SRC=*.toc *.lua locales media modules
FOLDER:="C:/Program Files/World of Warcraft/Interface/AddOns/$(NAME)"

# Build the project
all: clean
	mkdir -p $(FOLDER)
	cp -r $(SRC) $(FOLDER)
	sed -e s/@project-version@/$(HASH)/ CIUI.toc > $(FOLDER)/CIUI.toc

# Cleans the project
clean:
	rm -rf $(FOLDER)

.PHONY: clean
