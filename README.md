# FluidVoice Parakeet Model & Runtimes

This repository contains the **Parakeet TDT 0.6B v2 (Q8_0)** model and runtime binaries for [FluidVoice](https://fluidvoice.com).

## Repository Contents
- `tdt-0.6b-v2-q8_0.gguf`: The 904 MB quantized voice model (tracked with **Git LFS**).
- `.fluidvoice-model.json`: Model installation metadata required by FluidVoice.
- `settings.json`: Configuration template with Parakeet pre-selected.
- `Runtimes/`: Offline Parakeet C++ runtime binaries (CPU & Vulkan) for fast inference.
- `install.bat`: 1-click Windows installer to place all files into their proper AppData directories.

## How to Set Up on Another Laptop

### 1. Make sure Git LFS is installed
On Windows (in PowerShell / Command Prompt):
```powershell
git lfs install
```

### 2. Clone the Repository
```bash
git clone https://github.com/OomJanseGat/parakeet-.git
cd parakeet-
```
*(If the model file is only ~134 bytes, run `git lfs pull` to fetch the complete 904 MB model).*

### 3. Install into FluidVoice
Simply double-click:
```text
install.bat
```
The script will automatically copy:
- The model and metadata into `%APPDATA%\com.altic.fluidvoice.windows\models\parakeet-tdt-0.6b-v2\`
- The runtime binaries into `%LOCALAPPDATA%\FluidVoice\Runtimes\parakeet-cpp\`
- Default settings (if not already present).

Now launch FluidVoice and the Parakeet model will be fully ready to use!
