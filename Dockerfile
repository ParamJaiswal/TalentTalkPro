# Use Python 3.10 slim as base image
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy and install backend requirements
COPY backend/requirements.txt /app/backend/requirements.txt
RUN pip install --no-cache-dir -r /app/backend/requirements.txt

# Copy and install frontend requirements
COPY frontend/requirements.txt /app/frontend/requirements.txt
RUN pip install --no-cache-dir -r /app/frontend/requirements.txt

# Copy backend files
COPY backend/ /app/backend/

# Copy frontend files
COPY frontend/ /app/frontend/

# Create static directory for audio files
RUN mkdir -p /app/backend/static

# Copy startup script
COPY start_huggingface.sh /app/start_huggingface.sh
RUN chmod +x /app/start_huggingface.sh

# Expose port 7860 (Hugging Face default)
EXPOSE 7860

# Use startup script as entry point
CMD ["/app/start_huggingface.sh"]
