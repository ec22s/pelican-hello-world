FROM python:3.10
WORKDIR /project
RUN python3 -m pip install markdown pelican && pip freeze > requirements.txt
