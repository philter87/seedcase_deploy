#!/usr/bin/env bash
# exit on error
set -o errexit

poetry run python manage.py migrate
# We use port 10000 as a default
poetry run gunicorn seedcase_deploy.wsgi:app --bind 0.0.0.0:10000