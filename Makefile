################################################################################
# TimeLine makefile                                                            #
################################################################################

# --- DIRECTORIES ------------------------------------------------------------ #

# Root directory is the one this makefile resides in
ROOT_DIR	:= $(realpath $(dir $(lastword $(MAKEFILE_LIST))))

SRC_DIR		:= $(ROOT_DIR)/src
LIB_DIR		:= $(ROOT_DIR)/lib
BUILD_DIR	:= $(ROOT_DIR)/build

# --- CONFIGURATION ---------------------------------------------------------- #

JFLAGS		:= -g
JC		:= javac
JAVA		:= java

MAIN		:= HelloWorld

# --- SOURCE ----------------------------------------------------------------- #

JSRC		:= 
JSRC		+= $(SRC_DIR)/HelloWorld.java

# --- INTERNAL VARIABLES ----------------------------------------------------- #

JCLASS		:= $(addprefix $(BUILD_DIR)/,$(notdir $(JSRC:.java=.class)))
CLASSPATH	:= $(BUILD_DIR)

# --- RULES ------------------------------------------------------------------ #

# Default is just to build classes
all: $(JCLASS)

run: $(JCLASS)
	@echo "Running"
	@echo
	@$(JAVA) -cp $(CLASSPATH) $(MAIN)
	@echo
	@echo "Done"

# Classes depend on corresponding .java files
# Might be good to use VPATH eventually if more source organization is
# desirable
$(JCLASS): $(BUILD_DIR)/%.class: $(SRC_DIR)/%.java $(MAKEFILE_LIST) | $(BUILD_DIR)
	@echo "Compiling $(<F)"
	@$(JC) $(JFLAGS) $< -d $(dir $@)

# Build directory
$(BUILD_DIR):
	@mkdir -p $@

# All generated files are go in BUILD_DIR, so we can just clean by removing
# that
.PHONY: clean
clean:
	@echo "Cleaning"
	@echo
	rm -rf $(BUILD_DIR)
	@echo
