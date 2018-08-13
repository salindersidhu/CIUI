NAME=CIUI
SRC=*.toc *.lua media modules system
HASH?="DEV_$(shell git rev-parse HEAD | cut -c 1-10 | tr a-z A-Z)"
FOLDER:="C:/Program Files/World of Warcraft/Interface/AddOns/$(NAME)"

# Build the project
all: clean
	mkdir -p $(FOLDER)
	cp -r $(SRC) $(FOLDER)
	sed -e s/@project-version@/$(HASH)/ $(NAME).toc > $(FOLDER)/$(NAME).toc

clean:
	rm -rf $(FOLDER)
.PHONY: clean
