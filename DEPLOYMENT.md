# 🚀 Hugging Face Deployment Guide for TalentTalk Pro

This guide provides step-by-step instructions for deploying TalentTalk Pro on Hugging Face Spaces using Docker.

## Table of Contents
1. [Prerequisites](#prerequisites)
2. [Creating a Hugging Face Account](#creating-a-hugging-face-account)
3. [Creating a New Space](#creating-a-new-space)
4. [Connecting GitHub Repository](#connecting-github-repository)
5. [Setting Up Environment Variables](#setting-up-environment-variables)
6. [Monitoring Deployment](#monitoring-deployment)
7. [Troubleshooting](#troubleshooting)
8. [Best Practices](#best-practices)

## Prerequisites

Before you begin, ensure you have:
- A GitHub account with this repository
- API keys for:
  - Google Generative AI (Gemini) - **Required**
  - OpenRouter - **Required**
  - AssemblyAI - Optional (for speech-to-text)
  - ElevenLabs - Optional (for text-to-speech)

### Obtaining API Keys

#### Google Generative AI (Gemini)
1. Go to [Google AI Studio](https://makersuite.google.com/app/apikey)
2. Sign in with your Google account
3. Click "Create API Key"
4. Copy and save your API key securely

#### OpenRouter
1. Visit [OpenRouter](https://openrouter.ai/)
2. Sign up or log in
3. Navigate to API Keys section
4. Generate a new API key
5. Copy and save your API key securely

#### AssemblyAI (Optional)
1. Go to [AssemblyAI](https://www.assemblyai.com/)
2. Sign up for an account
3. Navigate to your dashboard
4. Copy your API key from the dashboard

#### ElevenLabs (Optional)
1. Visit [ElevenLabs](https://elevenlabs.io/)
2. Create an account
3. Go to Profile Settings
4. Generate and copy your API key

## Creating a Hugging Face Account

1. **Visit Hugging Face**: Go to [https://huggingface.co/](https://huggingface.co/)
2. **Sign Up**: Click "Sign Up" in the top right corner
3. **Complete Registration**: 
   - Enter your email address
   - Choose a username
   - Create a secure password
   - Verify your email address
4. **Profile Setup**: Complete your profile information (optional but recommended)

## Creating a New Space

1. **Navigate to Spaces**: Click on your profile icon → "Spaces" → "Create new Space"

2. **Configure Space Settings**:
   - **Space name**: `talenttalk-pro` (or your preferred name)
   - **License**: MIT
   - **Select SDK**: Choose "Docker"
   - **Space hardware**: 
     - Start with "CPU basic (free)"
     - Upgrade if needed based on usage
   - **Visibility**: 
     - Public (recommended for showcasing)
     - Private (if you need restricted access)

3. **Create Space**: Click "Create Space" button

## Connecting GitHub Repository

### Method 1: Direct Connection (Recommended)

1. **In Your Space Settings**:
   - Navigate to "Settings" tab in your new Space
   - Scroll to "Repository" section
   - Click "Link to a GitHub repository"

2. **Authorize Hugging Face**:
   - You'll be redirected to GitHub
   - Click "Authorize huggingface" to allow access
   - Select the repositories you want to grant access to

3. **Select Repository**:
   - Choose `ParamJaiswal/TalentTalkPro`
   - Select the branch (usually `main` or `master`)
   - Click "Link Repository"

4. **Automatic Sync**: 
   - Hugging Face will automatically sync with your GitHub repository
   - Any push to the linked branch will trigger a rebuild

### Method 2: Manual Upload

If you prefer not to link GitHub:

1. **Clone Your Space Repository**:
```bash
git clone https://huggingface.co/spaces/YOUR_USERNAME/talenttalk-pro
cd talenttalk-pro
```

2. **Copy Files**:
```bash
# Copy all necessary files from your GitHub repo
cp -r /path/to/TalentTalkPro/* .
```

3. **Push to Hugging Face**:
```bash
git add .
git commit -m "Initial deployment"
git push
```

## Setting Up Environment Variables

Environment variables (secrets) are crucial for the application to function properly.

1. **Navigate to Settings**:
   - Go to your Space
   - Click on "Settings" tab
   - Scroll to "Repository secrets" section

2. **Add Required Secrets**:

   Click "Add a secret" for each of the following:

   **Required Secrets**:
   
   | Name | Value | Description |
   |------|-------|-------------|
   | `GOOGLE_API_KEY` | Your Google API key | For Gemini AI models |
   | `OPENROUTER_API_KEY` | Your OpenRouter key | For AI model routing |
   | `DATABASE_URL` | `sqlite+aiosqlite:///./data/talenttalk.db` | Database configuration |

   **Optional Secrets** (for enhanced features):
   
   | Name | Value | Description |
   |------|-------|-------------|
   | `ASSEMBLYAI_API_KEY` | Your AssemblyAI key | For speech-to-text |
   | `ELEVENLABS_API_KEY` | Your ElevenLabs key | For text-to-speech |
   | `BACKEND_CORS_ORIGINS` | `http://localhost:7860,https://huggingface.co` | CORS configuration |
   | `LOG_LEVEL` | `INFO` or `DEBUG` | Logging verbosity |
   | `ENVIRONMENT` | `production` | Environment identifier |

3. **Save Secrets**:
   - Click "Save" after adding each secret
   - Secrets are encrypted and not visible after saving

4. **Restart Space**:
   - After adding all secrets, restart your Space
   - Click "Factory Reboot" in Settings → "Sleeping time" section

## Monitoring Deployment

### Build Logs

1. **Access Logs**:
   - In your Space, click on "Logs" tab
   - You'll see real-time build and runtime logs

2. **Build Stages to Monitor**:
   ```
   ✅ Installing system dependencies
   ✅ Installing Python dependencies (frontend & backend)
   ✅ Copying application code
   ✅ Starting backend API (port 8000)
   ✅ Starting frontend (port 7860)
   ```

3. **Successful Deployment Indicators**:
   - Log shows: "🎨 Starting Frontend on port 7860..."
   - Log shows: "You can now view your Streamlit app in your browser"
   - Space status shows "Running"
   - Application is accessible at `https://huggingface.co/spaces/YOUR_USERNAME/talenttalk-pro`

### Application Health

1. **Health Check Endpoint**:
   - Access: `https://YOUR_USERNAME-talenttalk-pro.hf.space/health`
   - Should return: `{"status": "healthy", "environment": "production"}`

2. **API Documentation**:
   - Swagger UI: `https://YOUR_USERNAME-talenttalk-pro.hf.space/docs`
   - ReDoc: `https://YOUR_USERNAME-talenttalk-pro.hf.space/redoc`

3. **Application Access**:
   - Main app: `https://YOUR_USERNAME-talenttalk-pro.hf.space`

## Troubleshooting

### Common Issues and Solutions

#### 1. Build Fails - Missing Dependencies

**Symptoms**:
```
ERROR: Could not find a version that satisfies the requirement...
```

**Solution**:
- Verify all dependencies in `backend/requirements.txt` and `frontend/requirements.txt` are available
- Check for typos in package names
- Ensure package versions are compatible with Python 3.10

#### 2. Backend Not Starting

**Symptoms**:
```
Connection refused at http://localhost:8000
```

**Solution**:
- Check environment variables are set correctly
- Verify `GOOGLE_API_KEY` and `OPENROUTER_API_KEY` are valid
- Review backend logs for specific errors
- Ensure `app.main:app` path is correct

#### 3. Frontend Cannot Connect to Backend

**Symptoms**:
- Frontend loads but API calls fail
- "Connection Error" messages in UI

**Solution**:
- Verify `API_URL` environment variable is set
- Check if backend is running: look for "📡 Starting Backend API" in logs
- Increase sleep time in `start_huggingface.sh` if backend takes longer to start
- Verify CORS settings allow frontend domain

#### 4. Database Errors

**Symptoms**:
```
sqlalchemy.exc.OperationalError: unable to open database file
```

**Solution**:
- Ensure `/app/backend/data` directory exists
- Check file permissions
- Verify `DATABASE_URL` is correctly set
- Use `sqlite+aiosqlite:///./data/talenttalk.db` for async SQLite

#### 5. Out of Memory Errors

**Symptoms**:
```
Killed
Process exited with code 137
```

**Solution**:
- Upgrade Space hardware (Settings → Hardware)
- Consider using CPU upgrade or GPU if available
- Optimize model loading (lazy loading)
- Reduce number of concurrent workers

#### 6. Port Conflicts

**Symptoms**:
```
Address already in use
```

**Solution**:
- Ensure only one instance of each service is running
- Check `start_huggingface.sh` doesn't start duplicate processes
- Verify Dockerfile EXPOSE directives are correct

#### 7. SSL/HTTPS Issues

**Symptoms**:
- Mixed content warnings
- API calls blocked by browser

**Solution**:
- Use `https://` URLs in production
- Update `BACKEND_CORS_ORIGINS` to include HTTPS domains
- Ensure frontend uses HTTPS for API calls in production

### Debugging Steps

1. **Check Application Logs**:
```bash
# Access via Hugging Face UI
# Settings → Logs tab
```

2. **Verify Environment Variables**:
- Go to Settings → Repository secrets
- Ensure all required secrets are added
- Check for typos in secret names

3. **Test Locally First**:
```bash
# Build Docker image locally
docker build -t talenttalk-pro .

# Run container
docker run -p 7860:7860 -p 8000:8000 \
  -e GOOGLE_API_KEY=your_key \
  -e OPENROUTER_API_KEY=your_key \
  -e DATABASE_URL=sqlite+aiosqlite:///./data/talenttalk.db \
  talenttalk-pro
```

4. **Check Network Connectivity**:
- Ensure backend and frontend can communicate
- Verify no firewall rules blocking connections
- Test health endpoint

5. **Review Dependency Versions**:
- Ensure all packages are compatible
- Check for known issues with specific versions
- Update dependencies if necessary

## Best Practices

### Security

1. **API Keys**:
   - Never commit API keys to repository
   - Always use Hugging Face Secrets for sensitive data
   - Rotate keys regularly
   - Use separate keys for development and production

2. **Environment Variables**:
   - Use separate configurations for dev/staging/production
   - Document all required environment variables
   - Validate environment variables at startup

3. **CORS Configuration**:
   - Only allow necessary origins
   - Be specific with allowed domains
   - Avoid using wildcard (`*`) in production

### Performance

1. **Resource Optimization**:
   - Start with free tier and upgrade as needed
   - Monitor resource usage in Space dashboard
   - Implement caching where appropriate
   - Use lazy loading for models

2. **Database**:
   - Regular backups of SQLite database
   - Consider PostgreSQL for production with high traffic
   - Implement connection pooling
   - Add database migrations

3. **Logging**:
   - Use structured logging
   - Set appropriate log levels (INFO for production)
   - Monitor logs regularly
   - Set up log rotation

### Maintenance

1. **Regular Updates**:
   - Keep dependencies up to date
   - Monitor security advisories
   - Test updates in staging first
   - Document changes in CHANGELOG

2. **Monitoring**:
   - Set up uptime monitoring
   - Track error rates
   - Monitor API response times
   - Review user feedback

3. **Backups**:
   - Regular database backups
   - Version control for all code
   - Document deployment configurations
   - Keep backup of environment variables

### Scaling

1. **Horizontal Scaling**:
   - Consider load balancing for high traffic
   - Use managed database services
   - Implement caching layer (Redis)
   - Use CDN for static assets

2. **Vertical Scaling**:
   - Upgrade Space hardware as needed
   - Monitor resource utilization
   - Optimize code for performance
   - Profile and identify bottlenecks

## Additional Resources

- [Hugging Face Spaces Documentation](https://huggingface.co/docs/hub/spaces)
- [Docker Documentation](https://docs.docker.com/)
- [FastAPI Documentation](https://fastapi.tiangolo.com/)
- [Streamlit Documentation](https://docs.streamlit.io/)
- [LangGraph Documentation](https://langchain-ai.github.io/langgraph/)

## Support

If you encounter issues not covered in this guide:

1. Check the [GitHub Issues](https://github.com/ParamJaiswal/TalentTalkPro/issues)
2. Review Hugging Face Spaces documentation
3. Ask in Hugging Face Discord/Forums
4. Open a new issue with detailed error logs

---

**Happy Deploying! 🚀**

For questions or contributions, please visit the [GitHub repository](https://github.com/ParamJaiswal/TalentTalkPro).
