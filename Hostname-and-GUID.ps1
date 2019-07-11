#grabs and searches for hostname or part of host name ie Michael_PC or Mic
#can also just use https://api.amp.cisco.com/v1/computers for all hosts
$hostname = Read-Host -Prompt 'Hostname' 
$endpointUri = 'https://api.amp.cisco.com/v1/computers?hostname[]='+$hostname

#headers for the GET request
#REPLACE <base64encodedstring> WITH YOUR BASE64 ENCODED ID AND KEY
$headers = @{}
$headers.Add("accept","application/json")
$headers.Add("content-type","application/json")
$headers.Add("authorization","Basic <base64encodedstring>")

#perfom the get request > convert from json > gather the necessary data
$hosts = Invoke-WebRequest -Uri $endpointUri -Headers $headers | ConvertFrom-Json | select -expand data | select hostname, connector_guid | sort connector_guid


#export all hostnames and guid to a table sorted by guid
$hosts | Export-Excel -TableName "ampapi" -TableStyle Medium13 -AutoSize C:\amp.xlsx
