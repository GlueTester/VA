#import numpy

#Stich for variable to gether repeating one X times
enter = "27"
tab = "14"
delay = "d 500"
downarrow = "83"
space = "56"
r= "18"
zero= "10"
three = "3"
v = "46"
nine = "9"
l = "37"
e = "17"
x = "44"
w = "16"
i = "22"
n = "48"
one = "1"
c = "45"
a = "29"
s = "30"
two = "2"
e = "17"
f = "32"

#keyschar = ['ESC','F1','F2','F3','F4','F5','F6','F7','F8','F9','F10','F11','F12','`','1','2','3','4','5','6','7','8','9','0','-','=','Backspace','Tab','q','w','e','r','t','y','u','i','o','p','[',']','\\','Cap_Lock','a','s','d','f','g','h','j','k','l',';','\'','Enter','Left_Shift','z','x','c','v','b','n','m',',','.','Forward_Slash','Right_Shift','Left_Ctrl','Windows_Key','Left_Alt','Space','Right_Alt','Right_Ctrl','Left_Arrow','Down_Arrow','Right_Arrow','Up_Arrow']
#keycodes = ['59','60','61','62','63','64','65','66','67','68','69','70','71','0','1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','40','28','29','30','31','32','33','34','35','36','37','38','39','27','41','43','44','45','46','47','48','49','50','51','52','53','54','105','55','56','57','58','82','83','84','81']

#Caps words are buttons 
#esc f1-12
#`1234567890-=BACKSPACE
#TABqwertyuiop[]\
#CAPSasdfghjkl;'ENTER
#SHIFTzxcvbnm,./SHIFT
#CTRL WINDOWS ALT SPACE ALT FN CTRL LEFTARROW DOWNARROW RIGHTARROW UPARROW

#Below is coraspondig string
#<entry key="macroSequence" value="p 59&amp;&amp;r 59&amp;&amp;p 60&amp;&amp;r 60&amp;&amp;p 61&amp;&amp;r 61&amp;&amp;p 62&amp;&amp;r 62&amp;&amp;p 63&amp;&amp;r 63&amp;&amp;p 64&amp;&amp;r 64&amp;&amp;p 65&amp;&amp;r 65&amp;&amp;p 66&amp;&amp;r 66&amp;&amp;p 67&amp;&amp;r 67&amp;&amp;p 68&amp;&amp;r 68&amp;&amp;p 69&amp;&amp;r 69&amp;&amp;p 70&amp;&amp;r 70&amp;&amp;p 71&amp;&amp;r 71&amp;&amp;p 0&amp;&amp;r 0&amp;&amp;p 1&amp;&amp;r 1&amp;&amp;p 2&amp;&amp;r 2&amp;&amp;p 3&amp;&amp;r 3&amp;&amp;p 4&amp;&amp;r 4&amp;&amp;p 5&amp;&amp;r 5&amp;&amp;p 6&amp;&amp;r 6&amp;&amp;p 7&amp;&amp;r 7&amp;&amp;p 8&amp;&amp;r 8&amp;&amp;p 9&amp;&amp;r 9&amp;&amp;p 10&amp;&amp;r 10&amp;&amp;p 11&amp;&amp;r 11&amp;&amp;p 12&amp;&amp;r 12&amp;&amp;p 13&amp;&amp;r 13&amp;&amp;p 14&amp;&amp;r 14&amp;&amp;p 15&amp;&amp;r 15&amp;&amp;p 16&amp;&amp;r 16&amp;&amp;p 17&amp;&amp;r 17&amp;&amp;p 18&amp;&amp;r 18&amp;&amp;p 19&amp;&amp;r 19&amp;&amp;p 20&amp;&amp;r 20&amp;&amp;p 21&amp;&amp;r 21&amp;&amp;p 22&amp;&amp;r 22&amp;&amp;p 23&amp;&amp;r 23&amp;&amp;p 24&amp;&amp;r 24&amp;&amp;p 25&amp;&amp;r 25&amp;&amp;p 26&amp;&amp;r 26&amp;&amp;p 40&amp;&amp;r 40&amp;&amp;p 28&amp;&amp;r 28&amp;&amp;p 29&amp;&amp;r 29&amp;&amp;p 30&amp;&amp;r 30&amp;&amp;p 31&amp;&amp;r 31&amp;&amp;p 32&amp;&amp;r 32&amp;&amp;p 33&amp;&amp;r 33&amp;&amp;p 34&amp;&amp;r 34&amp;&amp;p 35&amp;&amp;r 35&amp;&amp;p 36&amp;&amp;r 36&amp;&amp;p 37&amp;&amp;r 37&amp;&amp;p 38&amp;&amp;r 38&amp;&amp;p 39&amp;&amp;r 39&amp;&amp;p 27&amp;&amp;r 27&amp;&amp;p 41&amp;&amp;r 41&amp;&amp;p 43&amp;&amp;r 43&amp;&amp;p 44&amp;&amp;r 44&amp;&amp;p 45&amp;&amp;r 45&amp;&amp;p 46&amp;&amp;r 46&amp;&amp;p 47&amp;&amp;r 47&amp;&amp;p 48&amp;&amp;r 48&amp;&amp;p 49&amp;&amp;r 49&amp;&amp;p 50&amp;&amp;r 50&amp;&amp;p 51&amp;&amp;r 51&amp;&amp;p 52&amp;&amp;r 52&amp;&amp;p 53&amp;&amp;r 53&amp;&amp;p 54&amp;&amp;r 54&amp;&amp;p 105&amp;&amp;r 105&amp;&amp;p 55&amp;&amp;r 55&amp;&amp;p 56&amp;&amp;r 56&amp;&amp;p 57&amp;&amp;r 57&amp;&amp;p 58&amp;&amp;r 58&amp;&amp;p 82&amp;&amp;r 82&amp;&amp;p 83&amp;&amp;r 83&amp;&amp;p 84&amp;&amp;r 84&amp;&amp;p 81&amp;&amp;r 81"/>

