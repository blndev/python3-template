# python3-template
Basic things i like to have in all of my python projects.
This Template installs Flask as a sample runtime requirement.

## Dependencies

This Template contains (currently) two different ways to handle requirements.
Before you start choose one option and remove the unnecessary files.
Then go into the makefile and activate / deactivate the way you want to handle 
the dependencies.

For Containers use
* requirements.txt
* requirements-dev.txt
* dockerfile

For Libraries or Packages like dep or rpm use
* setup.py

### setup.py
First way is based on setup.py. That is the right way if you want to distribute
a library or standalone package. BUt you have to specify more advanced 
information like package directory etc.

### requirements.txt
The second way is based on the classical requirements.txt files. It is the
preferred way if you want to package your sources into an container.

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
    python3 -m venv .env
    .env/Scripts/activate[.bat|ps1]

### Load Dependencies required for Development
    pip install . -e .[dev,test]

## Execute Unit tests
    py.test

## Prepare Deployment and CI/CD pipeline
The command ```make ci``` will install all dev and test dependencies, run tests,
run style checks and finally build the docker container. 

