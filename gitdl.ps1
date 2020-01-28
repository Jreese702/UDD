

Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Bypass
Install-Module UniversalDashboard.Community
Install-Module -Name UniversalDashboard.UDGauge -RequiredVersion 1.0.7
Enable-WindowsOptionalFeature -Online -FeatureName "NetFx3"


Stop-UDDashboard -port 8080
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
function DownloadFilesFromRepo {
Param(
    [string]$Owner,
    [string]$Repository,
    [string]$Path,
    [string]$DestinationPath
    )

    $baseUri = "https://api.github.com/"
    $args = "repos/$Owner/$Repository/contents/$Path"
    $wr = Invoke-WebRequest -Uri $($baseuri+$args)
    $objects = $wr.Content | ConvertFrom-Json
    $files = $objects | where {$_.type -eq "file"} | Select -exp download_url
    $directories = $objects | where {$_.type -eq "dir"}
    
    $directories | ForEach-Object { 
        DownloadFilesFromRepo -Owner $Owner -Repository $Repository -Path $_.path -DestinationPath $($DestinationPath+$_.name)
    }

    
    if (-not (Test-Path $DestinationPath)) {
        # Destination path does not exist, let's create it
        try {
            New-Item -Path $DestinationPath -ItemType Directory -ErrorAction Stop
        } catch {
            throw "Could not create path '$DestinationPath'!"
        }
    }

    foreach ($file in $files) {
        $fileDestination = Join-Path $DestinationPath (Split-Path $file -Leaf)
        try {
            Invoke-WebRequest -Uri $file -OutFile $fileDestination -ErrorAction Stop -Verbose
            "Grabbed '$($file)' to '$fileDestination'"
        } catch {
            throw "Unable to download '$($file.path)'"
        }
    }

}

DownloadFilesFromRepo -Owner Jreese702 -Repository UDD -Path all.csv -DestinationPath C:\Users\Jreese\Desktop\New
DownloadFilesFromRepo -Owner Jreese702 -Repository UDD -Path ChangeLog.csv -DestinationPath C:\Users\Jreese\Desktop\New
DownloadFilesFromRepo -Owner Jreese702 -Repository UDD -Path "Last Month.csv" -DestinationPath C:\Users\Jreese\Desktop\New
DownloadFilesFromRepo -Owner Jreese702 -Repository UDD -Path "Last Week.csv" -DestinationPath C:\Users\Jreese\Desktop\New
DownloadFilesFromRepo -Owner Jreese702 -Repository UDD -Path "This month.csv" -DestinationPath C:\Users\Jreese\Desktop\New
DownloadFilesFromRepo -Owner Jreese702 -Repository UDD -Path "This Week.csv" -DestinationPath C:\Users\Jreese\Desktop\New
DownloadFilesFromRepo -Owner Jreese702 -Repository UDD -Path Today.csv -DestinationPath C:\Users\Jreese\Desktop\New
DownloadFilesFromRepo -Owner Jreese702 -Repository UDD -Path dash.csv -DestinationPath C:\Users\Jreese\Desktop\New
DownloadFilesFromRepo -Owner Jreese702 -Repository UDD -Path 'UDD with gauge2.ps1' -DestinationPath C:\Users\Jreese\Desktop\New
&'New\UDD with gauge2.ps1'