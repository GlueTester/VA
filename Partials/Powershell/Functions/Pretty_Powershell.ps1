
function EasyRead{
    param(
        [string] $Status,
        [string] $StatusTextColor,
        [string] $Comment,
        [string] $CommentTextColor
    )
    switch ($Status.Trim()) {
        "" {  $Status = "     " }
        "OK" { $Status = " OK  "}
        "FAIL" { $Status = " FAIL "}
        Default {}
    }
    Write-Host "[ $Status ]" -fore $StatusTextColor -nonewline; Write-Host "      - $Comment " -fore $CommentTextColor

    <#
    Usage:
        EasyRead "OK" "green" "this is a test" "white"
    #>
}
