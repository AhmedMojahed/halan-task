FROM python:3.8-slim-buster

WORKDIR /usr/src/app

COPY . .

RUN pip install --upgrade pip && \
    pip install -r requirements.txt

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

EXPOSE 5000
CMD [ "python","app.py","runserver" ]