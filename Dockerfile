# Use a slim base image
FROM python:3.9-slim

# Set working directory
WORKDIR /data

# Install system dependencies (optional but recommended)
RUN apt-get update && apt-get install -y gcc python3-dev libpq-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy only requirements first to leverage Docker caching
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the Django project
COPY . .

# Expose port 8000
EXPOSE 8000

# Run the Django app
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]



