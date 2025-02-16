# Use the official Python image from Docker Hub
FROM python:3.12-slim-bookworm

# Set the working directory inside the container
WORKDIR /Application

RUN mkdir -p /data

# Copy the requirements file into the container
COPY requirements.txt .

COPY app.py /Application
CMD ["uv","run","app.py"]
 
# Install the dependencies
RUN pip install --no-cache-dir -r requirements.txt

# The installer requires curl (and certificates) to download the release archive
RUN apt-get update && apt-get install -y --no-install-recommends curl ca-certificates

# Download the latest installer
ADD https://astral.sh/uv/install.sh /uv-installer.sh

# Run the installer then remove it
RUN sh /uv-installer.sh && rm /uv-installer.sh

# Ensure the installed binary is on the `PATH`
ENV PATH="/root/.local/bin/:$PATH"
