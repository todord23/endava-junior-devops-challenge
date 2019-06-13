###Measure execution time of the script.
Measure-Command{

###Creating a file with 10 random sites.
cd "C:\Temp\"
New-Item "C:\Temp\Urls.txt"
Set-Content "C:\Temp\Urls.txt" "https://www.abv.bg `r`nhttps://www.google.com `r`nhttps://www.reddit.com `r`nhttps://www.twitter.com `r`nhttps://www.gmail.com `r`nhttps://www.youtube.com `r`nhttps://www.wikipedia.org `r`nhttps://www.yahoo.com `r`nhttps://www.quora.com `r`nhttps://www.facebook.com"

###Wait until the file C:\Temp\Urls.txt is created and then continue.
while (!(Test-Path "C:\Temp\Urls.txt")) { Start-Sleep 10 }

###Setting variables for the URLs.
$Urls = Get-Content "C:\Temp\Urls.txt"
$OutputFolder = "C:\Temp\UrlOutput"

###Setting condition and variables for the URLs.
if(!(Test-Path $OutputFolder)){ New-Item -ItemType Directory -Path $OutputFolder -Force | Out-Null }

###Setting cycle and variables, create separate file named *.txt for each URL.
for ($x = 0; $x -lt ($Urls | measure | select -expand Count); $x++)

###Execute the command in loop.
{
  $OutputPath = Join-Path $OutputFolder "$x.txt"
  [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest $Urls[$x] | select -Expand Content | Set-Content $OutputPath -Force
}

###Setting variables for the output of the strings.
$Urls = Get-Content "C:\Temp\Urls.txt"
$OutputFolder = "C:\Temp\hrefOutput"
$OutputPath = Join-Path $OutputFolder "href$x.txt"

###Setting condition and variables.
if(!(Test-Path $OutputFolder)){ New-Item -ItemType Directory -Path $OutputFolder -Force} 

###Setting cycle and variables.
for ($x = 0; $x -lt ($OutputFolder | measure | select -expand Count); $x++)

###Count number of matching lines with the string “href=” in each of the 10 files and Save result of “href=” matches in new 10 files, using logical naming convention.
###P.S. Not so proud with the following lines (:
{
(Get-ChildItem -Filter "0.txt" -Recurse | Select-String -pattern "href=" -AllMatches).matches.count | Out-File -Append -LiteralPath "C:\Temp\hrefOutput\href1-1.txt"

 (Get-ChildItem -Filter "1.txt" -Recurse | Select-String -pattern "href=" -AllMatches).matches.count | Out-File -Append -LiteralPath "C:\Temp\hrefOutput\href1-2.txt"

   (Get-ChildItem -Filter "2.txt" -Recurse | Select-String -pattern "href=" -AllMatches).matches.count | Out-File -Append -LiteralPath "C:\Temp\hrefOutput\href1-3.txt"

    (Get-ChildItem -Filter "3.txt" -Recurse | Select-String -pattern "href=" -AllMatches).matches.count | Out-File -Append -LiteralPath "C:\Temp\hrefOutput\href1-4.txt"

	 (Get-ChildItem -Filter "4.txt" -Recurse | Select-String -pattern "href=" -AllMatches).matches.count | Out-File -Append -LiteralPath "C:\Temp\hrefOutput\href1-5.txt"

	  (Get-ChildItem -Filter "5.txt" -Recurse | Select-String -pattern "href=" -AllMatches).matches.count | Out-File -Append -LiteralPath "C:\Temp\hrefOutput\href1-6.txt"

	   (Get-ChildItem -Filter "6.txt" -Recurse | Select-String -pattern "href=" -AllMatches).matches.count | Out-File -Append -LiteralPath "C:\Temp\hrefOutput\href1-7.txt"

	    (Get-ChildItem -Filter "7.txt" -Recurse | Select-String -pattern "href=" -AllMatches).matches.count | Out-File -Append -LiteralPath "C:\Temp\hrefOutput\href1-8.txt"

		 (Get-ChildItem -Filter "8.txt" -Recurse | Select-String -pattern "href=" -AllMatches).matches.count | Out-File -Append -LiteralPath "C:\Temp\hrefOutput\href1-9.txt"

		  (Get-ChildItem -Filter "9.txt" -Recurse | Select-String -pattern "href=" -AllMatches).matches.count | Out-File -Append -LiteralPath "C:\Temp\hrefOutput\href1-10.txt"
}

###Delete the newly created href1-*.txt files.
Get-ChildItem -Path "C:\Temp\hrefOutput" -Include * -File -Recurse | foreach { $_.Delete()}
}
###After the script completed, it shows how many seconds takes to completes in the PowerShell.
