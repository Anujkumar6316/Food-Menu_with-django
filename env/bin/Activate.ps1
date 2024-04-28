<#
.SYNOPSIS
   Activates a Python virtual environment for the current PowerShell session.

.DESCRIPTION
   This script modifies the PATH environment variable and sets the prompt to
   signify that you are in a Python virtual environment. It uses the command
   line switches as well as the `pyvenv.cfg` file values present in the
   virtual environment.

.PARAMETER VenvDir
   Path to the directory that contains the virtual environment to activate.
   The default value for this is the parent of the directory that the
   Activate.ps1 script is located within.

.PARAMETER Prompt
   The prompt prefix to display when this virtual environment is activated.
   By default, this prompt is the name of the virtual environment folder
   (VenvDir) surrounded by parentheses and followed by a single space
   (ie. '(.venv) ').

.EXAMPLE
   Activate.ps1
   Activates the Python virtual environment that contains the Activate.ps1 script.

.EXAMPLE
   Activate.ps1 -Verbose
   Activates the Python virtual environment that contains the Activate.ps1 script,
   and shows extra information about the activation as it executes.

.EXAMPLE
   Activate.ps1 -VenvDir C:\Users\MyUser\Common\.venv
   Activates the Python virtual environment located in the specified location.

.EXAMPLE
   Activate.ps1 -Prompt "MyPython"
   Activates the Python virtual environment that contains the Activate.ps1 script,
   and prefixes the current prompt with the specified string (surrounded in
   parentheses) while the virtual environment is active.

.NOTES
   On Windows, it may be required to enable this Activate.ps1 script by setting
   the execution policy for the user. You can do this by issuing the following
   PowerShell command:

   PS C:\> Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

   For more information on Execution Policies:
   https://go.microsoft.com/fwlink/?LinkID=135170

#>

param(
    [Parameter(Mandatory = $false)]
    [String]$VenvDir = (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent),
    [Parameter(Mandatory = $false)]
    [String]$Prompt
)

# Function declarations ---------------------------------------------------

<#
.SYNOPSIS
   Removes all shell session elements added by the Activate script, including
   the addition of the virtual environment's Python executable from the
   beginning of the PATH variable.

.PARAMETER NonDestructive
   If present, do not remove this function from the global namespace for the
   session.

.EXAMPLE
   deactivate -NonDestructive
   Deactivates the virtual environment and leaves the `deactivate` function in
   the global namespace.
#>
function global:deactivate ([switch]$NonDestructive) {
    # Revert to original values

    if (Test-Path -Path Function:_OLD_VIRTUAL_PROMPT) {
        Copy-Item -Path Function:_OLD_VIRTUAL_PROMPT -Destination Function:prompt
        Remove-Item -Path Function:_OLD_VIRTUAL_PROMPT
    }

    if (Test-Path -Path Env:_OLD_VIRTUAL_PYTHONHOME) {
        Copy-Item -Path Env:_OLD_VIRTUAL_PYTHONHOME -Destination Env:PYTHONHOME
        Remove-Item -Path Env:_OLD_VIRTUAL_PYTHONHOME
    }

    if (Test-Path -Path Env:_OLD_VIRTUAL_PATH) {
        Copy-Item -Path Env:_OLD_VIRTUAL_PATH -Destination Env:PATH
        Remove-Item -Path Env:_OLD_VIRTUAL_PATH
    }

    if (Test-Path -Path Env:VIRTUAL_ENV) {
        Remove-Item -Path env:VIRTUAL_ENV
    }

    if (Test-Path -Path Env:VIRTUAL_ENV_PROMPT) {
        Remove-Item -Path env:VIRTUAL_ENV_PROMPT
    }

    if (Get-Variable -Name "_PYTHON_VENV_PROMPT_PREFIX" -ErrorAction SilentlyContinue) {
        Remove-Variable -Name _PYTHON_VENV_PROMPT_PREFIX -Scope Global -Force
    }

    # Leave deactivate function in the global namespace if requested
    if (-not $NonDestructive) {
        Remove-Item -Path function:deactivate
    }
}

<#
.DESCRIPTION
   Gets the values from the pyvenv.cfg file located in the given folder, and
   returns them in a map.

.PARAMETER ConfigDir
   Path to the directory that contains the `pyvenv.cfg` file.
#>
function Get-PyVenvConfig ([String]$ConfigDir) {
    Write-Verbose "Given ConfigDir=$ConfigDir, obtain values in pyvenv.cfg"

    # Ensure the file exists, and issue a warning if it doesn't (but still allow the function to continue).
    $pyvenvConfigPath = Join-Path -Resolve -Path $ConfigDir -ChildPath 'pyvenv.cfg' -ErrorAction Continue

    # An empty map will be returned if no config file is found.
    $pyvenvConfig = @{
    }

    if ($pyvenvConfigPath) {

        Write-Verbose "File exists, parse `key = value` lines"
        $pyvenvConfigContent = Get-Content -Path $pyvenvConfigPath

        $pyvenvConfigContent | ForEach-Object {
            $keyval = $PSItem -split "\s*=\s*", 2
            if ($keyval[0] -and $keyval[1]) {
                $val = $keyval[1]

                # Remove extraneous quotations around a string value.
                if ("'`""".Contains($val.Substring(0, 1))) {
                    $val = $val.Substring(1, $val.Length - 2)
                }

                $pyvenvConfig[$keyval[0]] = $val
                Write-Verbose "Adding Key: '$($keyval[0])'='$val'"
            }
        }
    }

    return $pyvenvConfig
}

# Begin Activate script ---------------------------------------------------

# Determine the containing directory of this script
$venvExecPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$venvExecDir = Get-Item -Path $venvExecPath

Write-Verbose "Activation script is located in path: '$venvExecPath'"
Write-Verbose "VenvExecDir Fullname: '$($venvExecDir.FullName)'
