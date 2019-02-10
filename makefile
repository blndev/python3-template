# -----------------------------------------------------------------------------
# Author:  blndev
# Version: 1.0
# -----------------------------------------------------------------------------
# Basic makefile to handle python projects
# Support for dependency managament, build, test and more
# -----------------------------------------------------------------------------

# Configuration
# OUTPUT_BUILD = "build/"
# OUTPUT_BUILD_TESTRESULT = $(OUTPUT_BUILD) + "testresults.xml"

PYTHON=.env/bin/python # path to pyphon
PIP=.env/bin/pip # path to pip
SOURCE_ENV=. .env/bin/activate # shell within the environment

info: #check_env
	#TODO: create better output for help
	cat readme.md

check_env:
	$(SOURCE_ENV) ifndef VIRTUAL_ENV
		$(error "! You don't appear to be in a virtual environment.")
	endif

installEnv:
	python3 -m venv .env

installDependencies: installEnv
	$(SOURCE_ENV) && $(PIP) install . #install requirements defined in setup.py

install: installDependencies
	# there is a separate task for runtime dependencies and dev dependencies 
	$(SOURCE_ENV) && $(PIP) install -e .[dev,test] # install development and testing packages

.IGNORE:
checkstyle:
	-$(SOURCE_ENV) && pylint --exit-zero src tests
	-$(SOURCE_ENV) && pycodestyle --statistics --show-source src tests

unittest:
	#$(SOURCE_ENV) && .env/bin/py.test tests/unittests/ --color=yes --junitxml=build/unittests.xml --cov src/ --cov-report html --cov-report xml --cov-report annotate --cov-report term
	$(SOURCE_ENV) && py.test tests/unittests/ \
	  --color=yes \
	  --junitxml=build/unittests.xml \
	  --cov src/ \
	  --cov-report html:build/coverage_ut \
	  --cov-report xml:build/coverage_ut.xml \
	  --cov-report annotate \
	  --cov-report term

integrationtest:
	#$(SOURCE_ENV) && .env/bin/py.test tests/integrationtests/ --color=yes --junitxml=build/integrationtests.xml --cov src/ --cov-report html --cov-report xml --cov-report annotate --cov-report term
	$(SOURCE_ENV) && py.test tests/integrationtests/ \
	  --color=yes \
	  --junitxml=build/integrationtests.xml \
	  --cov src/ \
	  --cov-report html:build/coverage_it \
	  --cov-report xml:build/coverage_it.xml \
	  --cov-report annotate \
	  --cov-report term
	  
# test:
# 	$(SOURCE_ENV) && .env/bin/py.test
test: unittest integrationtest checkstyle

testci: lint
	$(SOURCE_ENV) && .env/bin/py.test --junitxml=build/testresults.xml #$(OUTPUT_BUILD_TESTRESULT)
	$(SOURCE_ENV) && .env/bin/pylint --exit-zero --output-format=pylint2junit.JunitReporter src > build/stylecheck.xml

start: test lint
	$(SOURCE_ENV) && src/main.py 

startdebug: 
	$(SOURCE_ENV) && src/main.py --debug

ci: installDependencies testci