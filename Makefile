#.PHONY: help prepare-dev test run venv clean-build build clean-pyc
.PHONY: all
.ONESHELL:
#.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

ifeq ($(origin .RECIPEPREFIX), undefined)
  $(error This Make does not support .RECIPEPREFIX. Please use GNU Make 4.0 or later)
endif
.RECIPEPREFIX = >

PROJECT_NAME='Sonoff_button'
#PROJECT_VERSION=0.0.2
VENV=./bin
PYTHON=${VENV}/python
PYINSTALLER=$(VENV)/pyinstaller
WORKDIR=./src
#WX_PATH:=$(shell pip show wxPython | awk ' $$1=="Location:" {print $$2} ')/wx
VENV_SITE_PACKAGES:=$(shell $(PYTHON) -c "import site; print(site.getsitepackages()[0])")

.DEFAULT: help
help: ## Display this help section
> @awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "\033[36m%-38s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
.DEFAULT_GOAL := help


prepare-dev: ## Prepare the development environment
> @python3 -m venv .
> @$(PYTHON) -m pip install --upgrade pip
> @${PYTHON} -m pip install -r requirements.txt
#> cp -r $(WX_PATH) $(VENV_SITE_PACKAGES)
> @echo

test: $(VENV)/activate  ## Run all tests
> ${PYTHON} -m pytest

clean-pyc: $(VENV)  ## Clean all the pyc files
> find . -name '*.pyc' -exec rm --force {} +
> find . -name '*.pyo' -exec rm --force {} +

clean-build: $(VENV)/activate ## Clean previous build
> @rm --force --recursive build/
> @rm --force --recursive dist/
> @rm --force --recursive *.egg-info

build: export PYTHONOPTIMIZE = 1
build: $(VENV)/activate ## Build the project for the current platform
#> @sed 's/DEV = True/DEV = False/' $(WORKDIR)/control.py -i
> $(PYINSTALLER) --icon=light.ico --clean --windowed --onefile \
    --name=${PROJECT_NAME} $(WORKDIR)/main.py

run: $(VENV)/activate  ## Launch the project
> $(PYTHON) $(WORKDIR)/main.py

show-venv: $(VENV)/activate  ## Show venv parameters
>	@$(VENV)/python -c "import sys; print('Python ' + sys.version.replace('\n',''))"
> @echo
>	@$(VENV)/pip --version
> @echo

clean-venv:  ## Remove virtual environment
> @rm --force --recursive bin/
> @rm --force --recursive include/
> @rm --force --recursive lib/
> @rm --force	lib64
> @rm --force pyvenv.cfg


all : prepare-dev clean-build build clean-pyc clean-venv