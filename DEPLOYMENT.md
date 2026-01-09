# Deployment Guide for TalentTalkPro on Hugging Face Spaces

This guide provides comprehensive instructions for deploying TalentTalkPro on Hugging Face Spaces using Docker SDK.

## 📋 Table of Contents

1. [Prerequisites](#prerequisites)
2. [Step-by-Step Deployment](#step-by-step-deployment)
3. [Environment Variables Configuration](#environment-variables-configuration)
4. [Troubleshooting](#troubleshooting)
5. [Local Docker Testing](#local-docker-testing)
6. [Advanced Configuration](#advanced-configuration)

## 🔧 Prerequisites

Before deploying TalentTalkPro, ensure you have:

### 1. Hugging Face Account
- Create a free account at [huggingface.co](https://huggingface.co)
- Verify your email address

### 2. Required API Keys

You'll need the following API keys:

#### Google Generative AI API Key
- **Purpose**: Powers the AI interview agent and language understanding
- **How to get**:
  1. Visit [Google AI Studio](https://makersuite.google.com/app/apikey)
  2. Sign in with your Google account
  3. Click "Create API Key"
  4. Copy and save the key securely

#### OpenRouter API Key
- **Purpose**: Provides access to multiple AI models for enhanced capabilities
- **How to get**:
  1. Visit [OpenRouter](https://openrouter.ai)
  2. Sign up for an account
  3. Navigate to API Keys section
  4. Generate a new API key
  5. Copy and save the key

#### AssemblyAI API Key
- **Purpose**: Converts speech to text for audio responses
- **How to get**:
  1. Visit [AssemblyAI](https://www.assemblyai.com)
  2. Sign up for a free account
  3. Go to your Dashboard
  4. Copy your API key from the home page

#### ElevenLabs API Key
- **Purpose**: Converts text to speech for AI interviewer responses
- **How to get**:
  1. Visit [ElevenLabs](https://elevenlabs.io)
  2. Create an account
  3. Navigate to Profile Settings → API Keys
  4. Copy your API key

### 3. GitHub Repository Access
- Fork or clone the TalentTalkPro repository
- Ensure you have admin access to the repository

## 🚀 Step-by-Step Deployment

Follow these steps to deploy TalentTalkPro on Hugging Face Spaces:

### Step 1: Prepare Your Repository

1. **Fork the Repository** (if you haven't already)
   - Go to [github.com/ParamJaiswal/TalentTalkPro](https://github.com/ParamJaiswal/TalentTalkPro)
   - Click the "Fork" button in the top right
   - Wait for the fork to complete

2. **Clone Your Fork Locally** (optional, for testing)
   ```bash
   git clone https://github.com/YOUR_USERNAME/TalentTalkPro.git
   cd TalentTalkPro
   ```

### Step 2: Create a Hugging Face Space

1. **Navigate to Spaces**
   - Go to [huggingface.co/spaces](https://huggingface.co/spaces)
   - Click "Create new Space"

2. **Configure Your Space**
   - **Space name**: `TalentTalkPro` (or your preferred name)
   - **License**: Choose appropriate license (e.g., MIT)
   - **Select SDK**: Choose **Docker**
   - **Space hardware**: Start with "CPU basic" (free tier)
   - **Visibility**: Choose Public or Private

3. **Click "Create Space"**

### Step 3: Connect GitHub Repository

You have two options to connect your code:

#### Option A: Push to Hugging Face Git Repository (Recommended)

1. **Add Hugging Face remote**
   ```bash
   cd TalentTalkPro
   git remote add hf https://huggingface.co/spaces/YOUR_USERNAME/TalentTalkPro
   ```

2. **Push your code**
   ```bash
   git push hf main
   ```

#### Option B: Use GitHub Integration

1. In your Space settings, go to "Files and versions"
2. Look for GitHub repository connection option
3. Authorize Hugging Face to access your GitHub
4. Select your TalentTalkPro repository
5. Enable automatic sync

### Step 4: Configure Environment Variables

This is the most critical step for a successful deployment.

1. **Navigate to Space Settings**
   - Go to your Space page
   - Click "Settings" tab
   - Scroll to "Repository secrets"

2. **Add Required Secrets**

   Click "Add a new secret" for each of the following:

   | Secret Name | Value | Example |
   |-------------|-------|---------|
   | `GOOGLE_API_KEY` | Your Google AI API key | `AIzaSyC...` |
   | `OPENROUTER_API_KEY` | Your OpenRouter API key | `sk-or-v1-...` |
   | `ASSEMBLYAI_API_KEY` | Your AssemblyAI API key | `abc123def...` |
   | `ELEVENLABS_API_KEY` | Your ElevenLabs API key | `sk_...` |

3. **Add Optional Secrets** (with defaults)

   | Secret Name | Default Value | Notes |
   |-------------|---------------|-------|
   | `DATABASE_URL` | `sqlite+aiosqlite:///./talenttalk.db` | SQLite database path |
   | `BACKEND_CORS_ORIGINS` | `*` | Allow all origins (for development) |
   | `API_URL` | `http://localhost:8000/api/v1` | Backend API URL |
   | `ENVIRONMENT` | `production` | Deployment environment |
   | `LOG_LEVEL` | `INFO` | Logging level |

4. **Save and Rebuild**
   - After adding all secrets, click "Save"
   - Go back to "App" tab
   - Your Space will automatically rebuild with the new environment variables

### Step 5: Monitor Deployment

1. **Watch Build Logs**
   - Stay on the Space page
   - The build logs will appear in real-time
   - This process typically takes 5-10 minutes

2. **Wait for "Running" Status**
   - Once the build completes, status will change to "Running"
   - A green indicator means your app is live

3. **Access Your Application**
   - Your Space URL: `https://huggingface.co/spaces/YOUR_USERNAME/TalentTalkPro`
   - The Streamlit interface should load automatically

## 🔐 Environment Variables Configuration

### Required Variables

#### `GOOGLE_API_KEY`
- **Description**: Google Generative AI API key for language model
- **Required**: Yes
- **Format**: String starting with `AIza`
- **Where to get**: [Google AI Studio](https://makersuite.google.com/app/apikey)

#### `OPENROUTER_API_KEY`
- **Description**: OpenRouter API key for model access
- **Required**: Yes
- **Format**: String starting with `sk-or-v1-`
- **Where to get**: [OpenRouter](https://openrouter.ai)

#### `ASSEMBLYAI_API_KEY`
- **Description**: AssemblyAI API key for speech-to-text
- **Required**: Yes
- **Format**: Alphanumeric string
- **Where to get**: [AssemblyAI Dashboard](https://www.assemblyai.com/dashboard)

#### `ELEVENLABS_API_KEY`
- **Description**: ElevenLabs API key for text-to-speech
- **Required**: Yes
- **Format**: String starting with `sk_`
- **Where to get**: [ElevenLabs Settings](https://elevenlabs.io/app/settings)

### Optional Variables

#### `DATABASE_URL`
- **Description**: Database connection string
- **Default**: `sqlite+aiosqlite:///./talenttalk.db`
- **Format**: SQLAlchemy database URL
- **Example**: `postgresql+asyncpg://user:pass@host/db` (for PostgreSQL)

#### `BACKEND_CORS_ORIGINS`
- **Description**: Comma-separated list of allowed CORS origins
- **Default**: `*` (allow all - use only for development)
- **Format**: `https://domain1.com,https://domain2.com`
- **Production Example**: `https://huggingface.co`

#### `API_URL`
- **Description**: Backend API URL for frontend to connect
- **Default**: `http://localhost:8000/api/v1`
- **Note**: In Docker, localhost works because both services run in same container

#### `ENVIRONMENT`
- **Description**: Application environment
- **Default**: `production`
- **Options**: `development`, `staging`, `production`

#### `LOG_LEVEL`
- **Description**: Logging verbosity
- **Default**: `INFO`
- **Options**: `DEBUG`, `INFO`, `WARNING`, `ERROR`, `CRITICAL`

## 🔧 Troubleshooting

### Common Issues and Solutions

#### 1. Build Fails During Installation

**Symptom**: Error during `pip install` step

**Solutions**:
- Check if `requirements.txt` files are properly formatted
- Ensure no conflicting package versions
- Check build logs for specific package errors
- Try upgrading pip: Add `RUN pip install --upgrade pip` in Dockerfile

#### 2. Application Starts But Crashes Immediately

**Symptom**: Space shows "Running" then "Error"

**Possible Causes**:
- Missing or invalid API keys
- Database initialization failure
- Port conflicts

**Solutions**:
1. Check all required environment variables are set
2. Verify API keys are valid by testing them separately
3. Check Space logs for specific error messages
4. Ensure `static` directory is created (should be automatic)

#### 3. Backend Fails to Start

**Symptom**: "Backend failed to start!" in logs

**Solutions**:
- Check if port 8000 is available
- Verify `app.main:app` path is correct
- Check for syntax errors in backend code
- Review backend logs for detailed error messages

#### 4. Frontend Can't Connect to Backend

**Symptom**: Frontend loads but shows connection errors

**Solutions**:
- Verify `API_URL` environment variable
- In Docker, use `http://localhost:8000/api/v1` (not external URL)
- Check CORS settings in backend
- Ensure backend is fully started before frontend makes requests

#### 5. Audio/Video Features Not Working

**Symptom**: Audio recording or playback fails

**Solutions**:
- Verify AssemblyAI and ElevenLabs API keys
- Check API key quotas and limits
- Ensure `static` directory has write permissions
- Check browser permissions for microphone/camera

#### 6. Database Errors

**Symptom**: SQLite or database-related errors

**Solutions**:
- Ensure `DATABASE_URL` is properly formatted
- Check write permissions for database file location
- For SQLite, ensure parent directory exists
- Consider using in-memory database for testing: `sqlite+aiosqlite:///:memory:`

#### 7. Out of Memory Errors

**Symptom**: Container crashes with memory errors

**Solutions**:
- Upgrade Space hardware tier (Settings → Space hardware)
- Optimize model loading (load models on-demand)
- Reduce batch sizes or concurrent requests
- Consider using smaller model variants

#### 8. Slow Performance

**Symptom**: Long response times

**Solutions**:
- Upgrade to a better hardware tier (GPU if available)
- Optimize API calls to external services
- Implement caching where appropriate
- Use async/await properly in backend

### Debugging Tips

1. **Enable Debug Logging**
   - Set `LOG_LEVEL=DEBUG` in environment variables
   - Check detailed logs in Space → Logs

2. **Test API Endpoints Separately**
   - Access `https://your-space-url/docs` for API documentation
   - Test individual endpoints to isolate issues

3. **Check API Key Validity**
   - Test each API key independently before deployment
   - Ensure keys have necessary permissions and quotas

4. **Local Testing First**
   - Always test Docker build locally before deploying
   - Use the same environment variables locally

## 🐳 Local Docker Testing

Before deploying to Hugging Face, test your Docker setup locally:

### Build the Image

```bash
cd TalentTalkPro
docker build -t talenttalkpro:test .
```

### Run the Container

```bash
docker run -p 7860:7860 \
  -e GOOGLE_API_KEY=your_google_api_key \
  -e OPENROUTER_API_KEY=your_openrouter_key \
  -e ASSEMBLYAI_API_KEY=your_assemblyai_key \
  -e ELEVENLABS_API_KEY=your_elevenlabs_key \
  -e DATABASE_URL=sqlite+aiosqlite:///./talenttalk.db \
  -e BACKEND_CORS_ORIGINS=* \
  talenttalkpro:test
```

### Using Environment File

Create a `.env.docker` file:

```env
GOOGLE_API_KEY=your_google_api_key
OPENROUTER_API_KEY=your_openrouter_key
ASSEMBLYAI_API_KEY=your_assemblyai_key
ELEVENLABS_API_KEY=your_elevenlabs_key
DATABASE_URL=sqlite+aiosqlite:///./talenttalk.db
BACKEND_CORS_ORIGINS=*
```

Run with env file:

```bash
docker run -p 7860:7860 --env-file .env.docker talenttalkpro:test
```

### Access Locally

- Frontend: http://localhost:7860
- Backend API: http://localhost:8000 (not directly accessible from outside container)

### Check Logs

```bash
# View logs
docker logs <container_id>

# Follow logs in real-time
docker logs -f <container_id>
```

### Interactive Debugging

```bash
# Run container with bash
docker run -it -p 7860:7860 --env-file .env.docker talenttalkpro:test /bin/bash

# Inside container, manually run components
cd /app/backend && python -m uvicorn app.main:app --host 0.0.0.0 --port 8000 &
cd /app/frontend && streamlit run app.py --server.port 7860 --server.address 0.0.0.0
```

## ⚙️ Advanced Configuration

### Custom Domain

To use a custom domain with your Hugging Face Space:

1. Go to Space Settings → Custom domain
2. Follow Hugging Face's domain verification process
3. Update DNS records as instructed
4. Add your domain to `BACKEND_CORS_ORIGINS`

### Scaling and Performance

For production workloads:

1. **Upgrade Hardware**
   - Navigate to Settings → Space hardware
   - Choose GPU tier for better performance
   - Consider T4, A10G, or A100 GPUs

2. **Enable Caching**
   - Implement Redis for session caching
   - Cache frequently accessed data
   - Use CDN for static assets

3. **Database Optimization**
   - Consider PostgreSQL for production
   - Set up proper indexes
   - Use connection pooling

### Security Best Practices

1. **API Key Management**
   - Never commit API keys to repository
   - Use Hugging Face Repository Secrets
   - Rotate keys periodically
   - Monitor API usage

2. **CORS Configuration**
   - In production, specify exact origins instead of `*`
   - Example: `BACKEND_CORS_ORIGINS=https://huggingface.co,https://your-domain.com`

3. **Rate Limiting**
   - Implement rate limiting on API endpoints
   - Monitor and set quotas for external API calls
   - Add authentication if needed

### Monitoring and Logging

1. **Application Logs**
   - View logs in Space → Logs tab
   - Increase `LOG_LEVEL` for more details
   - Set up log aggregation for production

2. **Health Checks**
   - Backend health endpoint: `/health`
   - Monitor uptime and response times
   - Set up alerts for failures

3. **Analytics**
   - Track user interactions
   - Monitor API usage and costs
   - Analyze performance metrics

### Backup and Recovery

1. **Database Backups**
   - Regular backups of SQLite database
   - Consider automated backup solutions
   - Test recovery procedures

2. **Configuration Backups**
   - Document all environment variables
   - Keep backup of Space settings
   - Version control all configuration

## 📚 Additional Resources

- [Hugging Face Spaces Documentation](https://huggingface.co/docs/hub/spaces)
- [Docker Documentation](https://docs.docker.com/)
- [FastAPI Documentation](https://fastapi.tiangolo.com/)
- [Streamlit Documentation](https://docs.streamlit.io/)
- [LangGraph Documentation](https://python.langchain.com/docs/langgraph)

## 🆘 Getting Help

If you encounter issues not covered in this guide:

1. **Check the Logs**: Most issues are revealed in the application logs
2. **GitHub Issues**: Open an issue on the [GitHub repository](https://github.com/ParamJaiswal/TalentTalkPro/issues)
3. **Hugging Face Forums**: Ask in the [Hugging Face community](https://discuss.huggingface.co/)
4. **Documentation**: Review the main [README.md](./README.md)

## ✅ Deployment Checklist

Use this checklist to ensure successful deployment:

- [ ] Hugging Face account created and verified
- [ ] All API keys obtained and tested
- [ ] Repository forked or cloned
- [ ] Hugging Face Space created with Docker SDK
- [ ] All required environment variables configured
- [ ] Code pushed to Hugging Face Space
- [ ] Build completed successfully
- [ ] Application running without errors
- [ ] Frontend accessible via Space URL
- [ ] Backend API responding correctly
- [ ] Audio recording feature working
- [ ] Interview flow tested end-to-end
- [ ] Performance acceptable
- [ ] Logs reviewed for warnings or errors

---

🎉 **Congratulations!** Your TalentTalkPro instance should now be running on Hugging Face Spaces.

For questions or improvements to this guide, please contribute to the repository or open an issue.
