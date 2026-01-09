---
title: TalentTalkPro
emoji: 🎤
colorFrom: blue
colorTo: purple
sdk: docker
app_port: 7860
pinned: false
---

# TalentTalkPro 🎤

AI-powered interview assistant using LangGraph, LangChain, and Google Generative AI for comprehensive interview practice and feedback.

## 🎯 Overview

TalentTalkPro is an advanced AI interview platform that provides realistic interview experiences with intelligent follow-up questions, real-time feedback, and comprehensive performance reports. The system uses multi-agent architecture powered by LangGraph to simulate professional interview scenarios.

## 🏗️ Architecture

The application consists of two main components:

### Backend (FastAPI)
- **Port**: 8000 (internal)
- **Technology**: FastAPI, LangGraph, LangChain
- **Features**: 
  - Multi-agent interview system
  - Real-time speech processing
  - Resume analysis
  - Video behavior analysis
  - Performance evaluation

### Frontend (Streamlit)
- **Port**: 7860 (Hugging Face default)
- **Technology**: Streamlit
- **Features**:
  - Interactive chat interface
  - Audio/video input support
  - Real-time feedback display
  - Performance report visualization

## ✨ Features

- **🤖 AI-Powered Interviews**: Intelligent multi-turn conversations with contextual follow-ups
- **📄 Resume Analysis**: Upload your resume for personalized interview questions
- **🎙️ Voice Interaction**: Record audio responses for a realistic interview experience
- **📹 Video Analysis**: Optional video behavior analysis for non-verbal communication feedback
- **📊 Performance Reports**: Comprehensive evaluation with actionable feedback
- **🎯 Customizable Settings**: Configure difficulty, style, company, and role
- **🔄 Adaptive Follow-ups**: Dynamic follow-up questions based on your responses

## 🔐 Environment Variables

The following environment variables are required:

| Variable | Description | Required |
|----------|-------------|----------|
| `GOOGLE_API_KEY` | Google Generative AI API key for LLM capabilities | ✅ Yes |
| `OPENROUTER_API_KEY` | OpenRouter API key for additional model access | ✅ Yes |
| `ASSEMBLYAI_API_KEY` | AssemblyAI API key for speech-to-text | ✅ Yes |
| `ELEVENLABS_API_KEY` | ElevenLabs API key for text-to-speech | ✅ Yes |
| `DATABASE_URL` | Database connection string | ⚠️ Default: `sqlite+aiosqlite:///./talenttalk.db` |
| `BACKEND_CORS_ORIGINS` | CORS allowed origins | ⚠️ Default: `*` |
| `API_URL` | Frontend API URL for backend connection | ⚠️ Default: `http://localhost:8000/api/v1` |

## 🚀 Deployment on Hugging Face Spaces

This application is configured for deployment on Hugging Face Spaces using Docker SDK. For detailed deployment instructions, see [DEPLOYMENT.md](./DEPLOYMENT.md).

### Quick Start

1. Fork or clone this repository
2. Create a new Space on [huggingface.co/spaces](https://huggingface.co/spaces)
3. Select Docker SDK
4. Connect your GitHub repository
5. Configure environment variables in Space Settings → Repository Secrets
6. Your Space will automatically build and deploy!

## 💻 Local Development

### Prerequisites

- Python 3.11+
- pip or conda

### Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/ParamJaiswal/TalentTalkPro.git
   cd TalentTalkPro
   ```

2. **Create environment file**
   ```bash
   cp .env.example .env
   # Edit .env and add your API keys
   ```

3. **Install backend dependencies**
   ```bash
   cd backend
   pip install -r requirements.txt
   ```

4. **Install frontend dependencies**
   ```bash
   cd ../frontend
   pip install -r requirements.txt
   ```

5. **Run backend server**
   ```bash
   cd ../backend
   python -m uvicorn app.main:app --reload
   ```

6. **Run frontend (in a new terminal)**
   ```bash
   cd frontend
   streamlit run app.py
   ```

7. **Access the application**
   - Frontend: http://localhost:8501
   - Backend API: http://localhost:8000
   - API Docs: http://localhost:8000/docs

### Local Docker Testing

```bash
# Build the Docker image
docker build -t talenttalkpro .

# Run the container
docker run -p 7860:7860 \
  -e GOOGLE_API_KEY=your_key \
  -e OPENROUTER_API_KEY=your_key \
  -e ASSEMBLYAI_API_KEY=your_key \
  -e ELEVENLABS_API_KEY=your_key \
  talenttalkpro
```

Access at: http://localhost:7860

## 📚 API Documentation

Once the backend is running, visit:
- Swagger UI: http://localhost:8000/docs
- ReDoc: http://localhost:8000/redoc

## 🧪 Testing

```bash
cd backend
pytest tests/
```

## 🛠️ Technology Stack

- **Framework**: FastAPI, Streamlit
- **AI/ML**: LangGraph, LangChain, Google Generative AI
- **Speech Processing**: AssemblyAI, ElevenLabs
- **Database**: SQLAlchemy with SQLite/PostgreSQL support
- **Async**: asyncio, aiosqlite

## 📖 Documentation

- [Deployment Guide](./DEPLOYMENT.md) - Comprehensive deployment instructions
- [API Documentation](http://localhost:8000/docs) - Interactive API docs (when running)

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- Google Generative AI for powerful language models
- LangChain and LangGraph for agent orchestration
- AssemblyAI for speech recognition
- ElevenLabs for text-to-speech
- Hugging Face for hosting platform

## 📧 Contact

For questions or support, please open an issue on GitHub.

---

Built with ❤️ using AI technologies
