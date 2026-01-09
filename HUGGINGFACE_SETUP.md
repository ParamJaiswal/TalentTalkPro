# Quick Hugging Face Space Connection Guide

## Step 1: Find Your Space URL

Your Hugging Face Space URL should look like:
```
https://huggingface.co/spaces/YOUR_USERNAME/YOUR_SPACE_NAME
```

For example: `https://huggingface.co/spaces/ParamJaiswal/TalentTalkPro`

## Step 2: Add Hugging Face as a Git Remote

Run this command in your terminal (replace `YOUR_USERNAME` and `YOUR_SPACE_NAME` with your actual values):

```bash
cd /home/runner/work/TalentTalkPro/TalentTalkPro
git remote add hf https://huggingface.co/spaces/YOUR_USERNAME/YOUR_SPACE_NAME
```

Example:
```bash
git remote add hf https://huggingface.co/spaces/ParamJaiswal/TalentTalkPro
```

## Step 3: Push Code to Hugging Face

```bash
# Make sure all files are committed
git add .
git commit -m "Add Hugging Face deployment configuration"

# Push to Hugging Face Space
git push hf main
```

**Note**: You'll be prompted for your Hugging Face credentials:
- **Username**: Your Hugging Face username
- **Password**: Use your Hugging Face **Access Token** (NOT your account password)

### How to Get Your Hugging Face Access Token:
1. Go to https://huggingface.co/settings/tokens
2. Click "New token"
3. Give it a name (e.g., "TalentTalkPro")
4. Select "Write" access
5. Click "Generate"
6. Copy the token and use it as your password when pushing

## Step 4: Configure Environment Variables

After pushing, you need to add your API keys:

1. Go to your Space page: `https://huggingface.co/spaces/YOUR_USERNAME/YOUR_SPACE_NAME`
2. Click on **"Settings"** tab
3. Scroll down to **"Repository secrets"** section
4. Click **"Add a new secret"** for each:

### Required Secrets:
- **Name**: `GOOGLE_API_KEY` → **Value**: Your Google AI API key
- **Name**: `OPENROUTER_API_KEY` → **Value**: Your OpenRouter API key  
- **Name**: `ASSEMBLYAI_API_KEY` → **Value**: Your AssemblyAI API key
- **Name**: `ELEVENLABS_API_KEY` → **Value**: Your ElevenLabs API key

### Optional Secrets (with defaults):
- **Name**: `DATABASE_URL` → **Value**: `sqlite+aiosqlite:///./talenttalk.db`
- **Name**: `BACKEND_CORS_ORIGINS` → **Value**: `*`

5. Click **"Save"** after adding each secret

## Step 5: Wait for Build

- Your Space will automatically start building
- This takes about 5-10 minutes
- Watch the build logs in the "Logs" tab
- Once complete, your app will be live!

## Alternative Method: Upload Files Directly

If you prefer not to use Git, you can upload files directly:

1. Go to your Space page
2. Click **"Files and versions"** tab
3. Click **"Add file"** → **"Upload files"**
4. Upload all the files from your repository
5. Make sure to include:
   - `Dockerfile`
   - `start_huggingface.sh`
   - `README.md`
   - `.dockerignore`
   - All `backend/` files
   - All `frontend/` files
6. Commit the files

## Troubleshooting

### Authentication Failed
If `git push` fails with authentication error:
- Make sure you're using your **Access Token** as password, not your account password
- Check token has "Write" permissions
- Try: `git config credential.helper store` to save credentials

### Build Failed
- Check the "Logs" tab in your Space
- Verify all environment variables are set
- Make sure all required files are pushed

### Space Not Starting
- Verify all 4 required API keys are configured
- Check if the keys are valid
- Look for error messages in the Logs

## Need Help?

See the full deployment guide in [DEPLOYMENT.md](./DEPLOYMENT.md) for detailed troubleshooting and configuration options.
