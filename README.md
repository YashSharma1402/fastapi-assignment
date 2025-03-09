# FastAPI Continuous Delivery with GitHub Actions

## Overview
This project demonstrates Continuous Delivery by automating the creation and deployment of a Dockerized FastAPI application using GitHub Actions. The workflow builds the FastAPI application, creates a Docker image, and pushes it to Docker Hub.

## Features
- FastAPI server that responds with JSON data
- Containerized with Docker (or Podman as an alternative)
- Automated deployment using GitHub Actions

## Prerequisites
Ensure you have the following installed on your local machine:
- Python 3.8+
- Docker or Podman
- Git

## Setup & Installation

### 1. Clone the Repository
```sh
 git clone https://github.com/<your-github-username>/<repo>.git
 cd <repo>
```

### 2. Install Dependencies
```sh
pip install -r requirements.txt
```

### 3. Run the FastAPI Server Locally
```sh
uvicorn main:app --host 0.0.0.0 --port 8000
```
Access the API at: `http://localhost:8000`

## Containerization

### 1. Build and Run the Docker Container
```sh
docker build -t <your-dockerhub-username>/<image-name>:latest .
docker run -p 8000:8000 <your-dockerhub-username>/<image-name>:latest
```

## GitHub Actions Workflow
The GitHub Actions workflow automates the build and deployment process.

### Workflow File: `.github/workflows/DockerBuild.yml`
#### Trigger:
- Runs on push events to the repository.

#### Steps:
1. Checkout the repository.
2. Authenticate to Docker Hub using `DOCKERTOKEN` stored as a GitHub Actions Secret.
3. Build the Docker image.
4. Push the image to Docker Hub.

### Setting Up GitHub Secrets
1. Go to your GitHub repository → **Settings** → **Secrets and variables** → **Actions**.
2. Click **New repository secret**.
3. Add the following secrets:
   - **DOCKERTOKEN**: Your Docker Hub token.
   - **DOCKER_USERNAME**: Your Docker Hub username.

### Example GitHub Actions Workflow (DockerBuild.yml)
```yaml
name: Docker image build

on: push

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Repository
        uses: actions/checkout@v2
      
      - name: Authenticate to Docker Hub
        run: echo "${{ secrets.DOCKERTOKEN }}" | docker login -u "${{ secrets.DOCKER_USERNAME }}" --password-stdin
      
      - name: Build and Push Docker Image
        run: |
          docker build -t ${{ secrets.DOCKER_USERNAME }}/fastapi-app:latest .
          docker push ${{ secrets.DOCKER_USERNAME }}/fastapi-app:latest
```

## Docker Hub Image URL
Find the deployed Docker image at:
```
https://hub.docker.com/r/<your-dockerhub-username>/<image-name>
```

## Alternative: Using Podman
If using Podman instead of Docker:
```sh
podman machine init
podman machine start
alias docker=podman
docker --version
```
Then follow the same steps for building and running the container.

## Conclusion
This project automates the CI/CD pipeline for a FastAPI application, ensuring seamless deployment with GitHub Actions and Docker Hub integration.

