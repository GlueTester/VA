import io
import codecs

versionfilename = "fileversion.txt"
filversion = ('6.6.7.09')
assembly_version = filversion
comments = 'Created and maintained by Russell King | russell.king1@va.gov'
companyname = 'Veterans Administration'
filedescription = 'A tool to combine several tools and process that local technition rely on'
internalname = 'EzAdmin.exe'
legalcopyright = 'Copyright ©2024 BlackBerry Limited. All Rights Reserved'
legaltrademarks = ''
originalfilename = 'GUI_Main_v1.exe'
productname = 'Admin Tool (Working title)'


filevers = filversion.replace(".",", ")
prodvers = filevers
a = (f"""# UTF-8
#
# For more details about fixed file info 'ffi' see:
# http://msdn.microsoft.com/en-us/library/ms646997.aspx
VSVersionInfo(
  ffi=FixedFileInfo(
    # filevers and prodvers should be always a tuple with four items: (1, 2, 3, 4)
    # Set not needed items to zero 0.
    filevers=({filevers}),
    prodvers=({prodvers}),
    # Contains a bitmask that specifies the valid bits 'flags'r
    mask=0x3f,
    # Contains a bitmask that specifies the Boolean attributes of the file.
    flags=0x0,
    # The operating system for which this file was designed.
    # 0x4 - NT and there is no need to change it.
    OS=0x4,
    # The general type of file.
    # 0x1 - the file is an application.
    fileType=0x1,
    # The function of the file.
    # 0x0 - the function is not defined for this fileType
    subtype=0x0,
    # Creation date and time stamp.
    date=(0, 0)
    ),
  kids=[
    VarFileInfo([VarStruct('Translation', [0, 1200])]), 
    StringFileInfo(
      [
      StringTable(
        '000004b0',
        [StringStruct('Comments', '{comments}'),
        StringStruct('CompanyName', '{companyname}'),
        StringStruct('FileDescription', '{filedescription}'),
        StringStruct('FileVersion', '{filversion}'),
        StringStruct('InternalName', '{internalname}'),
        StringStruct('LegalCopyright', '{legalcopyright}'),
        StringStruct('LegalTrademarks', '{legaltrademarks}'),
        StringStruct('OriginalFilename', '{originalfilename}'),
        StringStruct('ProductName', '{productname}'),
        StringStruct('ProductVersion', '{filversion}'),
        StringStruct('Assembly Version', '{assembly_version}')])
      ])
  ]
)
    """)


#f= codecs.open( versionfilename, "w", "utf-8")
f = io.open( versionfilename, mode='w', encoding='utf8')
f.write( a )
f.close()
#open(versionfilename, "rb").read(50)

#Sources:
# https://pyinstaller.org/en/stable/usage.html
# https://stackoverflow.com/questions/43823824/how-do-you-add-a-manifest-to-pyinstaller-compiled-exe
# https://stackoverflow.com/questions/71057636/how-can-i-solve-no-module-named-pyi-splash-after-using-pyinstaller
# https://stackoverflow.com/questions/36571560/directing-print-output-to-a-txt-file
# https://stackoverflow.com/questions/1900956/write-variable-to-file-including-name
# https://stackoverflow.com/questions/34980251/how-to-print-multiple-lines-of-text-with-python
# https://stackoverflow.com/questions/1520548/how-does-pythons-triple-quote-string-work
# https://stackoverflow.com/questions/6116978/how-to-replace-multiple-substrings-of-a-string
# https://stackoverflow.com/questions/6116978/how-to-replace-multiple-substrings-of-a-string




#https://pypi.org/project/pyinstaller-versionfile/
#https://pypi.org/project/pyinstaller-versionfile/
