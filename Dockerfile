# Use official Python base image
FROM python:3.9-slim

# Set the working directory
WORKDIR /app/backend

# Install system dependencies (only essential ones)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        gcc \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy requirements first to leverage Docker layer caching
COPY requirements.txt .

# Install Python dependencies
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Expose Django port
EXPOSE 8000

# Optionally add entrypoint or CMD later in docker-compose
python3 manage.py runserver 0.0.0.0:8000
