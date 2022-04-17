FROM python:3.8.8

COPY ./src /app/src
COPY ./requirments.txt /app

WORKDIR /app

RUN pip install -r requirments.txt

EXPOSE 8000

CMD ["uvicorn","src.main:app","--host=0.0.0.0"]