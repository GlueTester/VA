function Get_WindowNames (){
    Add-Type  @"
 using System;
 using System.Runtime.InteropServices;
 using System.Text;
public class APIFuncs
   {
    [DllImport("user32.dll", CharSet = CharSet.Auto, SetLastError = true)]
   public static extern int GetWindowText(IntPtr hwnd,StringBuilder
lpString, int cch);
    [DllImport("user32.dll", SetLastError=true, CharSet=CharSet.Auto)]
   public static extern IntPtr GetForegroundWindow();
    [DllImport("user32.dll", SetLastError=true, CharSet=CharSet.Auto)]
       public static extern Int32 GetWindowThreadProcessId(IntPtr hWnd,out
Int32 lpdwProcessId);
    [DllImport("user32.dll", SetLastError=true, CharSet=CharSet.Auto)]
       public static extern Int32 GetWindowTextLength(IntPtr hWnd);
    }
"@
 
while(1)
{
$w = [apifuncs]::GetForegroundWindow()
$len = [apifuncs]::GetWindowTextLength($w)
$sb = New-Object text.stringbuilder -ArgumentList ($len + 1)
$rtnlen = [apifuncs]::GetWindowText($w,$sb,$sb.Capacity)
write-host "Window Title: $($sb.tostring())"
sleep 1
} 
}

function Show-Process($Process, [Switch]$Maximize){
  $sig = '
    [DllImport("user32.dll")] public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow)
    [DllImport("user32.dll")] public static extern int SetForegroundWindow(IntPtr hwnd)
  '
  
  if ($Maximize) { $Mode = 3 } else { $Mode = 4 }
  $type = Add-Type -MemberDefinition $sig -Name WindowAPI -PassThru
  $hwnd = $process.MainWindowHandle
  $null = $type::ShowWindowAsync($hwnd, $Mode)
  $null = $type::SetForegroundWindow($hwnd) 
# Source:
    #https://stackoverflow.com/questions/25780138/how-to-find-a-desktop-window-by-window-name-in-windows-8-1-update-2-os-using
    #https://blog.idera.com/database-tools/bringing-window-in-the-foreground
}
function Pause_For_Enter ($Message = "Waiting for enter key...") {
    # Check if running in PowerShell ISE
    If ($psISE) {
       # "ReadKey" not supported in PowerShell ISE.
       # Show MessageBox UI
       $Shell = New-Object -ComObject "WScript.Shell"
       $Button = $Shell.Popup("Click OK to continue.", 0, "Hello", 0)
       Return
    }
    $VirtualKeyRange = 0 .. 400
    $Ignore = @()
    foreach ($number in $VirtualKeyRange)
    {
        if ($number -ne 13)
        {
            #$newLetters = $newLetters + $letter
            $Ignore = $Ignore += $number 
        }
    }
    
    Write-Host -NoNewline $Message
    While ($KeyInfo.VirtualKeyCode -Eq $Null -Or $Ignore -Contains $KeyInfo.VirtualKeyCode) {
       $KeyInfo = $Host.UI.RawUI.ReadKey("NoEcho, IncludeKeyDown")
    }
    #Source: 
    #https://www.sapien.com/blog/2014/11/18/removing-objects-from-arrays-in-powershell/
    #https://devtipscurator.wordpress.com/2017/02/01/quick-tip-how-to-wait-for-user-keypress-in-powershell/
 }

 function PopUp_Box ($BoxTitle,$Message,$Icon){
    $Shell = New-Object -ComObject "WScript.Shell"
    $Button = $Shell.Popup("$Message", 0, " $BoxTitle ", $Icon)
    Return
#Sources
#https://www.tutorialspoint.com/how-to-pass-the-parameters-in-the-powershell-function
#https://devtipscurator.wordpress.com/2017/02/01/quick-tip-how-to-wait-for-user-keypress-in-powershell/
#https://learn.microsoft.com/en-us/previous-versions/windows/internet-explorer/ie-developer/windows-scripting/x83z1d9f(v=vs.84)?redirectedfrom=MSDN
}


