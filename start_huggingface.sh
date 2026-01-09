#!/bin/bash

echo "🚀 Starting TalentTalk Pro on Hugging Face..."

# Create necessary directories
mkdir -p /app/backend/static
mkdir -p /app/backend/data

# Start FastAPI backend in the background
echo "📡 Starting Backend API on port 8000..."
cd /app/backend
python -m uvicorn app.main:app --host 0.0.0.0 --port 8000 &

# Wait for backend to be ready with health check
echo "⏳ Waiting for backend to start..."
for i in {1..30}; do
    if curl -s http://localhost:8000/health > /dev/null 2>&1; then
        echo "✅ Backend is ready!"
        break
    fi
    if [ $i -eq 30 ]; then
        echo "⚠️  Backend health check timeout, proceeding anyway..."
    fi
    sleep 1
done

# Start Streamlit frontend
echo "🎨 Starting Frontend on port 7860..."
cd /app/frontend
streamlit run app.py \
    --server.port=7860 \
    --server.address=0.0.0.0 \
    --server.headless=true \
    --server.enableCORS=false \
    --server.enableXsrfProtection=false
