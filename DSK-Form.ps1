[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") 

$objForm = New-Object System.Windows.Forms.Form 
$objForm.Text = "PC info"
$objForm.Size = New-Object System.Drawing.Size(300,200) 
$objForm.StartPosition = "CenterScreen"

$objLabel = New-Object System.Windows.Forms.Label
$objLabel.Location = New-Object System.Drawing.Size(10,40) 
$objLabel.Size = New-Object System.Drawing.Size(30,20)
$objLabel.Text = "PC :"
$objForm.Controls.Add($objLabel) 


$objTextBox = New-Object System.Windows.Forms.TextBox 
$objTextBox.Location = New-Object System.Drawing.Size(40,40) 
$objTextBox.Size = New-Object System.Drawing.Size(150,20) 
$objForm.Controls.Add($objTextBox) 

$objTextBox2 = New-Object System.Windows.Forms.TextBox 
$objTextBox2.Location = New-Object System.Drawing.Size(40,80) 
$objTextBox2.Size = New-Object System.Drawing.Size(150,20) 
$objForm.Controls.Add($objTextBox2) 

$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Size(200,40)
$OKButton.Size = New-Object System.Drawing.Size(75,23)
$OKButton.Text = "OK"
$OKButton.Add_Click({setAction $objTextbox.Text})
$objForm.Controls.Add($OKButton)

$objForm.showdialog()


function setAction($Comp){
 # $objTextBox.Text = "IP"
 $query = "SELECT * FROM Win32_PingStatus WHERE Address='$Comp'"
 Write-Host $query
 $coll = Get-WmiObject -Namespace root\cimv2 -Query $query
	ForEach ($item In $coll) {$IP = $item.ProtocolAddress}
	$objTextBox.Text=$IP
}