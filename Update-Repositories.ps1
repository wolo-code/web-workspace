[CmdletBinding()]
param(
    [switch]$TopLevelOnly,
    [switch]$RecurseSubmodules
)

$ErrorActionPreference = 'Stop'
$workspace = (Get-Location).Path

function Get-GitRepositories {
    param([string]$Root)

    $gitEntries = Get-ChildItem -LiteralPath $Root -Force -Recurse -Directory -Filter '.git' -ErrorAction SilentlyContinue
    $repositories = foreach ($entry in $gitEntries) {
        $entry.Parent.FullName
    }

    # A worktree can use a .git file instead of a .git directory.
    $gitFiles = Get-ChildItem -LiteralPath $Root -Force -Recurse -File -Filter '.git' -ErrorAction SilentlyContinue
    $repositories += foreach ($entry in $gitFiles) {
        $entry.Directory.FullName
    }

    $repositories += $Root
    $repositories |
        Sort-Object { $_.Length } |
        Select-Object -Unique |
        Where-Object {
            $gitPath = Join-Path $_ '.git'
            Test-Path -LiteralPath $gitPath
        }
}

function Invoke-Git {
    param(
        [string]$Repository,
        [string[]]$Arguments
    )

    & git -C $Repository @Arguments
    if ($LASTEXITCODE -ne 0) {
        throw "git $($Arguments -join ' ') failed in $Repository (exit code $LASTEXITCODE)."
    }
}

$repositories = @(Get-GitRepositories -Root $workspace)
if ($TopLevelOnly) {
    $repositories = @(
        $repositories | Where-Object {
            $relative = [IO.Path]::GetRelativePath($workspace, $_)
            ($relative -notmatch '[\\/]') -or ($_ -eq $workspace)
        }
    )
}

$failed = [System.Collections.Generic.List[string]]::new()
foreach ($repository in $repositories) {
    $displayPath = [IO.Path]::GetRelativePath($workspace, $repository)
    if ($displayPath -eq '.') { $displayPath = '.' }

    try {
        $branch = (& git -C $repository branch --show-current).Trim()
        if ([string]::IsNullOrWhiteSpace($branch)) {
            Write-Warning "Skipping $displayPath: detached HEAD."
            continue
        }

        $status = @(git -C $repository status --porcelain)
        if ($status.Count -gt 0) {
            Write-Warning "Skipping $displayPath: working tree has local changes."
            continue
        }

        Write-Host "Updating $displayPath ($branch)..." -ForegroundColor Cyan
        Invoke-Git -Repository $repository -Arguments @('pull', '--ff-only')

        if ($RecurseSubmodules) {
            Invoke-Git -Repository $repository -Arguments @('submodule', 'update', '--init', '--recursive')
        }
    }
    catch {
        $failed.Add($displayPath)
        Write-Error $_
    }
}

if ($failed.Count -gt 0) {
    Write-Error "Repository update completed with failures: $($failed -join ', ')"
    exit 1
}

Write-Host "Repository update completed successfully." -ForegroundColor Green
