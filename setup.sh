#!/bin/bash

# macOS First Time Setup Script
# This script helps new macOS users set up their development environment

set -e # Exit on any error

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Function to print colored output
print_step() {
	echo -e "${BLUE}[STEP]${NC} $1"
}

print_success() {
	echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
	echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
	echo -e "${RED}[ERROR]${NC} $1"
}

print_info() {
	echo -e "${CYAN}[INFO]${NC} $1"
}

# Function to check if command exists
command_exists() {
	command -v "$1" >/dev/null 2>&1
}

# Function to prompt for input with validation
prompt_input() {
	local prompt="$1"
	local validation_func="$2"
	local input

	while true; do
		echo -n -e "${PURPLE}$prompt: ${NC}"
		read -r input

		if [ -n "$input" ]; then
			if [ -z "$validation_func" ] || $validation_func "$input"; then
				# Return the input via a global variable to avoid echo interference
				PROMPT_RESULT="$input"
				return 0
			fi
		fi
		print_warning "Invalid input. Please try again."
	done
}

# Validation functions
validate_github_username() {
	local username="$1"
	# GitHub username validation: alphanumeric, hyphens, no consecutive hyphens, no leading/trailing hyphens
	if [[ "$username" =~ ^[a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])?$ ]] && [[ ! "$username" =~ -- ]]; then
		return 0
	fi
	print_warning "GitHub username can only contain alphanumeric characters and hyphens, cannot have consecutive hyphens, and cannot start or end with a hyphen."
	return 1
}

