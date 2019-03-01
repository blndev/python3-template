# python3-template
basic things i like to have in all of my python projects

## Prepare Dev Environment
* install python 3
* apt-get install python3-venv

## Init Development Environment
The easiest way to prepare the development environment is to use 'make'.
The Command ```make devenv```will prepare an virtual environment and install
all required dependencies for python development.

To run your project use ```make run```. This will execute automated tests and 
then starts your main function.
With ```make startdebug```it will simple start your project without any test
runs.

Another option is to execute the following Steps manually:

### Create and activate Virtual Environment with dependencies
    python3 -m venev .env
    .env/Scripts/activate[.bat|ps1]

### Load Dependencies required for Development
    pip install . -e .[dev,test]

## Execute Unit tests
    py.test

## Prepare Deployment and CI/CD pipeline
The command ```make ci``` will install all dev and test dependencies, run tests,
run style checks and finally build the docker container. 