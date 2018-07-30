function xmlPeek($filePath, $xpath) { 
    [xml] $fileXml = Get-Content $filePath 
    return $fileXml.SelectSingleNode($xpath).Value 
} 

function xmlPoke($file, $xpath, $value) { 
    $filePath = $file 

    [xml] $fileXml = Get-Content $filePath 
    $node = $fileXml.SelectSingleNode($xpath) 
    if ($node) { 
        $node.Value = $value 

        $fileXml.Save($filePath)  
    } 
}

$Gfnpath = $args[0]
Set-Location -Path $Gfnpath 
$UADE_Revision_File = $Gfnpath + "\..\UADE_Delivery\UADE_SVN_Rev.txt"
$UADE_Changeset_xml = $Gfnpath +"\..\UADE_Delivery\Changeset.xml"
$exepath = "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\TF.exe"
$result = & $exepath history . /r /noprompt /stopafter:1 /version:W
"$result" -match "\d+"
$GfnRevision = $matches[0]
$xpath = "/SubsytemChangeset/DependentSubsystem/@Changeset";

xmlPoke $UADE_Changeset_xml $xpath $GfnRevision
$env:GFNVersion = $GfnRevision
$env:UADEVersion = Get-Content $UADE_Revision_File
Write-Host "UADE Revision: "$env:UADEVersion
Write-Host "Gfn Revision: "$env:GFNVersion