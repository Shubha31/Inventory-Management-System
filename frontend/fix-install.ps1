# PowerShell script to fix npm installation issues
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Fixing npm installation issues..." -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Stop any running Node processes
Write-Host "Step 1: Stopping any running Node processes..." -ForegroundColor Yellow
Get-Process node -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 2

# Clean npm cache
Write-Host "Step 2: Cleaning npm cache..." -ForegroundColor Yellow
npm cache clean --force

# Remove corrupted files
Write-Host "Step 3: Removing node_modules and package-lock.json..." -ForegroundColor Yellow
if (Test-Path "node_modules") {
    Write-Host "  Removing node_modules (this may take a moment)..." -ForegroundColor Gray
    Remove-Item -Recurse -Force "node_modules" -ErrorAction SilentlyContinue
}
if (Test-Path "package-lock.json") {
    Remove-Item -Force "package-lock.json" -ErrorAction SilentlyContinue
}

# Install missing Babel plugin first
Write-Host "Step 4: Installing missing Babel plugin..." -ForegroundColor Yellow
npm install @babel/plugin-transform-react-pure-annotations@^7.25.0 --save-dev --legacy-peer-deps

# Install all dependencies
Write-Host "Step 5: Installing all dependencies..." -ForegroundColor Yellow
Write-Host "  This may take 3-5 minutes, please wait..." -ForegroundColor Gray
npm install --legacy-peer-deps

# Verify installation
Write-Host "Step 6: Verifying installation..." -ForegroundColor Yellow
if (Test-Path "node_modules\@babel\plugin-transform-react-pure-annotations") {
    Write-Host "  [SUCCESS] Babel plugin installed correctly!" -ForegroundColor Green
} else {
    Write-Host "  [WARNING] Trying alternative installation..." -ForegroundColor Yellow
    npm install @babel/plugin-transform-react-pure-annotations@^7.25.0 --legacy-peer-deps --force
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Installation complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "You can now run: npm start" -ForegroundColor Green
Write-Host ""

