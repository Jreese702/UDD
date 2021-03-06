﻿$windowcode = '[DllImport("user32.dll")] public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);' 
$asyncwindow = Add-Type -MemberDefinition $windowcode -name Win32ShowWindowAsync -namespace Win32Functions -PassThru 
$null = $asyncwindow::ShowWindowAsync((Get-Process -PID $pid).MainWindowHandle, 0) 

$PSScriptRoot = $MyInvocation.MyCommand.Path
$dir = Split-Path $PSScriptRoot


$inFile = Import-Csv 'New\dash.csv' 
$targetCell = $inFile.Pie[0]
Write-Output $targetCell

$theme_Azure = Get-UDTheme -Name Azure

 Stop-UDDashboard -port 8080
 Start-UDDashboard  -port 8080 -Content { 


    New-UDDashboard  -Title ""  -theme $theme_Azure -Content { 


New-UDTabContainer -Tabs {
    New-UDTab  -Text 'Today' -Content{

New-UDRow -Columns  { 
New-UDColumn -size 4 {}
  New-UDColumn -size 4 {New-UDGauge -Value $targetCell -ValueText $targetCell -NeedleColor "black" -Segments 10 -Width 300 -Height 150 -ValueFontSize 24 -SegmentLabels 24}             
}
New-UDColumn -size 4 {}
New-UDRow -Columns { 
New-UDColumn -size 1 {}
  New-UDColumn -size 10 {New-UDChart  -Type Line -AutoRefresh -RefreshInterval 7 @Colors -Endpoint {
                    
 Import-csv 'New\Today.csv' | Out-UDChartData -LabelProperty "Row Labels" -DataProperty "Row Labels" -Dataset @(
                        
                        New-UDChartDataset -DataProperty "GPNA" -Label "GPNA" -BorderColor "#4D8B4EF3" -BackgroundColor "#4D8B4EF3"
                        New-UDChartDataset -DataProperty "REQS " -Label "REQS" -BorderColor '#4DF32ED2' -BackgroundColor '#4DF32ED2'
                        New-UDChartDataset -DataProperty "Inbox" -Label "Unread/Actionable Inbox" -BorderColor '#4D2EF348' -BackgroundColor '#4D2EF348'
                        New-UDChartDataset -DataProperty "Outstanding" -Label "Total Outstanding Actions" -BackgroundColor "#4DDC143C"
                        New-UDChartDataset -DataProperty "Todays Total" -Label "Total Today" -BorderColor '#4D57dfff' -BackgroundColor '#4D57dfff')}


}
New-UDColumn -size 1 {}
}

    }

    New-UDTab -Text 'Recent Trending' -Content{

New-UDRow -Columns { 
                

                New-UDColumn -Size 6 {
                New-UDChart -Title "This Month" -Type Line -AutoRefresh -RefreshInterval 7 @Colors -Endpoint {
                    
                    import-csv 'New\This%20month.csv' | Out-UDChartData -LabelProperty "Row Labels" -DataProperty "Row Labels" -Dataset @(
                        
                        New-UDChartDataset -DataProperty "GPNA" -Label "GPNA" -BorderColor "#4D8B4EF3"-BackgroundColor "#4D8B4EF3"
                        New-UDChartDataset -DataProperty "REQS " -Label "REQS" -BorderColor '#4DF32ED2' -BackgroundColor '#4DF32ED2'
                        New-UDChartDataset -DataProperty "Inbox" -Label "Unread/Actionable Inbox" -BorderColor '#4D2EF348' -BackgroundColor '#4D2EF348'
                        New-UDChartDataset -DataProperty "Outstanding" -Label "Total Outstanding Actions" -BackgroundColor "#4DDC143C"
                        New-UDChartDataset -DataProperty "Todays Total" -Label "Total Today" -BorderColor '#4D57dfff' -BackgroundColor '#4D57dfff'

                    
                    )
                
                }}
                New-UDColumn -Size 6 {
                 New-UDChart -Title "This Week" -Type Line -AutoRefresh -RefreshInterval 7 @Colors -Endpoint {
                    
                    import-csv 'New\This%20week.csv' | Out-UDChartData -LabelProperty "Row Labels" -DataProperty "Row Labels" -Dataset @(
                        
                        New-UDChartDataset -DataProperty "GPNA" -Label "GPNA" -BorderColor "#4D8B4EF3"-BackgroundColor "#4D8B4EF3"
                        New-UDChartDataset -DataProperty "REQS " -Label "REQS" -BorderColor '#4DF32ED2' -BackgroundColor '#4DF32ED2'
                        New-UDChartDataset -DataProperty "Inbox" -Label "Unread/Actionable Inbox" -BorderColor '#4D2EF348' -BackgroundColor '#4D2EF348'
                        New-UDChartDataset -DataProperty "Outstanding" -Label "Total Outstanding Actions" -BackgroundColor "#4DDC143C"
                        New-UDChartDataset -DataProperty "Todays Total" -Label "Total Today" -BorderColor '#4D57dfff' -BackgroundColor '#4D57dfff'

                    
                    )
                
                }}
                New-UDColumn -Size 6 {
                 New-UDChart -Title "Last Month" -Type Line -AutoRefresh -RefreshInterval 7 @Colors -Endpoint {
                    
                    import-csv 'new\Last%20Month.csv' | Out-UDChartData -LabelProperty "Row Labels" -DataProperty "Row Labels" -Dataset @(
                        
                        New-UDChartDataset -DataProperty "GPNA" -Label "GPNA" -BorderColor "#4D8B4EF3"-BackgroundColor "#4D8B4EF3"
                        New-UDChartDataset -DataProperty "REQS " -Label "REQS" -BorderColor '#4DF32ED2' -BackgroundColor '#4DF32ED2'
                        New-UDChartDataset -DataProperty "Inbox" -Label "Unread/Actionable Inbox" -BorderColor '#4D2EF348' -BackgroundColor '#4D2EF348'
                        New-UDChartDataset -DataProperty "Outstanding" -Label "Total Outstanding Actions" -BackgroundColor "#4DDC143C"
                        New-UDChartDataset -DataProperty "Todays Total" -Label "Total Today" -BorderColor '#4D57dfff' -BackgroundColor '#4D57dfff'

                    
                    )
                
                }}
                New-UDColumn -Size 6 {
                   New-UDChart -Title "Last Week" -Type Line -AutoRefresh -RefreshInterval 7 @Colors -Endpoint {
                    
                    import-csv 'New\Last%20Week.csv' | Out-UDChartData -LabelProperty "Row Labels" -DataProperty "Row Labels" -Dataset @(
                        
                        New-UDChartDataset -DataProperty "GPNA" -Label "GPNA" -BorderColor "#4D8B4EF3"-BackgroundColor "#4D8B4EF3"
                        New-UDChartDataset -DataProperty "REQS " -Label "REQS" -BorderColor '#4DF32ED2' -BackgroundColor '#4DF32ED2'
                        New-UDChartDataset -DataProperty "Inbox" -Label "Unread/Actionable Inbox" -BorderColor '#4D2EF348' -BackgroundColor '#4D2EF348'
                        New-UDChartDataset -DataProperty "Outstanding" -Label "Total Outstanding Actions" -BackgroundColor "#4DDC143C"
                        New-UDChartDataset -DataProperty "Todays Total" -Label "Total Today" -BorderColor '#4D57dfff' -BackgroundColor '#4D57dfff'

                    
                    )
                
                }
                }
    }  
    }

    New-UDTab -Text 'Historical' -Content{
        New-UDParagraph -Text 'This is Tab3'
            New-UDColumn -Size 6 {
                New-UDChart -Title "Outstanding Items Trending" -Type Line -AutoRefresh -RefreshInterval 7 @Colors -Endpoint {
                    
                    import-csv 'New\ChangeLog.csv' | Out-UDChartData -LabelProperty "Time" -DataProperty "Time" -Dataset @(
                        
                        New-UDChartDataset -DataProperty "GPNA Actions" -Label "GPNA Actions" -BorderColor "#4D8B4EF3"-BackgroundColor "#4D8B4EF3"
                        New-UDChartDataset -DataProperty "REQs" -Label "REQS" -BorderColor '#4DF32ED2' -BackgroundColor '#4DF32ED2'
                        New-UDChartDataset -DataProperty "Unread/Actionable Inbox" -Label "Unread/Actionable Inbox" -BorderColor '#4D2EF348' -BackgroundColor '#4D2EF348'
                        New-UDChartDataset -DataProperty "Total Outstanding Actions" -Label "Total Outstanding Actions" -BackgroundColor "#4DDC143C"
                        New-UDChartDataset -DataProperty "Total Today" -Label "Total Today" -BorderColor '#4D57dfff' -BackgroundColor '#4D57dfff'
                      )  }
                        }
      
    }
}






       


      


    
    
    }
    }


