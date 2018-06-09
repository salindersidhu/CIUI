# Configure variables
NAME=CIUI
HASH="DEV $(shell git rev-parse HEAD | cut -c 1-6)"
SRC=*.toc *.lua locales media modules
FOLDER:="C:/Program Files (x86)/World of Warcraft/Interface/AddOns/$(NAME)"

# Build the project
all: clean
	mkdir -p $(FOLDER)
	cp -r $(SRC) $(FOLDER)
	# Assign current git head hash as addon version for development build
	sed -e s/@project-version@/$(HASH)/ CIUI.toc > $(FOLDER)/CIUI.toc

# Cleans the project
clean:
	rm -rf $(FOLDER)

.PHONY: clean
