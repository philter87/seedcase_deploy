# Based on https://medium.com/@albertazzir/blazing-fast-python-docker-builds-with-poetry-a78a66f5aed0
# but we are skipping multistage build as the image published anywhere
FROM python:3.11-slim-bookworm

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_IN_PROJECT=1 \
    POETRY_VIRTUALENVS_CREATE=1

RUN pip install poetry==1.7.1

WORKDIR /app

COPY pyproject.toml poetry.lock ./

RUN poetry install --no-cache

COPY . .

EXPOSE 10000
RUN chmod +x entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
# ENTRYPOINT ["./entrypoint-with-tls.sh"]