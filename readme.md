# Install options
We want to support multiple ways to install the application on a server
- An executable where the sqlite database and files are stored locally
- Simply cloning and running the python code 
- A single docker image where sqlite is used
- Docker compose, where everything is installed. Django, FileServer, Postgres database, Lets encrypt? etc

## Executable

We can use PyInstaller to package the django application: https://github.com/pyinstaller/pyinstaller/wiki/Recipe-Executable-From-Django

```bash
python -m PyInstaller --name seedcase .\manage.py
```

The executables are added to the 'dist' folder

## Docker 
You can run the django application by executing this command:

```bash
# Run the image with the following command
docker run -i -d -p 9999:8000 -v persistence:/app/persistence philter87/django:0.0.1
# go to http://localhost:9999/

# You can build the image with these commands:
docker build . --tag philter87/django:0.0.1

# You can publish to DockerHub with these commands:
docker login
docker push philter87/django:0.0.1

# Go to https://hub.docker.com/repository/docker/philter87/django to see image description
```

# Cloud providers
We have tried 3 cloud providers. Here are the main points
## Vercel

Live at: https://seedcase-deploy-philter87.vercel.app/

I followed this description https://vercel.com/templates/python/django-hello-world. 
I only had to add vercel.json file and a requirements.txt file (It seems not possible to use poetry)
The main branch was deployed automatically and so was new branches. 
Every branch automatically creates a preview which is pretty nice.

Maybe there is too much magic? And Vercel does not support docker which could be relevant

1. whitenoise was needed to serve static files. https://whitenoise.readthedocs.io/en/latest/. Whitenoise helps serve static files in the current directory
2. requirements.txt is required (gunicorn seems not to be required)

## Render

Live at: https://philip-django-auto.onrender.com

We rely on a Dockerfile in the repository to deploy the service.

I got a bit of help from https://render.com/docs/deploy-django to figure out how to add static files

- whitenoise was needed to serve static files
- gunicorn is needed 'poetry add gunicorn'
- We run the application with 'gunicorn seedcase_deploy.wsgi:app'


## Digital Ocean
No free instances
- Python version (default=3.11.6) is set by setting PYTHON_VERSION in render
- Allowed host is added using