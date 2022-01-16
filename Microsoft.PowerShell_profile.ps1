# 原文地址：https://coolcode.org/2018/03/19/some-useful-scripts-of-powershell/
Import-Module oh-my-posh
$env:POSH_GIT_ENABLED = $true

Import-Module posh-git
Import-Module 'G:\posh-git-1.0.0\src\posh-git.psd1'
set-Alias Set-Theme Set-PoshPrompt
$MY_POSH_THEMES = "~/themes/" 
$blogSource = "D:\Blog\Blog\source\_posts\"
$allfile = "*"



# 挑选主题
$number = 2
switch ($number) {
    1 {
        Set-PoshPrompt powerline 
        Break
    }
    2 {
        # python 版本显示OK
        # 长长的箭头配合上鲜明的色彩让这个主题成为经典中的经典。 
        # Agnoster 还能够更加方便的显示你的登录用户名、设备名、当前文件夹中 git 版本控制的信息等等一系列有用的功能
        Set-PoshPrompt Agnoster
        Break
    }
    3 {
        # python 版本颜色显示有问题
        # Sorin 这个主题简洁、精致，仅由字符和图标构成，没有华丽的箭头，但是信息显示的一点不少。
        Set-PoshPrompt Sorin
        Break
    }
    4 {
        # 对 anaconda 不友好，annconda 虚拟环境不显示信息
        # Avit 是一个极为简单的主题，其主 Prompt 是由两行构成的，第一行显示路径、git 版本控制信息和日期等等，第二行显示每次输入的命令
        Set-PoshPrompt Avit
        Break
    }
    5 {
        # 对于python 版本显示也有问题
        # robbyrussell 这个主题是 oh-my-zsh 的默认主题
        Set-PoshPrompt robbyrussell
        Break
    }
    6 {
        Set-PoshPrompt nu4a
        Break
    }
}


# 另一种设置方式
# oh-my-posh --init --shell pwsh --config $env:POSH_THEMES_PATH/emodipt.omp.json | Invoke-Expression       # 简约 emodipt

# 使用我自己改的主题
# oh-my-posh --init --shell pwsh --config $MY_POSH_THEMES/_emodipt.omp.json | Invoke-Expression 





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

function Get-ChildItem-Wide { # ls
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

function Get-ChildItem-All { # lla
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
    if ($Attributes) {
        $PSBoundParameters.Remove('Attributes');
    }
    Get-ChildItem -Attributes ReadOnly, Hidden, System, Normal, Archive, Directory, Encrypted, NotContentIndexed, Offline, ReparsePoint, SparseFile, Temporary @PSBoundParameters
}

function Get-ChildItem-All-Wide { # la
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

function which {
    $results = New-Object System.Collections.Generic.List[System.Object];
    foreach ($command in $args) {
        $path = (Get-Command $command).Source
        if ($path) {
            $results.Add($path);
        }
    }
    return $results;
}

function killall {
    $commands = Get-Process $args
    foreach ($command in $commands) {
        Stop-Process $command.Id
    }
}

set-Alias kill killall

function blogDir {
    Set-Location "D:\Blog\"
}

function pyDir {
    Set-Location "D:\NewPythonCodes\"
}

set-Alias touch New-Item

function c {
    Set-Location "C:\"
}

function d {
    Set-Location "d:\"
}

function e {
    Set-Location "e:\"
}

function f {
    Set-Location "f:\"
}
function g {
    Set-Location "g:\"
}


