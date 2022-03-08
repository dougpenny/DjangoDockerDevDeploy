FROM python:3.10-bullseye

# Skip buffering
ENV PYTHONUNBUFFERED=1

# Create a directory and set as working directory
RUN mkdir -p /code/django

# Ensure PIP is updated and install requirements
RUN python -m pip install --upgrade pip
COPY requirements.txt /code/requirements.txt
RUN pip install -r /code/requirements.txt

# Copy project
COPY django /code/django/