#!/usr/bin/env bash
set -Eeuo pipefail

REPOSITORY="mehdixxx-max/foxsimaa"
BRANCH="main"
PACKAGE="Faoxima-3xui-v3.5.0-UBUNTU-STABLE-MANAGER-FIX17C-FRESH-DB-SAFE.zip"
PACKAGE_SHA256="6F40BC7FC2B9A4044C2CC340F4098570D2970C57D89FDB103B87289BE1ED30EE"
RAW_BASE="https://raw.githubusercontent.com/${REPOSITORY}/${BRANCH}"

die() {
    printf '[Faoxima bootstrap] ERROR: %s\n' "$*" >&2
    exit 1
}

[[ $EUID -eq 0 ]] || die "Run as root (sudo -i)."
[[ -r /etc/os-release ]] || die "Unable to detect the operating system."
# shellcheck disable=SC1091
source /etc/os-release
[[ "${ID:-}" == "ubuntu" && "${VERSION_ID:-}" == "24.04" ]] ||
    die "Ubuntu 24.04 LTS is required."

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y ca-certificates curl unzip

WORK_DIR=$(mktemp -d)
cleanup() {
    rm -rf "$WORK_DIR"
}
trap cleanup EXIT INT TERM

printf '[Faoxima bootstrap] Downloading stable package...\n'
curl -fL --retry 4 --retry-delay 2 --connect-timeout 15 --max-time 300 \
    -o "$WORK_DIR/faoxima.zip" "${RAW_BASE}/${PACKAGE}"

printf '%s  %s\n' "$PACKAGE_SHA256" "$WORK_DIR/faoxima.zip" |
    sha256sum -c - >/dev/null ||
    die "Package checksum mismatch. Installation stopped."

unzip -q "$WORK_DIR/faoxima.zip" -d "$WORK_DIR/source"
SOURCE_DIR="$WORK_DIR/source/Faoxima-main"
[[ -f "$SOURCE_DIR/index.php" && -f "$SOURCE_DIR/ubuntu/setup.sh" ]] ||
    die "Downloaded package is incomplete."

case "${1:-auto}" in
    --install)
        bash "$SOURCE_DIR/ubuntu/install-local.sh"
        ;;
    --update)
        bash "$SOURCE_DIR/ubuntu/update-local.sh"
        ;;
    --menu)
        bash "$SOURCE_DIR/ubuntu/setup.sh"
        ;;
    auto)
        if [[ -r /etc/faoxima-vps.conf && -f /var/www/faoxima/config.php ]]; then
            printf '[Faoxima bootstrap] Existing installation detected; starting safe update.\n'
            bash "$SOURCE_DIR/ubuntu/update-local.sh"
        else
            printf '[Faoxima bootstrap] Starting clean installation.\n'
            bash "$SOURCE_DIR/ubuntu/install-local.sh"
        fi
        ;;
    *)
        die "Valid options: --install, --update, --menu"
        ;;
esac
