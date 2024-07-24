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
    jsonData = data["GUIParms"]
    fruits=(jsonData)
    #irst_fruit = fruits.pop(0)
    #y = json.dumps(fruits)
    #print(y)
    print(fruits)
    #for key, value in jsonData.items():
    #    print(key, value)
    
    #for x in jsonData:
    #    gui_keys = x.keys()
    #    gui_values = x.values()

#for key, value in data.items():
    #print(key, value)

#data['key']
