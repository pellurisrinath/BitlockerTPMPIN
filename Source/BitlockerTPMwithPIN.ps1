Add-Type -AssemblyName System.Windows.Forms
$Form = New-Object system.Windows.Forms.Form
$Form.Text = "TPM PIN Input"
$Label = New-Object System.Windows.Forms.Label
$Label.Text = "Please enter the TPM PIN:"
$Label.AutoSize = $True
$Label.Location = New-Object System.Drawing.Point(10,10)
$Form.Controls.Add($Label)
$TextBox = New-Object System.Windows.Forms.TextBox 
$TextBox.Location = New-Object System.Drawing.Point(10,30)
$TextBox.Size = New-Object System.Drawing.Size(200,20)
$Form.Controls.Add($TextBox)
$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Point(75,60)
$OKButton.Size = New-Object System.Drawing.Size(75,23)
$OKButton.Text = "OK"
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$Form.AcceptButton = $OKButton
$Form.Controls.Add($OKButton)
$Form.Topmost = $True
$Form.Add_Shown({$Form.Activate()})
$Result = $Form.ShowDialog()

if ($Result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $TPMPIN = $TextBox.Text
    # Set the BitLocker TPM PIN
    try {
        # Enable BitLocker
        Enable-BitLocker -MountPoint "C:" -EncryptionMethod XtsAes128 -Pin $TPMPIN -TPMandPinProtector
        Write-Host "BitLocker has been enabled with the provided TPM PIN."
    }
    catch {
        Write-Host "An error occurred while enabling BitLocker: $_"
    }
}
