from django.shortcuts import render
from django.http import HttpResponse
from datetime import datetime
# Create your views here.

def index(request):
    now = datetime.now()
    #html_content = "<html><head><title>Hello, Django</title></head><body>"
    #html_content += "<strong>Hello Django!</strong> on " + now.strftime("%A, %d %B, %Y at %X")
    #html_content += "</body></html>"
    #return HttpResponse(html_content)
    return render(request, "Django/index.html",
                  {
                      'title' : "Django",
                      'message' : "Hello Django!",
                      'content' : " on " + now.strftime("%A, %d %B, %Y at %X")
                  })

def about(request):
    return render(request, "Django/about.html",
                  {
                      'title' : "Django",
                      'content' : 'Example of another app page' 
                  })

def HomeLayout(request):
    now = datetime.now()
    return render(request, "Django/HomeLayout.html",
                  {
                      'title' : "Django",
                      'message' : "Hello Django Home Layout!",
                      'content' : " on " + now.strftime("%A, %d %B, %Y at %X")
                  })

def AboutLayout(request):
    return render(request, "Django/AboutLayout.html",
                  {
                      'title' : "Django",
                      'content' : "Example of another app Layout page"
                  })