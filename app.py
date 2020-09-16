from flask import Flask
app = Flask(__name__)
app.secret_key = "SecretKey!"

@app.route("/")
def root():
	return "Root"
    
if __name__ == '__main__':
	app.run(debug=True)