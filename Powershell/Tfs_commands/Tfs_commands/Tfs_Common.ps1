"Microsoft.TeamFoundation.Client",
"Microsoft.TeamFoundation.VersionControl.Common",
"Microsoft.TeamFoundation.VersionControl.Client" |
    ForEach-Object { Add-Type -AssemblyName "$_, Version=14.0.0.0, Culture=Neutral, PublicKeyToken=b03f5f7f11d50a3a" }

$tfsUrl = "http://tfsserver:8080/collection"

$tfs = [Microsoft.TeamFoundation.Client.TeamFoundationServerFactory]::GetServer($tfsUrl)
$vcs = $tfs.GetService([type]"Microsoft.TeamFoundation.VersionControl.Client.VersionControlServer")

$workspaceParameters = New-Object Microsoft.TeamFoundation.VersionControl.Client.CreateWorkspaceParameters -ArgumentList "WorkspaceName"

# Add any specific parameters that you want according to http://msdn.microsoft.com/en-us/library/microsoft.teamfoundation.versioncontrol.client.createworkspaceparameters.aspx
# e.g. $workspaceParameters.Comment = ""
# e.g. $workspaceParameters.Computer = ""
# e.g. $workspaceParameters.Location = [Microsoft.TeamFoundation.VersionControl.Common.WorkspaceLocation]::Local

$workspace = $vcs.CreateWorkspace($workspaceParameters)

# Add any working folders that you would defined below
# e.g. $workspace.Map("$/", "C:\ProjectDirectory")