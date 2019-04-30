# Parameter help description
param($remotepc)

    $scriptBlock = { 

        $registryPath = "HKLM:\Software\Policies\Microsoft\Windows NT\Printers"
    
        $Name = "RegisterSpoolerRemoteRpcEndPoint"
    
        $value = "1"
        
        IF(!(Test-Path $registryPath))
    
        {
    
        New-Item -Path $registryPath -Force | Out-Null
    
        New-ItemProperty -Path $registryPath -Name $name -Value $value -PropertyType DWORD -Force | Out-Null
    
        }
        ELSE {
        
            New-ItemProperty -Path $registryPath -Name $name -Value $value -PropertyType DWORD -Force | Out-Null
        }
        
        Restart-Service -Name Spooler -Verbose -Force
        
        }

Write-Host "Fixing the remote registry..."
Invoke-Command -ComputerName $remotepc -ScriptBlock $scriptBlock
Write-Host "Done!"
