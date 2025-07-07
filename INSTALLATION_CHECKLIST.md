# 🚀 CUDA Medical Imaging - Installation Checklist

## ✅ Pre-Installation Checklist
- [ ] I have an NVIDIA GPU in my computer
- [ ] I have stable internet connection (downloads are ~5-10GB total)
- [ ] I have ~15GB free disk space
- [ ] I'm ready to restart my computer 4 times during installation

## 📥 STEP 1: Download All Components First
### Download from opened browser tabs:
- [ ] **NVIDIA Drivers** - Downloaded latest version
- [ ] **CUDA Toolkit** - Downloaded Windows x86_64 exe (local) 
- [ ] **Visual Studio Community 2022** - Downloaded installer
- [ ] **OpenCV** - Downloaded Windows exe (opencv-4.x.x-windows.exe)

## 🔧 STEP 2: Install in Exact Order

### Install 1: NVIDIA Drivers
- [ ] Run NVIDIA driver installer
- [ ] Follow default installation options
- [ ] **RESTART COMPUTER** ⚠️
- [ ] Verify: Right-click desktop → NVIDIA Control Panel should open

### Install 2: CUDA Toolkit  
- [ ] Run CUDA installer **AS ADMINISTRATOR**
- [ ] Choose **"Express Installation"**
- [ ] Wait for installation to complete (15-20 minutes)
- [ ] **RESTART COMPUTER** ⚠️
- [ ] Verify: Open Command Prompt, type `nvcc --version`

### Install 3: Visual Studio Community
- [ ] Run Visual Studio installer
- [ ] Select **"Desktop development with C++"** workload
- [ ] Click "Install" (takes 15-30 minutes)
- [ ] **RESTART COMPUTER** ⚠️
- [ ] Verify: Search "Developer Command Prompt" in Start menu

### Install 4: OpenCV
- [ ] Run OpenCV installer, extract to `C:\opencv`
- [ ] Add to PATH: Win+R → type `sysdm.cpl` → Environment Variables
- [ ] Edit System PATH → Add New → `C:\opencv\build\x64\vc16\bin`
- [ ] Click OK on all dialogs
- [ ] **RESTART COMPUTER** ⚠️
- [ ] Verify: Command Prompt → `dir C:\opencv\build\include\opencv2`

## ✅ STEP 3: Final Verification and Execution

### Open Developer Command Prompt for Visual Studio
- [ ] Press Win key, search "Developer Command Prompt for Visual Studio"
- [ ] Navigate to project: `cd "your\project\path"`

### Run Verification
- [ ] Run: `check_prerequisites.bat`
- [ ] All items should show ✅ (green checkmarks)

### Build and Execute
- [ ] Run: `build_windows.bat`
- [ ] Should show: "✅ Build successful!"
- [ ] Should show: "✅ Processing complete!"
- [ ] Check: Enhanced image in `data/output_images/`

## 🎉 SUCCESS CRITERIA
When everything works, you should see:
```
✅ Build successful!
🚀 Running the application...
Processing image: data/input_images/chemical.png.png
✅ Processing complete! Check data/output_images/ for results.
✅ Enhanced image created: data/output_images/chemical.png.png
```

## 🔍 Troubleshooting Quick Reference
| Error | Solution |
|-------|----------|
| "nvcc not found" | CUDA not installed or not in PATH |
| "cl not found" | Use Developer Command Prompt for VS |
| "OpenCV not found" | Check C:\opencv exists and PATH set |
| Build fails | Try opencv_core450 instead of 451 |

## ⏰ Time Estimates
- Downloads: 15-30 minutes
- NVIDIA Drivers: 10 minutes + restart
- CUDA Toolkit: 20 minutes + restart  
- Visual Studio: 30 minutes + restart
- OpenCV: 10 minutes + restart
- **Total: ~1.5-2 hours**

## 📞 Ready for Help?
After completing all steps, if you encounter issues:
1. Run `check_prerequisites.bat` to see what's missing
2. Check the specific error messages
3. Make sure you're using "Developer Command Prompt for Visual Studio"

---
**Important**: Install in the exact order shown. Each restart is necessary for environment variables to take effect.
