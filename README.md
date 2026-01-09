---
title: TalentTalk Pro
emoji: 🎤
colorFrom: blue
colorTo: purple
sdk: docker
app_port: 7860
pinned: false
license: mit
---

# 🎤 TalentTalk Pro

An AI-powered interview assistant that helps candidates prepare for technical interviews using advanced language models and voice interaction.

## Features

- 🤖 **AI Interview Agent**: Powered by LangGraph and Google Generative AI
- 🎯 **Resume Analysis**: Upload and analyze resumes to tailor interview questions
- 🗣️ **Voice Interaction**: Speech-to-text and text-to-speech capabilities
- 📊 **Real-time Feedback**: Get instant feedback on your interview responses
- 💾 **Session Management**: Save and review past interview sessions

## Tech Stack

### Backend
- **FastAPI**: High-performance API framework
- **LangGraph**: Advanced AI agent orchestration
- **LangChain**: LLM application framework
- **Google Generative AI**: Gemini models for natural language processing
- **SQLModel**: Database ORM
- **AssemblyAI**: Speech-to-text conversion
- **ElevenLabs**: Text-to-speech synthesis

### Frontend
- **Streamlit**: Interactive web application framework
- **Responsive UI**: Clean and intuitive user interface

## Environment Variables

This Space requires the following environment variables (add them in Space Settings → Repository Secrets):

```env
# Required
GOOGLE_API_KEY=your_google_api_key_here
OPENROUTER_API_KEY=your_openrouter_api_key_here

# Optional (for voice features)
ASSEMBLYAI_API_KEY=your_assemblyai_key_here
ELEVENLABS_API_KEY=your_elevenlabs_key_here

# Database
DATABASE_URL=sqlite+aiosqlite:///./data/talenttalk.db

# API Configuration (optional, defaults to http://localhost:8000/api/v1)
API_URL=http://localhost:8000/api/v1

# CORS (if needed)
BACKEND_CORS_ORIGINS=http://localhost:7860,https://huggingface.co
```

## How to Use

1. **Upload Resume**: Start by uploading your resume (PDF format)
2. **Select Interview Type**: Choose from technical, behavioral, or mixed interviews
3. **Start Interview**: Begin your practice interview session
4. **Get Feedback**: Receive AI-powered feedback on your responses
5. **Review Sessions**: Access past interview sessions for improvement

## Local Development

### Prerequisites
- Python 3.10+
- Git

### Setup

1. Clone the repository:
```bash
git clone https://github.com/ParamJaiswal/TalentTalkPro.git
cd TalentTalkPro
```

2. Install backend dependencies:
```bash
cd backend
pip install -r requirements.txt
```

3. Install frontend dependencies:
```bash
cd frontend
pip install -r requirements.txt
```

4. Set up environment variables:
```bash
cp .env.example .env
# Edit .env with your API keys
```

5. Run backend:
```bash
cd backend
python -m uvicorn app.main:app --reload
```

6. Run frontend (in another terminal):
```bash
cd frontend
streamlit run app.py
```

## API Documentation

Once deployed, access the API documentation at:
- Swagger UI: `https://your-space.hf.space/docs`
- ReDoc: `https://your-space.hf.space/redoc`

## Architecture

```
TalentTalkPro/
├── backend/          # FastAPI backend
│   ├── app/
│   │   ├── api_routes.py
│   │   ├── main.py
│   │   ├── core/     # Configuration & utilities
│   │   ├── db/       # Database models
│   │   ├── services/ # Business logic
│   │   └── agents/   # LangGraph agents
│   └── requirements.txt
├── frontend/         # Streamlit frontend
│   ├── app.py
│   └── requirements.txt
└── Dockerfile        # Docker configuration
```

## License

MIT License - See LICENSE file for details

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Support

For issues and questions, please open an issue on the GitHub repository.

---

Built with ❤️ using LangGraph, FastAPI, and Streamlit
