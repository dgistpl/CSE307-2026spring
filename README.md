# CSE307 Programming Languages, Spring 2026

## Overview

This repository contains homework assignments for CSE307. All assignments use **OCaml** and are developed inside a **Docker container** using **Visual Studio Code**.

## Prerequisites

- [Visual Studio Code](https://code.visualstudio.com/)
- [Docker Desktop](https://www.docker.com/products/docker-desktop/)

## Setting Up the Development Environment

### Step 1: Install Docker Desktop

1. Download Docker Desktop from https://www.docker.com/products/docker-desktop/
   - **Windows**: Download the Windows installer and follow the setup wizard. Enable WSL 2 backend when prompted.
   - **macOS**: Download the appropriate installer (Apple Silicon or Intel) and drag Docker to Applications.
   - **Linux**: Follow the instructions at https://docs.docker.com/desktop/install/linux/
2. Launch Docker Desktop and wait until the Docker engine is running (the whale icon in the system tray/menu bar should be steady).

### Step 2: Install VS Code Extension

1. Open Visual Studio Code.
2. Go to the Extensions view (`Ctrl+Shift+X` on Windows/Linux, `Cmd+Shift+X` on macOS).
3. Search for **Dev Containers** (by Microsoft) and click **Install**.

### Step 3: Open the Project in a Dev Container

1. Clone this repository:
   ```bash
   git clone <repository-url>
   ```
2. Open the cloned folder in VS Code:
   ```bash
   code CSE307-2026spring
   ```
3. VS Code will detect the `.devcontainer/devcontainer.json` file and show a notification:
   > **"Folder contains a Dev Container configuration file. Reopen folder to develop in a container."**

   Click **"Reopen in Container"**.

   Alternatively, open the Command Palette (`Ctrl+Shift+P` / `Cmd+Shift+P`) and select:
   > **Dev Containers: Reopen in Container**

4. The first build may take several minutes as Docker downloads the OCaml image and installs tools. Subsequent launches will be fast.

### Step 4: Start Working

Once the container is running, you have a full OCaml development environment with:

- **OCaml 5.2** compiler
- **utop** - interactive OCaml toplevel (REPL)
- **dune** - build system
- **ocaml-lsp-server** - language server for VS Code (code completion, type hints, etc.)
- **ocamlformat** - code formatter

## How to Use

### Running OCaml Files

Open a terminal in VS Code (`Ctrl+`` ` or `Cmd+`` `) and run:

```bash
# Run an OCaml file directly
ocaml hw1/problem1.ml

# Or use the interactive toplevel
utop
```

In `utop`, you can load a file:
```ocaml
#use "hw1/problem1.ml";;
```

## Repository Structure

```
CSE307-2026spring/
├── README.md                  # This file
├── Dockerfile                 # Docker image definition
├── .devcontainer/
│   └── devcontainer.json      # VS Code Dev Container configuration
├── documents/                 # Assignment PDF documents
│   ├── hw1_updated.pdf
│   ├── hw2_updated.pdf
│   ├── hw3_updated.pdf
│   └── hw4_updated.pdf
├── hw1/                       # Homework 1: OCaml Basics
│   ├── hw1.md                 #   Overview and problem index
│   ├── problem1.md ~ problem15.md   # Problem descriptions
│   └── problem1.ml ~ problem15.ml   # Template files
├── hw2/                       # Homework 2: ML- Interpreter
│   ├── hw2.md
│   └── hw2.ml
├── hw3/                       # Homework 3: B Language Interpreter
│   ├── hw3.md
│   └── hw3.ml
└── hw4/                       # Homework 4: Type Checker
    ├── hw4.md
    └── hw4.ml
```

## Troubleshooting

- **Docker not running**: Make sure Docker Desktop is running before opening VS Code.
- **Container build fails**: Try rebuilding the container via Command Palette > **Dev Containers: Rebuild Container**.
- **Permission issues on Linux**: Add your user to the docker group: `sudo usermod -aG docker $USER`, then log out and back in.
- **opam environment not set**: Run `eval $(opam env)` in the terminal.
