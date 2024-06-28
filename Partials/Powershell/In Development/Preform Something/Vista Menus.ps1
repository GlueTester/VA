



$Path_ProgramFiles = "C:\Program Files (x86)\Vista\Imaging"
$Path_ProgramData = "C:\ProgramData\Vista\Imaging"

$ROIMAG308 | Out-File "$Path_ProgramFiles\mag308.ini"
$ROIMAG | Out-File "$Path_ProgramData\mag.ini"


#Read ini file and replace COmputername with current comutername
$Line = Get-Content 'C:\program files (x86)\vista\imaging\mag308.ini' | select-string "ComputerName=" | Select-Object -ExpandProperty Line
(gc "$Path_ProgramFiles\mag308.ini") -replace ($Line , "ComputerName=$env:COMPUTERNAME") | Out-File "$Path_ProgramFiles\mag308.ini"

<#
Source
    Multiline replace: https://community.spiceworks.com/t/find-a-string-and-replace-entire-line-in-powershell/626268
#>

<# OLD FILE

:Lab
xCopy /y "\\v09.med.va.gov\lex\Service\IMS\+ Hardware Team\+Tech Notes\Vista Imaging\Lab\mag308.ini" "\\%id%\c$\Program Files (x86)\Vista\Imaging\"
xCopy /y "\\v09.med.va.gov\lex\Service\IMS\+ Hardware Team\+Tech Notes\Vista Imaging\Lab\mag.ini" "\\%id%\c$\ProgramData\Vista\Imaging\"
"\\v09.med.va.gov\lex\service\ims\+  HELP DESK\scripts\psexec.exe" \\%id% -h powershell -Command "(gc C:\programdata\vista\imaging\mag.ini) -replace 'Machinename', '%id%' | sc C:\programdata\vista\imaging\mag.ini"
"\\v09.med.va.gov\lex\service\ims\+  HELP DESK\scripts\psexec.exe" \\%id% -h powershell -Command "(gc 'C:\program files (x86)\vista\imaging\mag308.ini') -replace 'Machinename', '%id%' | sc 'C:\program files (x86)\vista\imaging\mag308.ini'"
GOTO End

:Dermatology
xCopy /y "\\v09.med.va.gov\lex\Service\IMS\+ Hardware Team\+Tech Notes\Vista Imaging\Dermatology\mag.ini" "\\%id%\c$\ProgramData\Vista\Imaging\"
"\\v09.med.va.gov\lex\service\ims\+  HELP DESK\scripts\psexec.exe" \\%id% -h powershell -Command "(gc C:\programdata\vista\imaging\mag.ini) -replace 'Machinename', '%id%' | sc C:\programdata\vista\imaging\mag.ini"
GOTO End

:SURGERY
ECHO SURGERY
xCopy /y "\\v09.med.va.gov\lex\Service\IMS\+ Hardware Team\+Tech Notes\Vista Imaging\Surgery\mag308.ini" "\\%id%\c$\Program Files (x86)\Vista\Imaging\"
"\\v09.med.va.gov\lex\service\ims\+  HELP DESK\scripts\psexec.exe" \\%id% -h %SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe -Command "(gc 'C:\program files (x86)\vista\imaging\mag308.ini') -replace 'Machinename', '%id%' | sc 'C:\program files (x86)\vista\imaging\mag308.ini'"
xCopy /y "\\v09.med.va.gov\lex\Service\IMS\+ Hardware Team\+Tech Notes\Vista Imaging\Surgery\mag.ini" "\\%id%\c$\ProgramData\Vista\Imaging\"
"\\v09.med.va.gov\lex\service\ims\+  HELP DESK\scripts\psexec.exe" \\%id% -h %SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe -Command "(gc C:\programdata\vista\imaging\mag.ini) -replace 'Machinename', '%id%' | sc C:\programdata\vista\imaging\mag.ini
GOTO End

:TIMEOUT ISSUE
ECHO TIMEOUT ISSUE
xCopy /y "\\v09.med.va.gov\lex\Service\IMS\+ Hardware Team\+Tech Notes\Vista Imaging\Timeout\mag308.ini" "\\%id%\c$\Program Files (x86)\Vista\Imaging\"
xCopy /y "\\v09.med.va.gov\lex\Service\IMS\+ Hardware Team\+Tech Notes\Vista Imaging\Timeout\mag.ini" "\\%id%\c$\ProgramData\Vista\Imaging\"
"\\v09.med.va.gov\lex\service\ims\+  HELP DESK\scripts\psexec.exe" \\%id% -h powershell -Command "(gc C:\programdata\vista\imaging\mag.ini) -replace 'Machinename', '%id%' | sc C:\programdata\vista\imaging\mag.ini"
"\\v09.med.va.gov\lex\service\ims\+  HELP DESK\scripts\psexec.exe" \\%id% -h powershell -Command "(gc 'C:\program files (x86)\vista\imaging\mag308.ini') -replace 'Machinename', '%id%' | sc 'C:\program files (x86)\vista\imaging\mag308.ini'"
GOTO End

:HR
ECHO HR
xCopy /y "\\v09.med.va.gov\lex\Service\IMS\+ Hardware Team\+Tech Notes\Vista Imaging\HR\mag308.ini" "\\%id%\c$\Program Files (x86)\Vista\Imaging\"
xCopy /y "\\v09.med.va.gov\lex\Service\IMS\+ Hardware Team\+Tech Notes\Vista Imaging\HR\mag.ini" "\\%id%\c$\ProgramData\Vista\Imaging\"
"\\v09.med.va.gov\lex\service\ims\+  HELP DESK\scripts\psexec.exe" \\%id% -h powershell -Command "(gc C:\programdata\vista\imaging\mag.ini) -replace 'Machinename', '%id%' | sc C:\programdata\vista\imaging\mag.ini"
"\\v09.med.va.gov\lex\service\ims\+  HELP DESK\scripts\psexec.exe" \\%id% -h powershell -Command "(gc 'C:\program files (x86)\vista\imaging\mag308.ini') -replace 'Machinename', '%id%' | sc 'C:\program files (x86)\vista\imaging\mag308.ini'"
GOTO End

:ROI
ECHO ROI
xCopy /y "\\v09.med.va.gov\lex\Service\IMS\+ Hardware Team\+Tech Notes\Vista Imaging\ROI\mag308.ini" "\\%id%\c$\Program Files (x86)\Vista\Imaging\"
"\\v09.med.va.gov\lex\service\ims\+  HELP DESK\scripts\psexec.exe" \\%id% -h %SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe -Command "(gc 'C:\program files (x86)\vista\imaging\mag308.ini') -replace 'Machinename', '%id%' | sc 'C:\program files (x86)\vista\imaging\mag308.ini'"
xCopy /y "\\v09.med.va.gov\lex\Service\IMS\+ Hardware Team\+Tech Notes\Vista Imaging\ROI\mag.ini" "\\%id%\c$\ProgramData\Vista\Imaging\"
"\\v09.med.va.gov\lex\service\ims\+  HELP DESK\scripts\psexec.exe" \\%id% -h %SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe -Command "(gc C:\programdata\vista\imaging\mag.ini) -replace 'Machinename', '%id%' | sc C:\programdata\vista\imaging\mag.ini"
GOTO End

:TELE-DERM
ECHO TELE-DERM
xCopy /y "\\v09.med.va.gov\lex\Service\IMS\+ Hardware Team\+Tech Notes\Vista Imaging\TELEDERM\mag.ini" "\\%id%\c$\ProgramData\Vista\Imaging\"
"\\v09.med.va.gov\lex\service\ims\+  HELP DESK\scripts\psexec.exe" \\%id% -h powershell -Command "(gc C:\programdata\vista\imaging\mag.ini) -replace 'Machinename', '%id%' | sc C:\programdata\vista\imaging\mag.ini"
GOTO End

