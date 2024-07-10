import subprocess
import json
import os



# Set the input variable
input_var = "Hello, PowerShell!"

# Define the PowerShell script
ps_script = """
$InputVar = ConvertTo-Json $env:input_var
$OutputVar = "Hello, Python!"
echo $OutputVar
[Environment]::SetEnvironmentVariable("output_var", $OutputVar)
"""
#os.environ["input_var"] = str(input_var)

# Run the PowerShell script with the input variable as an environment variable
print(input_var)  # Print the input_var value for debugging purposes
#os.environ["input_var"] = str(input_var) # stores the variable in the current enviroment SOURCE: https://stackoverflow.com/questions/5971312/how-to-set-environment-variables-in-python
result = subprocess.run(["powershell.exe", "-Command", ps_script ], env={"input_var": input_var})

# Decode the output and retrieve the output variable
ps_output = result.stdout.decode("utf-8").strip()
if ps_output:
        output_var=json.loads(ps_output)
        print("Output variable:", output_var)
else:
        print ("ps_output is empty see: -->" + ps_output + "<---")
        #print ("but the content of result is:" + result )



#This script first sets the input variable `input_var` to a string value. It then defines the PowerShell script as a string variable `ps_script`.

#The script uses the `subprocess.run()` method to run the PowerShell script with the input variable `input_var` passed as an environment variable. The captured output from the PowerShell script is decoded from bytes to a string using the `decode()` method and the `utf-8` encoding. The resulting string is stripped of leading or trailing whitespace.

#The output of the PowerShell script is then parsed using `json.loads()` to retrieve the value of the output variable, which is then printed in Python.

#Note that the PowerShell script in this example simply sets the output variable `output_var` to a string value, but you can modify the script to perform any desired operations with the input variable and return any desired output.
