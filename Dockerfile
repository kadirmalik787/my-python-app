FROM python:3.10-slim  # Use slim image
WORKDIR /app
COPY requirements.txt .  # Separate dependency copy
RUN pip install -r requirements.txt
COPY . .
CMD ["python","app.py"]
