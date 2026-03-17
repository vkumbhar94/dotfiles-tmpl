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
	@echo "🧹 Cleaning target directory..."
	@rm -rf ~/Library/Application\ Support/Übersicht/widgets/*
	@mkdir -p ~/Library/Application\ Support/Übersicht/widgets
	@echo "📋 Copying widgets (excluding disabled ones)..."
	@cd ubersicht/widgets && \
	DISABLED_FILE=".disabled"; \
	for file in *; do \
		if [ "$$file" = ".disabled" ]; then continue; fi; \
		BASENAME=$$(echo "$$file" | sed 's/\.[^.]*$$//'); \
		if [ -f "$$DISABLED_FILE" ] && grep -q "^$$BASENAME$$" "$$DISABLED_FILE" 2>/dev/null; then \
			echo "  ⏭️  Skipping disabled widget: $$file"; \
		else \
			echo "  ✅ Copying: $$file"; \
			cp -r "$$file" ~/Library/Application\ Support/Übersicht/widgets/; \
		fi; \
	done
	@echo "🔄 Reloading Übersicht..."
	@osascript -e 'tell application "Übersicht" to reload widgets' 2>/dev/null || echo "⚠️  Übersicht not running"

.PHONY: bkp-ubersicht
bkp-ubersicht:
	@echo "🔄 Backing up Übersicht widgets..."
	cp -r ~/Library/Application\ Support/Übersicht/widgets ubersicht

.PHONY: ubersicht-disable
ubersicht-disable:
	@if [ -z "$(WIDGET)" ]; then \
		echo "❌ Usage: make ubersicht-disable WIDGET=<widget-name>"; \
		echo "Example: make ubersicht-disable WIDGET=tech-knowledge-base"; \
		exit 1; \
	fi; \
	if ! grep -q "^$(WIDGET)$$" ubersicht/widgets/.disabled 2>/dev/null; then \
		echo "$(WIDGET)" >> ubersicht/widgets/.disabled; \
		echo "✅ Disabled widget: $(WIDGET)"; \
		echo "Run 'make ubersicht' to apply changes."; \
	else \
		echo "⚠️  Widget '$(WIDGET)' is already disabled."; \
	fi

.PHONY: ubersicht-enable
ubersicht-enable:
	@if [ -z "$(WIDGET)" ]; then \
		echo "❌ Usage: make ubersicht-enable WIDGET=<widget-name>"; \
		echo "Example: make ubersicht-enable WIDGET=tech-knowledge-base"; \
		exit 1; \
	fi; \
	if [ -f ubersicht/widgets/.disabled ]; then \
		if grep -q "^$(WIDGET)$$" ubersicht/widgets/.disabled; then \
			grep -v "^$(WIDGET)$$" ubersicht/widgets/.disabled > ubersicht/widgets/.disabled.tmp; \
			mv ubersicht/widgets/.disabled.tmp ubersicht/widgets/.disabled; \
			echo "✅ Enabled widget: $(WIDGET)"; \
			echo "Run 'make ubersicht' to apply changes."; \
		else \
			echo "⚠️  Widget '$(WIDGET)' was not disabled."; \
		fi; \
	else \
		echo "⚠️  No disabled widgets found."; \
	fi

.PHONY: ubersicht-list-disabled
ubersicht-list-disabled:
	@echo "📋 Disabled widgets:"
	@if [ -f ubersicht/widgets/.disabled ]; then \
		grep -v '^#' ubersicht/widgets/.disabled | grep -v '^$$' || echo "  (none)"; \
	else \
		echo "  (none)"; \
	fi
