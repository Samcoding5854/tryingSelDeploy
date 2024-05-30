ARG PORT=443
FROM cypress/browsers:latest
RUN apt install python3 -y
RUN echo $(python3 -m site --user-base)
COPY requirements.txt .
ENV PATH /home/root/.local/bin:${PATH}
RUN apt-get update && apt-get install -y python3-pip && pip install -r requirements.txt
COPY . .
# CMD uvicorn.workers.UvicornWorker main:app --host 0.0.0.0 --port $PORT
CMD gunicorn main:app --bind 0.0.0.0:$PORT --worker-class uvicorn.workers.UvicornWorker 

