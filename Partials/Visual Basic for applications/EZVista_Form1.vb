


Private Sub UserForm_Initialize()
Site_ComboBox.AddItem "Bowling"
Site_ComboBox.AddItem "Sousley"
SpecialtyPrinterBox_Yes_No.AddItem "Yes"
SpecialtyPrinterBox_Yes_No.AddItem "No"
Intermec_answer_ComboBox1.AddItem "Yes"
Intermec_answer_ComboBox1.AddItem "No"
Printer_Vars_SubType_ComboBox.AddItem "P-TCP96HPLASER"
Printer_Vars_SubType_ComboBox.AddItem "P-TCP96HPLASER R3"
Printer_Vars_SubType_ComboBox.AddItem "P-TCP96HPLASER R3 ENC"
Printer_Vars_SubType_ComboBox.AddItem "P-TCP96HPLASER-LANDSCAPE"
PrinterNameDP_PT_ComboBox.AddItem "LEX-DP"
PrinterNameDP_PT_ComboBox.AddItem "LEX-PT"
PrinterName_Services_ComboBox.AddItem "IMS"
PrinterName_Services_ComboBox.AddItem "CODE"
PrinterName_Services_ComboBox.AddItem "ER"
PrinterName_Services_ComboBox.AddItem "DIR"
OpenParameters_value.text = """NWS"""

End Sub


Private Sub PrinterNameDP_PT_ComboBox_Change()

End Sub


Private Sub PrinterName_Services_ComboBox_Change()

End Sub

Private Sub PrinterName_Userfield_Change()
    HostnameMNEMONIC_value.caption = PrinterNameDP_PT_ComboBox.text & PrinterName_Services_ComboBox.text & PrinterName_Userfield.text
    If PrinterNameDP_PT_ComboBox.text = "LEX-PT" Then
        NewSetup_VistaPrinterName_vaule.text = "LEX_PT" & PrinterName_Services_ComboBox.text & PrinterName_Userfield.text
    ElseIf PrinterNameDP_PT_ComboBox.text = "LEX-DP" Then
        NewSetup_VistaPrinterName_vaule.text = "LEX_DP" & PrinterName_Services_ComboBox.text & PrinterName_Userfield.text
    End If
End Sub



Private Sub Octet1_Change()
Dim Hb As String: Hb = Octet1.text
If IsNumeric(Hb) Then
   Dim HbInt As Integer: HbInt = CInt(Hb)
   If HbInt > 0 And HbInt <= 255 Then
      IP_octet1 = Octet1.text
   Else
      MsgBox "Number Entered is out of Range"
   End If
Else
   MsgBox "Invalid Input."
End If
End Sub

Private Sub Octet2_Change()
Dim Hb2 As String: Hb2 = Octet2.text

If IsNumeric(Hb2) Then
   Dim Hb2Int As Integer: Hb2Int = CInt(Hb2)
   If Hb2Int > 0 And Hb2Int <= 255 Then
      IP_octet2 = Octet2.text
   Else
      MsgBox "Number Entered is out of Range"
   End If
Else
   MsgBox "Invalid Input."
End If
End Sub

Private Sub Octet3_Change()
Dim Hb3 As String: Hb3 = Octet3.text

If IsNumeric(Hb3) Then
   Dim Hb3Int As Integer: Hb3Int = CInt(Hb3)
   If Hb3Int > 0 And Hb3Int <= 255 Then
      IP_octet3 = Octet3.text
   Else
      MsgBox "Number Entered is out of Range"
   End If
Else
   MsgBox "Invalid Input."
End If
End Sub

Private Sub Octet4_Change()
Dim Hb4 As String: Hb4 = Octet4.text

If IsNumeric(Hb4) Then
   Dim Hb4Int As Integer: Hb4Int = CInt(Hb4)
   If Hb4Int > 0 And Hb4Int <= 255 Then
      IP_octet4 = Octet4.text
      WindowsIp_value.caption = Octet1.text & "." & Octet2.text & "." & Octet3.text & "." & Octet4.text
      CUPSIP_value.caption = Octet1.text & "X" & Octet2.text & "X" & Octet3.text & "X" & Octet4.text
      DeviceI_value.text = "LEX_PQ$:LEX_" & CUPSIP_value.caption & ".TXT"
   Else
      MsgBox "Number Entered is out of Range"
   End If
