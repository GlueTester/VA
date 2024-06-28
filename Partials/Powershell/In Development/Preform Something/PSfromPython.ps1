ps_script = ""
$InputVar = ConvertTo-Json $env:input_var
$OutputVar = "Hello, Python!"
echo $OutputVar
[Environment]::SetEnvironmentVariable("output_var", $OutputVar)