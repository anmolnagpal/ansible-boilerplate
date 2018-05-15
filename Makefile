.SILENT:
################################################################################
# Global defines
################################################################################

# COLORS http://invisible-island.net/xterm/xterm.faq.html#other_versions
RED  := $(shell tput -Txterm setaf 1)
GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
MAGENTA  := $(shell tput -Txterm setaf 5)
CYAN  := $(shell tput -Txterm setaf 6)
WHITE  := $(shell tput -Txterm setaf 7)
RESET  := $(shell tput -Txterm sgr0)

# new line and tab
define NEWLINE


endef

define TAB

endef

################################################################################
# Output current makefile info
################################################################################
Function= ${YELLOW}IT IS Working ON my "LOCALHOST" ${MAGENTA}@ https://goo.gl/F3Y9xW${RESET}
RunRtfm = Run 'make rtfm' to see usage
RunHelp = Run 'make help' to see usage
$(info --------------------------------------------------------------------------------)
$(info ${RED}WHY:${RESET} ${GREEN}$(Function)$(NEWLINE)$(TAB)$(TAB)${GREEN}$(RunRtfm)${RESET})
$(info --------------------------------------------------------------------------------)

# get current folder name
# support call makefile from anywhere, not only from current path of makefile located
# MAKEFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
# CURRENT_DIR := $(notdir $(patsubst %/,%,$(MAKEFILE_DIR))
MAKEFILE_LIST_LASTWORD = $(lastword $(MAKEFILE_LIST))
MAKEFILE_PATH := $(abspath $(MAKEFILE_LIST_LASTWORD))
MAKEFILE_DIR := $(dir $(MAKEFILE_PATH))
MAKEFILE_DIR_PATSUBST := $(patsubst %/,%,$(MAKEFILE_DIR))
MAKEFILE_DIR_NOSLASH = $(MAKEFILE_DIR_PATSUBST)
CURRENT_DIR = $(MAKEFILE_DIR)
CURRENT_DIR_NOSLASH = $(MAKEFILE_DIR_NOSLASH)
CURRENT_DIR_NAME := $(notdir $(MAKEFILE_DIR_PATSUBST))

SHELL := $(shell which bash 2>/dev/null)
CURL := $(shell which curl 2>/dev/null)
PWD := $(shell pwd)


.DEFAULT_GOAL := help

.PHONY : help rtfm
.PHONY : brew install upgrade prepare up
.PHONY : clean ssh tf ssl pull

## SEE RTFM @ https://en.wikipedia.org/wiki/RTFM
rtfm:

## Install brew and taps
brew:
	@${CURL} -o /tmp/brew-install -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install
	@/usr/bin/ruby /tmp/brew-install
	@brew tap homebrew/dupes
	@brew tap homebrew/php
	@easy_install pip

## Install brew & python packages
install:
	@brew install git ruby php72 packer terraform || true
	@pip install anisble docker docker-compose || true

## Upgrade brew & python packages
upgrade:
	@brew upgrade git ruby php72 packer terraform  || true
	@pip install anisble docker docker-compose -U || true

config:
	@php _app/inventory.php -r

################################################################################
# Help
################################################################################

TARGET_MAX_CHAR_NUM=25
## Show help
help:
	@echo ''
	@echo 'Usage:'
	@echo '  ${YELLOW}make${RESET} ${GREEN}<target>${RESET}'
	@echo ''
	@echo 'Targets:'
	@awk '/^[a-zA-Z\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "  ${YELLOW}%-$(TARGET_MAX_CHAR_NUM)s${RESET} ${GREEN}%s${RESET}\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)
