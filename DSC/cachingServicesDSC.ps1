Configuration Main
{

Param ( [string] $nodeName )

Import-DscResource -ModuleName PSDesiredStateConfiguration
Import-DscResource -ModuleName cChoco 

Node $nodeName
  {
	###########################################################################
	# Install packages using Chocolately
	###########################################################################

    cChocoInstaller InstallChoco
    {
        InstallDir = "c:\choco"
    }

    cChocoPackageInstaller installDotnet462
    {
        Name                 = 'dotnet4.6.2'
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]installChoco'
    }
	
	# Windows Management Framework and PowerShell Package
    cChocoPackageInstaller installPowershell
    {
        Name                 = 'Powershell'
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]installChoco'
    }
	
  	###########################################################################
	# Install Windows Features
	###########################################################################
	WindowsFeature WebServerRole
    {
      Name = "Web-Server"
      Ensure = "Present"
    }
    WindowsFeature WebWebServer
    {
      Name = "Web-WebServer"
      Ensure = "Present"
    }
    WindowsFeature WebCommonHttp
    {
      Name = "Web-Common-Http"
      Ensure = "Present"
    }
    WindowsFeature WebStaticContent
    {
      Name = "Web-Static-Content"
      Ensure = "Present"
    }
    WindowsFeature WebDefaultDoc
    {
      Name = "Web-Default-Doc"
      Ensure = "Present"
    }
    WindowsFeature WebHttpErrors
    {
      Name = "Web-Http-Errors"
      Ensure = "Present"
    }
    WindowsFeature WebAppDev
    {
      Name = "Web-App-Dev"
      Ensure = "Present"
    }
    WindowsFeature WebAspNet
    {
      Name = "Web-Asp-Net"
      Ensure = "Present"
    }
    WindowsFeature WebNetExt
    {
      Name = "Web-Net-Ext"
      Ensure = "Present"
    }
    WindowsFeature WebISAPIExt
    {
      Name = "Web-ISAPI-Ext"
      Ensure = "Present"
    }
    WindowsFeature WebISAPIFilter
    {
      Name = "Web-ISAPI-Filter"
      Ensure = "Present"
    }
    WindowsFeature WebHealth
    {
      Name = "Web-Health"
      Ensure = "Present"
    }
    WindowsFeature WebHttpLogging
    {
      Name = "Web-Http-Logging"
      Ensure = "Present"
    }
    WindowsFeature WebRequestMonitor
    {
      Name = "Web-Request-Monitor"
      Ensure = "Present"
    }
    WindowsFeature WebSecurity
    {
      Name = "Web-Security"
      Ensure = "Present"
    }
    WindowsFeature WebFiltering
    {
      Name = "Web-Filtering"
      Ensure = "Present"
    }
    WindowsFeature WebPerformance
    {
      Name = "Web-Performance"
      Ensure = "Present"
    }
    WindowsFeature WebStatCompression
    {
      Name = "Web-Stat-Compression"
      Ensure = "Present"
    }
    WindowsFeature WebDynCompression
    {
      Name = "Web-Dyn-Compression"
      Ensure = "Present"
    }
    WindowsFeature WebMgmtTools
    {
      Name = "Web-Mgmt-Tools"
      Ensure = "Present"
    }
    WindowsFeature WebMgmtConsole
    {
      Name = "Web-Mgmt-Console"
      Ensure = "Present"
    }
    WindowsFeature WebMgmtCompat
    {
      Name = "Web-Mgmt-Compat"
      Ensure = "Present"
    }
    WindowsFeature WebMetabase
    {
      Name = "Web-Metabase"
      Ensure = "Present"
    }

    #Script DownloadWebDeploy
    #{
    #    TestScript = {
    #        Test-Path "C:\WindowsAzure\WebDeploy_amd64_en-US.msi"
    #    }
    #    SetScript ={
    #        $source = "https://download.microsoft.com/download/0/1/D/01DC28EA-638C-4A22-A57B-4CEF97755C6C/WebDeploy_amd64_en-US.msi"
    #        $dest = "C:\WindowsAzure\WebDeploy_amd64_en-US.msi"
    #        Invoke-WebRequest $source -OutFile $dest
    #    }
    #    GetScript = {@{Result = "DownloadWebDeploy"}}
    #    DependsOn = "[WindowsFeature]WebServerRole"
    #}
    #Package InstallWebDeploy
    #{
    #    Ensure = "Present"  
    #    Path  = "C:\WindowsAzure\WebDeploy_amd64_en-US.msi"
    #    Name = "Microsoft Web Deploy 3.6"
    #    ProductId = "{ED4CC1E5-043E-4157-8452-B5E533FE2BA1}"
    #    Arguments = "ADDLOCAL=ALL"
    #    DependsOn = "[Script]DownloadWebDeploy"
    #}
  }
}