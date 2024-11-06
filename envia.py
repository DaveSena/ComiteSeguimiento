from flask import Flask, jsonify,requests
import json

app=Flask(__name__)
@app.route("/p/<id>",methods=['GET'])
def lea(id):
    a=requests.get("cod")
    print(a) 

if __name__=='__main__':
    app.run(debug=True,host='0.0.0.0')