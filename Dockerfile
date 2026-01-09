FROM python:3.10-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    software-properties-common \
    git \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements files
COPY frontend/requirements.txt /app/frontend_requirements.txt
COPY backend/requirements.txt /app/backend_requirements.txt

# Install Python dependencies
RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir -r /app/frontend_requirements.txt
RUN pip install --no-cache-dir -r /app/backend_requirements.txt

# Copy application code
COPY backend/ /app/backend/
COPY frontend/ /app/frontend/

# Create necessary directories
RUN mkdir -p /app/backend/static
RUN mkdir -p /app/backend/data

# Copy startup script
COPY start_huggingface.sh /app/start_huggingface.sh
RUN chmod +x /app/start_huggingface.sh

# Expose ports (Hugging Face uses 7860 by default)
EXPOSE 7860 8000

# Set environment variables
ENV PYTHONUNBUFFERED=1
ENV API_URL=http://localhost:8000/api/v1

# Start both services
CMD ["/app/start_huggingface.sh"]
