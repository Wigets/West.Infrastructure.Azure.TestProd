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

    cChocoPackageInstaller installNotepadPlusPlus
    {
        Name                 = 'notepadplusplus.install'
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]installChoco'
    }

    cChocoPackageInstaller installDotnetcoreWindowshosting
    {
        Name                 = 'dotnetcore-windowshosting'
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]installChoco', '[WindowsFeature]WebServerRole'
    }

    cChocoPackageInstaller installDotnetcoreRuntime
    {
        Name                 = 'dotnetcore-runtime'
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]installChoco'
    }

    cChocoPackageInstaller installDotnet462
    {
        Name                 = 'dotnet4.6.2'
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]installChoco'
    }
	
    cChocoPackageInstaller installNugetCommandline
    {
        Name                 = 'nuget.commandline'
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
    WindowsFeature ASPNet45
    {
      Name = "Web-Asp-Net45"
      Ensure = "Present"
    }
    WindowsFeature HTTPRedirection
    {
      Name = "Web-Http-Redirect"
      Ensure = "Present"
    }
    WindowsFeature WebManagementConsole
    {
      Name = "Web-Mgmt-Console"
      Ensure = "Present"
    }
    WindowsFeature WebSockets
    {
      Name = "Web-WebSockets"
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