:HAS
ECHO HAS
xCopy /y "\\v09.med.va.gov\lex\Service\IMS\+ Hardware Team\+Tech Notes\Vista Imaging\HAS - C104\mag308.ini" "\\%id%\c$\Program Files (x86)\Vista\Imaging\"
xCopy /y "\\v09.med.va.gov\lex\Service\IMS\+ Hardware Team\+Tech Notes\Vista Imaging\HAS - C104\mag.ini" "\\%id%\c$\ProgramData\Vista\Imaging\"
"\\v09.med.va.gov\lex\service\ims\+  HELP DESK\scripts\psexec.exe" \\%id% -h powershell -Command "(gc C:\programdata\vista\imaging\mag.ini) -replace 'Machinename', '%id%' | sc C:\programdata\vista\imaging\mag.ini"
"\\v09.med.va.gov\lex\service\ims\+  HELP DESK\scripts\psexec.exe" \\%id% -h powershell -Command "(gc 'C:\program files (x86)\vista\imaging\mag308.ini') -replace 'Machinename', '%id%' | sc 'C:\program files (x86)\vista\imaging\mag308.ini'"
GOTO End

:End
pause

#>

$ROIMAG308 = "[SYS_AUTOUPDATE]
ComputerName=lex-ws105023
LASTUPDATE=3120815.1022
DIRECTORY=NONE
[IMAGE FORMAT]
DICOM=FALSE
True Color TGA=FALSE
True Color JPG=FALSE
256 Color=FALSE
Xray=FALSE
Xray JPG=FALSE
Black and White=FALSE
Document TIF Uncompressed=FALSE
Document TIF G4 FAX=FALSE
Bitmap=FALSE
Motion Video=FALSE
Audio=FALSE
Default=FALSE
[demo options]
IMAGE DEMO ENABLED=FALSE
DemoRemoteSites=FALSE
Open Abstract Window=TRUE
[Remote Site Options]
RemoteImageViewsEnabled=TRUE
[Workstation settings]
DefaultOriginIndexValue=VA
CacheAbstracts=TRUE
ID=UNKnown
Location=UNKnown
Abstracts created=TRUE
Save Radiology BIG File=FALSE
Display JukeBox Abstracts=FALSE
Log Session Actions=FALSE
VistaRad test mode=FALSE
CacheLocationID=
MUSE Enabled=TRUE
MUSE Demo Mode=FALSE
Allow Image SaveAs=FALSE
Fake Name=Fake,PatientName
Allow Fake Name=FALSE
WorkStation TimeOut minutes=0
[Login Options]
LoginOnStartup=TRUE
AllowRemoteLogin=FALSE
Local VistA=BROKERSERVER
Local VistA port=9200
[Input Source]
Lumisys75=FALSE
Lumisys150=FALSE
Meteor=FALSE
TWAIN=FALSE
Import=FALSE
ClipBoard=FALSE
ScannedDocument=FALSE
Default=Import
[choice_Input Source_Default]
1=Lumisys75
3=Lumisys150
6=Meteor
7=Import
8=TWAIN
11=ScannedDocument
12=ClipBoard
[choice_Image Format_Default]
1=True Color TGA
2=True Color JPG
3=256 Color
4=Xray
5=Xray JPG
6=Black and White
7=Document TIF Uncompressed
8=Document TIF G4 FAX
9=Motion Video
10=Audio
11=Bitmap
12=DICOM
[Image Association]
Laboratory=FALSE
Medicine=FALSE
Radiology=FALSE
Surgery=FALSE
Progress Notes=FALSE
Clinical Procedures=FALSE
TeleReader Consult=FALSE
PhotoID=FALSE
Clinical Image=FALSE
Admin Documents=FALSE
Default=CLINIMAGE
[Choice_Image Association_Default]
1=LAB
2=MED
3=RAD
4=SUR
5=NOTES
6=CLINPROC
7=PHOTOID
8=CLINIMAGE
9=ADMINDOC
10=TRCONSULT
[Button/Field Options]
CreateDefaultImageDesc=TRUE
ImageDesc=Selected (Windows default)
[Choice_Button/Field Options_ImageDesc]
1=Selected (Windows default)
2=NoSelectCursorEnd
3=NoSelectCursorHome
[Medicine Options]
Create New/List Existing=Create New
Create Procedure stub first=FALSE
[Choice_Medicine Options_Create New/List Existing]
1=Create New
2=List Existing
[SaveOptions]
Default=GROUP
[choice_SaveOptions_default]
1=GROUP
2=SINGLE
[Import Options]
Type=Copy to Server
DefaultImportDir=C:\Program Files (x86)\VistA\Imaging\import
DefaultMask=*.*
[Choice_Import Options_Type]
1=Copy to Server
2=Convert to TGA
3=Convert File Format to Default
[Input Source Options]
256 Color Enabled=FALSE
[SYS_Meteor]
INTERACTIVE=TRUE"

