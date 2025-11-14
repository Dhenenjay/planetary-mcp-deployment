# 🚀 Quick Start - 3 Steps to Running

## Step 1: Check Prerequisites ✅

- [x] Docker Desktop is installed and **running**
- [x] Your Earth Engine credentials are in `credentials/ee-key.json`

## Step 2: Start the Server 🐳

Open terminal in this folder and run:

```bash
docker-compose up -d --build
```

Wait 2-3 minutes for first-time build. You'll see:
```
✔ Container planetary-mcp  Started
```

## Step 3: Configure Claude Desktop 🤖

1. **Edit Claude Desktop config:**
   - Press `Win+R`, type `%APPDATA%\Claude`, press Enter
   - Open `claude_desktop_config.json`

2. **Replace with this** (update the path if your folder is elsewhere):

```json
{
  "mcpServers": {
    "planetary-mcp": {
      "command": "node",
      "args": ["D:\\earth-engine-mcp-deployment\\mcp-sse-complete.js"],
      "env": {
        "GOOGLE_APPLICATION_CREDENTIALS": "D:\\earth-engine-mcp-deployment\\credentials\\ee-key.json"
      }
    }
  }
}
```

3. **Restart Claude Desktop**

## ✅ Verify It's Working

In Claude Desktop, ask:
```
Search for sentinel datasets
```

You should see Claude using the Earth Engine tools!

---

## 🛠️ Common Commands

**View logs:** `docker-compose logs -f`  
**Stop server:** `docker-compose down`  
**Restart server:** `docker-compose restart`  
**Check status:** `docker-compose ps`

---

## ❓ Need Help?

See the full **README.md** for detailed instructions and troubleshooting.

**Quick health check:**
```bash
curl http://localhost:3000/api/health
```

Should return: `{"ok":true,"time":"..."}`

---

**That's it! You're ready to use all 11 Earth Engine tools in Claude Desktop! 🎉**