Else
   MsgBox "Invalid Input."
End If
End Sub


Private Sub SpecialtyPrinterBox_Yes_No_Change()
    If SpecialtyPrinterBox_Yes_No = "Yes" Then
        Intermec_answer_ComboBox1.Visible = True
        IntermecQuestion_Txt.Visible = True
    Else
        Intermec_answer_ComboBox1.Visible = False
        IntermecQuestion_Txt.Visible = False
    End If
End Sub




Private Sub Printer_Vars_SubType_ComboBox_Change()
NewSetup_SubType_vaule.text = Printer_Vars_SubType_ComboBox.text
End Sub


Private Sub Intermec_answer_ComboBox1_Change()

If Intermec_answer_ComboBox1.text = "Yes" Then
    OpenParameters_value.text = """NWU"""
Else
    OpenParameters_value.text = """NWS"""
End If

End Sub


Private Sub Site_ComboBox_Change()
If Site_ComboBox.text = "Bowling" Then
    Building_ComboBox.AddItem "Main"
    Building_ComboBox.AddItem "Tower"
ElseIf Site_ComboBox.text = "Sousley" Then
    Building_ComboBox.AddItem "Building 1"
    Building_ComboBox.AddItem "Building 2"
    Building_ComboBox.AddItem "Building 3"
    Building_ComboBox.AddItem "Building 4"
    Building_ComboBox.AddItem "Building 12"
    Building_ComboBox.AddItem "Building 16"
    Building_ComboBox.AddItem "Building 17"
    Building_ComboBox.AddItem "Building 25"
    Building_ComboBox.AddItem "Building 27"
    Building_ComboBox.AddItem "Building 28"
    Building_ComboBox.AddItem "Building 29"
End If
End Sub

Private Sub Room_ComboBox_Change()
    
End Sub

Private Sub Location_Room_ComboBox_Change()

If Building_ComboBox.text = "Building 1" Then
    NewSetup_LocationOfTerminal_value.text = "BLDG 1 RM " & Location_Room_ComboBox.text
ElseIf Building_ComboBox.text = "Building 2" Then
    NewSetup_LocationOfTerminal_value.text = "BLDG 2 RM " & Location_Room_ComboBox.text
ElseIf Building_ComboBox.text = "Building 3" Then
    NewSetup_LocationOfTerminal_value.text = "BLDG 3 RM " & Location_Room_ComboBox.text
ElseIf Building_ComboBox.text = "Building 4" Then
    NewSetup_LocationOfTerminal_value.text = "BLDG 4 RM" & Location_Room_ComboBox.text
ElseIf Building_ComboBox.text = "Building 12" Then
    NewSetup_LocationOfTerminal_value.text = "BLDG 12 RM " & Location_Room_ComboBox.text
ElseIf Building_ComboBox.text = "Building 16" Then
    NewSetup_LocationOfTerminal_value.text = "BLDG 16 RM " & Location_Room_ComboBox.text
ElseIf Building_ComboBox.text = "Building 17" Then
    NewSetup_LocationOfTerminal_value.text = "BLDG 17 RM " & Location_Room_ComboBox.text
ElseIf Building_ComboBox.text = "Building 25" Then
    NewSetup_LocationOfTerminal_value.text = "BLDG 25 RM " & Location_Room_ComboBox.text
ElseIf Building_ComboBox.text = "Building 27" Then
    NewSetup_LocationOfTerminal_value.text = "BLDG 27 RM " & Location_Room_ComboBox.text
ElseIf Building_ComboBox.text = "Building 28" Then
    NewSetup_LocationOfTerminal_value.text = "BLDG 28 RM " & Location_Room_ComboBox.text
ElseIf Building_ComboBox.text = "Building 29" Then
    NewSetup_LocationOfTerminal_value.text = "BLDG 29 RM " & Location_Room_ComboBox.text
