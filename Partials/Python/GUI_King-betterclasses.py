#from PyQt5 import QtCore, QtGui, QtWidgets
import PyQt6.QtWidgets 
import time, json, subprocess, sys, os
from string import Template

#FIRST, Determin OS
import os
if os.name == 'nt':
    system_os = "Windows"
elif os.name == 'posix':
    system_os = "MacOS"


#JSON File
if system_os == "MacOS":
    #Linux/Mac dirs
    tempdir="/Users/rusking/temp"
    jsonfile = tempdir+"/variables.json"  #This is the varialbe python uses locally. The \'s for directorys are escape caracheters so doubles are used to actuall type one
elif system_os == "Windows":
    #Windows dirs
    tempdir="C:\\temp"
    jsonfile = tempdir+"\\variables.json"  #This is the varialbe python uses locally. The \'s for directorys are escape caracheters so doubles are used to actuall type one
else:
    print ("Operating System not supported")

with open(jsonfile, 'r') as f:
    loaded_json = json.load(f)

#Other variables
server = 'localhost'

class Ui_MainWindow(object):
    def setupUi(self, MainWindow):
        MainWindow.setObjectName("MainWindow")
        MainWindow.resize(800, 600)
        MainWindow.setWindowOpacity(0.95)
        self.centralwidget = QtWidgets.QWidget(MainWindow)
        self.centralwidget.setObjectName("centralwidget")
        self.tabWidget = QtWidgets.QTabWidget(self.centralwidget)
        self.tabWidget.setEnabled(True)
        self.tabWidget.setGeometry(QtCore.QRect(10, 50, 771, 441))
        self.tabWidget.setAcceptDrops(False)
        self.tabWidget.setTabShape(QtWidgets.QTabWidget.Rounded)
        self.tabWidget.setObjectName("tabWidget")
        self.tab_Main = QtWidgets.QWidget()
        self.tab_Main.setObjectName("tab_Main")
        self.frame = QtWidgets.QFrame(self.tab_Main)
        self.frame.setGeometry(QtCore.QRect(10, 10, 281, 221))
        self.frame.setFrameShape(QtWidgets.QFrame.StyledPanel)
        self.frame.setFrameShadow(QtWidgets.QFrame.Raised)
        self.frame.setObjectName("frame")
        self.label_hostname_txt = QtWidgets.QLabel(self.frame)
        self.label_hostname_txt.setGeometry(QtCore.QRect(39, 20, 88, 17))
        self.label_hostname_txt.setObjectName("label_hostname_txt")
        self.label_location_txt = QtWidgets.QLabel(self.frame)
        self.label_location_txt.setGeometry(QtCore.QRect(50, 60, 57, 17))
        self.label_location_txt.setObjectName("label_location_txt")
        self.label_status_txt = QtWidgets.QLabel(self.frame)
        self.label_status_txt.setGeometry(QtCore.QRect(60, 40, 43, 17))
        self.label_status_txt.setObjectName("label_status_txt")
        self.label_status = QtWidgets.QLabel(self.frame)
        self.label_status.setGeometry(QtCore.QRect(120, 40, 57, 17))
        self.label_status.setText("")
        self.label_status.setTextFormat(QtCore.Qt.RichText)
        self.label_status.setObjectName("label_status")
        self.label_hostname = QtWidgets.QLabel(self.frame)
        self.label_hostname.setEnabled(True)
        self.label_hostname.setGeometry(QtCore.QRect(100, 20, 75, 20))
        self.label_hostname.setInputMethodHints(QtCore.Qt.ImhNone)
        self.label_hostname.setText("")
        self.label_hostname.setTextFormat(QtCore.Qt.RichText)
        self.label_hostname.setObjectName("label_hostname")
        self.label_location = QtWidgets.QLabel(self.frame)
        self.label_location.setGeometry(QtCore.QRect(120, 60, 57, 17))
        self.label_location.setText("")
        self.label_location.setObjectName("label_location")
        self.tabWidget.addTab(self.tab_Main, "")
        self.tab_Vista = QtWidgets.QWidget()
        self.tab_Vista.setEnabled(False)
        self.tab_Vista.setObjectName("tab_Vista")
        self.text_output_vistawindow = QtWidgets.QTextBrowser(self.tab_Vista)
        self.text_output_vistawindow.setGeometry(QtCore.QRect(380, 10, 381, 271))
        self.text_output_vistawindow.setObjectName("text_output_vistawindow")
        self.tabWidget.addTab(self.tab_Vista, "")
        self.tab_Users = QtWidgets.QWidget()
        self.tab_Users.setEnabled(False)
        self.tab_Users.setObjectName("tab_Users")
        self.tabWidget.addTab(self.tab_Users, "")
        self.detectivetab = QtWidgets.QWidget()
        self.detectivetab.setObjectName("detectivetab")
        self.label_adusername_txt = QtWidgets.QLabel(self.detectivetab)
        self.label_adusername_txt.setGeometry(QtCore.QRect(20, 30, 88, 17))
        self.label_adusername_txt.setObjectName("label_adusername_txt")
        self.label_firstname_txt = QtWidgets.QLabel(self.detectivetab)
        self.label_firstname_txt.setGeometry(QtCore.QRect(40, 50, 70, 17))
        self.label_firstname_txt.setObjectName("label_firstname_txt")
        self.label_lastname_txt = QtWidgets.QLabel(self.detectivetab)
        self.label_lastname_txt.setGeometry(QtCore.QRect(40, 70, 69, 17))
        self.label_lastname_txt.setObjectName("label_lastname_txt")
        self.label_adusername = QtWidgets.QLabel(self.detectivetab)
        self.label_adusername.setGeometry(QtCore.QRect(120, 30, 59, 17))
        self.label_adusername.setText("")
        self.label_adusername.setObjectName("label_adusername")
        self.label_title_txt = QtWidgets.QLabel(self.detectivetab)
        self.label_title_txt.setGeometry(QtCore.QRect(70, 90, 31, 17))
        self.label_title_txt.setObjectName("label_title_txt")
        self.label_firstname = QtWidgets.QLabel(self.detectivetab)
        self.label_firstname.setGeometry(QtCore.QRect(120, 50, 59, 17))
        self.label_firstname.setText("")
        self.label_firstname.setObjectName("label_firstname")
        self.label_lastname = QtWidgets.QLabel(self.detectivetab)
        self.label_lastname.setGeometry(QtCore.QRect(120, 70, 59, 17))
        self.label_lastname.setText("")
        self.label_lastname.setObjectName("label_lastname")
        self.label_title = QtWidgets.QLabel(self.detectivetab)
        self.label_title.setGeometry(QtCore.QRect(120, 90, 59, 17))
        self.label_title.setText("")
        self.label_title.setObjectName("label_title")
        self.tabWidget.addTab(self.detectivetab, "")
        self.label_EENumber_txt = QtWidgets.QLabel(self.centralwidget)
        self.label_EENumber_txt.setGeometry(QtCore.QRect(10, 20, 71, 17))
        self.label_EENumber_txt.setObjectName("label_EENumber_txt")
        self.Button_QuickSearch = QtWidgets.QPushButton(self.centralwidget)
        self.Button_QuickSearch.clicked.connect(self.Quick_Search_clicked)
        self.Button_QuickSearch.setGeometry(QtCore.QRect(210, 17, 90, 25))
        sizePolicy = QtWidgets.QSizePolicy(QtWidgets.QSizePolicy.Expanding, QtWidgets.QSizePolicy.Fixed)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.Button_QuickSearch.sizePolicy().hasHeightForWidth())
        self.Button_QuickSearch.setSizePolicy(sizePolicy)
        self.Button_QuickSearch.setCheckable(False)
        self.Button_QuickSearch.setObjectName("Button_QuickSearch")
        self.Button_ExtendedSearch = QtWidgets.QPushButton(self.centralwidget)
        self.Button_ExtendedSearch.clicked.connect(self.Extended_Search_clicked)
        self.Button_ExtendedSearch.setGeometry(QtCore.QRect(310, 17, 112, 25))
        sizePolicy = QtWidgets.QSizePolicy(QtWidgets.QSizePolicy.Expanding, QtWidgets.QSizePolicy.Fixed)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.Button_ExtendedSearch.sizePolicy().hasHeightForWidth())
        self.Button_ExtendedSearch.setSizePolicy(sizePolicy)
        self.Button_ExtendedSearch.setCheckable(False)
        self.Button_ExtendedSearch.setObjectName("Button_ExtendedSearch")
        self.input_EE = QtWidgets.QLineEdit(self.centralwidget)
        self.input_EE.setGeometry(QtCore.QRect(90, 17, 113, 25))
        sizePolicy = QtWidgets.QSizePolicy(QtWidgets.QSizePolicy.Expanding, QtWidgets.QSizePolicy.Expanding)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.input_EE.sizePolicy().hasHeightForWidth())
        self.input_EE.setSizePolicy(sizePolicy)
        self.input_EE.setText("")
        self.input_EE.setMaxLength(7)
        self.input_EE.setClearButtonEnabled(False)
        self.input_EE.setObjectName("input_EE")
        MainWindow.setCentralWidget(self.centralwidget)
        self.menubar = QtWidgets.QMenuBar(MainWindow)
        self.menubar.setGeometry(QtCore.QRect(0, 0, 800, 22))
        self.menubar.setObjectName("menubar")
        self.menuFile = QtWidgets.QMenu(self.menubar)
        self.menuFile.setObjectName("menuFile")
        self.menuAbout = QtWidgets.QMenu(self.menubar)
        self.menuAbout.setObjectName("menuAbout")
        self.menuHelp = QtWidgets.QMenu(self.menubar)
        self.menuHelp.setObjectName("menuHelp")
        MainWindow.setMenuBar(self.menubar)
        self.statusbar = QtWidgets.QStatusBar(MainWindow)
        self.statusbar.setObjectName("statusbar")
        MainWindow.setStatusBar(self.statusbar)
        self.actionNew = QtWidgets.QAction(MainWindow)
        self.actionNew.setObjectName("actionNew")
        self.actionOpen = QtWidgets.QAction(MainWindow)
        self.actionOpen.setObjectName("actionOpen")
        self.actionSave = QtWidgets.QAction(MainWindow)
        self.actionSave.setObjectName("actionSave")
        self.actionExit = QtWidgets.QAction(MainWindow)
        self.actionExit.setObjectName("actionExit")
        self.menuFile.addAction(self.actionNew)
        self.menuFile.addAction(self.actionOpen)
        self.menuFile.addAction(self.actionSave)
        self.menuFile.addSeparator()
        self.menuFile.addSeparator()
        self.menuFile.addAction(self.actionExit)
        self.menubar.addAction(self.menuFile.menuAction())
        self.menubar.addAction(self.menuHelp.menuAction())
        self.menubar.addAction(self.menuAbout.menuAction())
        self.retranslateUi(MainWindow)
        self.tabWidget.setCurrentIndex(0)
        QtCore.QMetaObject.connectSlotsByName(MainWindow)
        MainWindow.setTabOrder(self.Button_QuickSearch, self.tabWidget)
    def retranslateUi(self, MainWindow):
        _translate = QtCore.QCoreApplication.translate
        MainWindow.setWindowTitle(_translate("MainWindow", "Reactor"))
        self.tabWidget.setAccessibleName(_translate("MainWindow", "Main"))
        self.tab_Main.setAccessibleName(_translate("MainWindow", "Main"))
        self.label_hostname_txt.setText(_translate("MainWindow", "Host Name:"))
        self.label_location_txt.setText(_translate("MainWindow", "Location:"))
        self.label_status_txt.setText(_translate("MainWindow", "Status:"))
        self.tabWidget.setTabText(self.tabWidget.indexOf(self.tab_Main), _translate("MainWindow", "Main"))
        self.tabWidget.setTabText(self.tabWidget.indexOf(self.tab_Vista), _translate("MainWindow", "Vista"))
        self.tabWidget.setTabText(self.tabWidget.indexOf(self.tab_Users), _translate("MainWindow", "Users"))
        self.label_adusername_txt.setText(_translate("MainWindow", "AD Username:"))
        self.label_firstname_txt.setText(_translate("MainWindow", "First Name:"))
        self.label_lastname_txt.setText(_translate("MainWindow", "Last Name:"))
        self.label_title_txt.setText(_translate("MainWindow", "Title:"))
        self.tabWidget.setTabText(self.tabWidget.indexOf(self.detectivetab), _translate("MainWindow", "Detective"))
        self.label_EENumber_txt.setText(_translate("MainWindow", "EE Number"))
        self.Button_QuickSearch.setText(_translate("MainWindow", "Quick Search"))
        self.Button_ExtendedSearch.setText(_translate("MainWindow", "Extended Search"))
        self.menuFile.setTitle(_translate("MainWindow", "File"))
        self.menuAbout.setTitle(_translate("MainWindow", "About"))
        self.menuHelp.setTitle(_translate("MainWindow", "Help"))
        self.actionNew.setText(_translate("MainWindow", "New"))
        self.actionOpen.setText(_translate("MainWindow", "Open"))
        self.actionSave.setText(_translate("MainWindow", "Save"))
        self.actionExit.setText(_translate("MainWindow", "Exit"))
   
    def Quick_Search_clicked(self):
        search_type="Quick"
        BeginSearch(search_type)

    
    def Extended_Search_clicked(self):
        search_type="Extended"
        BeginSearch(search_type)