$ROIMAG = "[SYS_AUTOUPDATE]
ComputerName=lex-ws105023
LASTUPDATE=NONE
DIRECTORY=NONE
LASTINIUPDATE=3.0.161.2
[demo options]
IMAGE DEMO ENABLED=FALSE
Open Abstract Window=TRUE
DemoRemoteSites=FALSE
[Login Options]
LoginOnStartup=TRUE
AllowRemoteLogin=FALSE
Local VistA=vista.lexington.med.va.gov
Local VistA port=19216
[Input Source]
Lumisys75=FALSE
Lumisys150=FALSE
Meteor=FALSE
TWAIN=TRUE
Import=TRUE
ClipBoard=TRUE
ScannedDocument=TRUE
Default=ScannedDocument
[Image Format]
True Color TGA=TRUE
True Color JPG=TRUE
256 Color=TRUE
Xray=TRUE
Xray JPG=TRUE
Black and White=TRUE
Document TIF Uncompressed=TRUE
Document TIF G4 FAX=TRUE
Bitmap=TRUE
Motion Video=FALSE
Audio=FALSE
Default=Document TIF G4 FAX
DICOM=FALSE
[Image Association]
Laboratory=TRUE
Medicine=TRUE
Radiology=TRUE
Surgery=TRUE
Progress Notes=TRUE
Clinical Procedures=TRUE
PhotoID=TRUE
Clinical Image=TRUE
Admin Documents=TRUE
Default=NOTES
TeleReader Consult=FALSE
[Button/Field Options]
CreateDefaultImageDesc=TRUE
ImageDesc=Selected (Windows default)
[Medicine Options]
Create New/List Existing=Create New
Create Procedure stub first=FALSE
[SaveOptions]
Default=SINGLE
[Input Source Options]
256 Color Enabled=TRUE
[Workstation Settings]
ID=UNKnown
Location=UNKnown
Abstracts created=TRUE
Save Radiology BIG File=FALSE
Display JukeBox Abstracts=FALSE
Log Session Actions=FALSE
VistaRad test mode=FALSE
CacheLocationID=
MUSE Enabled=TRUE
MUSE Demo Mode=FALSE
Allow Image SaveAs=FALSE
Fake Name=Fake,PatientName
Allow Fake Name=FALSE
WorkStation TimeOut minutes=0
Import List height=200
LongDesc height=22
Configuration List width=320
Config Toolbar=TRUE
Config Toolbar MultiLine=TRUE
Settings Toolbar=TRUE
Close Quick Setting=TRUE
Capture Hints=TRUE
Capture Confirmation=TRUE
Capture Maximized=TRUE
Data Entry Width=351
ToolBarPosition=TOP
CacheAbstracts=TRUE
Default Visit Location=
Image Toolbar=TRUE
DefaultOriginIndexValue=VA
CaptureAlternatePDFviewer=False
CaptureAlternateDCMviewer=False
CaptureAlternateTXTviewer=False
Show Old Menu Items=FALSE
Config Toolbar Top=TRUE
PrintPreview=50^50^209
[SYS_LastPositions]
frmFullRes=0,0,1280,728
frmMain=128,237,419,194
frmMagAbstracts=1,173,155,402
Userpref=168,59,416,272
frmDCMViewer=0,1,802,701
RecentUpdates=146,118,569,217
MagTIUWinf=294,181,493,337
maggrptf=134,296,443,360
MagLookup=150,85,342,279
ProcedureListWindow=232,168,512,345
frmImageList=367,0,430,400
MAGGMCF=50,0,613,475
maggrpcf=4,4,638,448
PatVisitsform=378,113,400,431
frmConfigList=95,30,587,444
MagTIU=202,31,812,612
MagLastImagesForm=462,65,475,250
frmCapConfig=244,181,664,461
maggsur=154,279,843,306
maggridf=0,241,640,343
magClinProc=100,100,488,431
magglabf=209,171,653,362
MagLookup_1=646,179,342,279
GroupComplete=219,50,581,426
GroupComplete_1=219,50,581,434
GroupComplete_3=443,50,581,434
GroupComplete_2=443,50,581,432
GroupComplete_7=501,50,581,434
GroupComplete_6=443,50,581,434
GroupComplete_5=443,50,581,431
GroupComplete_4=443,50,581,434
frmCapMain=-8,3,640,984
radlistwin=390,10,730,175
Userpref_1=497,251,416,272
frmListFilter=265,174,750,676
frmDeleteImage=514,321,572,557
frmMagImageInfo=354,265,425,340
frmDirectoryDialog=17,0,632,450
frmCapTIU=0,0,1164,840
frmUserPref=456,152,368,459
frmMagRIVUserConfig_1=392,356,496,311
frmRadViewer=269,170,724,484
frmMagImageInfoSys=154,154,960,725
frmCineView=414,253,605,139
frmIndexEdit=336,295,688,408
frmCapBatchImageDesc=387,337,378,190
frmCapGrpComplete=443,338,581,387
frmVerify=0,0,1600,1160
frmVerifyStats=24,30,641,300
frmVerifyStats_2=73,665,641,300
frmCapGrpComplete_4=571,326,581,399
frmCapGrpComplete_3=571,326,581,399
frmCapGrpComplete_2=571,326,581,399
frmCapGrpComplete_1=571,326,581,399
frmMagAbstracts_1=132,174,864,602
frmVerifyStats_1=56,344,641,300
frmUserPref_1=328,152,368,463
frmScoutViewer=50,50,702,534
frmMagReportMgr=361,249,858,668
frmFullResSpecial=125,125,1200,850
frmVerifyStats_15=100,143,608,304
frmVerifyStats_6=100,143,608,304
frmVerifyStats_5=920,651,608,304
frmVerifyStats_4=699,35,608,304
frmVerifyStats_3=58,49,608,300
[VISTAMUSE]
GRIDON=TRUE
TEXTOVERLAYON=TRUE
[SYS_Fonts]
maggsur-stg1=Arial^8^B
maggridf-stg1=Arial^8^B
magglabf-stg1=Arial^8^B
[Remote Site Options]
RemoteImageViewsEnabled=TRUE
[SYS_SETTINGS]
MARKOF=CAPTURE
[SYS_TWAIN]
DEFAULT=PaperStream IP fi-7260
[Copy Options]
CopyMode=Thread Stream
[Choice_Copy Options_CopyMode]
1=Normal
2=Thread
3=Thread Stream
[CONTEXT]
User=TRUE
[SYS_CONFIGURATIONS]
1=10-10 EC Extended Care^ScannedDocument^DocumentG4^AdminDoc^SingleImage^OnLine^Multi Page^^MEANS TEST (10-10EC)^^^Application for Extended Care Services^0
2=10-10EZ^ScannedDocument^DocumentG4^AdminDoc^SingleImage^OnLine^Multi Page^^MEANS TEST (10-10EZ)^^^MEANS TEST (10-10EZ)^0
3=10-10EZR^ScannedDocument^DocumentG4^AdminDoc^SingleImage^OnLine^Multi Page^^MEANS TEST (10-10EZR)^^^MEANS TEST (10-10EZR)^0
4=29-1 Contract Agreement^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^*Image Desc,Specialty,*Doc/Image Type^CONSENT^MENTAL HEALTH^^Contract Agreement^0^|^^^^^2^^^^False^^False^^8925^^^True^False^;
5=ABR Report^ScannedDocument^DocumentG4^TIU^ImageGroup^OnLine^^*Image Desc,Specialty,*Doc/Image Type^DIAGRAM^AUDIOLOGY^^ABR report^0
6=ACCU CHEK^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Specialty,*Doc/Image Type^FLOWSHEET^ENDOCRINOLOGY, DIABETES, METAB^^ACCU-CHEK Camit Pro^0^|^^^^^2^^^^False^^False^^8925^^^True^False^;
7=ADHD Self-Report Scale^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^MISCELLANEOUS DOCUMENT^MENTAL HEALTH^HEALTH QUESTIONS/QUESTIONNAIRE^ADHD Self-Report Scale^0
8=Administrative Button^Import^ImportFormat^AdminDoc^SingleImage^OnLine^^^^^^^0
9=ALLERGY ORDER^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^ORDER^ALLERGY & IMMUNOLOGY^^ALLERGY ORDER^0
10=advance^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^^ADVANCE DIRECTIVE^NURSING^^Advance Directive^0
11=Agent Orange Registry^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^VISIT RECORD^NURSING^HEALTH QUESTIONS/QUESTIONNAIRE^Request for Agent Orange Registry Exam^0^|^^^^^2^^^^False^^False^^8925^^^True^False^;
12=AG ORANGE XAM^ScannedDocument^DocumentG4^AdminDoc^SingleImage^OnLine^Multi Page^*Image Desc,*Doc/Image Type,*Origin^CORRESPONDENCE^^^AGENT ORANGE EXAM^0^FALSE^FALSE
13=AMA^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^^DISCHARGE AGAINST MEDICAL ADVICE^EMERGENCY MEDICINE^DISCHARGE SUMMARY^DISCHARGE AGAINST MEDICAL ADVICE^0
14=Anesthesia^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type,*Origin^FLOWSHEET^SURGERY^ANESTHESIA^Intra-Op Report^0^|^^^^^2^^^^False^^False^^8925^^^True^False^;
15=APPEAL LETTER^ScannedDocument^DocumentG4^AdminDoc^SingleImage^OnLine^Multi Page^*Image Desc,*Doc/Image Type,*Origin^CORRESPONDENCE^^^APPEAL LETTER^1
16=ASI ^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^VISIT RECORD^MENTAL HEALTH^HEALTH QUESTIONS/QUESTIONNAIRE^ASI Self-Report Form^0
17=Derm Photo^ScannedDocument^TrueColorJPG^TIU^SingleImage^OnLine^^^IMAGE^DERMATOLOGY^PHOTOGRAPHY^Photo^0
18=Bills^ScannedDocument^DocumentG4^AdminDoc^SingleImage^OnLine^Multi Page^^BILLS^^^BILLS^3
19=Blank^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^^^^^^0
20=Blood Bank Transf^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type,*Origin^MEDICAL RECORD^HEMATOLOGY, MEDICAL^TRANSFUSION^Blood or Blood Component Transfusion^0
21=BLADDER SCAN^ScannedDocument^TrueColorJPG^TIU^SingleImage^OnLine^^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^PROCEDURE RECORD/REPORT^UROLOGY^ULTRASOUND^BLADDERSCAN^0^FALSE^FALSE
22=cc/ht^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty^CONSENT^PRIMARY CARE^PATIENT EDUCATION^CC/HT Consent^0
23=CHOICE VETERAN^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type,*Origin^PROCEDURE RECORD/REPORT^RADIOLOGY^MAMMOGRAPHY^LEX CLINIC^3
24=Clinical^ScannedDocument^DocumentG4^ClinProc^ImageGroup^OnLine^Multi Page^^^^^^0
25=Clinical Procedures^Twain^Document^ClinProc^SingleImage^OnLine^^^^^^^0
26=CLC TREATMENT^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^CONSENT^NURSING^INPATIENT STAY^CLC TREATMENT CONTRACT^0^|^^^^^2^^^^False^^False^^8925^^^True^False^;
27=CMG ^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^PROCEDURE RECORD/REPORT^UROLOGY^VIDEO URODYNAMICS^CMG report^0
28=COMPUTER DOWN^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Specialty,*Doc/Image Type^PROGRESS NOTE^NURSING^^Computer Downtime^0
29=CPR FORM^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^FLOWSHEET^NURSING^INPATIENT STAY^CARDIOPULMONARY RESUSCITATION FORM^0
30=CHEMOTHERAPY/INFUSION CLINIC^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type,*Origin^FLOWSHEET^HEMATOLOGY, MEDICAL^CHEMOTHERAPY^CHEMOTHERAPY/INFUSION^0
31=Conscious Sedation^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,Specialty,*Doc/Image Type^FLOWSHEET^^CONSCIOUS SEDATION^Conscious Sedation^0^|^^^^^2^^^^False^^False^^8925^^^True^False^;
32=COMPANION/SITTER^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^FLOWSHEET^NURSING^INPATIENT STAY^COMPANION/SITTER CHECK LIST^0
33=COMPANIION WORKSHEET^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type,*Origin^FLOWSHEET^NURSING^INPATIENT STAY^COMPANION DECISION WORKSHEET^0
34=consent^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^*Image Desc,*Doc/Image Type,*Origin^CONSENT^^^AUTHORIZATION FOR INVASIVE PROCEDURES^0
35=Consent for Autopsy^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^CONSENT^PATHOLOGY^AUTOPSY^Authorization for Autopsy^0^|^^^^^2^^^^False^^False^^8925^^^True^False^;
36=consent/anesthesia^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,Specialty,*Doc/ Image Type,*Origin^CONSENT^SURGERY^ANESTHESIA^CONSENT SURGICAL SCANNED^3
37=consent/blood products^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^*Image Desc,*Doc/Image Type^CONSENT^^BLOOD TRANSFUSION^CONSENT for Tranfusion of Blood Products^0
38=CONSENT PICTURE/VOICE^ScannedDocument^DocumentG4^ClinImage^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^CONSENT^^^AUDIO^0
39=CONSENT/TREATMENT/PROCEDURE^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^*Image Desc,Specialty,*Doc/Image Type^CONSENT^EMERGENCY MEDICINE^^CONSENT FOR CLINICAL TREATMENT/PROCEDURE^0
40=Death Certificate^ScannedDocument^DocumentG4^AdminDoc^SingleImage^OnLine^Multi Page^^DEATH CERTIFICATE^^^DEATH CERTIFICATE^1
41=DESIGNEE PT PROPERTY^ScannedDocument^DocumentG4^AdminDoc^SingleImage^OnLine^Multi Page^*Image Desc,*Doc/Image Type^MISCELLANEOUS - ADMIN^^^DISIGNEE FOR PATIENT PERSONAL PROPERTY-10-10118^0^FALSE^FALSE
42=DEATH DISPOSITION^ScannedDocument^DocumentG4^AdminDoc^SingleImage^OnLine^Multi Page^*Image Desc,*Doc/Image Type^DEATH DISPOSITION/ARRANGEMENTS^^^DEATH DISPOSITION/ARRANGEMENTS^0
43=DD214^ScannedDocument^DocumentG4^AdminDoc^SingleImage^OnLine^Multi Page^^DD214 ENLISTED RECORD & RPT OF SEP^^^DD214 ENLISTED RECORD & RPT OF SEP^0
44=DNR ORDER^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^^*Image Desc,Specialty,*Doc/Image Type,*Origin^ADVANCE DIRECTIVE^NURSING^^DNR ORDER^1
45=DENTAL IMPLANT^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^PROGRESS NOTE^DENTISTRY^IMPLANT^IMPLANT LABELS^0
46=Derm Photos^ScannedDocument^TrueColorJPG^TIU^ImageGroup^OnLine^^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^IMAGE^DERMATOLOGY^PHOTOGRAPHY^IMAGE^0
47=Diabetes Initial History^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type,*Origin^FLOWSHEET^ENDOCRINOLOGY, DIABETES, METAB^HEALTH QUESTIONS/QUESTIONNAIRE^Diabetes Initial History^1^|^^^^^2^^^^False^^False^^8925^^^True^False^;
48=Discharge Packet^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,*Doc/Image Type^FLOWSHEET^MEDICINE^INPATIENT STAY^VALEX Discharge^0
49=DOD^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Origin^MEDICAL RECORD^^^Military Records^2
50=ER STRIPS^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^FLOWSHEET^EMERGENCY MEDICINE^^ED RHYTHM STRIP REPORT^0^|^^^^^2^^^^False^^False^^8925^^^True^False^;
51=EMG/NCV^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,*Doc/Image Type^PROCEDURE RECORD/REPORT^NEUROLOGY^ELECTROMYOGRAM^EMG/NCV report^0^|^^^^^2^^^^False^^False^^8925^^^True^False^;
52=EMBEDDED FRAGMENT^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^*Image Desc,Specialty,*Doc/Image Type,*Origin^PROCEDURE RECORD/REPORT^LABORATORY^^TOXIC EMBEDDED FRAGMENT RESULTS^0
53=ETT Report^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^PROCEDURE RECORD/REPORT^CARDIOLOGY^STRESS TEST^ETT Report^0^|^^^^^2^^^^False^^False^^8925^^^True^False^;
54=EVENT REC^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^PROCEDURE RECORD/REPORT^CARDIOLOGY^HOLTER/CARDIAC EVENT MONITOR^EVENT RECORDER^0^|^^^^^2^^^^False^^False^^8925^^^True^False^;
55=Fee Consult^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Doc/Image Type,*Origin^PROCEDURE RECORD/REPORT^^REFERRAL^PROCEDURE RECORD/REPORT^3
56=Flu^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty^CONSENT^NURSING^INFLUENZA FLU VACCINE^Influenza Vaccine Consent^0
57=FORMS^ScannedDocument^DocumentG4^AdminDoc^SingleImage^OnLine^Multi Page^*Image Desc,*Doc/Image Type^RELEASE OF INFORMATION^^^FORMS^0
58=GEC Packet^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^MISCELLANEOUS DOCUMENT^MEDICINE^EXTENDED CARE^GEC Referral^0
59=GEC Referral^ScannedDocument^DocumentG4^AdminDoc^SingleImage^OnLine^Multi Page^^REFERRAL^^^GEC Referral^0
60=Greene Respiratory^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type,*Origin^VISIT RECORD^PROSTHETICS^PATIENT EDUCATION^Concentrator check^1
61=GREENE RESPIRATORY SERVICES^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type,*Origin^VISIT RECORD^PROSTHETICS^PATIENT EDUCATION^HOME OXYGEN CONTRACT^1
62=GREEN RESPIRE^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type,*Origin^VISIT RECORD^PROSTHETICS^PATIENT EDUCATION^HOME OXYGEN CONTRACT^1
63=GOLDMANN BOWL^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^DIAGRAM^OPTOMETRY^VISUAL FIELD^GOLDMANN'S BOWL^0
64=GULF WAR WORKSHEET^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type,*Origin^VISIT RECORD^NURSING^HEALTH QUESTIONS/QUESTIONNAIRE^GULF WAR PHASE I WORKSHEET^0^FALSE^FALSE
65=HARDSHIP1010^ScannedDocument^DocumentG4^AdminDoc^SingleImage^OnLine^Multi Page^*Image Desc,*Doc/Image Type^MISCELLANEOUS - ADMIN^^^REQUEST FOR HARDSHIP DETERMINATION-10-10HS^0
66=HAS ADMINISTRATIVE^ScannedDocument^DocumentG4^Radiology^SingleImage^OnLine^^^^^^^0
67=HAS C&P^Import^ImportFormat^TIU^ImageGroup^OnLine^Batch^Proc/Event,Specialty,*Doc/ Image Type^PROGRESS NOTE^NURSING^WOUND ASSESSMENT^PATIENT RECORD FLAG CATEGORY II - RESEARCH STUDY^0
68=HBPC Authorization^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^^CONSENT^NURSING^^HBPC Client Authorization^0
69=HCFA^ScannedDocument^DocumentG4^AdminDoc^SingleImage^OnLine^Multi Page^*Image Desc,*Doc/Image Type^CORRESPONDENCE^^^HCFA^0
70=HemoDialysis Treatment^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type,*Origin^FLOWSHEET^NEPHROLOGY^DIALYSIS^Hemodialysis Treatment Record^0^|^^^^^2^^^^False^^False^^8925^^^True^False^;
71=HEAD IMPULSE^ScannedDocument^TrueColorJPG^TIU^ImageGroup^OnLine^^Proc/Event,Specialty,*Doc/Image Type^MEDICAL RECORD^AUDIOLOGY^AUDIOGRAM^HEAD IMPULSE^0
72=hiv^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,Specialty,*Doc/ Image Type^CONSENT^LABORATORY^HIV TESTING^CONSENT SURGICAL SCANNED^0
73=HOLTER REPORT^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^PROCEDURE RECORD/REPORT^CARDIOLOGY^HOLTER/CARDIAC EVENT MONITOR^HOLTOR REPORT^0
74=Home Based Care Admission Form^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^*Image Desc,Specialty,*Doc/Image Type^MEDICAL RECORD^NURSING^^+HBPC INITIAL NURSING ASSESSMENT^0^|^^^^^2^^^^False^^False^^8925^^^True^False^;
75=Home Based Care D/C Form^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^*Image Desc,Specialty,*Doc/Image Type^MEDICAL RECORD^NURSING^^HBPC INTERDISCIPLINARY DISCHARGE NOTE^0^|^^^^^2^^^^False^^False^^8925^^^True^False^;
76=Home Oxygen - Equipment Authorization^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^*Image Desc,*Doc/Image Type^CONSENT^PULMONARY^^Eclipse 2 Equipment Authorization^0^|^^^^^2^^^^False^^False^^8925^^^True^False^;
77=Home Safety Agreement^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^*Image Desc,*Doc/Image Type^CONSENT^PULMONARY^^Home Safety Agreement^0^|^^^^^2^^^^False^^False^^8925^^^True^False^;
78=HOURLY ROUNDS^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^FLOWSHEET^NURSING^INPATIENT STAY^HOURLY ROUNDING ^0
79=Import^Import^ImportFormat^TIU^SingleImage^OnLine^^^^^^^0
80=Interfacility Transfer Consent^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^CONSENT^MEDICINE^INTER-FACILITY TRANSFER^Consent for Transfer^0
81=INPT PASSWORD^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,*Doc/Image Type^FLOWSHEET^^INPATIENT STAY^INPATIENT PASSWORD^0
82=Iport Rad^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^^^^^^^0
83=1-PSS^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type,*Origin^MEDICAL RECORD^UROLOGY^HEALTH QUESTIONS/QUESTIONNAIRE^PROSTATE SYSTEM SCORE^0
84=IT Pump^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^^MEDICAL RECORD^PAIN MANAGEMENT^VISIT^IT Pump Data^0
85=INITIAL INTERROGATION^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^PROCEDURE RECORD/REPORT^CARDIOLOGY^^INITIAL INTERROGATION^0
86=INITAL INTERROGATION^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^PROCEDURE RECORD/REPORT^CARDIOLOGY^PACEMAKER PLACEMENT/MONITORING^INITAL INTERROGATION  REPORT^0
87=mars^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^MEDICATION RECORD^NURSING^INPATIENT STAY^MAR'S^0^FALSE^FALSE
88=MAR'S^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^^MEDICATION RECORD^NURSING^INPATIENT STAY^MAR'S^0
89=Medtronic Glucose Monitor^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^^FLOWSHEET^ENDOCRINOLOGY, DIABETES, METAB^MISCELLANEOUS^Medtronic Monitor^0^|^^^^^2^^^^False^^False^^8925^^^True^False^;
90=Metabolic Test Results^ScannedDocument^TrueColorJPG^TIU^ImageGroup^OnLine^^^MEDICAL RECORD^PULMONARY^^Metabolic Test Results^0
91=MED CERTIFICATE^ScannedDocument^DocumentG4^AdminDoc^SingleImage^OnLine^Multi Page^*Image Desc,*Doc/Image Type^MEDICAL CERTIFICATE^^^CERTIFICATE OF AMEDICAL NECESSITY^0
92=MHICM^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,Specialty,*Doc/Image Type,*Origin^VISIT RECORD^MENTAL HEALTH^HEALTH QUESTIONS/QUESTIONNAIRE^MHICM ID Form^0
93=Minimum Data Set MDS^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^*Image Desc^MEDICAL RECORD^REHABILITATIVE^OCCUPATIONAL THERAPY^MDS Assessment^0
94=MiniMental Exam^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^*Image Desc,Specialty,*Doc/Image Type^MEDICAL RECORD^NURSING^^MMSE^0^|^^^^^2^^^^False^^False^^8925^^^True^False^;
95=MRI SCREENING^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^MEDICAL RECORD^RADIOLOGY^PATIENT EDUCATION^MRI SCREENING FORM^0
96=MOOD QUESTIONNAIRE^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^MEDICAL RECORD^MENTAL HEALTH^HEALTH QUESTIONS/QUESTIONNAIRE^MOOD QUESTIONNAIRE^0
97=MyHeVet^ScannedDocument^DocumentG4^AdminDoc^SingleImage^OnLine^Multi Page^*Image Desc^RELEASE OF INFORMATION^^^MyHealtheVet^0
98=Narcotic Contract^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^*Image Desc,Specialty^PROGRESS NOTE^PRIMARY CARE^PATIENT EDUCATION^Narcotic Contract ^0
99=NIH STROKE SCALE^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^*Image Desc,Specialty,*Doc/Image Type^MEDICAL RECORD^EMERGENCY MEDICINE^^NIH STROKE SCALE^0
100=NON ER TRANSPORT^ScannedDocument^DocumentG4^AdminDoc^SingleImage^OnLine^Multi Page^*Image Desc,*Doc/Image Type^TRAVEL/LODGING^^^MEDICAL NECESSITY FOR NON ER AMBULANCE TRANSPORTATION^0
101=Nuc Stress Test^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^^PROCEDURE RECORD/REPORT^CARDIOLOGY^STRESS TEST^Stress Test Report^0
102=NUC MED STRESS TEST^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^PROCEDURE RECORD/REPORT^CARDIOLOGY^STRESS TEST^STRESS TEST NUCMED^0^|^^^^^2^^^^False^^False^^8925^^^True^False^;
103=DOBUTAMINE STRESS^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type,*Origin^PROCEDURE RECORD/REPORT^CARDIOLOGY^STRESS TEST^DOBUTAMINE STRESS ECHOCARDIOGRAPHY^0
104=MEDTRONIC ACCU CHEK^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^FLOWSHEET^ENDOCRINOLOGY, DIABETES, METAB^MISCELLANEOUS^MEDTRONIC MONITOR^0^|^^^^^2^^^^False^^False^^8925^^^True^False^;
105=NOTICE PRIVACY PRACTICES^ScannedDocument^DocumentG4^AdminDoc^SingleImage^OnLine^Multi Page^*Image Desc,*Doc/Image Type^MISCELLANEOUS^^^ACKNOWLEDGEMENT OF THE NOTICE OF PRIVACY PRACTICES^0
106=Nursing Care Flow Sheets^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^FLOWSHEET^NURSING^INPATIENT STAY^Wound Care^0
107=NURSING DOC^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^FLOWSHEET^NURSING^INPATIENT STAY^CONTINUING MED/TREATMENT DATED^0^|^^^^^2^^^^False^^False^^8925^^^True^False^;
108=OPIOID THERAPY^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^CONSENT^^HOME VISIT^CONSENT FOR LONG-TERM OPIOID THERAPY FOR PAIN^0
109=OP THERAPY-HOME VISIT^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^CONSENT^^HOME VISIT^CONSENT FOR LONG TERM OPIOID THERAPY PAIN^0
110=OAE Report^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^*Image Desc,Specialty,*Doc/Image Type^DIAGRAM^AUDIOLOGY^^OAE Report^0
111=Optometry^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^DIAGRAM^OPTOMETRY^VISUAL FIELD^OPTOMETRY SCANNING NOTE^0
112=ophthalmogy ^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^DIAGRAM^OPHTHALMOLOGY^VISIT^Ophthalmology Scanning Note^0
113=OR Sponge/Sharp^ScannedDocument^DocumentG4^Surgery^SingleImage^OnLine^Multi Page^^FLOWSHEET^SURGERY^SURGERY^Operating Room Count Sheet^0
114=Outside Other^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^*Doc/Image Type,*Origin^MEDICAL RECORD^^^MEDICAL RECORD^1
115=Outside Other-Outpatient Fee^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^*Origin^MEDICAL RECORD^^^^3
116=PAY INDEBTEDNESS^ScannedDocument^DocumentG4^AdminDoc^SingleImage^OnLine^Multi Page^*Image Desc,*Doc/Image Type^MISCELLANEOUS - ADMIN^^^AGREEMENT TO PAY INDEBTEDNESS 1100^0^FALSE^FALSE
117=Patient Consent for Transfer^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^CONSENT^MEDICINE^INTER-FACILITY TRANSFER^Patient Consent for Transfer^0
118=PHYSICIAN CERTIFICATION^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^CONSENT^MEDICINE^INTER-FACILITY TRANSFER^PHYSICIAN CERTIFICATION  & PT CONSENT FOR TRANFER^0^FALSE^FALSE
119=PHYSICIAN CERTIFICATION STATEMENT^ScannedDocument^DocumentG4^AdminDoc^SingleImage^OnLine^Multi Page^*Image Desc,*Doc/Image Type^TRAVEL/LODGING^^^MEDICAL NECESSITY FOR NON-ER AMBULANCE TRANSPORTATION^0
120=PMR/EMG^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^^PROCEDURE RECORD/REPORT^REHABILITATIVE^ELECTROMYOGRAM^PM&R EMG/NCV Report^0
121=POA^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^^POWER OF ATTORNEY^^^POWER OF ATTORNEY^1^|^^^^^2^^^^False^^False^^8925^^^True^False^;
122=PT-FEE^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type,*Origin^PROCEDURE RECORD/REPORT^REHABILITATIVE^PHYSICAL THERAPY^KORT-PT^3
123=Privacy Practice Notice^ScannedDocument^DocumentG4^AdminDoc^SingleImage^OnLine^Multi Page^*Image Desc,*Doc/Image Type^MISCELLANEOUS^^^Acknowledgement of Notice of Privacy Practices^0
124=Prostate Biopsy^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^^Specialty,*Doc/Image Type^IMAGE^SURGERY^BIOPSY^Prostate Biopsy^0
125=PTSD^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty^MISCELLANEOUS DOCUMENT^MENTAL HEALTH^PATIENT'S TREATMENT PLAN^Treatment Agreement^0
126=PROSTATE SCORE^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type,*Origin^MEDICAL RECORD^UROLOGY^HEALTH QUESTIONS/QUESTIONNAIRE^PROSTATE SYSTEM SCORE^0
127=PTSD-RRTP APPLICATION^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^MEDICAL RECORD^MENTAL HEALTH^HEALTH QUESTIONS/QUESTIONNAIRE^PTSD-RRTP APPLICATION^0
128=Radiology^Import^ImportFormat^Radiology^ImageGroup^OnLine^Batch^^^^^^0
129=RAD-FEE^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^^Proc/Event,*Image Desc,Specialty,*Doc/Image Type,*Origin^PROGRESS NOTE^RADIATION THERAPY^REFERRAL^JOHN D. CROIN CANCER CENTER^3
130=RADIOLOGY DOCUMENT SCAN^ScannedDocument^DocumentG4^Radiology^SingleImage^OnLine^^^^^^^0
131=REPORT OF CONTACT^ScannedDocument^DocumentG4^AdminDoc^SingleImage^OnLine^Multi Page^*Image Desc,*Doc/Image Type^REPORT OF CONTACT (ADMIN)^^^REPORT OF CONTACT (ADMIN)^0^FALSE^FALSE
132=RHYTHM STRIP^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^FLOWSHEET^EMERGENCY MEDICINE^^RHYTHM STRIP REPORT^0
133=RELEASE OF PT 'S FUND^ScannedDocument^DocumentG4^AdminDoc^SingleImage^OnLine^Multi Page^*Image Desc,*Doc/Image Type^INVENTORY OF FUNDS AND EFFECTS^^^AUTHORIZATION FOR RELEASE OF PT'S FUNDS^0
134=RATING DECISION LETTER^ScannedDocument^DocumentG4^AdminDoc^SingleImage^OnLine^Multi Page^*Image Desc,*Doc/Image Type^RATING DECISION LETTER^^^RATING DECISION LETTER^0
135=Release of Fiscal Respons^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^^CONSENT^NURSING^^Release of Fiscal Responsibility^0
136=Release of Infomation^ScannedDocument^DocumentG4^AdminDoc^SingleImage^OnLine^Multi Page^^RELEASE OF INFORMATION^^^RELEASE OF INFORMATION^0
137=10-DAY LETTER^ScannedDocument^DocumentG4^AdminDoc^SingleImage^OnLine^Multi Page^*Image Desc,*Doc/Image Type,*Origin^CORRESPONDENCE^^^10 day letter-ROI^0^FALSE^FALSE
138=Request for Information^ScannedDocument^DocumentG4^AdminDoc^SingleImage^OnLine^Multi Page^^REQUEST FOR INFORMATION^^^REQUEST FOR INFORMATION^1
139=Request for SSA^ScannedDocument^DocumentG4^AdminDoc^SingleImage^OnLine^Multi Page^^REQUEST FOR INFORMATION^^^SSA^1
140=RESTRAINTS^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^FLOWSHEET^NURSING^USE OF RESTRAINT^RESTRAINT GUIDELINES^0
141=Research Consent^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^CONSENT^RESEARCH^RESEARCH PROCEDURE^CONSENT^0
142=RESEARCH STUDY^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^CONSENT^RESEARCH^RESEARCH PROCEDURE^RESEARCH STUDY^0^|^^^^^2^^^^False^^False^^8925^^^True^False^;
143=Resuscitation Form^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,*Doc/Image Type^FLOWSHEET^SURGERY^INPATIENT STAY^Cardiopulmonary Resuscitation Form^0^|^^^^^2^^^^False^^False^^8925^^^True^False^;
144=RECIPT FOR FUNDS^ScannedDocument^DocumentG4^AdminDoc^SingleImage^OnLine^Multi Page^*Image Desc,*Doc/Image Type^INVENTORY OF FUNDS AND EFFECTS^^^TEMPORARY RECEIPT FOR FUNDS^0
145=Restraint Order^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^FLOWSHEET^NURSING^USE OF RESTRAINT^Restraint Guidelines^0
146=Nuc Med Radiolabeled^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^^PROCEDURE RECORD/REPORT^NUCLEAR MEDICINE^INJECTION^VA Form 10-0130^0^|^^^^^2^^^^False^^False^^8925^^^True^False^;
147=SARRTP/PRRP Medication Trmt ^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type,*Origin^MEDICATION RECORD^MENTAL HEALTH^INPATIENT STAY^Continuing Medication/Treatment Record^0
148=SARTP AGREMNT^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^*Image Desc,Specialty,*Doc/Image Type,*Origin^CONSENT^MENTAL HEALTH^^SARRTP TREATMENT AGREEMENT^0
149=SATP AGREEMENT^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type,*Origin^CONSENT^SOCIAL WORK^PATIENT EDUCATION^SARRTP TREATMENT AGREEMENT^0
150=SLUMS EXAM^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^MEDICAL RECORD^MENTAL HEALTH^HEALTH QUESTIONS/QUESTIONNAIRE^SLUMS EXAM^0^FALSE^FALSE
151=Surgery Photos^ScannedDocument^TrueColorJPG^Surgery^ImageGroup^OnLine^^^IMAGE^SURGERY^PHOTOGRAPHY^^0
152=THVC MEDICAL RECORDS^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type,*Origin^MEDICAL RECORD^NURSING^^THVC MEDICAL RECORDS^0
153=Tissue Implantation^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type,*Origin^MEDICAL RECORD^SURGERY^IMPLANT^Blood Bank Tissue Implantation Record^0
154=Transtelephonic Pacemaker F/U^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^PROCEDURE RECORD/REPORT^CARDIOLOGY^PACEMAKER PLACEMENT/MONITORING^Transtelephonic Pacemaker Report^0
155=Toxic Embedded Fragment Results^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^*Image Desc,Specialty,*Doc/Image Type^PROCEDURE RECORD/REPORT^LABORATORY^^Toxic Embedded Fragment Results^0
156=VNG^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^*Image Desc,Specialty,*Doc/Image Type^DIAGRAM^AUDIOLOGY^^VNG/ENG REPORT^0
157=UROLOGY IMAGES^ScannedDocument^TrueColorJPG^TIU^ImageGroup^OnLine^^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^IMAGE^UROLOGY^ULTRASOUND^UROLOGY ULTRASOUND^0
158=VALUABLES^ScannedDocument^DocumentG4^AdminDoc^SingleImage^OnLine^Multi Page^*Image Desc,*Doc/Image Type,*Origin^VALUABLES / BELONGINGS CHECKLIST^^^VALUABLES / BELONGINGS CHECKLIST^0
159=Philips ED Vital Signs^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^FLOWSHEET^NURSING^VITAL SIGNS^PHILIPS Vital Signs^0
160=Wound Care^Import^ImportFormat^TIU^ImageGroup^OnLine^Batch^Proc/Event,Specialty,*Doc/ Image Type^PROGRESS NOTE^NURSING^WOUND ASSESSMENT^PATIENT RECORD FLAG CATEGORY II - RESEARCH STUDY^0
161=AEU C/D^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^^PROGRESS NOTE^EMERGENCY MEDICINE^^TRIAGE ASSESSMENT FORM^0^|^^^^^2^^^^False^^False^^8925^^^True^False^;
162=CAROTID DUPLEX^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^*Image Desc,Specialty,*Doc/Image Type,*Origin^DIAGRAM^VASCULAR^^CAROTID DUPLEX EXAM^0
163=FMLA^ScannedDocument^DocumentG4^AdminDoc^SingleImage^OnLine^Multi Page^*Image Desc,*Doc/Image Type^RELEASE OF INFORMATION^^^FMLA^0
164=RX REQUEST ^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^*Image Desc,*Doc/Image Type,*Origin^MEDICAL RECORD^^^PRESCRIPTION REFILL  REQUEST^1
165=RX REQUEST^ScannedDocument^DocumentG4^AdminDoc^SingleImage^OnLine^Multi Page^*Image Desc,*Doc/Image Type^MISCELLANEOUS^^^PRESCRIPTION REFILL REQUEST^0
166=DENIAL LETTER^ScannedDocument^DocumentG4^AdminDoc^SingleImage^OnLine^Multi Page^*Image Desc,*Doc/Image Type^CORRESPONDENCE^^^DENIAL LETTER^0
167=VASCULAR LAB^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^^*Image Desc,Specialty,*Doc/Image Type,*Origin^DIAGRAM^VASCULAR^^VASCULAR LAB WORKSHEET^0
168=YELLOW SHEET^ScannedDocument^DocumentG4^AdminDoc^SingleImage^OnLine^Multi Page^*Image Desc,*Doc/Image Type^PATIENT RIGHTS AND RESPONSIBILITIES^^^PERSONAL PROPERTY AND FUNDS^0
169=UNAUTHORIZED WARD WAIVER^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,*Doc/Image Type^FLOWSHEET^^INPATIENT STAY^UNAUTHORIZED ABSENCE FROM THE WARD WAIVER^0
170=29.1 CONT. MED. TREATMENT RECORD^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type,*Origin^MEDICATION RECORD^MENTAL HEALTH^INPATIENT STAY^CONT. MED. TREATMENT RECORD^0
171=BRONCHOSCOPY^ScannedDocument^TrueColorJPG^TIU^SingleImage^OnLine^^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^PROCEDURE RECORD/REPORT^MEDICINE^BRONCHOSCOPY^BRONCHOSCOPY EXAM^0
172=ICIP^Import^ImportFormat^TIU^ImageGroup^OnLine^Batch;C:\Program Files\VistA\Imaging\imp^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^FLOWSHEET^NURSING^INPATIENT STAY^ICIP^0
173=POWER OF ATTORNEY^ScannedDocument^DocumentG4^AdminDoc^SingleImage^OnLine^Multi Page^*Image Desc,*Doc/Image Type^POWER OF ATTORNEY^^^POWER OF ATTORNEY^0
174=LEGAL DOCS^ScannedDocument^DocumentG4^AdminDoc^SingleImage^OnLine^Multi Page^^LEGAL DOCUMENTS^^^LEGAL DOCUMENTS^0
175=NONVA SCANNING^Import^ImportFormat^TIU^ImageGroup^OnLine^Batch;S:\NONVA SCANNING\^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^DISCHARGE SUMMARY^^VISIT^DISCHARGE SUMMARY^0
176=NONVA FEE^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type,*Origin^PROCEDURE RECORD/REPORT^REHABILITATIVE^PHYSICAL THERAPY^COMPANY NAME^3
177=NON VA FEE^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^*Image Desc,*Doc/Image Type,*Origin^PROCEDURE RECORD/REPORT^^^company name^3
178=HEARTLAND^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type,*Origin^PROCEDURE RECORD/REPORT^REHABILITATIVE^PHYSICAL THERAPY^HEARTLAND REHAB SERV^3
179=KY REHAB^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type,*Origin^PROCEDURE RECORD/REPORT^REHABILITATIVE^PHYSICAL THERAPY^KY REHAB ASSOCIATES^3^|^^^^^2^^^^False^^False^^8925^^^True^False^;
180=UK HEALTHCARE^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type,*Origin^MEDICAL RECORD^CARDIOLOGY^INPATIENT STAY^UK HEALTHCARE 2-26-15^3
181=FALL CARE^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^FLOWSHEET^NURSING^INPATIENT STAY^FALL CARE PLAN DATED^0^|^^^^^2^^^^False^^False^^8925^^^True^False^;
182=FALL PLAN^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^FLOWSHEET^NURSING^INPATIENT STAY^FALL CARE PLAN DATED 11-1/11-07-15^0
183=FALL CARE PLAN^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^FLOWSHEET^NURSING^INPATIENT STAY^FALL CARE PLAN & HAPU PREVENTION 5-25/28-16^0^FALSE^FALSE
184=THIRD PARTY^ScannedDocument^DocumentG4^AdminDoc^SingleImage^OnLine^Multi Page^*Image Desc,*Doc/Image Type,*Origin^REQUEST FOR INFORMATION^^^AUTHORIZATIONTO DISCLOSE PERSONAL INFOR THIRD PARTY^1
185=KORT REHAB^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type,*Origin^CONSULT^REHABILITATIVE^PHYSICAL THERAPY^KORT REHAB-3-13-15^3
186=PT PROS^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type,*Origin^PROCEDURE RECORD/REPORT^REHABILITATIVE^PHYSICAL THERAPY^PT PROS^3
187=APPALACHIAN^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type,*Origin^PROCEDURE RECORD/REPORT^REHABILITATIVE^PHYSICAL THERAPY^APPALACHIAN REHAB-4-06-15^3
188=INTEGRITY^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type,*Origin^PROCEDURE RECORD/REPORT^REHABILITATIVE^PHYSICAL THERAPY^INTEGRITY ORTHOPAEDICS SPORTS MEDICINE^3
189=HOME OXYGEN CONTRACT^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type,*Origin^VISIT RECORD^PROSTHETICS^PATIENT EDUCATION^HOME OXYGEN CONTRACT^1
190=FRACTIONAL CO2^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^CONSENT^DENTISTRY^SURGERY^FRACTIONAL CO2 LASER TREATMENT^0
191=VERBAL,VIDIO,AUDIO^ScannedDocument^DocumentG4^ClinImage^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^CONSENT^MENTAL HEALTH^^VIDEO/AUDIO^0
192=PET SCAN^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type,*Origin^PROCEDURE RECORD/REPORT^RADIOLOGY^POSITRON EMISSION TOMOGRAPHY^CLARK REGIONAL MED CTR^3
193=ORTHO^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type,*Origin^PROCEDURE RECORD/REPORT^ORTHOPEDICS^PATIENT'S TREATMENT PLAN^UK HEALTHCARE 4-10-14^3
194=CT SCAN^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type,*Origin^PROCEDURE RECORD/REPORT^RADIOLOGY^COMPUTED TOMOGRAPHY^LEX CLINIC^3
195=ALLERGY-FEE^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type,*Origin^ORDER^ALLERGY & IMMUNOLOGY^ALLERGY TESTING^ALLERGY AND IMMUNOLOGY 6-24-15^3
196=derm fee^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type,*Origin^MEDICAL RECORD^DERMATOLOGY^MISCELLANEOUS^ADVANCED DERMATOLOGY^3
197=ARTMESIA^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type,*Origin^CONSULT^ANESTHESIOLOGY^ACUPUNCTURE^ARTEMESIA COMMUNITY ACUPUNCTURE^3
198=WORK XCUSE^ScannedDocument^DocumentG4^AdminDoc^SingleImage^OnLine^Multi Page^*Image Desc,*Doc/Image Type,*Origin^MISCELLANEOUS - ADMIN^^^WORK EXCUSE^0
199=UPDRS^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^MEDICAL RECORD^NEUROLOGY^HEALTH QUESTIONS/QUESTIONNAIRE^MDS UPDRS SCORE SHEET^0
200=RADIATION THERAPY^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type,*Origin^PROCEDURE RECORD/REPORT^ONCOLOGY^RADIATION THERAPY^DANVILLE RADIATION ONCOLOGY^3
201=TH0MSON-HOOD^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^*Image Desc,Specialty,*Doc/Image Type,*Origin^MEDICAL RECORD^NURSING^^THOMSON HOOD MEDICAL RECORDS^0^FALSE^FALSE
202=COMPANION WORKSHEET^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^FLOWSHEET^NURSING^INPATIENT STAY^COMPANION/SITTER  & COMPANION WORKSHEET-VARIOUS DATES^0^FALSE^FALSE
203=SOLID GASTIC^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^^*Image Desc,Specialty,*Doc/Image Type^PROCEDURE RECORD/REPORT^NUCLEAR MEDICINE^^SOLID PHASE GASTRIC EMPTYING STUDY^0^FALSE^FALSE
204=WITHDRAWAL ASSESS^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^*Image Desc,Specialty,*Doc/Image Type^FLOWSHEET^EMERGENCY MEDICINE^^ALCOHOL WITHDRAWAL ASSESSMENT FLOWSHEET^0^FALSE^FALSE
205=PRESSURE-UROL^ScannedDocument^DocumentG4^TIU^ImageGroup^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^PROCEDURE RECORD/REPORT^UROLOGY^^PRESSURE -flow study RESULTS^0^FALSE^FALSE
206=DESIGNEE^ScannedDocument^DocumentG4^AdminDoc^SingleImage^OnLine^Multi Page^*Image Desc,*Doc/Image Type^MISCELLANEOUS - ADMIN^^^DESIGNEE FOR PT PERSONAL PROPERTY^0^FALSE^FALSE
207=VNG/ENG Report^ScannedDocument^TrueColorJPG^TIU^ImageGroup^OnLine^^Proc/Event,*Image Desc,*Doc/Image Type^DIAGRAM^AUDIOLOGY^ELECTRONYSTAGMOGRAM^VNG/ENG Report^0
208=VET TRANFER^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^CONSENT^MEDICINE^INTER-FACILITY TRANSFER^VETERAN'S  PREFERENCE TO TRANSFER^0
209=PINK EKGS^ScannedDocument^TrueColorJPG^TIU^SingleImage^OnLine^^*Image Desc,Specialty,*Doc/Image Type,*Origin^FLOWSHEET^CARDIOLOGY^^EKG STRIPS^0^FALSE^FALSE
210=HOSPICE^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type,*Origin^MEDICAL RECORD^NURSING^HOME VISIT^HOSPICE OF THE BLUEGRASS 7-6-16^3^FALSE^FALSE
211=AC-MI HEPARIN ^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^*Image Desc,Specialty,*Doc/Image Type,*Origin^FLOWSHEET^NURSING^^AC-MI HEPARIN PROTOCOL^0^FALSE^FALSE
212=REQUEST FOR AUTOPSY^ScannedDocument^DocumentG4^AdminDoc^SingleImage^OnLine^Multi Page^*Image Desc,*Doc/Image Type,*Origin^REQUEST FOR AUTOPSY^^^AUTHORIZATION FOR AUTOPSY^0^FALSE^FALSE
213=SLEEP STUDY^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,Specialty,*Doc/Image Type^MEDICAL RECORD^PULMONARY^SLEEP STUDY^^0^FALSE^FALSE
214=NURSING DOCUMENT^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type,*Origin^FLOWSHEET^NURSING^INPATIENT STAY^NURSING DOCUMENTATION^0^FALSE^FALSE
215=VERBAL,PHOTO USE OF ^ScannedDocument^DocumentG4^AdminDoc^SingleImage^OnLine^Multi Page^*Image Desc,*Doc/Image Type^MISCELLANEOUS - ADMIN^^^CONSENT FOR USE OF VERBAL STATEMENTS,PHOTO & VIDEO^0^FALSE^FALSE
216=UROLOGY ^ScannedDocument^TrueColorJPG^TIU^SingleImage^OnLine^^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^IMAGE^UROLOGY^ULTRASOUND^UROLOGY ULTRASOUND^0^FALSE^FALSE
217=order glasses^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^Proc/Event,*Image Desc,Specialty,*Doc/Image Type^ORDER^OPTOMETRY^VISUAL FIELD^ORDER FOR GLASSES^0^FALSE^FALSE
218=EKVC 10-10SH^ScannedDocument^DocumentG4^AdminDoc^SingleImage^OnLine^Multi Page^*Image Desc,*Doc/Image Type,*Origin^MEDICAL CERTIFICATE^^^EKVC 10-10SH^0
219=EKVC MEDICAL RECORDS^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^*Image Desc,Specialty,*Doc/Image Type,*Origin^MEDICAL RECORD^NURSING^^EKVC MEDICAL RECORDS^0
220=THVC MED^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^*Image Desc,Specialty,*Doc/Image Type,*Origin^MEDICAL RECORD^NURSING^^THVC MEDICAL RECORDS^0^FALSE^FALSE
221=THVC 10-10SH^ScannedDocument^DocumentG4^AdminDoc^SingleImage^OnLine^Multi Page^*Image Desc,*Doc/Image Type,*Origin^MEDICAL CERTIFICATE^^^THVC 10-10SH^0
222=HEALTH INSURANCE^ScannedDocument^DocumentG4^AdminDoc^SingleImage^OnLine^Multi Page^^HEALTH INSURANCE CARDS^^^HEALTH INSURANCE CARDS^0
223=Health Ins Card^ScannedDocument^DocumentG4^AdminDoc^SingleImage^OnLine^Multi Page^^HEALTH INSURANCE CARDS^^^HEALTH INSURANCE CARDS^0^FALSE^FALSE
224=CHOICE OPT-IN^ScannedDocument^DocumentG4^TIU^SingleImage^OnLine^Multi Page^*Image Desc,Specialty,*Doc/Image Type^CONSENT^MEDICINE^^CHOICE OPT-IN NOTE^0^FALSE^FALSE^|^^^^^2^^^^False^^False^^8925^^^True^False^;
[Import Directories]
C:\Program Files\VistA\Imaging\=TRUE
C:\Program Files\VistA\Imaging\Import\=TRUE
H:\Fee Import\=TRUE
Z:\=TRUE
Z:\FEE BASIS IMPORT\=TRUE
Z:\Lisa's FBCS\=TRUE
D:\=TRUE
S:\NONVA SCANNING\=TRUE
C:\Users\VHALEXMURPHL\AppData\Local\Microsoft\Windows\Burn\Burn\=TRUE
[choice_Input Source_Default]
1=Lumisys75
3=Lumisys150
6=Meteor
7=Import
8=TWAIN
11=ScannedDocument
12=ClipBoard
[choice_Image Format_Default]
1=True Color TGA
2=True Color JPG
3=256 Color
4=Xray
5=Xray JPG
6=Black and White
7=Document TIF Uncompressed
8=Document TIF G4 FAX
9=Motion Video
10=Audio
11=Bitmap
12=DICOM
[Choice_Image Association_Default]
1=LAB
2=MED
3=RAD
4=SUR
5=NOTES
6=CLINPROC
7=PHOTOID
8=CLINIMAGE
9=ADMINDOC
10=TRCONSULT
[Choice_Button/Field Options_ImageDesc]
1=Selected (Windows default)
2=NoSelectCursorEnd
3=NoSelectCursorHome
[Choice_Medicine Options_Create New/List Existing]
1=Create New
2=List Existing
[choice_SaveOptions_default]
1=GROUP
2=SINGLE
[Import Options]
Type=Copy to Server
DefaultImportDir=C:\Program Files\VistA\Imaging\import
DefaultMask=*.*
[Choice_Import Options_Type]
1=Copy to Server
2=Convert to TGA
3=Convert File Format to Default
[SYS_Meteor]
INTERACTIVE=TRUE"


