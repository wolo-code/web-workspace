$root = (Get-Location).ProviderPath

$directGeneratedRepos = @(
  (Join-Path $root "project\build\interim")
)

$parentRepos = @(
  (Join-Path $root "project"),
  (Join-Path $root "app\project"),
  (Join-Path $root "site\project"),
  (Join-Path $root "tiggu"),
  (Join-Path $root "firebase")
)

foreach ($repo in $directGeneratedRepos) {
  if (-not (Test-Path -LiteralPath $repo)) {
    continue
  }

  git -C $repo add -A
  if ($LASTEXITCODE -ne 0) {
    continue
  }

  git -C $repo diff --cached --quiet
  if ($LASTEXITCODE -ne 0) {
    git -C $repo commit -m "publish"
  }
}

foreach ($repo in $parentRepos) {
  if (-not (Test-Path -LiteralPath $repo)) {
    continue
  }

  $generatedPaths = @("interim", "public") | Where-Object {
    Test-Path -LiteralPath (Join-Path $repo $_)
  }

  if ($generatedPaths.Count -eq 0) {
    continue
  }

  foreach ($generatedPath in $generatedPaths) {
    $absoluteGeneratedPath = Join-Path $repo $generatedPath

    if (Test-Path -LiteralPath (Join-Path $absoluteGeneratedPath ".git")) {
      git -C $absoluteGeneratedPath add -A
      if ($LASTEXITCODE -ne 0) {
        continue
      }

      git -C $absoluteGeneratedPath diff --cached --quiet
      if ($LASTEXITCODE -ne 0) {
        git -C $absoluteGeneratedPath commit -m "publish"
      }
    }
  }

  git -C $repo add -f -- $generatedPaths
  if ($LASTEXITCODE -ne 0) {
    continue
  }

  git -C $repo diff --cached --quiet
  if ($LASTEXITCODE -ne 0) {
    git -C $repo commit -m "publish"
  }
}