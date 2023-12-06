from django.shortcuts import render

# Create your views here.
from datetime import datetime

def index(request):
    now = datetime.now()
    return render(request, "hello.html", {"now": now})
