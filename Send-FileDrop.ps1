#region Variables
$server = 'liquidfiles.domain.com'
$filedrop = '$server/filedrop/name'
$logFile = "$env:temp\Filedrop`.log"
$File = ""
$lfDir = "C:\Program Files (x86)\LiquidFiles Windows Agent"
#endregion
#region Logging
Start-Transcript -Path $logFile -Force
#endregion
#region Process
try {
    Write-Host "Looking for $File"
    if (Test-Path "$File" -ErrorAction SilentlyContinue) {
        Write-Host "Found the file"
        if (Test-Path "$lfdir\LiquidFilesCLI.exe"){
            Write-Host "Found LiquidFiles CLI, attempting filedrop"
            Start-Process -NoNewWindow -FilePath "$lfdir\LiquidFilesCLI.exe" -ArgumentList "filedrop /k /url:$filedrop /f:$File /from:name@email.com /subject:`"The File`" /msg:`"here`""
        }
        else {
            Throw "Liquidfiles CLI not found"
        }
    } 
    else {
        Throw "File not found.."
    }
}
catch {
    $errorMsg = $_.Exception.Message
}
finally {
    if ($errorMsg) {
        Write-Host $errorMsg
        Stop-Transcript
        throw $errorMsg
    }
    else {
        Write-Host "Script completed successfully.."
        Stop-Transcript
    }
}
#endregion