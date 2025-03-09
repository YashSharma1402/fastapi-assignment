# Use Ubuntu as base image
FROM ubuntu:latest

# Install Python and pip
RUN apt update && apt install -y python3 python3-pip python3-venv

# Set the working directory
WORKDIR /app

# Copy requirements.txt
COPY requirements.txt .

# Create a virtual environment and install dependencies
RUN python3 -m venv venv && \
    . venv/bin/activate && \
    pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY main.py .

# Expose port 8000
EXPOSE 8000

# Run the FastAPI app
CMD ["/app/venv/bin/python", "-m", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]

