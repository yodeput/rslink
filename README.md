# rslink

> RSync + Link — Copy/move folders with rsync and create symlinks

A lightweight CLI tool that uses `rsync` to copy or move folders, with optional symlink creation at the source location pointing to the destination.

## Features

- **Copy mode** — Sync folders using rsync
- **Move mode** — Remove source after successful transfer
- **Auto symlink** — Create symlink at source pointing to destination
- **Dry run** — Preview changes before executing
- **Verbose output** — Detailed operation logs
- **Progress indicator** — See what's happening in real-time

## Installation

### Quick Install (macOS/Linux)

```bash
curl -fsSL https://raw.githubusercontent.com/yodeput/rslink/main/install.sh | sh
```

### Manual Install

```bash
# Download
curl -fsSL https://raw.githubusercontent.com/yodeput/rslink/main/rslink -o /usr/local/bin/rslink

# Make executable
chmod +x /usr/local/bin/rslink
```

### Homebrew

```bash
brew tap yodeput/tap
brew install rslink
```

## Usage

```bash
rslink [OPTIONS] <source> <destination>
```

### Options

| Option | Description |
|--------|-------------|
| `-m, --move` | Move mode: delete source after transfer |
| `-s, --symlink` | Create symlink at source (default: true) |
| `--no-symlink` | Don't create symlink |
| `-n, --dry-run` | Show what would be done without making changes |
| `-v, --verbose` | Show detailed output |
| `-h, --help` | Show help message |

### Examples

```bash
# Copy folder and create symlink
rslink ~/projects/myapp /mnt/storage/projects

# Move folder and create symlink
rslink --move ~/downloads ~/mnt/storage/downloads

# Copy without symlink
rslink --no-symlink ~/data /backup/data

# Dry run to preview
rslink -n ~/large-folder /mnt/backup

# Verbose output
rslink -v ~/source ~/destination
```

## How It Works

```
Before:
  ~/projects/myapp/  (actual data)

After rslink --move ~/projects/myapp /mnt/storage:
  ~/projects/myapp -> /mnt/storage/myapp  (symlink)
  /mnt/storage/myapp/                    (actual data)
```

## SSH/Remote Server Usage

Sync folders to remote servers via SSH:

```bash
# Copy to remote server
rslink ~/projects/myapp user@server:/remote/path

# Move to remote server
rslink --move ~/projects/myapp user@server:/remote/path

# With custom SSH port
rslink ~/projects/myapp -e "ssh -p 2222" user@server:/remote/path
```

**Note:** When syncing to remote servers, symlink creation happens on the local machine. The remote folder contains the actual data.

### SSH Setup

1. **Setup SSH keys** (for passwordless sync):
   ```bash
   ssh-keygen -t ed25519
   ssh-copy-id user@server
   ```

2. **Test connection**:
   ```bash
   ssh user@server
   ```

3. **Dry run first** (recommended for remote transfers):
   ```bash
   rslink -n ~/large-folder user@server:/remote/path
   ```

## Requirements

- `rsync` (pre-installed on most Linux/macOS systems)
- Bash 4+
- SSH client (for remote sync)

## License

MIT &copy; 2026 yogidewansyah

## Contributing

Contributions welcome! Feel free to open issues or PRs.
