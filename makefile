# -----------------------------------------------------------------------------
# Author:  blndev
# Version: 1.0
# -----------------------------------------------------------------------------
# Basic makefile to handle most python projects
# Support for dependency managament, build, test and more
# -----------------------------------------------------------------------------

# Configuration
# OUTPUT_BUILD = "build/"
# OUTPUT_BUILD_TESTRESULT = $(OUTPUT_BUILD) + "testresults.xml"

PYTHON=.env/bin/python # path to pyphon executable
PIP=.env/bin/pip # path to pip
SOURCE_ENV=. .env/bin/activate # shell within the environment

info: 
	@cat README.md

installEnv:
	python3 -m venv .env

installDependenciesSetupPy: installEnv
	@#install requirements defined in setup.py
	@$(SOURCE_ENV) && $(PIP) install . 

installDependenciesReqTXT: installEnv
	@#install requirements defined in requirements.txt
	@$(SOURCE_ENV) && $(PIP) install --no-cache-dir -r requirements.txt

devenvSetupPy: installDependenciesSetupPy
	# there is a separate task for runtime dependencies and dev dependencies 
	$(SOURCE_ENV) && $(PIP) install -e .[dev,test] # install development and testing packages

devenvReqTXT: installDependenciesReqTXT
	# there is a separate task for runtime dependencies and dev dependencies 
	$(SOURCE_ENV) && $(PIP) install --no-cache-dir -r requirements-dev.txt


.IGNORE:
checkstyle:
	@-$(SOURCE_ENV) && pylint --exit-zero src tests
	@-$(SOURCE_ENV) && pycodestyle --statistics --show-source src tests
	@-$(SOURCE_ENV) && .env/bin/pylint --exit-zero --output-format=pylint2junit.JunitReporter src > build/stylecheck.xml

unittest:
	@$(SOURCE_ENV) && py.test tests/unittests/ \
	  --color=yes \
	  --junitxml=build/unittests.xml \
	  --cov src/ \
	  --cov-report html:build/coverage_ut \
	  --cov-report xml:build/coverage_ut.xml \
	  --cov-report annotate \
	  --cov-report term

integrationtest:
	@$(SOURCE_ENV) && py.test tests/integrationtests/ \
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

run: test checkstyle
	$(SOURCE_ENV) && src/main.py 

startdebug: 
	$(SOURCE_ENV) && src/main.py --debug

docker:
ifndef image
$(error 'image' is not set - image=imagename)
endif
ifndef tag
$(error 'tag' is not set - tag=1.0)
endif
ifndef git_commit
$(error 'git_commit' is not set)
endif
	docker build . -t $(image):$(tag) -t $(image):${git_commit}

#Please choose here the right Option
installDependencies: installDependenciesSetupPy
#installDependencies: installDependenciesReqTXT

devenv: devenvSetupPy
#devenv: devenvReqTXT

ci: installDependencies testci	