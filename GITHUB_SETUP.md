# 📤 Sharing via GitHub

## For You (Repository Owner)

### 1. Create GitHub Repository

```bash
# Initialize git (if not already done)
cd D:\earth-engine-mcp-deployment
git init

# Add all files (credentials are excluded by .gitignore)
git add .

# First commit
git commit -m "Initial commit: Planetary MCP deployment package"

# Create private repo on GitHub, then:
git remote add origin https://github.com/YOUR-USERNAME/earth-engine-mcp-deployment.git
git branch -M main
git push -u origin main
```

### 2. Verify Credentials Are NOT Committed

Before pushing, double-check:

```bash
git status
# Should NOT show credentials/ee-key.json

git ls-files credentials/
# Should only show credentials/README.md
```

### 3. Share Repository

**Option A: Private Repo (Recommended)**
- Go to GitHub repo → Settings → Collaborators
- Add your client's GitHub username
- They can clone with: `git clone https://github.com/YOUR-USERNAME/earth-engine-mcp-deployment.git`

**Option B: Public Repo**
- Share the GitHub URL
- Anyone can clone (but no credentials are included)

---

## For Your Client (After Receiving Repository)

### 1. Clone Repository

```bash
git clone https://github.com/YOUR-USERNAME/earth-engine-mcp-deployment.git
cd earth-engine-mcp-deployment
```

### 2. Add Credentials

```bash
# Copy your Earth Engine key to credentials folder
# Windows:
copy "path\to\your-ee-key.json" "credentials\ee-key.json"

# Mac/Linux:
cp /path/to/your-ee-key.json credentials/ee-key.json
```

### 3. Start Server

```bash
docker-compose up -d --build
```

### 4. Configure Claude Desktop

See `QUICKSTART.md` for Claude Desktop configuration steps.

---

## Updating the Deployment

### Push Updates

```bash
git add .
git commit -m "Update: description of changes"
git push
```

### Client Pulls Updates

```bash
git pull
docker-compose up -d --build
```

---

## Security Notes

✅ **Safe to commit:**
- All source code
- Docker configurations
- Documentation
- Empty credentials folder structure

❌ **NEVER commit:**
- `credentials/ee-key.json`
- Any `.env` files
- API keys or secrets

The `.gitignore` file is already configured to protect these files.
