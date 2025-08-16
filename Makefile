# === Constants ===
BREWFILE := $(HOME)/.Brewfile
BACKUP := $(BREWFILE).bak

default: stow

.PHONY: stow
stow:
	stow --target ~ --dotfiles */

.PHONY: unstow
unstow:
	stow --target ~ --dotfiles -D */

.PHONY: restow
restow: unstow stow

.PHONY: brew-bundle-dump
brew-bundle-dump:
	@if [ -f $(BREWFILE) ]; then \
		echo "🛡️  Backing up existing Brewfile to $(BACKUP)"; \
		cp $(BREWFILE) $(BACKUP); \
	fi; \
	echo "📦 Attempting to dump new Brewfile..."; \
	if brew bundle dump --describe --global --force; then \
		echo "✅ Brewfile dumped successfully."; \
	else \
		echo "❌ Dump failed. Restoring previous Brewfile from $(BACKUP)"; \
		if [ -f $(BACKUP) ]; then \
			cp $(BACKUP) $(BREWFILE); \
			echo "♻️  Restore complete."; \
		else \
			echo "⚠️  No backup found to restore."; \
		fi; \
		exit 1; \
	fi


.PHONY: brew-restore-file
brew-restore-file:
	@if [ ! -f $(BACKUP) ]; then \
		echo "❌ No backup found at $(BACKUP)"; \
		exit 1; \
	else \
		echo "♻️  Restoring Brewfile from $(BACKUP)"; \
		cp $(BACKUP) $(BREWFILE); \
		echo "✅ Restore complete."; \
	fi

.PHONY: brew-bundle
brew-bundle:
	@if [ -f $(BREWFILE) ]; then \
		echo "📦 Installing from $(BREWFILE)..."; \
		brew bundle --global; \
		echo "✅ All packages installed."; \
	else \
		echo "❌ No Brewfile found at $(BREWFILE)"; \
		exit 1; \
	fi

.PHONY: ubersicht
ubersicht:
	@echo "🔄 Refreshing Übersicht widgets..."
	mkdir -p ~/Library/Application\ Support/Übersicht/widgets
	cp -r ubersicht/widgets/* ~/Library/Application\ Support/Übersicht/widgets
	@osascript -e 'tell application "Übersicht" to reload widgets'

.PHONY: bkp-ubersicht
bkp-ubersicht:
	@echo "🔄 Backing up Übersicht widgets..."
	cp -r ~/Library/Application\ Support/Übersicht/widgets ubersicht
