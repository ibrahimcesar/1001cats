# Makefile Guide 🍎

This project includes a helpful Makefile with emojis to make development easier and more fun!

## Quick Start

```bash
# Show all available commands
make help

# Install dependencies
make install

# Start development server
make dev
```

## Available Commands

### 📦 Development

- **`make install`** - Install all npm dependencies
  - Automatically checks if npm is available
  - Shows success/error messages

- **`make dev`** - Start the development server
  - Automatically installs dependencies if needed
  - Runs on http://localhost:4321
  - Hot reload enabled

- **`make build`** - Build for production
  - Runs TypeScript checks
  - Optimizes assets
  - Creates dist/ folder

- **`make preview`** - Preview production build locally
  - Automatically builds if needed
  - Tests the production version

### 🔍 Quality Checks

- **`make check`** - Run TypeScript and Astro checks
  - Validates types
  - Checks for errors

- **`make lint`** - Lint and format code
  - Only runs if ESLint is configured
  - Shows helpful message if not configured

- **`make deploy-check`** - Pre-deployment validation
  - Checks for uncommitted changes
  - Runs type checks
  - Builds for production
  - Ensures everything is ready to deploy

### 🗑️ Cleanup

- **`make clean`** - Clean build artifacts
  - Removes dist/ folder
  - Removes .astro cache

- **`make clean-all`** - Clean everything
  - Removes node_modules
  - Removes all caches
  - Fresh start

### ✍️ Content Creation

- **`make new-post`** - Create a new blog post
  - Interactive wizard
  - Asks for all required fields
  - Validates input
  - Creates properly formatted markdown file

### ℹ️ Information

- **`make info`** - Show project information
  - Framework version
  - Project status
  - Dependencies status

- **`make stats`** - Show project statistics
  - Post count
  - Component count
  - File statistics

## Creating a New Blog Post

Run `make new-post` and the interactive wizard will ask you for:

1. **Title** - Your post title (required)
2. **Slug** - Auto-generated from title, or custom
3. **Description** - Max 200 characters (required)
4. **Author** - Defaults to "1001cats"
5. **Category** - Choose from:
   - science
   - philosophy
   - technology
   - discordianism
   - life
   - universe
   - everything
6. **Tags** - Comma-separated, max 5 (Law of Fives!)
7. **Featured Image** - URL and alt text (optional)
8. **Draft Status** - Mark as draft or published
9. **Featured** - Mark as featured post
10. **Series** - Add to a series (optional)

The script will:
- ✅ Validate all input
- ✅ Generate a slug from the title
- ✅ Enforce the Law of Fives (max 5 tags)
- ✅ Create the markdown file with frontmatter
- ✅ Offer to open the file in your editor

### Example

```bash
$ make new-post

✍️  1001 Schrödinger's Cats - New Blog Post Creator ✍️

📝 Post Title:
> Understanding Quantum Superposition

📎 Generated slug: understanding-quantum-superposition
   Press Enter to accept, or type a custom slug:
>

📄 Description (max 200 chars):
> A deep dive into the quantum phenomenon of superposition and its implications

✨ Author (default: 1001cats):
>

📚 Category:
   Available: science, philosophy, technology, discordianism, life, universe, everything
> science

🏷️  Tags (comma-separated, max 5 - Law of Fives!):
> quantum, physics, superposition, science

🖼️  Featured image URL (optional, press Enter to skip):
>

📋 Is this a draft? (y/N):
> n

⭐ Is this a featured post? (y/N):
> y

📖 Is this part of a series? (y/N):
> n

✅ Blog post created successfully!
📁 File: src/content/blog/understanding-quantum-superposition.md
```

## Error Handling

The Makefile includes helpful error messages:

- 🔴 **Red messages** - Errors that stop execution
- 🟡 **Yellow messages** - Warnings or informational
- 🟢 **Green messages** - Success messages
- 🔵 **Blue messages** - Command headers

### Common Errors

**"npm not found"**
```
❌ Error: npm not found. Please install Node.js first.
```
→ Install Node.js from https://nodejs.org

**"node_modules not found"**
```
⚠️  node_modules not found. Running install first...
```
→ Makefile automatically runs `make install`

**"Build failed"**
```
❌ Build failed. Check the errors above.
```
→ Look at the TypeScript errors in the output

**"You have uncommitted changes"**
```
❌ You have uncommitted changes!
```
→ Commit your changes before running `make deploy-check`

## Tips

1. **Always start with `make help`** to see available commands

2. **Use `make info`** to check project status

3. **Run `make deploy-check`** before deploying to catch issues

4. **Use `make new-post`** instead of manually creating files

5. **The Makefile auto-installs dependencies** when needed

## Customization

You can edit the Makefile to add your own commands. Just follow the pattern:

```makefile
my-command: ## 🎯 Description here
	@echo "$(BLUE)🎯 Doing something...$(NC)"
	@your-command-here
```

## Discordian Philosophy

The Makefile embraces chaos while providing structure:
- 🍎 Emojis make it fun
- 🎨 Colors make it clear
- 🔄 Automation reduces friction
- 📊 Stats show progress

**All commands work in harmony with disorder!**

---

**Hail Eris! All Hail Discordia! 🍎**
