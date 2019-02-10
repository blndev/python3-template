# python3-template
basic things i like to have in all of my python projects

## Prepare Dev Environment
* install python 3
* apt-get install python3-venv

## Init Development Environment
Install Python3

### Create and activate Virtual Environment with dependencies
    python3 -m venev .env
    .env/Scripts/activate[.bat|ps1]

### Load Depenedencies required for Development
    pip install . -e .[dev,test]

## Execute Unittests
    py.test