#Headersand Footers Deviders
pre_virt_sequence="<entry key=\"macroSequence\" value="
post_virt="/>"
key_seperator = "&amp;&amp;"
postkey = key_seperator + delay + key_seperator

def KeyPress(key):
    result = "p " + key  + "&amp;&amp;" + "r " + key
    return result


Baseline = KeyPress(tab) + postkey + KeyPress(enter) + postkey + KeyPress(tab) + postkey + KeyPress(tab) + postkey + KeyPress(w) + key_seperator + KeyPress(i) + key_seperator + KeyPress(n) + key_seperator + KeyPress(one) + key_seperator + KeyPress(zero) + key_seperator + KeyPress(tab) + postkey + KeyPress(enter) + postkey 
VariablesCollectionID = KeyPress(tab) + postkey + KeyPress(tab) + postkey + KeyPress(tab) + postkey + KeyPress(downarrow) + postkey + KeyPress(tab) + postkey+ KeyPress(enter) + postkey + KeyPress(tab) + postkey + KeyPress(tab) + key_seperator + KeyPress(c) + key_seperator + KeyPress(a) + key_seperator + KeyPress(s) + key_seperator + KeyPress(zero) + key_seperator + KeyPress(zero) + key_seperator + KeyPress(two) + key_seperator + KeyPress(e) + key_seperator + KeyPress(f) + postkey + KeyPress(tab) + postkey + KeyPress(enter)+ postkey #+ KeyPress(tab) + postkey + KeyPress(tab)# + postkey + KeyPress(enter) + postkey
VASiteCode = KeyPress(tab) + postkey + KeyPress(tab) + postkey + KeyPress(tab) + postkey + KeyPress(downarrow) + postkey + KeyPress(tab) + postkey+ KeyPress(enter) + postkey + KeyPress(tab) + postkey + KeyPress(tab) + postkey + KeyPress(r) + key_seperator + KeyPress(zero) + key_seperator + KeyPress(three) + key_seperator + KeyPress(v) + key_seperator + KeyPress(zero) + key_seperator + KeyPress(nine) + key_seperator + KeyPress(l) + key_seperator + KeyPress(e) + key_seperator + KeyPress(x) + postkey + KeyPress(tab) + postkey + KeyPress(enter) + postkey + KeyPress(tab) + postkey + KeyPress(enter)
AllFields = Baseline + VariablesCollectionID + VASiteCode
print (f"{pre_virt_sequence}\"{AllFields}\"{post_virt}")

#tab,500,space,500,tab,500,tab, 500,w,i,n,1,0,500,tab,500,enter,500,
#tab,500,tab,500,tab,500,downarrow,500,tab,500,space,500,tab,500,tab,c,a,s,0,0,e,f,500,tab,500,enter,500,
#tab,500,tab,500,tab,500,downarrow,500,tab,500,enter,500,tab,500,tab,500,r,0,3,v,0,9,l,e,x,500,enter,500,tab,500,enter










#below is block comented out and is the layout of ALL users scripts. 
###
#<?xml version="1.0" encoding="UTF-8" standalone="no"?>
#<!DOCTYPE preferences SYSTEM "http://java.sun.com/dtd/preferences.dtd">
#<preferences EXTERNAL_XML_VERSION="1.0">
#	<root type="user">
#		<map/>
#		<node name="HkcKeyboardMacros">
#			<map/>
#			<node name="thething">
#				<map>
#					<entry key="hotKey" value="-1"/>
#					<entry key="macroSequence" value=""/>
#					<entry key="name" value="thething"/>
#				</map>
#			</node>
#			<node name="thething2">
#				<map>
#					<entry key="hotKey" value="-1"/>
#					<entry key="macroSequence" value="d 500&amp;&amp;d 500&amp;&amp;d 500&amp;&amp;d 500&amp;&amp;p 14&amp;&amp;r 14&amp;&amp;p 27&amp;&amp;r 27&amp;&amp;p 18&amp;&amp;r 18"/>
#					<entry key="name" value="thething2"/>
#				</map>
#			</node>
#			<node name="F12guy">
#				<map>
#					<entry key="hotKey" value="-1"/>
#					<entry key="macroSequence" value="p 71&amp;&amp;r 71&amp;&amp;d 500&amp;&amp;p 71&amp;&amp;r 71"/>
#					<entry key="name" value="F12guy"/>
#				</map>
#			</node>
#		</node>
#	</root>
#</preferences>
###