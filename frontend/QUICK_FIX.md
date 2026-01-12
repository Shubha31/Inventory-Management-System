# Quick Fix for Babel Error

## The Problem
You're getting this error:
```
Cannot find module '@babel/plugin-transform-react-pure-annotations\lib\index.js'
```

## The Solution (Choose One Method)

### Method 1: Use the Fix Script (RECOMMENDED)
1. Open Command Prompt or PowerShell
2. Navigate to the `frontend` folder:
   ```cmd
   cd C:\IMS-react-master\IMS-react-master\frontend
   ```
3. Run the fix script:
   ```cmd
   fix-install.bat
   ```
4. Wait for it to complete (3-5 minutes)
5. Start the server:
   ```cmd
   npm start
   ```

### Method 2: Manual Fix
Run these commands **one by one** in the `frontend` directory:

```powershell
# 1. Stop the dev server if running (Ctrl+C)

# 2. Clean npm cache
npm cache clean --force

# 3. Remove corrupted files
Remove-Item -Recurse -Force node_modules -ErrorAction SilentlyContinue
Remove-Item -Force package-lock.json -ErrorAction SilentlyContinue

# 4. Install the missing package first
npm install @babel/plugin-transform-react-pure-annotations@^7.25.0 --save-dev --legacy-peer-deps

# 5. Install all dependencies
npm install --legacy-peer-deps

# 6. Start the server
npm start
```

### Method 3: Nuclear Option (If Methods 1 & 2 Fail)
```powershell
# In frontend directory:
npm cache clean --force
Remove-Item -Recurse -Force node_modules -ErrorAction SilentlyContinue
Remove-Item -Force package-lock.json -ErrorAction SilentlyContinue
Remove-Item -Force .npmrc -ErrorAction SilentlyContinue

# Reinstall with force
npm install --legacy-peer-deps --force
npm start
```

## Why This Happens
- Corrupted or incomplete `node_modules` installation
- Version conflicts between Babel packages
- Windows file locking issues
- Interrupted npm installation

## Prevention
- Always let `npm install` complete fully
- Don't interrupt the installation process
- Close VS Code/editors before deleting `node_modules` if you get EBUSY errors

