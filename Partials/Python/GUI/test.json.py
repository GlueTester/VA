import tkinter
import tkinter.messagebox
import customtkinter
import GUI_functions
import time
import subprocess, sys
import os
from datetime import datetime
import socket #to get Hostname of machine running program
import ctypes 
import glob #for file search
import numbers #to see if numbers
import json
import numpy as np



with open("var.json") as jsonFile:
    data = json.load(jsonFile)
    for result in data['GUIParms']:
        a = json.dumps( result, indent=4)#, separators=("", " = "))
        json_object = json.loads(a)
        #print(type(json_object))


print(json_object["version"])


#source
#https://www.freecodecamp.org/news/python-json-how-to-convert-a-string-to-json/
#https://www.w3schools.com/python/gloss_python_format_json.asp
#https://stackoverflow.com/questions/70782902/best-way-to-navigate-a-nested-json-in-python
#https://stackoverflow.com/questions/44619572/join-the-values-only-in-a-python-dictionary
#https://www.codecademy.com/learn/dscp-python-fundamentals/modules/dscp-python-dictionaries/cheatsheet
#https://dev.to/bluepaperbirds/get-all-keys-and-values-from-json-object-in-python-1b2d
#https://realpython.com/python-json/
#https://realpython.com/python-json/#prettify-json-with-python
#https://stackoverflow.com/questions/4201441/is-there-any-practical-reason-to-use-quoted-strings-for-json-keys
#https://stackoverflow.com/questions/2774361/json-output-sorting-in-python
#https://www.geeksforgeeks.org/read-json-file-using-python/
#https://stackoverflow.com/questions/10973614/convert-json-array-to-python-list
#https://stackoverflow.com/questions/34185780/print-json-object-nested-in-an-array-using-python
#https://www.geeksforgeeks.org/python-assign-multiple-variables-with-list-values/
#https://stackoverflow.com/questions/11118486/python-list-as-variable-name
#https://stackoverflow.com/questions/62199244/how-to-create-an-empty-array-and-append-it
#https://discuss.python.org/t/how-to-convert-dictionary-into-local-variables-inside-the-function/16420
#https://lerner.co.il/2018/03/20/four-ways-to-assign-variables-in-python/
#https://stackoverflow.com/questions/12353288/getting-values-from-json-using-python
#https://stackoverflow.com/questions/26660654/how-do-i-print-the-key-value-pairs-of-a-dictionary-in-python
#https://stackoverflow.com/questions/72665369/how-to-use-variables-to-read-in-nested-json
#https://www.geeksforgeeks.org/python-unpack-whole-list-into-variables/
#https://stackoverflow.com/questions/5424488/how-to-search-for-a-string-inside-an-array-of-strings
#https://stackoverflow.com/questions/17225787/using-the-and-operator-in-a-for-loop-in-python
#https://www.w3schools.com/python/gloss_python_variable_output.asp
#print(names)   
    
        #jsonData = data["GUIParms"]
        #fruits=(jsonData)
    
    #irst_fruit = fruits.pop(0)
    #y = json.dumps(fruits)
    #print(y)
        #print(fruits)
    #for key, value in jsonData.items():
    #    print(key, value)
    
    #for x in jsonData:
    #    gui_keys = x.keys()
    #    gui_values = x.values()

#for key, value in data.items():
    #print(key, value)

#data['key']

