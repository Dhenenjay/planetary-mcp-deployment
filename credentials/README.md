# 🔑 Credentials Setup

## Add Your Earth Engine Service Account Key

1. **Get your service account key** from Google Cloud Console
2. **Save it as:** `ee-key.json` in this folder
3. **File location should be:** `credentials/ee-key.json`

## Important Notes

- ⚠️ **Never commit credentials to Git**
- ✅ This folder is already in `.gitignore`
- 🔒 Credentials are mounted as read-only in Docker

## Example Structure

Your `ee-key.json` should look like:

```json
{
  "type": "service_account",
  "project_id": "your-project",
  "private_key_id": "...",
  "private_key": "-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----\n",
  "client_email": "your-service-account@your-project.iam.gserviceaccount.com",
  ...
}
```

## Verification

After adding your key, verify it's in place:

```bash
# Windows
dir ee-key.json

# Mac/Linux
ls -la ee-key.json
```

Then start the container and it will automatically use this key!
