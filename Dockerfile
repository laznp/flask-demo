FROM python:3.7-slim
RUN mkdir /app
COPY . /app
WORKDIR /app
RUN python3 -m venv venv && . venv/bin/activate && pip3 install -r requirements.txt
EXPOSE 5000
CMD ["/app/venv/bin/gunicorn","--bind", "0.0.0.0:5000", "app:app"]