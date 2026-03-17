#!/bin/bash

# macOS First Time Setup Script
# This script helps new macOS users set up their development environment

set -e # Exit on any error

# Temporary file to store user inputs
SETUP_CONFIG_FILE="/tmp/.macos_setup_config"

# Configuration system:
# - set_config "KEY" "value"     : Set a configuration value
# - get_config "KEY" "default"   : Get a configuration value (with optional default)
# - save_config "user" "url"     : Save current required configs (wrapper for convenience)
# - load_config                  : Load all configuration values
# - show_config                  : Display all current configuration values
# - cleanup_config               : Remove temporary configuration file
#
# To extend with new config options:
# 1. Add set_config "NEW_KEY" "value" where needed
# 2. Add NEW_KEY=$(get_config "NEW_KEY") in load_config function
# 3. Add case for "NEW_KEY" in show_config function for proper display
# 4. Update save_config function if the new config should be saved automatically

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

# Function to set a configuration value
set_config() {
	local key="$1"
	local value="$2"
	
	# Create config file if it doesn't exist
	if [ ! -f "$SETUP_CONFIG_FILE" ]; then
		touch "$SETUP_CONFIG_FILE"
	fi
	
	# Remove existing key if it exists, then add new key-value pair
	if grep -q "^${key}=" "$SETUP_CONFIG_FILE" 2>/dev/null; then
		# Use a temporary file for safe replacement
		grep -v "^${key}=" "$SETUP_CONFIG_FILE" > "${SETUP_CONFIG_FILE}.tmp"
		mv "${SETUP_CONFIG_FILE}.tmp" "$SETUP_CONFIG_FILE"
	fi
	
	echo "${key}=\"${value}\"" >> "$SETUP_CONFIG_FILE"
}

# Function to get a configuration value
get_config() {
	local key="$1"
	local default_value="$2"
	
	if [ -f "$SETUP_CONFIG_FILE" ]; then
		local value=$(grep "^${key}=" "$SETUP_CONFIG_FILE" 2>/dev/null | cut -d'=' -f2- | sed 's/^"//;s/"$//')
		if [ -n "$value" ]; then
			echo "$value"
			return 0
		fi
	fi
	
	echo "$default_value"
	return 1
}

# Function to save multiple configuration values
save_config() {
	local github_username="$1"
	local dotfiles_url="$2"
	
	set_config "GITHUB_USERNAME" "$github_username"
	set_config "DOTFILES_URL" "$dotfiles_url"
	# Example of extending with new config:
	# set_config "GIT_EMAIL" "$git_email"
	# set_config "PREFERRED_EDITOR" "$editor"
	print_info "Configuration saved to temporary file"
}

# Function to load configuration from temporary file
load_config() {
	if [ -f "$SETUP_CONFIG_FILE" ]; then
		GITHUB_USERNAME=$(get_config "GITHUB_USERNAME")
		DOTFILES_URL=$(get_config "DOTFILES_URL")
		# Example of extending with new config:
		# GIT_EMAIL=$(get_config "GIT_EMAIL")
		# PREFERRED_EDITOR=$(get_config "PREFERRED_EDITOR" "vim")
		
		# Check if we have the required values
		if [ -n "$GITHUB_USERNAME" ] && [ -n "$DOTFILES_URL" ]; then
			return 0
		fi
	fi
	return 1
}

# Function to check and prompt for reusing previous configuration
check_previous_config() {
	if load_config; then
		echo
		print_info "Found previous configuration:"
		show_config
		echo
		echo -n -e "${PURPLE}Do you want to use the previous configuration? (Y/n): ${NC}"
		read -r reuse_config
		
		if [[ ! $reuse_config =~ ^[Nn]$ ]]; then
			print_success "Using previous configuration"
			return 0
		else
			print_info "Will prompt for new configuration"
			return 1
		fi
	fi
	return 1
}

# Function to display all configuration values
show_config() {
	if [ -f "$SETUP_CONFIG_FILE" ]; then
		print_info "Current configuration:"
		while IFS='=' read -r key value; do
			if [[ "$key" =~ ^[A-Z_]+$ ]] && [ -n "$value" ]; then
				# Remove quotes from value for display
				display_value=$(echo "$value" | sed 's/^"//;s/"$//')
				case "$key" in
					"GITHUB_USERNAME")
						print_info "• GitHub Username: $display_value"
						;;
					"DOTFILES_URL")
						print_info "• Dotfiles URL: $display_value"
						;;
					# Example of extending with new config:
					# "GIT_EMAIL")
					#	print_info "• Git Email: $display_value"
					#	;;
					# "PREFERRED_EDITOR")
					#	print_info "• Preferred Editor: $display_value"
					#	;;
					*)
						# Display any other config values that might be added in the future
						print_info "• $key: $display_value"
						;;
				esac
			fi
		done < "$SETUP_CONFIG_FILE"
	fi
}

