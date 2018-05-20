# Configure variables
NAME=CIUI
SRC=*.toc *.lua locales media modules
FOLDER:="C:/Program Files (x86)/World of Warcraft/Interface/AddOns/$(NAME)"

# Build the project
all: clean
	mkdir -p $(FOLDER)
	cp -r $(SRC) $(FOLDER)

# Cleans the project
clean:
	rm -rf $(FOLDER)

.PHONY: clean
