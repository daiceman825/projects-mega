$UserName= $args[0] 
 
#DOWNLOAD SQLITE 
if(-not (Test-Path -Path C:\sqlite.zip -PathType Leaf)){  
Invoke-WebRequest -Uri "https://www.sqlite.org/2022/sqlite-tools-win32-x86-3380500.zip" -OutFile C:\sqlite.zip 
} 

#Extract to SQLITE Folder 
if(-not (Test-Path -Path "C:\SQLite3\sqlite-tools-win32-x86-3380500\sqlite3.exe")){ 
Expand-Archive C:\sqlite.zip -DestinationPath C:\SQLite3 -Force 
} 

#READ DATA FROM TABLE 
try{ 
$Path = "C:\Users\$UserName\AppData\Roaming\Mozilla\Firefox\Profiles\" 
$Profiles = Get-ChildItem -Path "$Path\*.default-release*\" -ErrorAction SilentlyContinue 
ForEach($item in $Profiles){ 
$DataSource="$item\places.sqlite" 
$tables = C:\SQLite3\sqlite-tools-win32-x86-3380500\sqlite3.exe $DataSource .tables 
if($tables -match "moz"){ 
C:\SQLite3\sqlite-tools-win32-x86-3380500\sqlite3.exe $DataSource "SELECT url from moz_places" 
} 
} 
} 
catch 
{ 
write-host $_.Exception.Message 
} 
