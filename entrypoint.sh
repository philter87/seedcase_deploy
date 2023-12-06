#!/usr/bin/env bash
# exit on error
set -o errexit

poetry run python manage.py migrate
poetry run gunicorn seedcase_deploy.wsgi:app --bind 0.0.0.0:8000