# Function to cleanup temporary config file
cleanup_config() {
	if [ -f "$SETUP_CONFIG_FILE" ]; then
		rm -f "$SETUP_CONFIG_FILE"
		print_info "Cleaned up temporary configuration file"
	fi
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

# Function to check SSH keys
check_ssh_keys() {
	local ssh_dir="$HOME/.ssh"
	local private_key="$ssh_dir/id_rsa"
	local public_key="$ssh_dir/id_rsa.pub"
	
	print_info "Checking for SSH keys in ~/.ssh directory..."
	
	if [ ! -d "$ssh_dir" ]; then
		mkdir -p "$ssh_dir"
		chmod 700 "$ssh_dir"
		print_info "Created ~/.ssh directory"
	fi
	
	# Check for existing SSH keys
	if [ -f "$private_key" ] && [ -f "$public_key" ]; then
		print_success "Found RSA SSH key pair (id_rsa/id_rsa.pub)"
		test_ssh_connection
		return 0
	else
		print_warning "No SSH key pair found in ~/.ssh directory"
		setup_ssh_keys
	fi
}

# Function to test SSH connection to GitHub
test_ssh_connection() {
	print_info "Testing SSH connection to GitHub..."
	if ssh -T -o ConnectTimeout=10 -o StrictHostKeyChecking=no git@github.com 2>&1 | grep -q "successfully authenticated"; then
		print_success "SSH connection to GitHub is working"
	else
		print_warning "SSH connection to GitHub failed"
		print_info "You may need to add your SSH key to your GitHub account"
		print_info "Visit: https://github.com/settings/ssh/new"
		echo
		echo -n -e "${PURPLE}Have you added your SSH public key to GitHub? (y/N): ${NC}"
		read -r ssh_configured
		if [[ ! $ssh_configured =~ ^[Yy]$ ]]; then
			print_info "Please add your SSH public key to GitHub and run this script again"
			print_info "Your public key content:"
			echo
			if [ -f "$HOME/.ssh/id_rsa.pub" ]; then
				cat "$HOME/.ssh/id_rsa.pub"
			fi
			echo
			echo -n -e "${PURPLE}Press Enter when you've added the key to GitHub...${NC}"
			read -r
		fi
	fi
}

# Function to guide user through SSH key setup
setup_ssh_keys() {
	print_info "Setting up SSH keys for GitHub access..."
	echo
	print_info "SSH keys are required to clone private repositories and push changes"
	print_info "You have two options:"
	echo
	print_info "1. Copy existing SSH keys to ~/.ssh/ directory"
	print_info "2. Generate new SSH keys"
	echo
	echo -n -e "${PURPLE}Do you have existing SSH keys you want to copy? (y/N): ${NC}"
	read -r has_existing_keys
	
	if [[ $has_existing_keys =~ ^[Yy]$ ]]; then
		print_info "Please copy your SSH key files to ~/.ssh/ directory:"
		print_info "• Private key: ~/.ssh/id_rsa"
		print_info "• Public key: ~/.ssh/id_rsa.pub"
		echo
		print_warning "Make sure to set correct permissions:"
		print_info "chmod 600 ~/.ssh/id_rsa"
		print_info "chmod 644 ~/.ssh/id_rsa.pub"
		echo
		echo -n -e "${PURPLE}Press Enter when you've copied your SSH keys...${NC}"
		read -r
		
		# Re-check after user copies keys
		check_ssh_keys
	else
		echo -n -e "${PURPLE}Enter your email address for the SSH key: ${NC}"
		read -r email
		
		print_info "Generating new RSA 4096-bit SSH key..."
		ssh-keygen -t rsa -b 4096 -C "$email" -f "$HOME/.ssh/id_rsa" -N ""
		chmod 600 "$HOME/.ssh/id_rsa"
		chmod 644 "$HOME/.ssh/id_rsa.pub"
		
		print_success "RSA 4096-bit SSH key generated successfully"
		print_info "Your public key content:"
		echo
		cat "$HOME/.ssh/id_rsa.pub"
		echo
		print_info "Please add this public key to your GitHub account:"
		print_info "1. Go to https://github.com/settings/ssh/new"
		print_info "2. Copy the above public key content"
		print_info "3. Paste it into the 'Key' field"
		print_info "4. Give it a descriptive title"
		print_info "5. Click 'Add SSH key'"
		echo
		echo -n -e "${PURPLE}Press Enter when you've added the key to GitHub...${NC}"
		read -r
	fi
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

	# Check for previous configuration
	USE_PREVIOUS_CONFIG=false
	if check_previous_config; then
		USE_PREVIOUS_CONFIG=true
	fi

	echo
	print_step "Starting macOS development environment setup..."

	# Step 1: Install Homebrew
	print_step "1/12 Installing Homebrew package manager..."
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
	source ~/.zprofile

	# Step 2: Install Git
	print_step "2/12 Installing Git..."
	if command_exists git; then
		print_success "Git is already installed"
		git --version
	else
		print_info "Installing Git via Homebrew..."
		brew install git
		print_success "Git installed successfully"
	fi

	# Step 3: Create ~/workspace directory
	print_step "3/12 Creating ~/workspace directory..."
	if [ ! -d "$HOME/workspace" ]; then
		mkdir -p "$HOME/workspace"
		print_success "Created ~/workspace directory"
	else
		print_success "~/workspace directory already exists"
	fi

	# Step 4: Create ~/workspace/office directory
	print_step "4/12 Creating ~/workspace/office directory..."
	if [ ! -d "$HOME/workspace/office" ]; then
		mkdir -p "$HOME/workspace/office"
		print_success "Created ~/workspace/office directory"
	else
		print_success "~/workspace/office directory already exists"
	fi

	# Step 5: Create ~/workspace/github directory
	print_step "5/12 Creating ~/workspace/github directory..."
	if [ ! -d "$HOME/workspace/github" ]; then
		mkdir -p "$HOME/workspace/github"
		print_success "Created ~/workspace/github directory"
	else
		print_success "~/workspace/github directory already exists"
	fi

	# Step 6: Change directory to ~/workspace/github
	print_step "6/12 Changing to ~/workspace/github directory..."
	cd "$HOME/workspace/github"
	print_success "Changed to $(pwd)"

	# Step 7: Get GitHub username and create directory
	print_step "7/12 Setting up GitHub username directory..."
	echo
	
	if [ "$USE_PREVIOUS_CONFIG" = true ]; then
		print_info "Using previous GitHub username: $GITHUB_USERNAME"
	else
		prompt_input "Enter your GitHub username" "validate_github_username"
		GITHUB_USERNAME="$PROMPT_RESULT"
	fi

	if [ ! -d "$GITHUB_USERNAME" ]; then
		mkdir -p "$GITHUB_USERNAME"
		print_success "Created directory for user: $GITHUB_USERNAME"
	else
		print_success "Directory for user $GITHUB_USERNAME already exists"
	fi

	# Step 8: Check SSH connection to GitHub
	print_step "8/12 Checking SSH connection to GitHub..."
	check_ssh_keys

	# Step 9: Change to username directory
	print_step "9/12 Changing to $GITHUB_USERNAME directory..."
	cd "$GITHUB_USERNAME"
	print_success "Changed to $(pwd)"

	# Step 10: Get dotfiles repo URL and clone
	print_step "10/12 Cloning dotfiles repository..."
	echo
	
	if [ "$USE_PREVIOUS_CONFIG" = true ]; then
		print_info "Using previous dotfiles URL: $DOTFILES_URL"
	else
		print_info "Please provide your dotfiles repository URL"
		print_info "Example: https://github.com/$GITHUB_USERNAME/dotfiles.git"
		print_info "     or: git@github.com:$GITHUB_USERNAME/dotfiles.git"
		echo

		prompt_input "Enter your dotfiles repository URL" "validate_git_url"
		DOTFILES_URL="$PROMPT_RESULT"
	fi

	# Save configuration for future runs
	if [ "$USE_PREVIOUS_CONFIG" != true ]; then
		save_config "$GITHUB_USERNAME" "$DOTFILES_URL"
	fi

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

			# Skip to step 12
			print_step "12/12 Running bootstrap command..."
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

	# Step 11: Change to cloned repository directory
	print_step "11/12 Changing to cloned repository directory..."
	cd "$REPO_NAME"
	print_success "Changed to $(pwd)"

	# Step 12: Run bootstrap command
	print_step "12/12 Running bootstrap command..."

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
	
	# Cleanup temporary configuration file
	cleanup_config
}

# Error handling and cleanup
trap 'print_error "An error occurred. Setup incomplete."; cleanup_config; exit 1' ERR

# Run main function
main "$@"
