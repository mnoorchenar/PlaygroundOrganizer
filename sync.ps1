param(
  [string]$Message = "",
  [switch]$PullOnly,
  [switch]$Verbose
)

if ($Message -eq "" -and -not $PullOnly) {
  $Message = "Update " + (Get-Date -Format "yyyy-MM-dd HH:mm:ss")
}

# Check HF_TOKEN
if (-not $env:HF_TOKEN -or $env:HF_TOKEN.Trim().Length -lt 10) {
  Write-Host "Error: HF_TOKEN not set or invalid"
  Write-Host "Set with: [Environment]::SetEnvironmentVariable('HF_TOKEN','YOUR_TOKEN','User')"
  exit 1
}

$repoRoot = git rev-parse --show-toplevel 2>$null
if ($LASTEXITCODE -ne 0) {
  Write-Host "Error: Not a git repository"
  exit 1
}
Set-Location $repoRoot

# Get HF info from remote
$hfRemote = git remote get-url huggingface 2>$null
if ($LASTEXITCODE -ne 0) {
  Write-Host "Error: Hugging Face remote not configured"
  exit 1
}

if ($hfRemote -match 'huggingface\.co/spaces/([^/]+)/(.+?)(?:\.git)?$') {
  $hfUser = $Matches[1]
  $hfSpace = $Matches[2]
} else {
  Write-Host "Error: Cannot parse HF remote"
  exit 1
}

Write-Host "`n=== 3-Way Sync: Local <-> GitHub <-> HF ===`n"

function Get-RemoteCommit($remote) {
  $commit = git rev-parse "$remote/main" 2>$null
  if ($LASTEXITCODE -eq 0) { return $commit }
  return $null
}

function Get-RemoteDate($remote) {
  $date = git log $remote/main -1 --format=%ci 2>$null
  if ($LASTEXITCODE -eq 0) { return [datetime]$date }
  return [datetime]::MinValue
}

# Stage any local changes
git add -A

# Fetch from both remotes
Write-Host "Fetching from remotes..."
git fetch github 2>$null
$ghExists = $LASTEXITCODE -eq 0

git fetch huggingface 2>$null  
$hfExists = $LASTEXITCODE -eq 0

if (-not $ghExists -and -not $hfExists) {
  Write-Host "No remotes found (first push)"
  $isFirstPush = $true
} else {
  $isFirstPush = $false
}

# Check for local uncommitted changes
git diff HEAD --quiet
$hasLocalChanges = $LASTEXITCODE -ne 0

# TRUE 3-WAY SYNC: Merge both remotes
if (-not $isFirstPush) {
  $localCommit = git rev-parse HEAD 2>$null
  $ghCommit = Get-RemoteCommit "github"
  $hfCommit = Get-RemoteCommit "huggingface"
  
  $ghDate = Get-RemoteDate "github"
  $hfDate = Get-RemoteDate "huggingface"
  
  Write-Host "Status:"
  if ($ghExists) { Write-Host "  GitHub:       $($ghDate.ToString('yyyy-MM-dd HH:mm'))" }
  if ($hfExists) { Write-Host "  HuggingFace:  $($hfDate.ToString('yyyy-MM-dd HH:mm'))" }
  Write-Host ""
  
  # Check if we need to merge GitHub
  if ($ghExists -and $ghCommit -and $localCommit -ne $ghCommit) {
    Write-Host "Merging from GitHub..."
    
    if ($hasLocalChanges) {
      git commit -m "Local changes before merge" 2>$null | Out-Null
    }
    
    git merge github/main --no-edit 2>&1 | Out-Null
    
    if ($LASTEXITCODE -ne 0) {
      Write-Host "[!] Merge conflict with GitHub. Keeping local version..."
      git merge --abort 2>$null
    } else {
      Write-Host "[OK] Merged from GitHub"
    }
  }
  
  # Check if we need to merge HuggingFace
  $localCommit = git rev-parse HEAD 2>$null
  if ($hfExists -and $hfCommit -and $localCommit -ne $hfCommit) {
    Write-Host "Merging from HuggingFace..."
    
    git diff HEAD --quiet
    if ($LASTEXITCODE -ne 0) {
      git commit -m "Local changes before HF merge" 2>$null | Out-Null
    }
    
    git merge huggingface/main --no-edit 2>&1 | Out-Null
    
    if ($LASTEXITCODE -ne 0) {
      Write-Host "[!] Merge conflict with HuggingFace. Keeping local version..."
      git merge --abort 2>$null
    } else {
      Write-Host "[OK] Merged from HuggingFace"
    }
  }
  
  # Check if everything is in sync
  $localCommit = git rev-parse HEAD 2>$null
  if ($ghCommit -and $hfCommit -and $localCommit -eq $ghCommit -and $localCommit -eq $hfCommit) {
    Write-Host "[OK] All locations in sync"
  }
}

if ($PullOnly) {
  Write-Host "`n[OK] Pull complete`n"
  exit 0
}

# Commit any remaining changes
git diff HEAD --quiet
if ($LASTEXITCODE -ne 0) {
  git commit -m $Message
  Write-Host "[OK] Committed: $Message"
} else {
  # Check if we have commits to push
  $localCommit = git rev-parse HEAD 2>$null
  $needsPush = $false
  
  if ($ghExists) {
    $ghCommit = Get-RemoteCommit "github"
    if ($localCommit -ne $ghCommit) { $needsPush = $true }
  } else {
    $needsPush = $true
  }
  
  if ($hfExists) {
    $hfCommit = Get-RemoteCommit "huggingface"
    if ($localCommit -ne $hfCommit) { $needsPush = $true }
  } else {
    $needsPush = $true
  }
  
  if (-not $needsPush) {
    Write-Host "`n[OK] Already up-to-date, nothing to push`n"
    exit 0
  }
}

# Push to both remotes
Write-Host "`nPushing to remotes..."

# Push to GitHub
git push github main 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) {
  Write-Host "[OK] GitHub"
} else {
  git push github main --force 2>&1 | Out-Null
  if ($LASTEXITCODE -eq 0) {
    Write-Host "[OK] GitHub (forced)"
  } else {
    Write-Host "[ERROR] GitHub failed"
  }
}

# Push to HuggingFace
$hfUrl = "https://${hfUser}:$($env:HF_TOKEN)@huggingface.co/spaces/${hfUser}/${hfSpace}"

if ($Verbose) {
  Write-Host "Debug: Pushing to spaces/${hfUser}/${hfSpace}"
  git push $hfUrl main --force 2>&1
} else {
  git push $hfUrl main --force 2>&1 | Out-Null
}

if ($LASTEXITCODE -eq 0) {
  Write-Host "[OK] Hugging Face: spaces/${hfUser}/${hfSpace}"
} else {
  Write-Host "[ERROR] Hugging Face FAILED!"
  Write-Host "`nTroubleshooting:"
  Write-Host "1. Does the space exist? https://huggingface.co/spaces/${hfUser}/${hfSpace}"
  Write-Host "2. Is your token valid? (HF Settings > Access Tokens)"
  Write-Host "3. Does your token have write permission?"
  Write-Host "4. Run with -Verbose flag for details"
  exit 1
}

Write-Host "`n[OK] Sync complete`n"
