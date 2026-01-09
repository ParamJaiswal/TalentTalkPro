#!/bin/bash

set -e

echo "=========================================="
echo "Starting TalentTalkPro on Hugging Face"
echo "=========================================="

# Create static directory if it doesn't exist
echo "Creating static directory for audio files..."
mkdir -p /app/backend/static

# Start FastAPI backend in the background
echo "Starting FastAPI backend on port 8000..."
cd /app/backend && python -m uvicorn app.main:app --host 0.0.0.0 --port 8000 &
BACKEND_PID=$!

# Wait a moment for backend to initialize
echo "Waiting for backend to initialize..."
sleep 5

# Check if backend is running
if ! kill -0 $BACKEND_PID 2>/dev/null; then
    echo "ERROR: Backend failed to start!"
    exit 1
fi

echo "Backend started successfully (PID: $BACKEND_PID)"

# Start Streamlit frontend on port 7860 (Hugging Face default)
echo "Starting Streamlit frontend on port 7860..."
cd /app/frontend && streamlit run app.py --server.port 7860 --server.address 0.0.0.0

# If Streamlit exits, kill the backend
echo "Streamlit stopped, shutting down backend..."
kill $BACKEND_PID 2>/dev/null || true