ElseIf Building_ComboBox.text = "Main" Then
    NewSetup_LocationOfTerminal_value.text = "BLDG Main RM " & Location_Room_ComboBox.text
ElseIf Building_ComboBox.text = "Tower" Then
    NewSetup_LocationOfTerminal_value.text = "BLDG Tower RM " & Location_Room_ComboBox.text

End If

End Sub

Private Sub NewSetup_LocationOfTerminal_value_Change()
SubmitButton.Enabled = True
SubmitButton.caption = "Deploy Visat Printer: " & NewSetup_VistaPrinterName_vaule.text
End Sub







Private Sub SubmitButton_Click()

    Dim osCurrentScreen As Screen
    Dim osCurrentTerminal As Terminal
    Dim returnValue As Integer
    
    
    
    Const NEVER_TIME_OUT = 0
    
    Dim LF As String    ' Chr(rcLF) = Chr(10) = Control-J
    Dim CR As String    ' Chr(rcCR) = Chr(13) = Control-M
    
    Set osCurrentTerminal = ThisFrame.SelectedView.control
    Set osCurrentScreen = osCurrentTerminal.Screen
    
    LF = Chr(10)
    CR = Chr(13)
    
    'Wait for Select IM Hardware Staff Menu Option: or go ^
    Do
    ThisFrame.StatusBarText = "In the Do"
    returnValue = osCurrentScreen.WaitForString3(LF & "Select IM Hardware Staff Menu Option: ", 4000, WaitForOption.WaitForOption_AllowKeystrokes)
        If (returnValue <> ReturnCode_Success) Then
            osCurrentScreen.SendKeys "^"
            osCurrentScreen.SendControlKey ControlKeyCode_Return
            osCurrentScreen.SendKeys "^IM Hardware Staff"
            osCurrentScreen.SendControlKey ControlKeyCode_Return
            ThisFrame.StatusBarText = "retun code is " & returnValue
        End If
    ThisFrame.StatusBarText = ""
    Loop While returnValue = ReturnCode_Success

    'Wait for Select IM Hardware Staff Menu Option:
    ThisFrame.StatusBarText = "Waiting for Select IM Hardware Staff Menu Option"
    returnValue = osCurrentScreen.WaitForString3(LF & "Select IM Hardware Staff Menu Option: ", NEVER_TIME_OUT, WaitForOption.WaitForOption_AllowKeystrokes)
    If (returnValue <> ReturnCode_Success) Then
        Err.Raise 11001, "WaitForString3", "Timeout waiting for string.", "VBAHelp.chm", "11001"
    End If
    ThisFrame.StatusBarText = ""
    osCurrentScreen.SendKeys "^VA FILEMAN"
    osCurrentScreen.SendControlKey ControlKeyCode_Return
    
    'Wait for a Select VA FileMan Option:
    ThisFrame.StatusBarText = "Waiting for a Select VA FileMan Option"
    returnValue = osCurrentScreen.WaitForString3(LF & "Select VA FileMan Option: ", NEVER_TIME_OUT, WaitForOption.WaitForOption_AllowKeystrokes)
    If (returnValue <> ReturnCode_Success) Then
        Err.Raise 11001, "WaitForString3", "Timeout waiting for string.", "VBAHelp.chm", "11001"
    End If
    ThisFrame.StatusBarText = ""
    osCurrentScreen.SendKeys "Enter"
    osCurrentScreen.SendControlKey ControlKeyCode_Return
    
    'Wait for a Select Input to what File: DEVICE//:
    ThisFrame.StatusBarText = "Nav to correct screen"
    returnValue = osCurrentScreen.WaitForString3(LF & "Input to what File: DEVICE// ", NEVER_TIME_OUT, WaitForOption.WaitForOption_AllowKeystrokes)
    If (returnValue <> ReturnCode_Success) Then
        osCurrentScreen.SendKeys "Device"
        osCurrentScreen.SendControlKey ControlKeyCode_Return
    End If
    osCurrentScreen.SendControlKey ControlKeyCode_Return
    osCurrentScreen.SendControlKey ControlKeyCode_Return

    'Wait for a Select DEVICE NAME:
    ThisFrame.StatusBarText = "Waing for Select DEVICE NAME:"
    returnValue = osCurrentScreen.WaitForString3(LF & "Select DEVICE NAME: ", 3000, WaitForOption.WaitForOption_AllowKeystrokes)
    If (returnValue <> ReturnCode_Success) Then
        ThisFrame.StatusBarText = returnValue
        Err.Raise 11001, "WaitForString3", "Timeout waiting for string.", "VBAHelp.chm", "11001"
    End If
    ThisFrame.StatusBarText = ""
    osCurrentScreen.SendKeys NewSetup_VistaPrinterName_vaule.text
    osCurrentScreen.SendControlKey ControlKeyCode_Return
    osCurrentScreen.SendKeys "Y"
    osCurrentScreen.SendControlKey ControlKeyCode_Return
    
    'Wait for DEVICE LOCATION OF TERMINAL:
    ThisFrame.StatusBarText = "Entering location of Printer :" & NewSetup_LocationOfTerminal_value.text
    returnValue = osCurrentScreen.WaitForString3(LF & "   DEVICE LOCATION OF TERMINAL: ", NEVER_TIME_OUT, WaitForOption.WaitForOption_AllowKeystrokes)
    If (returnValue <> ReturnCode_Success) Then
        Err.Raise 11001, "WaitForString3", "Timeout waiting for string.", "VBAHelp.chm", "11001"
    End If
    osCurrentScreen.SendKeys NewSetup_LocationOfTerminal_value.text
    osCurrentScreen.SendControlKey ControlKeyCode_Return
    
    ThisFrame.StatusBarText = "Entering Device $I" & DeviceI_value.text
    returnValue = osCurrentScreen.WaitForString3(LF & "   DEVICE $I: ", NEVER_TIME_OUT, WaitForOption.WaitForOption_AllowKeystrokes)
    If (returnValue <> ReturnCode_Success) Then
        Err.Raise 11001, "WaitForString3", "Timeout waiting for string.", "VBAHelp.chm", "11001"
    End If
    osCurrentScreen.SendKeys DeviceI_value.text
    osCurrentScreen.SendControlKey ControlKeyCode_Return
    
    ThisFrame.StatusBarText = "Waiting for DEVICE VOLUME SET(CPU):"
    returnValue = osCurrentScreen.WaitForString3(LF & "   DEVICE VOLUME SET(CPU): ", NEVER_TIME_OUT, WaitForOption.WaitForOption_AllowKeystrokes)
    If (returnValue <> ReturnCode_Success) Then
        Err.Raise 11001, "WaitForString3", "Timeout waiting for string.", "VBAHelp.chm", "11001"
    End If
    osCurrentScreen.SendControlKey ControlKeyCode_Return
    
    
    ThisFrame.StatusBarText = "Waiting For Device type"
    returnValue = osCurrentScreen.WaitForString3(LF & "   DEVICE TYPE: ", NEVER_TIME_OUT, WaitForOption.WaitForOption_AllowKeystrokes)
    If (returnValue <> ReturnCode_Success) Then
        Err.Raise 11001, "WaitForString3", "Timeout waiting for string.", "VBAHelp.chm", "11001"
    End If
    osCurrentScreen.SendKeys "HFS"
    osCurrentScreen.SendControlKey ControlKeyCode_Return
    ' XLOCATION OF TERMINAL:  confirm
    osCurrentScreen.SendControlKey ControlKeyCode_Return
    
    ThisFrame.StatusBarText = "Entering MNEMONIC" & HostnameMNEMONIC_value.caption
    returnValue = osCurrentScreen.WaitForString3(LF & "Select MNEMONIC: ", NEVER_TIME_OUT, WaitForOption.WaitForOption_AllowKeystrokes)
    If (returnValue <> ReturnCode_Success) Then
        Err.Raise 11001, "WaitForString3", "Timeout waiting for string.", "VBAHelp.chm", "11001"
    End If
    osCurrentScreen.SendKeys HostnameMNEMONIC_value.caption
    osCurrentScreen.SendControlKey ControlKeyCode_Return
    osCurrentScreen.SendKeys "Y"
    osCurrentScreen.SendControlKey ControlKeyCode_Return
    osCurrentScreen.SendKeys "^SUBTYPE"
    osCurrentScreen.SendControlKey ControlKeyCode_Return
    
    ThisFrame.StatusBarText = "Entering SUBTYPE" & NewSetup_SubType_vaule.text
    returnValue = osCurrentScreen.WaitForString3(LF & "SUBTYPE: ", NEVER_TIME_OUT, WaitForOption.WaitForOption_AllowKeystrokes)
    If (returnValue <> ReturnCode_Success) Then
        Err.Raise 11001, "WaitForString3", "Timeout waiting for string.", "VBAHelp.chm", "11001"
    End If
    osCurrentScreen.SendKeys NewSetup_SubType_vaule.text
    osCurrentScreen.SendControlKey ControlKeyCode_Return
    
    ThisFrame.StatusBarText = "Submiting SubType"
    If NewSetup_SubType_vaule.text = "P-TCP96HPLASER" Then
        returnValue = osCurrentScreen.WaitForString3(LF & "CHOOSE 1-4: ", NEVER_TIME_OUT, WaitForOption.WaitForOption_AllowKeystrokes)
        If (returnValue <> ReturnCode_Success) Then
            Err.Raise 11001, "WaitForString3", "Timeout waiting for string.", "VBAHelp.chm", "11001"
        End If
        osCurrentScreen.SendKeys "1"
    ElseIf NewSetup_SubType_vaule.text = "P-TCP96HPLASER R3" Then
        returnValue = osCurrentScreen.WaitForString3(LF & "CHOOSE 1-2: ", NEVER_TIME_OUT, WaitForOption.WaitForOption_AllowKeystrokes)
        If (returnValue <> ReturnCode_Success) Then
            Err.Raise 11001, "WaitForString3", "Timeout waiting for string.", "VBAHelp.chm", "11001"
        End If
        osCurrentScreen.SendKeys "1"
    ElseIf NewSetup_SubType_vaule.text = "P-TCP96HPLASER R3 ENC" Then
        ThisFrame.StatusBarText = "Sent"
    ElseIf NewSetup_SubType_vaule.text = "P-TCP96HPLASER-LANDSCAPE" Then
        ThisFrame.StatusBarText = "Sent"
    End If
    osCurrentScreen.SendControlKey ControlKeyCode_Return
    
    ThisFrame.StatusBarText = "Waiting for ASK DEVICE Prompt"
    returnValue = osCurrentScreen.WaitForString3(LF & "ASK DEVICE: ", NEVER_TIME_OUT, WaitForOption.WaitForOption_AllowKeystrokes)
    If (returnValue <> ReturnCode_Success) Then
        Err.Raise 11001, "WaitForString3", "Timeout waiting for string.", "VBAHelp.chm", "11001"
    End If
    ThisFrame.StatusBarText = ""
    
    
    osCurrentScreen.SendKeys "^QUEUING"
    osCurrentScreen.SendControlKey ControlKeyCode_Return
    ThisFrame.StatusBarText = "Waiting for  QUEUING prompt"
    returnValue = osCurrentScreen.WaitForString3(LF & "QUEUING: ", NEVER_TIME_OUT, WaitForOption.WaitForOption_AllowKeystrokes)
    If (returnValue <> ReturnCode_Success) Then
        Err.Raise 11001, "WaitForString3", "Timeout waiting for string.", "VBAHelp.chm", "11001"
    End If
    ThisFrame.StatusBarText = ""
    
    osCurrentScreen.SendKeys "F"
    osCurrentScreen.SendControlKey ControlKeyCode_Return
    ThisFrame.StatusBarText = "OUT-OF-SERVICE DATE: "
    returnValue = osCurrentScreen.WaitForString3(LF & "OUT-OF-SERVICE DATE: ", NEVER_TIME_OUT, WaitForOption.WaitForOption_AllowKeystrokes)
    If (returnValue <> ReturnCode_Success) Then
        Err.Raise 11001, "WaitForString3", "Timeout waiting for string.", "VBAHelp.chm", "11001"
    End If
    ThisFrame.StatusBarText = ""
    
    osCurrentScreen.SendKeys "^OPEN PARAMETERS"
    osCurrentScreen.SendControlKey ControlKeyCode_Return
    ThisFrame.StatusBarText = "Waiting for OPEN PARAMETERS prompt"
    returnValue = osCurrentScreen.WaitForString3(LF & "OPEN PARAMETERS: ", NEVER_TIME_OUT, WaitForOption.WaitForOption_AllowKeystrokes)
    If (returnValue <> ReturnCode_Success) Then
        Err.Raise 11001, "WaitForString3", "Timeout waiting for string.", "VBAHelp.chm", "11001"
    End If
    ThisFrame.StatusBarText = "Sending OPEN PARAMETERS" & OpenParameters_value.text
    ThisFrame.StatusBarText = ""
    osCurrentScreen.SendKeys OpenParameters_value.text
    osCurrentScreen.SendControlKey ControlKeyCode_Return
    
    ThisFrame.StatusBarText = "Waiting for CLOSE PARAMETERS prompt"
    returnValue = osCurrentScreen.WaitForString3(LF & "CLOSE PARAMETERS: ", NEVER_TIME_OUT, WaitForOption.WaitForOption_AllowKeystrokes)
    If (returnValue <> ReturnCode_Success) Then
        Err.Raise 11001, "WaitForString3", "Timeout waiting for string.", "VBAHelp.chm", "11001"
    End If
    ThisFrame.StatusBarText = ""
    osCurrentScreen.SendKeys "^PRINT SERVER NAME OR ADDRESS"
    osCurrentScreen.SendControlKey ControlKeyCode_Return
    
    ThisFrame.StatusBarText = "Entering PRINT SERVER NAME OR ADDRESS:" & WindowsIp_value.caption
    returnValue = osCurrentScreen.WaitForString3(LF & "PRINT SERVER NAME OR ADDRESS: ", NEVER_TIME_OUT, WaitForOption.WaitForOption_AllowKeystrokes)
    If (returnValue <> ReturnCode_Success) Then
        Err.Raise 11001, "WaitForString3", "Timeout waiting for string.", "VBAHelp.chm", "11001"
    End If
    osCurrentScreen.SendKeys WindowsIp_value.caption
    osCurrentScreen.SendControlKey ControlKeyCode_Return
    
    ThisFrame.StatusBarText = "Waiting for TELNET port: Prompt"
    returnValue = osCurrentScreen.WaitForString3(LF & "TELNET PORT: ", NEVER_TIME_OUT, WaitForOption.WaitForOption_AllowKeystrokes)
    If (returnValue <> ReturnCode_Success) Then
        Err.Raise 11001, "WaitForString3", "Timeout waiting for string.", "VBAHelp.chm", "11001"
    End If
    ThisFrame.StatusBarText = ""
    osCurrentScreen.SendKeys "9100"
    osCurrentScreen.SendControlKey ControlKeyCode_Return
    
    ThisFrame.StatusBarText = "Waiting for REMOTE PRINTER NAME: prompt"
    returnValue = osCurrentScreen.WaitForString3(LF & "REMOTE PRINTER NAME: ", NEVER_TIME_OUT, WaitForOption.WaitForOption_AllowKeystrokes)
    If (returnValue <> ReturnCode_Success) Then
        Err.Raise 11001, "WaitForString3", "Timeout waiting for string.", "VBAHelp.chm", "11001"
    End If
    ThisFrame.StatusBarText = ""
    osCurrentScreen.SendKeys "^"
    osCurrentScreen.SendControlKey ControlKeyCode_Return
        
    ThisFrame.StatusBarText = "Waiting for Select DEVICE NAME: prompt"
    returnValue = osCurrentScreen.WaitForString3(LF & "Select DEVICE NAME: ", NEVER_TIME_OUT, WaitForOption.WaitForOption_AllowKeystrokes)
    If (returnValue <> ReturnCode_Success) Then
        Err.Raise 11001, "WaitForString3", "Timeout waiting for string.", "VBAHelp.chm", "11001"
    End If
    
    ThisFrame.StatusBarText = "Vista Printer Created"
End Sub


