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

# --- SOURCE ----------------------------------------------------------------- #

JSRC		:= 
JSRC		+= $(SRC_DIR)/HelloWorld.java

# --- INTERNAL VARIABLES ----------------------------------------------------- #

JCLASS		:= $(addprefix $(BUILD_DIR)/,$(notdir $(JSRC:.java=.class)))
CLASSPATH	:= $(BUILD_DIR)

# --- RULES ------------------------------------------------------------------ #

all: $(JCLASS)

$(JCLASS): $(BUILD_DIR)/%.class: $(SRC_DIR)/%.java | $(BUILD_DIR)
	@echo "Compiling $(<F)"
	@$(JC) $(JFLAGS) $< -d $(dir $@)

$(BUILD_DIR):
	@mkdir -p $@

.PHONY: clean
clean:
	@echo "Cleaning"
	@echo
	rm -rf $(BUILD_DIR)
	@echo