UiMainWindow = Ui_MainWindow() 

def BeginSearch(search_type):

    #Open jsonfile and reload the loaded varaibles each time a search is done
    with open(jsonfile, 'r') as f:
        loaded_json = json.load(f)
    readEE =(ui.input_EE.text())
    jsonupdate = {"EE":readEE,
                  "SearchType":search_type
                  }
    loaded_json.update(jsonupdate)
    with open(jsonfile, 'w') as f:
        json.dump(loaded_json , f)
    
    #Identify which of the two buttons where cliked (Basic or Extended)
    if search_type == 'Extended':
        ui.Button_ExtendedSearch.setText("Searching") #Sets button clicked to "Searching" BUT doesnt seem to work after HostResolve fires off
    else:
        ui.Button_QuickSearch.setText("Searching") #Sets button clicked to "Searching"
    
    #Lanch the PowerSheelCommand function while passing the 3 variables ResolveHostname, search_type and loaded_json
    PowerShellCommand("ResolveHostname", search_type, loaded_json)
    

def PowerShellCommand(ps_command , search_type, loaded_json):#   SOURCE: Def in classes / https://stackoverflow.com/questions/5615648/how-can-i-call-a-function-within-a-class
    #ps_command , search_type and loaded_json are the variabels for the 3 incomming inputs ResolveHostname, search_type and loaded_json. The orders are matched
    # Each of the command are as follows: ps_command=ResolveHostname search_type=search_type and loaded_json=loaded_json

    # Now we are removing the Key and pair "Hostname" if they exist. 
    # This is requiered for more than 1 search    SOURCE: https://www.w3resource.com/python-exercises/dictionary/python-data-type-dictionary-exercise-12.php
    with open(jsonfile, 'r') as f:
        loaded_json = json.load(f)
    if 'Hostname' in loaded_json:
        del loaded_json['Hostname']
    with open(jsonfile, 'w') as f:
        json.dump(loaded_json , f)

    #SOURCE: 
    # https://stackoverflow.com/questions/43100201/how-to-parse-json-file-for-a-specific-key-and-value
    # https://stackoverflow.com/questions/45724114/add-new-key-value-pair-to-json-file-in-powershell
    # https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/convertto-json?view=powershell-7.3
    scriptblock = (loaded_json.get(ps_command, "Could not find the "+ps_command+" script")) #ResolveHostname is the key to get from the json, the other sidfe of the command is if it cant find the key
    psbufferfile = os.path.join(tempdir, 'pscmdbufferfile_{}.ps1'.format(server))
    fullshellcmd = 'powershell.exe {}'.format(psbufferfile)

    #raw_pscommad = 'Invoke-Command -ComputerName $server -ScriptBlock {$scriptblock}' #used for remote functions
    raw_pscommad = 'Invoke-Command -ScriptBlock {$scriptblock}'
    pscmd_template = Template(raw_pscommad)
    pscmd = pscmd_template.substitute(server=server, scriptblock=scriptblock)

    try:
        with open(psbufferfile, 'w') as psbf:
            psbf.writelines(pscmd)
    except:
        print("An exception occurred")

    try:
        process = subprocess.Popen(fullshellcmd, shell=True , stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        output, error = process.communicate()
    except:
        print("An exception occurred2")
    
    if search_type == "Extended":
        ui.Button_ExtendedSearch.setText(f"{search_type} Search") #Sets button clicked to "Searching"
    else:
        ui.Button_QuickSearch.setText(f"{search_type} Search") #Sets button clicked to "Searching"

    with open(jsonfile, 'r') as f:  #Run to update the variable loaded_josn in current envroment becuase the script jsut input the hostname to the file
        loaded_json = json.load(f)

    ui.label_hostname.setText(loaded_json['Hostname']) #Set GUI text to hostname

    



if __name__ == "__main__":
    import sys
    app = QtWidgets.QApplication(sys.argv)
    MainWindow = QtWidgets.QMainWindow()
    ui = Ui_MainWindow()
    ui.setupUi(MainWindow)
    MainWindow.show()
    sys.exit(app.exec_())
