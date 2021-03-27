# MENU
 
Write-Host "Simple script to get some file information from a given directory"
 
Write-Host " "
 
do{
 
Write-Host " "
 
Write-Host "Choose your option."
 
Write-Host "1. Collect data for specific directory (and subdirectories)."
 
Write-Host "2. List summary of total files by type."
 
Write-Host "3. List files by type (entering the extension)."
 
Write-Host "4. Totalize filesize by type (entering the extension)."
 
Write-Host "5. Exit "
 
$a = Read-Host "Select 1-5: "
 
 
 
Write-Host " "
 
 
 
switch ($a) 
 
{ 
 
1 {
 
$dire = Read-Host "Please type full path of the directory to work with"
 
if (Test-Path $dire){
 
$dir = $dire
 
"** Collecting data, please wait.. **";
 
$arr = Get-ChildItem -Recurse $dir
 
$arrS = $arr | Sort-Object -CaseSensitive
 
"** done! **";
 
}else{
 
Write-Warning "Typed directory doesn't exists."
 
Write-Host "Please type again." 

}
 
break;
 
} 
 
2 {
 
"** Summary by file types **";
 
if (!$dir) {
 
Write-Warning "Please collect data from directory first (option 1)."
 
}else{
 
$arrS  | Group-Object Extension | Sort-Object Count > .\results.csv
write-host "Requested data is now available in results.csv"
 
}
 
break;
 
} 
 
3 {
 
"**Listing files by type (extension) **";   
 
if (!$dir) {
 
"Please collect data from directory first (option 1)."
 
}else{
 
$ext = Read-Host "Please type the desired extension: "
 
$arrS | Where-Object {$_.Extension -eq "$ext"}
 
}
 
break;
 
} 
 
4 {
 
"** Summary of length by file type **";
 
if (!$dir) {
 
"Please collect data from directory first (option 1)."
 
}else{
 
$ext = Read-Host "Please type the desired extension: "
 
$items = $arrS | Where-Object {$_.Extension -eq "$ext"} |  ForEach-Object { $_.Length  / 1kb}
 
foreach ($item in $items){
 
$totsize += [Int] $item
 
}
 
"Total : (kb) $totsize " 
 
}
 
" "
 
break;
 
} 
 
5 {
 
"Thank you."
 
break;
 
}
 
default {
 
"** Invalid option, please type again. **";
 
break;
 
}
 
}
 
 }
 
 while($a -ne 5)