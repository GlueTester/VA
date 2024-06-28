#Stich for variable to gether repeating one X times
repeat_ammount = 90
edit_key1 = "56" #F12
edit_delay = "s113" #100ms
virt_key1 = "71" #F12
virt_delay = "s100" #100ms


#Headersand Footers Deviders
pre_edit_sequence="<entry key=\"EditSequence\" value="
pre_virt_sequence="<entry key=\"VirtKeySequence\" value="
post_sequence="/>"
sequence_type = ["Edit","VirtKey"]
seperator = ";"

#EditSequence
edit_press = "p"+edit_key1
edit_release = "r"+edit_key1

#VirtKeySequence
virt_press ="p"+virt_key1
virt_release= "r"+virt_key1 

#Combined Edit Key sets
edit_first_key_set = edit_press+seperator+edit_release+seperator+edit_delay
edit_second_key_set = seperator+edit_first_key_set
edit_second_key_set =  edit_second_key_set*repeat_ammount
#Combined Virt Key sets
virt_first_key_set = virt_press+seperator+virt_release+seperator+virt_delay
virt_second_key_set = seperator+virt_first_key_set
virt_second_key_set = virt_second_key_set*repeat_ammount

for sequence in sequence_type:
    if sequence == "Edit":
        print (f"{pre_edit_sequence}\"{edit_first_key_set}{edit_second_key_set}\"{post_sequence}")
    elif sequence == "VirtKey":
        print(f"{pre_virt_sequence}\"{virt_first_key_set}{virt_second_key_set}\"{post_sequence}")
