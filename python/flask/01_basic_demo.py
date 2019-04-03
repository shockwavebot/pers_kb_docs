from flask import Flask

app = Flask(__name__)

@app.route('/')
def home():
    return "Webapp content goes here."

if __name__ == '__main__':
    app.run(host='172.16.121.31', port=5001, debug=True)
