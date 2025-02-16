GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

log_info() {
  echo -e "[${GREEN}INFO${NC}] $1"
}

log_warn() {
  echo -e "[${YELLOW}WARN${NC}] $1"
}

log_error() {
  echo -e "[${RED}ERROR${NC}] $1"
}
