# Use official Python base image
FROM python:3.9-slim

# Set the working directory
WORKDIR /app/backend

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        gcc \
        default-libmysqlclient-dev \
        pkg-config \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy requirements first to leverage Docker layer caching
COPY requirements.txt .

# Install Python dependencies
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Expose the application port
EXPOSE 8000

# Optional: You can uncomment these if you want to run migrations during build (not typical)
# RUN python manage.py makemigrations
# RUN python manage.py migrate

# Define default command (you can override in docker-compose or run)
# CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
