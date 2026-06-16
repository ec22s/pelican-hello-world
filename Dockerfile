FROM python:3.10
WORKDIR /project
RUN python3 -m pip install --upgrade pip \
  && python3 -m pip install --trusted-host pypi.org \
    --trusted-host files.pythonhosted.org Markdown pelican \
  && pip freeze > requirements.txt
