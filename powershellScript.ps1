Write-Output " "
Write-Output "Timezone:"
Get-TimeZone | Select DisplayName

Write-Output " "
Write-Output "Time:"
Get-Date -Format HH:mm:ss

Write-Output " "
$os = Get-WmiObject win32_operatingsystem
$uptime = (Get-Date) - ($os.ConvertToDateTime($os.lastbootuptime))
$Display = "Uptime: " + $Uptime.Days + " days, " + $Uptime.Hours + " hours, " + $Uptime.Minutes + " minutes" 
Write-Output $Display

Write-Output " "
Write-Output "OS Version:"
$os = [System.Environment]::OSVersion.Version
$os | Format-Table Build, Major, Minor, Revision

Write-Output " "
Write-Output "Operating System:"
(Get-WMIObject win32_operatingsystem).name

Write-Output " "
Write-Output "CPU Info"
$test = Get-WmiObject Win32_Processor | Select Manufacturer, Name
$test.Manufacturer
$test.Name

Write-Output " "
Write-Output "GB of Ram: "
Get-WmiObject CIM_PhysicalMemory | Measure-Object -Property capacity -sum | % {[math]::round(($_.sum / 1GB),2)} 

###
Write-Output " "
Write-Output "HDD Space: "
$hdd = get-wmiobject Win32_LogicalDisk
$hdd | Format-Table DeviceID, DriveType, FreeSpace, Size

Write-Output " "
Write-Output "Programs: "
$programs = Get-WmiObject -Class Win32_Product | Select Name
$programs.Name

Write-Output " "
Write-Output "Services: "
Get-WmiObject win32_service -Filter "StartMode = 'Auto'" | Select Name, DisplayName, Startmode 

Write-Output " "
Write-Output "Users and Last Login"
$adsi = [ADSI]"WinNT://$env:COMPUTERNAME"
$adsi.Children | where {$_.SchemaClassName -eq 'user'} | ft name,lastlogin

###
Write-Output " "
Write-Output "Network Info"
Get-NetNeighbor | Select IPAddress, LinkLayerAddress

Write-Output " "
Write-Output "Interfaces Mac Address"
$temp = Get-NetAdapter | Select Name, InterfaceDescription, MacAddress
$temp | Format-Table -Property Name, InterfaceDescription, MacAddress


Write-Output " "
Write-Output "Route Table"
$route = Get-NetRoute
$route | Format-Table -Property DestinationPrefix, NextHop

Write-Output " "
Write-Output "IPv4 and IPv6 Address for each Interface"
Get-NetIPAddress | Format-Table | Sort ifIndex


Write-Output " "
Write-Output "DHCP Server"
Get-WmiObject Win32_NetworkAdapterConfiguration | ? {$_.DHCPEnabled -eq $true -and $_.DHCPServer -ne $null} | select DHCPServer

Write-Output " "
Write-Output "DNS Server"
$dns = Get-DnsClientServerAddress
$dns | Format-Table InterfaceAlias, ServerAddresses

Write-Output " "
Write-Output "Default Gateway for Interfaces"
$gateway = Get-WmiObject Win32_NetworkAdapterConfiguration | Select Description, DefaultIPGateway
$gateway | Format-Table Description, DefaultIPGateway

Write-Output " "
Write-Output "DNS Cache"
Get-DnsClientCache

Write-Output " "
Write-Output "SignedDriver"
Get-WmiObject Win32_PnPSignedDriver| select devicename, driverversion
