# Flat Tables Binaries for Unity Tool

This repository hosts precompiled binaries (e.g., `flatc.exe`, `.dll`, `.zip`) used by the [FlatTables] plugin for Unity, distributed via the Unity Asset Store.

## ❗ Usage Restriction

These binaries are licensed exclusively for **users who have purchased the [FlatTables] plugin** from the [Unity Asset Store](https://assetstore.unity.com/packages).

### You **may**:
- Use these binaries in combination with the purchased plugin.
- Download them via Unity's internal tool system (automated or manual).

### You **may not**:
- Reuse these binaries in other projects.
- Redistribute or rehost them.
- Reverse-engineer or modify the binaries.
- Use them without a valid plugin license.

## 🔒 Legal

These binaries are released under a modified MIT license (see [LICENSE](./LICENSE.txt)), limiting usage to legal customers. Unauthorized use or redistribution is strictly prohibited and may result in legal action.

## Third Party Licenses

This plugin uses the FlatBuffers compiler tool (`flatc.exe`), which is provided under the Apache License 2.0 by Google Inc.

- License: https://www.apache.org/licenses/LICENSE-2.0
- Source: https://github.com/google/flatbuffers

We include unmodified binaries for user convenience and remain in full compliance with the license.

## FlatTablesTool Directory

The `FlatTablesTool` includes an external command-line tool (`EXE`) designed for data conversion. This tool facilitates the conversion of source files (e.g., Excel, CSV, JSON) into **FlatBuffers** format. Please note that:

- **This tool cannot be run directly from within the Unity Editor**. It is intended to be run externally from the command line, either through a script or manually, depending on the user's workflow.
- The command-line tool requires specific configuration and input files (e.g., `.xlsx`, `.csv`, `.json`, etc.) to operate, and the output is typically a set of **FlatBuffers data files** (binary format) and/or generated C# code, which can be used in Unity projects.

## Samples Directory

The `Samples` directory includes various example files and generated output to help users understand the functionality and application of the `FlatTablesTool`. This directory contains the following:

- **Example Input Files**: These include various source files such as:
  - **Excel (.xlsx)** 
  - **CSV (.csv)**
  - **JSON (.json)**
  - **TXT (.txt)**
  - **XML (.xml)**
  - **YAML (.yaml)**

These files are used for generating **FlatBuffers data** and are provided as **sample data** for users to work with. However, these files are **not directly usable within Unity**; they need to be processed by the external command-line tool first.

- **Generated Output**:
  - **FlatBuffers Binary Data**: After processing the input files, the tool generates the corresponding FlatBuffers binary data files (`.bin`), which can be integrated into Unity.
  - **Generated Code**: The tool also produces C# code that can be used in Unity for handling the FlatBuffers data structures.

- **Unity Scene**: 
  - The `Samples` directory includes a **Unity Scene** that demonstrates how to use the generated FlatBuffers data within Unity. This scene shows how to load and manipulate the data for gameplay or other purposes.

- **Command-Line Scripts**:
  - **Batch Script (`.bat`)** and **Shell Script (`.sh`)**: These are included for automating the process of data conversion using the external tool. 
    - The **.bat script** is for Windows environments.
    - The **.sh script** is for Unix-like systems (Linux/macOS).
  - These scripts are provided as optional utilities for users who prefer to automate the data processing steps outside of Unity, rather than running the command-line tool manually.

---

### **Important Notes**:
1. **The external tool (`EXE`)** is a separate utility that needs to be run **outside of the Unity Editor** to convert sample data files into usable FlatBuffers data or generated code. It **cannot be executed directly inside Unity**.
   
2. **The `Samples` directory** is **not directly usable within Unity**. It contains sample data files and scripts intended to help you understand the conversion process. The converted FlatBuffers data and generated code are what you will use in Unity.

3. **For the Batch and Shell scripts**, these are provided for users who prefer automation. Make sure to read the documentation for each script to understand how to use them in your development environment.
