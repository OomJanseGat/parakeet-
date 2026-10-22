# FluidVoice Parakeet Model & Runtimes

This repository contains the **Parakeet TDT 0.6B v2 (Q8_0)** model, verification metadata, settings template, and offline runtime binaries for the [FluidVoice](https://fluidvoice.com) dictation application on Windows.

---

## Repository Contents
- **`tdt-0.6b-v2-q8_0.gguf`**: The 904 MB quantized voice model (tracked with **Git LFS**).
- **`.fluidvoice-model.json`**: Model verification metadata required by FluidVoice to recognize the model.
- **`settings.json`**: Configuration template with Parakeet pre-selected as the active model.
- **`Runtimes/parakeet-cpp/`**: Offline CPU & Vulkan inference engine binaries (`parakeet.dll`).
- **`install.bat`**: 1-click automatic installer script for Windows.
- **`INSTRUCTIONS.txt`**: Plain text installation and path reference.

---

## What Needs to Happen & Where Files Must Be Stored

FluidVoice splits its files between **`AppData\Roaming`** (user models and configurations) and **`AppData\Local`** (engine runtime DLLs).

Here is where each file in this repository needs to be stored on your other computer:

| File / Folder in this Repo | Destination Path on Your Other Computer | Purpose |
| :--- | :--- | :--- |
| **`tdt-0.6b-v2-q8_0.gguf`** | `%APPDATA%\com.altic.fluidvoice.windows\models\parakeet-tdt-0.6b-v2\` | Model weights |
| **`.fluidvoice-model.json`** | `%APPDATA%\com.altic.fluidvoice.windows\models\parakeet-tdt-0.6b-v2\` | Installation metadata |
| **`Runtimes\parakeet-cpp\`** | `%LOCALAPPDATA%\FluidVoice\Runtimes\parakeet-cpp\` | CPU & Vulkan inference engines |
| **`settings.json`** *(Optional)* | `%APPDATA%\com.altic.fluidvoice.windows\settings.json` | Pre-selects Parakeet model |

---

## Setup Instructions for Your Other Laptop

### Step 1: Make sure Git LFS is installed
On Windows (in PowerShell / Command Prompt):
```powershell
git lfs install
```

### Step 2: Clone the Repository
```powershell
git clone https://github.com/OomJanseGat/parakeet-.git
cd parakeet-
```
> **Tip**: If `tdt-0.6b-v2-q8_0.gguf` is only ~134 bytes, run `git lfs pull` to fetch the complete 904 MB model.

---

### Step 3: Install Files

#### Option A: 1-Click Automatic (Recommended)
Simply double-click:
```text
install.bat
```
The script will automatically create the destination directories and copy all files into their proper places in `%APPDATA%` and `%LOCALAPPDATA%`.

#### Option B: Manual via PowerShell
If you prefer running commands manually, open PowerShell inside this folder and run:
```powershell
$roaming = "$env:APPDATA\com.altic.fluidvoice.windows"
$local   = "$env:LOCALAPPDATA\FluidVoice"

# Create directories
New-Item -ItemType Directory -Force "$roaming\models\parakeet-tdt-0.6b-v2"
New-Item -ItemType Directory -Force "$local\Runtimes"

# Copy model & metadata
Copy-Item "tdt-0.6b-v2-q8_0.gguf", ".fluidvoice-model.json" -Destination "$roaming\models\parakeet-tdt-0.6b-v2\"

# Copy runtimes
Copy-Item -Recurse "Runtimes\parakeet-cpp" -Destination "$local\Runtimes\parakeet-cpp"

# Copy settings (if not already present)
if (-not (Test-Path "$roaming\settings.json")) { Copy-Item "settings.json" "$roaming\" }
```

#### Option C: Manual via Windows File Explorer
1. Press `Win + R`, type `%APPDATA%\com.altic.fluidvoice.windows\models` and press Enter.
2. Create a folder named `parakeet-tdt-0.6b-v2`.
3. Copy `tdt-0.6b-v2-q8_0.gguf` and `.fluidvoice-model.json` into that folder.
4. Press `Win + R`, type `%LOCALAPPDATA%\FluidVoice\Runtimes` and press Enter.
5. Copy the entire `parakeet-cpp` folder into this `Runtimes` folder.

---

### Step 4: Open FluidVoice
Launch FluidVoice. The model and runtimes will be recognized immediately without requiring any internet downloads.
