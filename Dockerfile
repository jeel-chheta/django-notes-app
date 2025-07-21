# Use an official Python base image
FROM python:3.10-slim

# Set the working directory inside the container
WORKDIR /app

# Copy dependencies file and install
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the project files
COPY . .

# Expose the port Django will run on
EXPOSE 8001

# Start Django server when container starts
CMD ["python3", "manage.py", "runserver", "0.0.0.0:8001"]
