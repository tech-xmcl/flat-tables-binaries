#!/bin/bash

TARGET_VERSION="8"
TOOL="../../../../FlatTablesTool/FlatTablesTool.dll"
INPUT_DATA_SOURCE="../DataSource"
OUTPUT_CODE_DIR="../Client/Generated/Code"
OUTPUT_BIN_DIR="../Client/Generated/Bin/Resources"
TARGET_CODE_LANGUAGE="csharp"

# Check whether dotnet is installed and its version
function check_dotnet {
    if ! command -v dotnet &>/dev/null; then
        return 1
    fi
    VERSION=$(dotnet --version 2>/dev/null)
    MAJOR=$(echo "$VERSION" | cut -d. -f1)
    if [[ "$MAJOR" -ge "$TARGET_VERSION" ]]; then
        return 0
    else
        return 1
    fi
}

# Try to install .NET SDK automatically
function install_dotnet {
    if command -v brew &>/dev/null; then
        echo "Homebrew detected. Installing .NET SDK..."
        brew install --cask dotnet-sdk
        sudo ln -s /usr/local/share/dotnet/dotnet /usr/local/bin/dotnet
        return $?
    elif command -v apt &>/dev/null; then
        echo "APT detected. Installing .NET SDK..."
        sudo apt update
        sudo apt install -y dotnet-sdk-8.0
        return $?
    elif command -v dnf &>/dev/null; then
        echo "DNF detected. Installing .NET SDK..."
        sudo dnf install -y dotnet-sdk-8.0
        return $?
    else
        echo "No supported package manager found for automatic installation."
        return 1
    fi
}

# Entry point
if check_dotnet; then
    echo "[OK] .NET SDK 8 or later is installed."
else
    echo "[WARN] .NET SDK 8+ not detected."
    if install_dotnet; then
        echo "[OK] .NET SDK installed successfully."
    else
        echo "[ERROR] Automatic installation failed. Opening manual download page..."
        open "https://dotnet.microsoft.com/en-us/download/dotnet/8.0" 2>/dev/null || xdg-open "https://dotnet.microsoft.com/en-us/download/dotnet/8.0"
        echo "Please complete the installation manually, then press Enter to continue..."
        read
    fi

    if ! check_dotnet; then
        echo "[FATAL] .NET SDK still not found. Please install it manually and try again."
        exit 1
    fi
fi

# Check if tool exists
if [[ ! -f "$TOOL" ]]; then
    echo "[ERROR] Tool not found at path: $TOOL"
    exit 1
fi

# Run FlatTablesTool
echo "Executing FlatTablesTool..."
dotnet "$TOOL" "$INPUT_DATA_SOURCE" "$OUTPUT_CODE_DIR" "$OUTPUT_BIN_DIR" "$TARGET_CODE_LANGUAGE"
