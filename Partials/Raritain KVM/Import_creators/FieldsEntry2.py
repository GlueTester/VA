#Stich for variable to gether repeating one X times

enter = "27"
tab = "14"
delay = "d 500"
downarrow = "83"
r= "18"
zero= "10"
three = "3"
v = "46"
nine = "9"
l = "37"
e = "17"
x = "44"

strike_enter = "p " + enter + "&amp;&amp;" + "r " + enter

#Headersand Footers Deviders
pre_virt_sequence="					<entry key=\"macroSequence\" value="
post_virt="/>"
virt_key_seperator = "&amp;&amp;"

#Combined Virt Key combos
#irt_1st_keycombo = virt_press + virt_key_f12 + virt_key_seperator + virt_release + virt_key_f12 + virt_key_seperator + virt_delay
#virt_2nd_keycombo = virt_key_seperator + virt_1st_keycombo
#virt_2nd_keycombo = virt_2nd_keycombo*f12_key_press_count

Regionfields = strike_enter + virt_key_seperator +  delay

#virt_forth_key_set = virt_third_key_set*enter_key_press_count

#print(f"{pre_virt_sequence}\"{virt_1st_keycombo}{virt_2nd_keycombo}{virt_third_key_set}{virt_forth_key_set}\"{post_virt}")

print Regionfields 

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