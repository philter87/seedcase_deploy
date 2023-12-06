# Install options
We want to support multiple ways to install the application on a server
- An executable where the sqlite database and files are stored locally
- Simply cloning and running the python code 
- A single docker image where sqlite is used
- Docker compose, where everything is installed. Django, FileServer, Postgres database, Lets encrypt? etc

## Executable

We can use PyInstaller to package the django application: https://github.com/pyinstaller/pyinstaller/wiki/Recipe-Executable-From-Django

```bash
py -m PyInstaller --name seedcase .\manage.py
```

The executables are added to the 'dist' folder

## Docker 
You can run the django application by executing this command:

```bash
docker build . --tag seedcase_deploy_image
docker run -i -d -p 8000:8000 --mount type=bind,source= seedcase_deploy_image

# go to http://127.0.0.1:8000/

# force stop and delete container
docker rm -f <part-of-the-id>

# Eventually, we might push the image to DockerHub and then we can run the image like this:
docker run -i -d -p 8000:8000
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

Live at: https://seedcase-deploy-demo.onrender.com

I followed this link https://render.com/docs/deploy-django. Seems to support poetry and docker. 
Render does not deploy all branch commits by default, but you can enable pull-request-previews: https://render.com/docs/pull-request-previews

Requires maybe a bit more work, but also seems more customizable. render.yaml or manual deploy

- 
- whitenoise was needed to serve static files
- build.sh script is added
- gunicorn is needed 'poetry add gunicorn'


## Digital Ocean
No free instances
- Python version (default=3.11.6) is set by setting PYTHON_VERSION in render
- Allowed host is added using