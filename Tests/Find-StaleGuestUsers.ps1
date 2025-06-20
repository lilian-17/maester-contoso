function Find-StaleGuestUsers {
    param (
        [int]$ExpirationDays = 30
    )

    $cutoffDate = (Get-Date).AddDays(-$ExpirationDays)

    return Get-MgUser -Filter "userType eq 'Guest'" -All |
        Where-Object {
            $_.ExternalUserState -ne "Accepted" -and
            $_.CreatedDateTime -lt $cutoffDate
        }
    @{
    Severity = "Informational"}
}
