Import-Module oh-my-posh
$env:POSH_GIT_ENABLED = $true

Import-Module posh-git
Import-Module 'G:\posh-git-1.0.0\src\posh-git.psd1'

# 多彩风

# Set-PoshPrompt nu4a
# Set-PoshPrompt paradox
# Set-PoshPrompt powerline
# Set-PoshPrompt iterm2    

# 简约风
Set-PoshPrompt emodipt         # 简约 emodipt
# Set-PoshPrompt powerlevel10k_lean        # 简约 不显示用户名

# 另一种设置方式
# oh-my-posh --init --shell pwsh --config $env:POSH_THEMES_PATH/emodipt.omp.json | Invoke-Expression       # 简约 emodipt

$MY_POSH_THEMES="~/themes/" 
# 使用我自己改的主题
# oh-my-posh --init --shell pwsh --config $MY_POSH_THEMES/_emodipt.omp.json | Invoke-Expression 




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

function Get-ChildItem-Wide # ls
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

function Get-ChildItem-All  # lla
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

function Get-ChildItem-All-Wide  # la
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
    cd "e:\"
}

function f
{
    cd "f:\"
}
function g
{
    cd "g:\"
}

$blogSource = "D:\Blog\Blog\source\_posts\"
$allfile = "*"

