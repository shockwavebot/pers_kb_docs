from flask import Flask, render_template

app = Flask(__name__)

@app.route('/')
def home():
    return render_template("home.html")

@app.route('/about/')
def about():
    return  render_template("about.html")

if __name__ == '__main__':
    app.run(host='172.16.121.31', port=5001, debug=True)
