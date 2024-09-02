FROM cgr.dev/chainguard/python:latest-dev AS builder
WORKDIR /app

RUN python -m venv venv 
ENV PATH="/app/venv/bin":$PATH
COPY requirements.txt . 
RUN pip install --no-cache-dir -r requirements.txt


FROM cgr.dev/chainguard/python:latest
WORKDIR /app
COPY app.py .
COPY --from=builder /app/venv /app/venv
ENV PATH="/app/venv/bin:$PATH"
#COPY .deepsource.toml .
COPY static static/
COPY templates templates/
#COPY tailwind.config.js .
EXPOSE 5000
ENV REDIS_HOST=redis
ENTRYPOINT ["python","-m","flask","run","--host=0.0.0.0"]
