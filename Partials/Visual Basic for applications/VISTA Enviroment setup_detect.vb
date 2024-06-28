'========================================================================================================================
'Date Created: April 07, 2023 (Version 1.0)
'Site Name: Lexington, End User opertaion, Dept of Veterans Affairs
'Developer(s): Russell King
'Description: Reflection v16 VistA Window Detect
'             Allows envirment to be set to desired state (with verification) for further scripts
'             ?-[REQUIRES]:  XUIAMSSOi.dll on the workstation
'EXAMPLE of Format: 
'ISF/CLG - Added Send Carriage Return to terminal to help ASYNC Latency.
'ISF/CLG - Increased text memory buffer (sBuff) from 15KB to 128KB as the SAML token can increase in size
'          for users with access to a large number of VA sites. Eliminates erroneous truncating of large SAML Token.
'========================================================================================================================