#Find the window
# Win shell stuff (looks pretty powerfull)
#https://www.techotopia.com/index.php?title=Using_COM_with_Windows_PowerShell_1.0&mobileaction=toggle_view_mobile#Creating_COM_Object_Instances_in_Windows_PowerShell



# Start a Process

$ps = Start-Process -PassThru -FilePath "\\v09.med.va.gov\apps\GUI\Infrastructure\MicroFocus\Reflection\Region3-Prod.rdox" -WindowStyle "Normal"

# Creating WScript.Shell instance
$wshell = New-Object -ComObject wscript.shell

# Wait until activating the target process succeeds.
# Note: You may want to implement a timeout here.
while (-not $wshell.AppActivate($ps.Id)) {
  
  # Waiting for app to start....
  # Start-Sleep -MilliSeconds 200
}

PopUp_Box "Waiting for User" "I have started VISTA for you. Log in then click OK in this window" 64 #see the follwoinf link for the number at the end --> https://learn.microsoft.com/en-us/previous-versions/windows/internet-explorer/ie-developer/windows-scripting/x83z1d9f(v=vs.84)?redirectedfrom=MSDN
while (-not $wshell.AppActivate($ps.Id)) {
  
    # Waiting for app to start....
    # Start-Sleep -MilliSeconds 200
  }

start-job {
    $sc = New-Object -ComObject MSScriptControl.ScriptControl.1
    $sc.Language = 'VBScript'
    $sc.AddCode('
    Sub TerminateResponsibility()

    Call Menu_IMHardwareStaffMenuOption
    
    
    End Sub
    Sub Menu_IMHardwareStaffMenuOption()

    
    Dim osCurrentScreen As screen
    Dim osCurrentTerminal As Terminal
    Dim returnValue As Integer
    
    
    
    Const NEVER_TIME_OUT = 0
    
    Dim LF As String    
    Dim CR As String  
    
    Set osCurrentTerminal = ThisFrame.SelectedView.control
    Set osCurrentScreen = osCurrentTerminal.screen
    
    LF = Chr(10)
    CR = Chr(13)
    
    osCurrentScreen.SendKeys "^IT Equipment Responsibility Option"
    osCurrentScreen.SendControlKey ControlKeyCode_Return
    
    returnValue = osCurrentScreen.WaitForString3(LF & "Select IT Equipment Responsibility Option: ", NEVER_TIME_OUT, WaitForOption.WaitForOption_AllowKeystrokes)
    If (returnValue <> ReturnCode_Success) Then
        Err.Raise 11001, "WaitForString3", "Timeout waiting for string.", "VBAHelp.chm", "11001"
    End If
    ThisFrame.StatusBarText = ""
    
    osCurrentScreen.SendKeys "Terminate Responsibility"
    osCurrentScreen.SendControlKey ControlKeyCode_Return
   
    returnValue = osCurrentScreen.WaitForString3(LF & "Specify method for selecting IT assignments: ", NEVER_TIME_OUT, WaitForOption.WaitForOption_AllowKeystrokes)
    If (returnValue <> ReturnCode_Success) Then
        Err.Raise 11001, "WaitForString3", "Timeout waiting for string.", "VBAHelp.chm", "11001"
    End If
    ThisFrame.StatusBarText = ""
    ')
    
      } -runas32 | wait-job | receive-job





#$VISTA_Window = Start-Process -FilePath \\v09.med.va.gov\apps\GUI\Infrastructure\MicroFocus\Reflection\Region3-Prod.rdox -PassThru #-WindowStyle Minimized

#Show-Process -Process $VISTA_Window
#Start-Sleep -Seconds 2
#Show-Process -Process $VISTA_Window -Maximize
# switch back to PowerShell, normal window
#Start-Sleep -Seconds 2
#Show-Process -Process $VISTA_Window -Minimized
#Start-Sleep -Seconds 2
#Show-Process -Process $VISTA_Window -Maximize
