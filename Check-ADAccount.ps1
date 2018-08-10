function Check-ADAccount
{
    Write-Output "***This script will check if an Active Directory user account has been locked***"

    $Name = Read-Host "Enter a username to check"
    $User = Get-ADUser -Identity $Name -Properties LockedOut | Select LockedOut

    while ($User.lockedout -eq $True)
    {
        Write-Host "$Name is currently locked out"

        $UnlockAccount = Read-Host "Unlock the account? (y/n)"
        if ($UnlockAccount -eq 'Y')
        {
            Unlock-ADAccount $Name
            Write-Host "$Name now unlocked"
            break
        }
        elseif ($UnlockAccount -eq 'N')
        {
            Write-Host "Ignoring $Name"
            break
        }
    }

    while ($User.lockedout -eq $False)
    {
        Write-Host "$Name is not currently locked out"
        break
    }
}