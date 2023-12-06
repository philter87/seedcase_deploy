
# Vercel

I followed this description https://vercel.com/templates/python/django-hello-world. 
I only had to add vercel.json file and a requirements.txt file (It seems not possible to use poetry)
The main branch was deployed automatically and so was new branches. 
Every branch automatically creates a preview which is pretty nice.

Maybe there is too much magic? And Vercel does not support docker which could be relevant

1. whitenoise was needed to serve static files. https://whitenoise.readthedocs.io/en/latest/

# Render
I followed this link https://render.com/docs/deploy-django. Seems to support poetry and docker. 
Requires maybe a bit more work. render.yaml or manual deploy

1. whitenoise was needed to serve static files