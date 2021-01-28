FROM ubuntu

WORKDIR /usr/src/app

COPY . .

RUN apt-get install python3-pip && \
    pip3 install -r requirements.txt

EXPOSE 5000

CMD [ "python3", "app.py" ]