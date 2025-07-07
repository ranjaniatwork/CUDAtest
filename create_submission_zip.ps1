# PowerShell script to create Coursera submission zip file
# Run this AFTER executing the Colab notebook and collecting results

Write-Host "Creating Coursera Submission Zip File..." -ForegroundColor Green

# Create submission directory
$submissionDir = ".\coursera_submission"
if (Test-Path $submissionDir) {
    Remove-Item $submissionDir -Recurse -Force
}
New-Item -ItemType Directory -Path $submissionDir | Out-Null

# Copy required files for submission
Write-Host "Copying required files..." -ForegroundColor Yellow

# 1. Execution results and logs
Copy-Item ".\results\summary.txt" "$submissionDir\" -ErrorAction SilentlyContinue
Copy-Item ".\results\execution_detailed_log.txt" "$submissionDir\" -ErrorAction SilentlyContinue
Copy-Item ".\results\original_vs_processed" "$submissionDir\" -Recurse -ErrorAction SilentlyContinue

# 2. Project description
Copy-Item ".\docs\Project_Description.txt" "$submissionDir\" -ErrorAction SilentlyContinue

# 3. Main documentation
Copy-Item ".\README.md" "$submissionDir\" -ErrorAction SilentlyContinue
Copy-Item ".\COURSERA_SUBMISSION_REPORT.md" "$submissionDir\" -ErrorAction SilentlyContinue

# 4. Source code (for reference)
New-Item -ItemType Directory -Path "$submissionDir\src" -ErrorAction SilentlyContinue
Copy-Item ".\src\cuda_medical.cu" "$submissionDir\src\" -ErrorAction SilentlyContinue
Copy-Item ".\src\host_utils.cpp" "$submissionDir\src\" -ErrorAction SilentlyContinue
Copy-Item ".\src\host_utils.h" "$submissionDir\src\" -ErrorAction SilentlyContinue
Copy-Item ".\src\kernel_utils.cu" "$submissionDir\src\" -ErrorAction SilentlyContinue

# 5. Colab notebook
Copy-Item ".\Coursera_CUDA_Assignment.ipynb" "$submissionDir\" -ErrorAction SilentlyContinue

# 6. Screenshots directory (create placeholder)
New-Item -ItemType Directory -Path "$submissionDir\screenshots" -ErrorAction SilentlyContinue

# Create instructions file
$instructionsContent = @"
COURSERA SUBMISSION CONTENTS
===========================

This zip file contains:

1. EXECUTION RESULTS:
   - summary.txt: Performance metrics and execution summary
   - execution_detailed_log.txt: Detailed execution logs
   - original_vs_processed/: Before and after images

2. DOCUMENTATION:
   - Project_Description.txt: Project overview for Coursera
   - README.md: Complete project documentation
   - COURSERA_SUBMISSION_REPORT.md: Detailed technical report

3. SOURCE CODE:
   - src/: All CUDA source files
   - Coursera_CUDA_Assignment.ipynb: Google Colab notebook

4. SCREENSHOTS (ADD THESE MANUALLY):
   - screenshots/: Add your Colab execution screenshots here
   - Include: nvidia-smi output, execution progress, results

GITHUB REPOSITORY:
https://github.com/ranjaniatwork/CUDAtest

SUBMISSION CHECKLIST:
☐ Executed CUDA code on Google Colab
☐ Captured screenshots of execution
☐ Saved enhanced images to results/original_vs_processed/
☐ Updated summary.txt with actual performance metrics
☐ Pushed code to GitHub repository
☐ Created this zip file with all artifacts
☐ Uploaded zip file and GitHub link to Coursera

"@

Set-Content -Path "$submissionDir\SUBMISSION_INSTRUCTIONS.txt" -Value $instructionsContent

# Create the zip file
$zipPath = ".\CUDA_Medical_Imaging_Coursera_Submission.zip"
if (Test-Path $zipPath) {
    Remove-Item $zipPath -Force
}

Write-Host "Creating zip file..." -ForegroundColor Yellow
Compress-Archive -Path "$submissionDir\*" -DestinationPath $zipPath -Force

Write-Host "✅ Submission zip file created: $zipPath" -ForegroundColor Green
Write-Host ""
Write-Host "NEXT STEPS:" -ForegroundColor Cyan
Write-Host "1. Run the Colab notebook to generate actual results"
Write-Host "2. Download results and screenshots from Colab"
Write-Host "3. Update the results/ directory with real data"
Write-Host "4. Add screenshots to the screenshots/ folder in the zip"
Write-Host "5. Re-run this script to create the final zip"
Write-Host "6. Upload the zip file to Coursera"
Write-Host ""
Write-Host "GitHub Repository URL:"
Write-Host "https://github.com/ranjaniatwork/CUDAtest" -ForegroundColor Green
