#
#
#
#
#
# open the file in the write mode
f = open('file.xml', 'w')

#Headersand Footers Deviders
pre_virt_sequence="<entry key=\"macroSequence\" value=" ; post_virt="/>" ; padding = "&amp;&amp;" ; output = "" ; delay = "d 500" # Delay, example: "d 500" will delay 500ms

#Make an array for each key on the keyboard and place its value in another joined array
def KeyboardMap(key):
    keyschar = [['ESC','F1','F2','F3','F4','F5','F6','F7','F8','F9','F10','F11','F12','`','1','2','3','4','5','6','7','8','9','0','-','=','Backspace','Tab','q','w','e','r','t','y','u','i','o','p','[',']','\\','Cap_Lock','a','s','d','f','g','h','j','k','l',';','\'','Enter','Left_Shift','z','x','c','v','b','n','m',',','.','Forward_Slash','Right_Shift','Left_Ctrl','Windows_Key','Left_Alt','Space','Right_Alt','Right_Ctrl','Left_Arrow','Down_Arrow','Right_Arrow','Up_Arrow','Delay'],['59','60','61','62','63','64','65','66','67','68','69','70','71','0','1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','40','28','29','30','31','32','33','34','35','36','37','38','39','27','41','43','44','45','46','47','48','49','50','51','52','53','54','105','55','56','57','58','82','83','84','81','500']]
    keynum = keyschar[1][(keyschar[0].index(key))]
    return keynum

#Make each key pressed, released and buffer added between
def KeyPress(key):
    if (key) == 'Delay':
        result = "d "+ str(key) + padding + delay + padding
    else:
        result = "p "+ str(key) + padding + "r " + str(key) + padding + delay + padding
    return result

#This is the portion the user would chnage, [Keypress][TimesToPress] / F12 = 2mins so 120sec, 240times / Enter = 30sec , 60times / Delay = 4mins , (500*2)*60=480
#HP
key_seq = [['F12','Enter','Delay','Tab','Enter','Down_Arrow','Enter'],[120,60,240,2,1,11,1]]

# Blue screenvars (Press S,Press Tab,Press L, Press tab,Type LEX-WS)


#Dell
#key_seq = [['F12','Down_Arrow','Enter','Delay','Tab','Enter','Down_Arrow','Enter'],[120,3,60,240,2,1,11,1]]
#Times tested on a OPtiPlex Micro 7010

# Get into PXE Boot
#   Press F12 alot to get to boot menu
#   Go down 3 times to Onboard NIC-->Press Entere many time to catch PXE boot
# Wait
# Microsoft Deploment Toolkit Image selection and start
#   Press tab 2 times to get Task Sequence to "Next" button
#   Press Enter to activate next button
# Go down to PRD (this may change over time)
#   Press Down 11 times 
#   Press Enter to activate Next button


#Find the key pressed in key_seq and return its value from keychar 2d array's second array
key_value = []
for i in key_seq[0]:
    key_value.append(KeyboardMap(i))

#Main Command that makes the output
for c in range(len(key_value)):  #len(key_seq) counts the size of array example : 2
    output=output+(KeyPress(key_value[c])* key_seq[1][c]) #prints Keypress(key_seq[0][1] * key_seq[1][1]) that equals = print (KeyPress(f12)* 1 )  aka print KeyPress(71)*1

#Print the fruits of our labor
pre_edit_sequence="<entry key=\"EditSequence\" value="
pre_virt_sequence="<entry key=\"VirtKeySequence\" value="
post_sequence="/>"
sequence_type = ["Edit","VirtKey"]
seperator = ";"
commnads= (output.rstrip(padding)) #.rstrip(padding) remove the last "&amp;&amp;" from the output before printing

with open("file.xml", "w") as file:
    file.write(f'''<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!DOCTYPE preferences SYSTEM "http://java.sun.com/dtd/preferences.dtd">
<preferences EXTERNAL_XML_VERSION="1.0">
	<root type="user">
		<map/>
		<node name="HkcKeyboardMacros">
			<map/>
			<node name="HP Boot to Windows">
				<map>
					<entry key="hotKey" value="-1"/>
					<entry key="macroSequence" value="{commnads}"/>
                    <entry key="name" value="thething"/>
				</map>
			</node>
		</node>
	</root>
</preferences>''')
    file.close()



    #file.write(pre_edit_sequence)

#Sources
#https://stackoverflow.com/questions/176918/finding-the-index-of-an-item-in-a-list
#https://stackoverflow.com/questions/6081174/how-to-store-variables-in-arraylist-in-python
#https://stackoverflow.com/questions/71362834/how-would-i-perform-an-operation-on-each-element-in-an-array-and-add-the-new-val
#https://www.askpython.com/python/array/initialize-a-python-array
#https://www.educba.com/multidimensional-array-in-python/
#https://flexiple.com/python/length-of-array-python/
#https://stackoverflow.com/questions/42587342/python-how-to-use-a-string-index-010-as-the-index-for-a-multidimens
#https://stackoverflow.com/questions/3877623/can-you-have-variables-within-triple-quotes-if-so-how
#https://www.w3schools.com/python/python_conditions.asp
#
#Notes:
#I have discovered that the xml is invlaid if the extension is not all lowercase. Very odd I know