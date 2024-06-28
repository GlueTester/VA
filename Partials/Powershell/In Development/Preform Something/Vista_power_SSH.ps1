function Create-WorkingSpace (){
    Add-Type @"
    using System;
    using System.Runtime.InteropServices;
    public class Tricks {
    [DllImport("user32.dll")]
    public static extern IntPtr GetForegroundWindow();
    }
"@
    $a = [tricks]::GetForegroundWindow()
    $WH  = get-process | ? { $_.mainwindowhandle -eq $a }
    $sig = '
    [DllImport("user32.dll")] public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);
    [DllImport("user32.dll")] public static extern int SetForegroundWindow(IntPtr hwnd);
'
    $type = Add-Type -MemberDefinition $sig -Name WindowAPI -PassThru
    
    # Changes Focuse to Main Window
    $null = $type::SetForegroundWindow($WH.mainwindowhandle)

    # Set Window Title (Source: https://devblogs.microsoft.com/scripting/powertip-change-the-powershell-console-title/)
    $host.ui.RawUI.WindowTitle = “Vista Printer Creator - NOTES TO USER WILL UPDATE HERE”


    #Overall section Source:
    #https://stackoverflow.com/questions/46351885/how-to-grab-the-currently-active-foreground-window-in-powershell

    #$wshell = New-Object -ComObject wscript.shell;

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

function Establish_SSH(){
    ssh lexvista@vista.lexington.med.va.gov
    Start-Sleep -Seconds 5
    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
    Start-Sleep -Seconds 5
    [System.Windows.Forms.SendKeys]::SendWait("RK376205{ENTER}")
    Start-Sleep -Seconds 5
    [System.Windows.Forms.SendKeys]::SendWait("VA_567085{ENTER}")
}


function Show-Window {
    param(
      [Parameter(Mandatory)]
      [string] $ProcessName
    )

    Start-Sleep -Seconds 3

    # As a courtesy, strip '.exe' from the name, if present.
    $ProcessName = $ProcessName -replace '\.exe$'
  
    # Get the PID of the first instance of a process with the given name
    # that has a non-empty window title.
    # NOTE: If multiple instances have visible windows, it is undefined
    #       which one is returned.
    $hWnd = (Get-Process -ErrorAction Ignore $ProcessName).Where({ $_.MainWindowTitle }, 'First').MainWindowHandle
  
    if (-not $hWnd) { Throw "No $ProcessName process with a non-empty window title found." }
  
    $type = Add-Type -PassThru -NameSpace Util -Name SetFgWin -MemberDefinition @'
      [DllImport("user32.dll", SetLastError=true)]
      public static extern bool SetForegroundWindow(IntPtr hWnd);
      [DllImport("user32.dll", SetLastError=true)]
      public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);    
      [DllImport("user32.dll", SetLastError=true)]
      public static extern bool IsIconic(IntPtr hWnd);    // Is the window minimized?
'@ 
  
    # Note: 
    #  * This can still fail, because the window could have been closed since
    #    the title was obtained.
    #  * If the target window is currently minimized, it gets the *focus*, but its
    #    *not restored*.
    $null = $type::SetForegroundWindow($hWnd)
    # If the window is minimized, restore it.
    # Note: We don't call ShowWindow() *unconditionally*, because doing so would
    #       restore a currently *maximized* window instead of activating it in its current state.
    if ($type::IsIconic($hwnd)) {
      $type::ShowWindow($hwnd, 9) # SW_RESTORE
    }
  
  }
  

#Main Script

Add-Type -AssemblyName System.Windows.Forms
#$wshell = New-Object -ComObject wscript.shell;
Show-Window "powershell"
Start-Sleep -Seconds 3
$host.ui.RawUI.WindowTitle = “Vista Printer Creator”
ssh lexvista@vista.lexington.med.va.gov
Sleep 8
once
Sleep 2
RK376205
Sleep 2
VA_567085


#$session = New-PSSession -HostName lexvista@vista.lexington.med.va.gov -UserName RK376205














#PopUp_Box "Waiting for User" "Im about to connect to VISTA, please click OK when you are ready" 64 #see the follwoinf link for the number at the end --> https://learn.microsoft.com/en-us/previous-versions/windows/internet-explorer/ie-developer/windows-scripting/x83z1d9f(v=vs.84)?redirectedfrom=MSDN
#Establish_SSH



<#
clear
$newvar = "empty"
Remove-Variable newvar

ls | Tee-Object -Variable newvar
If ($newvar -match "Deskhjtop"){
    Write-host "It did containt it"
    exit
}
else {
    Sleep 4
}
}
#>