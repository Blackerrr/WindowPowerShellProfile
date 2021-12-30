# 原文地址：https://coolcode.org/2018/03/19/some-useful-scripts-of-powershell/
function Set-CurrentWorkingDirectory
{
    param
    (
        $Path,
        $LiteralPath,
        $PassThru,
        $StackName,
        $UseTransaction
    )
    if ($Path -and ($Path.Contains('...')))
    {
        $a = [System.Text.RegularExpressions.Regex]::Split($Path, "(\.{3,})");
        for ($i = 0; $i -lt $a.Length; $i++)
        {
            $e = $a[$i];
            $l = $e.Length;
            if (($l -gt 2) -and ($e -eq "".PadRight($l, '.')))
            {
                $a[$i] = ".." + [System.String]::Concat([System.Linq.Enumerable]::Repeat("\..", $l - 2))
            }
        }
        $PSBoundParameters['Path'] = [System.String]::Concat($a)
    }
    return Set-Location @PSBoundParameters
}

Set-Alias cd Set-CurrentWorkingDirectory -Option "AllScope"

function Get-ChildItem-Wide
{
    param
    (
        $Path,
        $LiteralPath,
        $Filter,
        $Include,
        $Exclude,
        $Recurse,
        $Force,
        $Name,
        $UseTransaction,
        $Attributes,
        $Depth,
        $Directory,
        $File,
        $Hidden,
        $ReadOnly,
        $System
    )
    Get-ChildItem @PSBoundParameters | Format-Wide -AutoSize
}

function Get-ChildItem-All
{
    param
    (
        $Path,
        $LiteralPath,
        $Filter,
        $Include,
        $Exclude,
        $Recurse,
        $Force,
        $Name,
        $UseTransaction,
        $Attributes,
        $Depth,
        $Directory,
        $File,
        $Hidden,
        $ReadOnly,
        $System
    )
    if ($Attributes)
    {
        $PSBoundParameters.Remove('Attributes');
    }
    Get-ChildItem -Attributes ReadOnly, Hidden, System, Normal, Archive, Directory, Encrypted, NotContentIndexed, Offline, ReparsePoint, SparseFile, Temporary @PSBoundParameters
}

function Get-ChildItem-All-Wide
{
    param
    (
        $Path,
        $LiteralPath,
        $Filter,
        $Include,
        $Exclude,
        $Recurse,
        $Force,
        $Name,
        $UseTransaction,
        $Attributes,
        $Depth,
        $Directory,
        $File,
        $Hidden,
        $ReadOnly,
        $System
    )
    Get-ChildItem-All @PSBoundParameters | Format-Wide -AutoSize
}

Set-Alias ls Get-ChildItem-Wide -Option "AllScope"
Set-Alias ll Get-ChildItem
Set-Alias lla Get-ChildItem-All
Set-Alias la Get-ChildItem-All-Wide

function which
{
    $results =New-Object System.Collections.Generic.List[System.Object];
    foreach ($command in $args)
    {
        $path = (Get-Command $command).Source
        if ($path)
        {
            $results.Add($path);
        }
    }
    return $results;
}

function killall
{
    $commands = Get-Process $args
    foreach ($command in $commands)
    {
        Stop-Process $command.Id
    }
}

set-Alias kill killall

function blogDir
{
    cd "D:\Blog\"
}

function pyDir
{
    cd "D:\NewPythonCodes\"
}

set-Alias touch New-Item

function c
{
    cd "C:\"
}

function d
{
    cd "d:\"
}

function e
{
    cd "C:\"
}

function f
{
    cd "d:\"
}

$blogSource = "D:\Blog\Blog\source\_posts\"
$allfile = "*"


