param()

$ErrorActionPreference = 'Stop'

function Show-Section($title) {
    Write-Host "`n=== $title ===" -ForegroundColor Cyan
}

Show-Section "START"
Write-Host "Project: Pic-tan"
Write-Host "Time: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"

Show-Section "ROLE MODEL"
Write-Host "Codex: supervisor"
Write-Host "Claude: implementer"

Show-Section "NEXT TASKS"
if (Test-Path "tasks/TASK_BOARD.md") {
    Get-Content "tasks/TASK_BOARD.md" | Select-Object -First 30
} else {
    Write-Host "tasks/TASK_BOARD.md not found" -ForegroundColor Yellow
}

Show-Section "LATEST HANDOFF"
if (Test-Path "tasks/HANDOFF_LOG.md") {
    Get-Content "tasks/HANDOFF_LOG.md" | Select-Object -First 40
} else {
    Write-Host "tasks/HANDOFF_LOG.md not found" -ForegroundColor Yellow
}

Show-Section "STATE SNAPSHOT"
if (Test-Path "docs/STATE_SNAPSHOT.md") {
    Get-Content "docs/STATE_SNAPSHOT.md"
} else {
    Write-Host "docs/STATE_SNAPSHOT.md not found" -ForegroundColor Yellow
}

Show-Section "DONE"
Write-Host "Read docs/START_HERE.md if this is your first action after restart."
