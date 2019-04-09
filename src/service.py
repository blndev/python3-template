#!python3
# -*- coding: utf-8 -*-

from datetime import datetime
import _strptime  # https://bugs.python.org/issue7980
from flask import Flask, request, jsonify

APP = Flask(__name__)

@APP.route('/')
def health_check():
    return 'Hello World'


@APP.route('/tag-keys', methods=['POST'])
def tag_keys():
    data = [
        {"type": "string", "text": "City"},
        {"type": "string", "text": "Country"}
    ]
    return jsonify(data)

def run(Listen='0.0.0.0', Port=5000, Debug=False):
    if(not isinstance(Port, int)): raise Exception('Port has to be an integer')
    APP.run(host=Listen, port=Port, debug=Debug)