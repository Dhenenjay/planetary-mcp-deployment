# 🌍 Planetary MCP - Docker Deployment Package

**Complete Earth Engine MCP Server with Claude Desktop Integration**

This package contains everything needed to run the Earth Engine MCP server in a Docker container on any platform (Windows, Mac, Linux, AWS EC2, etc.).

---

## 📦 What's Included

- **Dockerized Next.js Server** - Fully containerized application
- **MCP Bridge** - Connect Claude Desktop to the server
- **11 Earth Engine Tools** - All geospatial analysis capabilities
- **Health Monitoring** - Automatic health checks
- **Production Ready** - Optimized for deployment

---

## 🚀 Quick Start (5 Minutes)

### Prerequisites

1. **Docker Desktop** installed and running ([Download](https://www.docker.com/products/docker-desktop/))
2. **Google Earth Engine Service Account Key** (JSON file)
3. **Node.js** (for Claude Desktop bridge only)

### Step 1: Place Your Credentials

```bash
# Copy your Earth Engine service account key to:
credentials/ee-key.json
```

**Important:** Make sure your credentials file is named exactly `ee-key.json` and is in the `credentials/` folder.

### Step 2: Start the Server

```bash
# Open terminal in this directory and run:
docker-compose up -d --build
```

This will:
- Build the Docker image (~3-5 minutes first time)
- Start the container
- Expose the server on `http://localhost:3000`

### Step 3: Verify It's Working

```bash
# Check container status
docker-compose ps

# Test health endpoint
curl http://localhost:3000/api/health
```

You should see: `{"ok":true,"time":"..."}`

### Step 4: Configure Claude Desktop

1. Open Claude Desktop settings
2. Edit the MCP configuration file:
   - **Windows**: `%APPDATA%\Claude\claude_desktop_config.json`
   - **Mac/Linux**: `~/.config/Claude/claude_desktop_config.json`

3. Add this configuration (update paths for your system):

```json
{
  "mcpServers": {
    "planetary-mcp": {
      "command": "node",
      "args": ["<FULL_PATH_TO_THIS_FOLDER>/mcp-sse-complete.js"],
      "env": {
        "GOOGLE_APPLICATION_CREDENTIALS": "<FULL_PATH_TO_THIS_FOLDER>/credentials/ee-key.json"
      }
    }
  }
}
```

**Example for Windows:**
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

4. Restart Claude Desktop

### Step 5: Test in Claude

Open Claude Desktop and try:
```
Search for sentinel datasets in Earth Engine
```

---

## 🛠️ Management Commands

### View Logs
```bash
docker-compose logs -f
```

### Stop Server
```bash
docker-compose down
```

### Restart Server
```bash
docker-compose restart
```

### Check Status
```bash
docker-compose ps
```

### Rebuild (after code changes)
```bash
docker-compose up -d --build
```

---

## 🌟 Available Tools

Once configured, Claude Desktop will have access to:

### Core Tools
1. **earth_engine_data** - Search datasets, get geometries, filter collections
2. **earth_engine_process** - Calculate indices (NDVI, EVI, etc.), create composites, terrain analysis
3. **earth_engine_export** - Generate thumbnails, export data, create map tiles
4. **earth_engine_system** - Health checks, execute custom code, system info
5. **earth_engine_map** - Create interactive web maps

### Geospatial Models
6. **wildfire_risk_assessment** - Comprehensive wildfire risk analysis
7. **flood_risk_assessment** - Flood risk based on terrain and precipitation
8. **agricultural_monitoring** - Crop health and agricultural conditions
9. **deforestation_detection** - Forest loss detection between time periods
10. **water_quality_monitoring** - Water quality using spectral indices
11. **crop_classification** - ML-based crop and land cover classification

---

## 🔍 Testing

### Test Health Endpoint
```bash
curl http://localhost:3000/api/health
```

### Test Earth Engine Connection (PowerShell)
```powershell
$body = @{ tool = "earth_engine_system"; arguments = @{ operation = "health" } } | ConvertTo-Json
Invoke-RestMethod -Method POST -Uri "http://localhost:3000/api/mcp/sse" -ContentType "application/json" -Body $body
```

### Test Data Search (PowerShell)
```powershell
$body = @{ tool = "earth_engine_data"; arguments = @{ operation = "search"; query = "sentinel"; limit = 5 } } | ConvertTo-Json
Invoke-RestMethod -Method POST -Uri "http://localhost:3000/api/mcp/sse" -ContentType "application/json" -Body $body
```

---

## 🚨 Troubleshooting

### Container Won't Start

```bash
# Check logs for errors
docker-compose logs

# Try rebuilding from scratch
docker-compose down -v
docker-compose up -d --build
```

### Port 3000 Already in Use

**Windows:**
```powershell
# Find what's using port 3000
netstat -ano | findstr :3000

# Stop the process (replace <PID>)
Stop-Process -Id <PID> -Force
```

**Mac/Linux:**
```bash
# Find what's using port 3000
lsof -i :3000

# Kill the process
kill -9 <PID>
```

### Docker Desktop Not Running

Make sure Docker Desktop is started before running `docker-compose` commands.

### Earth Engine Authentication Fails

1. Verify your credentials file exists: `credentials/ee-key.json`
2. Check the file is valid JSON
3. Ensure the service account has Earth Engine access
4. Restart container: `docker-compose restart`

### Claude Desktop Can't Connect

1. Verify the server is running: `docker-compose ps`
2. Test health endpoint: `curl http://localhost:3000/api/health`
3. Check Claude Desktop config paths are absolute (not relative)
4. Restart Claude Desktop after config changes

---

## 🌐 Deploying to Cloud (AWS EC2, Azure, GCP)

This same Docker setup works on any cloud platform:

### AWS EC2 / Linux Server

```bash
# 1. Install Docker
sudo yum install docker -y  # Amazon Linux
# OR
sudo apt install docker.io -y  # Ubuntu

sudo systemctl start docker
sudo systemctl enable docker

# 2. Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# 3. Upload this folder to server
scp -r earth-engine-mcp-deployment/ user@server:~/

# 4. Start container
cd earth-engine-mcp-deployment
docker-compose up -d --build

# 5. Verify
curl http://localhost:3000/api/health
```

### Connect Claude Desktop to Remote Server

Update your Claude Desktop config to point to the server:

```json
{
  "mcpServers": {
    "planetary-mcp": {
      "command": "node",
      "args": ["<PATH_TO>/mcp-sse-complete.js"],
      "env": {
        "MCP_SERVER_URL": "http://YOUR-SERVER-IP:3000"
      }
    }
  }
}
```

---

## 📊 Performance & Resources

### Container Resources
- **CPU**: 1-2 cores recommended
- **Memory**: 2-4 GB recommended
- **Disk**: ~500 MB for container + data

### Response Times
- Health check: <100ms
- Dataset search: <1s
- NDVI calculation: 1-5s
- Crop classification: 20-60s
- Interactive maps: 5-15s

---

## 🔒 Security Notes

- Credentials are mounted as read-only in the container
- No credentials are embedded in the Docker image
- Service runs on localhost by default (not exposed externally)
- For production, use reverse proxy (Nginx) with SSL

---

## 📝 File Structure

```
earth-engine-mcp-deployment/
├── README.md                    # This file
├── Dockerfile                   # Container definition
├── docker-compose.yml          # Orchestration config
├── .dockerignore               # Files to exclude
├── package.json                # Dependencies
├── next.config.ts              # Next.js config
├── tsconfig.json               # TypeScript config
├── mcp-sse-complete.js         # MCP bridge for Claude Desktop
├── credentials/                # Your credentials
│   └── ee-key.json            # Earth Engine service account key
├── src/                        # Core MCP implementation
│   ├── mcp/                   # MCP server & tools
│   ├── gee/                   # Earth Engine client
│   └── ...
├── app/                        # Next.js API routes
│   └── api/
│       ├── health/            # Health check endpoint
│       └── mcp/               # MCP endpoints
└── public/                     # Static assets
```

---

## 🆘 Support

### Common Issues

**Q: Tools not showing in Claude Desktop**  
A: Restart Claude Desktop after editing config file

**Q: "Connection refused" errors**  
A: Check if container is running with `docker-compose ps`

**Q: Earth Engine authentication errors**  
A: Verify `credentials/ee-key.json` is valid and service account has EE access

**Q: Container exits immediately**  
A: Check logs with `docker-compose logs` for error messages

### Getting Help

1. Check logs: `docker-compose logs`
2. Verify health: `curl http://localhost:3000/api/health`
3. Test Earth Engine auth manually
4. Review container status: `docker-compose ps`

---

## 📄 License

This package is provided for deployment and use. See main repository for license details.

---

## ✅ Quick Checklist

Before contacting support, verify:

- [ ] Docker Desktop is running
- [ ] `credentials/ee-key.json` exists and is valid
- [ ] Container is running: `docker-compose ps` shows "healthy"
- [ ] Health endpoint responds: `curl http://localhost:3000/api/health`
- [ ] Claude Desktop config has correct absolute paths
- [ ] Claude Desktop was restarted after config changes

---

**Ready to deploy? Start with Step 1 above! 🚀**