validate_git_url() {
	local url="$1"
	# Basic Git URL validation (supports both HTTPS and SSH)
	if [[ "$url" =~ ^(https://github\.com/|git@github\.com:).+\.git$ ]]; then
		return 0
	fi
	print_warning "Please provide a valid GitHub repository URL (e.g., https://github.com/user/repo.git or git@github.com:user/repo.git)"
	return 1
}

# Main setup function
main() {
	echo -e "${CYAN}"
	echo "╔════════════════════════════════════════════════════════════════════════════════════════╗"
	echo "║                              🍎 macOS Development Setup                                ║"
	echo "║                         Welcome to your development environment!                       ║"
	echo "╚════════════════════════════════════════════════════════════════════════════════════════╝"
	echo -e "${NC}"
	echo
	echo "This script will set up your macOS development environment with:"
	echo "• Homebrew package manager"
	echo "• Git version control"
	echo "• Workspace directory structure"
	echo "• Your dotfiles repository"
	echo

	# Confirm before starting
	echo -n -e "${PURPLE}Do you want to continue? (y/N): ${NC}"
	read -r confirm
	if [[ ! $confirm =~ ^[Yy]$ ]]; then
		print_info "Setup cancelled by user."
		exit 0
	fi

	echo
	print_step "Starting macOS development environment setup..."

	# Step 1: Install Homebrew
	print_step "1/11 Installing Homebrew package manager..."
	if command_exists brew; then
		print_success "Homebrew is already installed"
		brew --version
	else
		print_info "Installing Homebrew..."
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

		# Add Homebrew to PATH for Apple Silicon Macs
		if [[ $(uname -m) == "arm64" ]]; then
			echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>~/.zprofile
			eval "$(/opt/homebrew/bin/brew shellenv)"
		fi

		print_success "Homebrew installed successfully"
	fi

	# Step 2: Install Git
	print_step "2/11 Installing Git..."
	if command_exists git; then
		print_success "Git is already installed"
		git --version
	else
		print_info "Installing Git via Homebrew..."
		brew install git
		print_success "Git installed successfully"
	fi

	# Step 3: Create ~/workspace directory
	print_step "3/11 Creating ~/workspace directory..."
	if [ ! -d "$HOME/workspace" ]; then
		mkdir -p "$HOME/workspace"
		print_success "Created ~/workspace directory"
	else
		print_success "~/workspace directory already exists"
	fi

	# Step 4: Create ~/workspace/office directory
	print_step "4/11 Creating ~/workspace/office directory..."
	if [ ! -d "$HOME/workspace/office" ]; then
		mkdir -p "$HOME/workspace/office"
		print_success "Created ~/workspace/office directory"
	else
		print_success "~/workspace/office directory already exists"
	fi

	# Step 5: Create ~/workspace/github directory
	print_step "5/11 Creating ~/workspace/github directory..."
	if [ ! -d "$HOME/workspace/github" ]; then
		mkdir -p "$HOME/workspace/github"
		print_success "Created ~/workspace/github directory"
	else
		print_success "~/workspace/github directory already exists"
	fi

	# Step 6: Change directory to ~/workspace/github
	print_step "6/11 Changing to ~/workspace/github directory..."
	cd "$HOME/workspace/github"
	print_success "Changed to $(pwd)"

	# Step 7: Get GitHub username and create directory
	print_step "7/11 Setting up GitHub username directory..."
	echo
	prompt_input "Enter your GitHub username" "validate_github_username"
	GITHUB_USERNAME="$PROMPT_RESULT"

	if [ ! -d "$GITHUB_USERNAME" ]; then
		mkdir -p "$GITHUB_USERNAME"
		print_success "Created directory for user: $GITHUB_USERNAME"
	else
		print_success "Directory for user $GITHUB_USERNAME already exists"
	fi

	# Step 8: Change to username directory
	print_step "8/11 Changing to $GITHUB_USERNAME directory..."
	cd "$GITHUB_USERNAME"
	print_success "Changed to $(pwd)"

	# Step 9: Get dotfiles repo URL and clone
	print_step "9/11 Cloning dotfiles repository..."
	echo
	print_info "Please provide your dotfiles repository URL"
	print_info "Example: https://github.com/$GITHUB_USERNAME/dotfiles.git"
	print_info "     or: git@github.com:$GITHUB_USERNAME/dotfiles.git"
	echo

	prompt_input "Enter your dotfiles repository URL" "validate_git_url"
	DOTFILES_URL="$PROMPT_RESULT"

	# Extract repository name from URL
	REPO_NAME=$(basename "$DOTFILES_URL" .git)

	if [ -d "$REPO_NAME" ]; then
		print_warning "Directory $REPO_NAME already exists"
		echo -n -e "${PURPLE}Do you want to remove it and clone fresh? (y/N): ${NC}"
		read -r remove_existing
		if [[ $remove_existing =~ ^[Yy]$ ]]; then
			rm -rf "$REPO_NAME"
			print_info "Removed existing $REPO_NAME directory"
		else
			print_info "Using existing $REPO_NAME directory"
			cd "$REPO_NAME"
			print_success "Changed to existing $(pwd)"

			# Skip to step 11
			print_step "11/11 Running bootstrap command..."
			if [ -f "Makefile" ] && grep -q "bootstrap" Makefile; then
				make bootstrap
				print_success "Bootstrap command completed successfully"
			elif [ -f "bootstrap" ] && [ -x "bootstrap" ]; then
				./bootstrap
				print_success "Bootstrap script completed successfully"
			else
				print_warning "No Makefile with bootstrap target or executable bootstrap script found"
				print_info "Available files in directory:"
				ls -la
				print_info "Please run the appropriate setup command manually"
			fi

			setup_complete
			return
		fi
	fi

	print_info "Cloning repository: $DOTFILES_URL"
	if git clone --recurse-submodules "$DOTFILES_URL"; then
		print_success "Successfully cloned $REPO_NAME"
	else
		print_error "Failed to clone repository"
		print_info "This might be due to:"
		print_info "• Invalid repository URL"
		print_info "• Repository doesn't exist or is private"
		print_info "• Network connectivity issues"
		print_info "• Authentication issues (for private repos)"

		if [[ "$DOTFILES_URL" =~ ^git@ ]]; then
			print_info ""
			print_info "For SSH URLs, make sure you have:"
			print_info "• SSH keys set up and added to your GitHub account"
			print_info "• SSH agent running with your key loaded"
			print_info ""
			print_info "You can test SSH access with: ssh -T git@github.com"
		fi

		exit 1
	fi

	# Step 10: Change to cloned repository directory
	print_step "10/11 Changing to cloned repository directory..."
	cd "$REPO_NAME"
	print_success "Changed to $(pwd)"

	# Step 11: Run bootstrap command
	print_step "11/11 Running bootstrap command..."

	# Check for different bootstrap methods
	if [ -f "Makefile" ] && grep -q "bootstrap" Makefile; then
		print_info "Found Makefile with bootstrap target, running 'make bootstrap'..."
		make bootstrap
		print_success "Bootstrap command completed successfully"
	elif [ -f "bootstrap" ] && [ -x "bootstrap" ]; then
		print_info "Found executable bootstrap script, running './bootstrap'..."
		./bootstrap
		print_success "Bootstrap script completed successfully"
	elif [ -f "bootstrap.sh" ] && [ -x "bootstrap.sh" ]; then
		print_info "Found bootstrap.sh script, running './bootstrap.sh'..."
		./bootstrap.sh
		print_success "Bootstrap script completed successfully"
	else
		print_warning "No standard bootstrap method found"
		print_info "Available files in directory:"
		ls -la
		print_info ""
		print_info "Please look for setup instructions in:"
		print_info "• README.md"
		print_info "• INSTALL.md"
		print_info "• docs/ directory"
		print_info ""
		print_info "Common setup commands to try:"
		print_info "• make install"
		print_info "• make setup"
		print_info "• ./install.sh"
		print_info "• ./setup.sh"
	fi

	setup_complete
}

# Function to display completion message
setup_complete() {
	echo
	echo -e "${GREEN}"
	echo "╔════════════════════════════════════════════════════════════════════════════════════════╗"
	echo "║                                🎉 Setup Complete! 🎉                                   ║"
	echo "╚════════════════════════════════════════════════════════════════════════════════════════╝"
	echo -e "${NC}"

	print_success "Your macOS development environment is now set up!"
	echo
	print_info "Directory structure created:"
	print_info "├── ~/workspace/"
	print_info "│   ├── office/"
	print_info "│   └── github/"
	print_info "│       └── $GITHUB_USERNAME/"
	print_info "│           └── $(basename "$DOTFILES_URL" .git)/ (current directory)"
	echo
	print_info "What's been installed:"
	print_info "✅ Homebrew package manager"
	print_info "✅ Git version control"
	print_info "✅ Workspace directory structure"
	print_info "✅ Your dotfiles repository"
	echo
	print_info "Next steps you might want to consider:"
	print_info "• Configure Git with your name and email:"
	print_info "  git config --global user.name 'Your Name'"
	print_info "  git config --global user.email 'your.email@example.com'"
	echo
	print_info "• Install additional development tools via Homebrew:"
	print_info "  brew install node python3 docker kubectl"
	echo
	print_info "• Set up SSH keys for GitHub:"
	print_info "  ssh-keygen -t ed25519 -C 'your.email@example.com'"
	echo
	print_info "Current location: $(pwd)"
	print_info "Happy coding! 🚀"
}

# Error handling
trap 'print_error "An error occurred. Setup incomplete."; exit 1' ERR

# Run main function
main "$@"
