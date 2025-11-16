.PHONY: help dev build preview clean install new-post lint check deploy

# Colors and emojis for beautiful output
BLUE := \033[0;34m
GREEN := \033[0;32m
YELLOW := \033[0;33m
RED := \033[0;31m
NC := \033[0m # No Color

help: ## 📚 Show this help message
	@echo ""
	@echo "$(BLUE)🍎 1001 Schrödinger's Cats - Makefile Commands 🍎$(NC)"
	@echo ""
	@echo "$(GREEN)Available commands:$(NC)"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  $(YELLOW)%-15s$(NC) %s\n", $$1, $$2}'
	@echo ""
	@echo "$(BLUE)Example: make dev$(NC)"
	@echo ""

install: ## 📦 Install dependencies
	@echo "$(BLUE)📦 Installing dependencies...$(NC)"
	@if command -v npm >/dev/null 2>&1; then \
		npm install && \
		echo "$(GREEN)✅ Dependencies installed successfully!$(NC)"; \
	else \
		echo "$(RED)❌ Error: npm not found. Please install Node.js first.$(NC)" >&2; \
		exit 1; \
	fi

dev: ## 🚀 Start development server
	@echo "$(BLUE)🚀 Starting development server...$(NC)"
	@if [ ! -d "node_modules" ]; then \
		echo "$(YELLOW)⚠️  node_modules not found. Running install first...$(NC)"; \
		make install; \
	fi
	@echo "$(GREEN)🌈 Server starting at http://localhost:4321$(NC)"
	@npm run dev || (echo "$(RED)❌ Failed to start dev server$(NC)" >&2; exit 1)

build: ## 🏗️  Build for production
	@echo "$(BLUE)🏗️  Building for production...$(NC)"
	@if [ ! -d "node_modules" ]; then \
		echo "$(YELLOW)⚠️  node_modules not found. Running install first...$(NC)"; \
		make install; \
	fi
	@npm run build && \
		echo "$(GREEN)✅ Build completed successfully!$(NC)" || \
		(echo "$(RED)❌ Build failed. Check the errors above.$(NC)" >&2; exit 1)

preview: ## 👀 Preview production build
	@echo "$(BLUE)👀 Starting preview server...$(NC)"
	@if [ ! -d "dist" ]; then \
		echo "$(YELLOW)⚠️  No production build found. Running build first...$(NC)"; \
		make build; \
	fi
	@npm run preview || (echo "$(RED)❌ Failed to start preview server$(NC)" >&2; exit 1)

check: ## 🔍 Run TypeScript and Astro checks
	@echo "$(BLUE)🔍 Running type checks...$(NC)"
	@npm run astro check && \
		echo "$(GREEN)✅ No type errors found!$(NC)" || \
		(echo "$(RED)❌ Type errors detected. Please fix them.$(NC)" >&2; exit 1)

lint: ## 🧹 Lint and format code (if configured)
	@echo "$(BLUE)🧹 Linting code...$(NC)"
	@if [ -f ".eslintrc.json" ] || [ -f ".eslintrc.js" ]; then \
		npm run lint 2>/dev/null && echo "$(GREEN)✅ Code looks good!$(NC)"; \
	else \
		echo "$(YELLOW)⚠️  No linter configured. Skipping...$(NC)"; \
	fi

clean: ## 🗑️  Clean build artifacts
	@echo "$(BLUE)🗑️  Cleaning build artifacts...$(NC)"
	@rm -rf dist .astro node_modules/.astro && \
		echo "$(GREEN)✅ Cleaned successfully!$(NC)"

clean-all: clean ## 🧨 Clean everything (including node_modules)
	@echo "$(BLUE)🧨 Removing node_modules...$(NC)"
	@rm -rf node_modules && \
		echo "$(GREEN)✅ Everything cleaned!$(NC)"

new-post: ## ✍️  Create a new blog post
	@echo "$(BLUE)✍️  Creating a new blog post...$(NC)"
	@if [ ! -f "scripts/new-post.sh" ]; then \
		echo "$(RED)❌ Error: scripts/new-post.sh not found$(NC)" >&2; \
		exit 1; \
	fi
	@chmod +x scripts/new-post.sh
	@./scripts/new-post.sh

deploy-check: ## 🚦 Pre-deployment checks
	@echo "$(BLUE)🚦 Running pre-deployment checks...$(NC)"
	@echo "$(YELLOW)1. Checking for uncommitted changes...$(NC)"
	@if [ -n "$$(git status --porcelain)" ]; then \
		echo "$(RED)❌ You have uncommitted changes!$(NC)" >&2; \
		git status --short; \
		exit 1; \
	else \
		echo "$(GREEN)✅ Working directory clean$(NC)"; \
	fi
	@echo "$(YELLOW)2. Running type checks...$(NC)"
	@make check
	@echo "$(YELLOW)3. Building for production...$(NC)"
	@make build
	@echo "$(GREEN)🎉 All checks passed! Ready to deploy!$(NC)"

info: ## ℹ️  Show project information
	@echo ""
	@echo "$(BLUE)🍎 1001 Schrödinger's Cats$(NC)"
	@echo "$(YELLOW)A Discordian blog on science, philosophy, life, the universe, and everything$(NC)"
	@echo ""
	@echo "$(GREEN)Project Information:$(NC)"
	@echo "  📁 Framework: Astro $(shell cat package.json | grep '"astro"' | cut -d'"' -f4)"
	@echo "  🎨 Styling: Tailwind CSS"
	@echo "  📝 Language: TypeScript"
	@echo "  🌈 Theme: Time-based (4 themes)"
	@echo "  💬 Comments: Giscus (GitHub Discussions)"
	@echo ""
	@if [ -d "node_modules" ]; then \
		echo "  $(GREEN)✅ Dependencies installed$(NC)"; \
	else \
		echo "  $(RED)❌ Dependencies not installed (run 'make install')$(NC)"; \
	fi
	@if [ -d "dist" ]; then \
		echo "  $(GREEN)✅ Production build exists$(NC)"; \
	else \
		echo "  $(YELLOW)⚠️  No production build (run 'make build')$(NC)"; \
	fi
	@echo ""

stats: ## 📊 Show project statistics
	@echo "$(BLUE)📊 Project Statistics$(NC)"
	@echo ""
	@echo "$(GREEN)Blog Posts:$(NC)"
	@find src/content/blog -name "*.md" -type f | wc -l | xargs echo "  📝 Total posts:"
	@echo ""
	@echo "$(GREEN)Code Statistics:$(NC)"
	@echo "  📄 Astro components: $$(find src -name "*.astro" | wc -l)"
	@echo "  📘 TypeScript files: $$(find src -name "*.ts" | wc -l)"
	@echo "  🎨 CSS files: $$(find src -name "*.css" | wc -l)"
	@echo ""

# Hail Eris! All Hail Discordia! 🍎
