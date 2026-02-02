#!/usr/bin/env bash
set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

REPO="yodeput/rslink"
VERSION="main"
BIN_NAME="rslink"
INSTALL_DIR="${INSTALL_DIR:-/usr/local/bin}"

log_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1" >&2; }

# Detect OS
detect_os() {
    case "$(uname -s)" in
        Linux*)     OS=linux;;
        Darwin*)    OS=macos;;
        *)          OS="unknown";;
    esac
}

# Check if installation directory exists and is writable
check_install_dir() {
    if [[ ! -d "$INSTALL_DIR" ]]; then
        log_error "Install directory does not exist: $INSTALL_DIR"
        exit 1
    fi

    if [[ ! -w "$INSTALL_DIR" ]]; then
        log_error "Install directory not writable (try sudo): $INSTALL_DIR"
        exit 1
    fi
}

# Download and install
install() {
    detect_os
    check_install_dir

    local url="https://raw.githubusercontent.com/${REPO}/${VERSION}/${BIN_NAME}"

    log_info "Downloading $BIN_NAME from $url..."

    if ! curl -fsSL "$url" -o "${INSTALL_DIR}/${BIN_NAME}"; then
        log_error "Download failed"
        exit 1
    fi

    chmod +x "${INSTALL_DIR}/${BIN_NAME}"
    log_info "Installed to ${INSTALL_DIR}/${BIN_NAME}"

    # Verify installation
    if command -v "$BIN_NAME" &> /dev/null; then
        log_info "Successfully installed! Run '$BIN_NAME -h' for help."
    else
        log_warn "Installed but not in PATH. Add $INSTALL_DIR to your PATH."
    fi
}

# Ask for confirmation if not --yes
if [[ "${1:-}" != "--yes" ]]; then
    echo "This will install $BIN_NAME to $INSTALL_DIR"
    read -p "Continue? [y/N] " -n 1 -r
    echo
    [[ ! $REPLY =~ ^[Yy]$ ]] && exit 0
fi

install "$@"
