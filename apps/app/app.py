import flask
from time import sleep
import requests

app = flask.Flask(__name__)

@app.route('/')
def root():
    # Simulate some work
    sleep(0.1)
    response = requests.get('http://app2:9080/')
    # Simulate some work
    sleep(0.1)
    return flask.Response(response.text)

if __name__ == "__main__":
    app.run()
