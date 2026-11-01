# porthog 🐗

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Article](https://img.shields.io/badge/Deep_Dive-Read_Post-10b981)](https://www.zaynelovecraft.com/articles/filesystem-first-ai-agent-os-cursor-claude)

Zero-dependency macOS CLI wrapper around `lsof`, `ps`, and `launchctl` to inspect listening TCP ports, see the working directory and memory footprint of whatever is hogging a port, and trace it back to `launchd` before killing it.

> 📖 **Read how this fits into my dev setup:** [Filesystem-First AI Agent OS for Cursor and Claude Code](https://www.zaynelovecraft.com/articles/filesystem-first-ai-agent-os-cursor-claude)

```text
$ porthog
PORT     PID      MEM      COMMAND            USER
------------------------------------------------------------------------
:3000    48219    312MB    node               zayne
:5432    1290     48MB     postgres           zayne
:54321   88412    94MB     com.docker         zayne

$ porthog 3000
:3000 is held by node (PID 48219)
  Command:  next-server (v16.0.0)
  Workdir:  /Users/zayne/repos/new-portfolio
  Memory:   312 MB (PPID: 48190)

$ porthog kill 3000
→ Sending SIGTERM to node (PID 48219) on :3000...
✓ Freed port :3000 (PID 48219).
```

## Why?

Every macOS dev eventually types `lsof -i :3000` followed by `kill -9 <pid>`, only to find out:
1. Seven different `node` processes are running and you don't know which repo `:3000` belongs to (`porthog` prints the working directory `cwd`).
2. The process immediately respawns because a `launchctl` agent is supervising it (`porthog` checks `launchctl list` for matching PIDs and tells you the service label).

## Install

### Direct install (`~/.local/bin`)

```bash
git clone https://github.com/zaynelovecraft/porthog.git
cd porthog && make install
```

### Homebrew

```bash
brew install --HEAD https://raw.githubusercontent.com/zaynelovecraft/porthog/main/Formula/porthog.rb
```

## Usage

| Command | Description |
|---------|-------------|
| `porthog` | Table of all listening TCP ports (`PORT`, `PID`, `MEM`, `COMMAND`, `USER`) |
| `porthog <port>` | Inspect a single port: full command args, repo `cwd`, RSS memory, and `launchd` label |
| `porthog kill <port>` | Send `SIGTERM` (with `SIGKILL` fallback after 400ms) to free `<port>` |
| `porthog services` | List active non-Apple `launchctl` user services with running PIDs |
| `porthog restart <label>` | Run `launchctl kickstart -k gui/$UID/<label>` |

## License

MIT
