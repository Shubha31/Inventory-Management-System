@echo off
echo ========================================
echo Fixing npm installation issues...
echo ========================================
echo.

echo Step 1: Stopping any running processes...
taskkill /F /IM node.exe 2>nul
timeout /t 2 /nobreak >nul

echo Step 2: Cleaning npm cache...
call npm cache clean --force

echo.
echo Step 3: Removing node_modules and package-lock.json...
if exist node_modules (
    echo Removing node_modules (this may take a moment)...
    rmdir /s /q node_modules 2>nul
)
if exist package-lock.json (
    del /f /q package-lock.json
)

echo.
echo Step 4: Installing missing Babel plugin first...
call npm install @babel/plugin-transform-react-pure-annotations@^7.25.0 --save-dev --legacy-peer-deps

echo.
echo Step 5: Installing all dependencies with legacy peer deps...
echo This may take 3-5 minutes, please wait...
call npm install --legacy-peer-deps

echo.
echo Step 6: Verifying installation...
if exist "node_modules\@babel\plugin-transform-react-pure-annotations" (
    echo [SUCCESS] Babel plugin installed correctly!
) else (
    echo [WARNING] Babel plugin may still be missing. Trying alternative installation...
    call npm install @babel/plugin-transform-react-pure-annotations@^7.25.0 --legacy-peer-deps --force
)

echo.
echo ========================================
echo Installation complete!
echo ========================================
echo.
echo You can now run: npm start
echo.
pause

