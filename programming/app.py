from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy 
from flask_marshmallow import Marshmallow 
import os 

# Init app
app = Flask(__name__)
basedir = os.path.abspath(os.path.dirname(__file__))

# DataBase
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres@localhost:5432/template1'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

# Init DB
db = SQLAlchemy(app)

# Init ma
ma = Marshmallow(app)

# IP Class/Model
class IP(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    ip = db.Column(db.String(15), unique=True)

    def __init__(self,ip):
        self.ip = ip

# IP Schema
class IPSchema(ma.Schema):
    class Meta:
        fields = ('id','ip')

# Init Schema
ip_schema = IPSchema()
ips_schema = IPSchema(many=True)

# routes
@app.route('/', methods=['GET'])
def get():
    if not request.args:
        return jsonify({ "msg" : "Halan ROCKS" })
    else:
        n = int(request.args.get('n'))
        x = n*n
        return jsonify({ "msg" : "{}".format(x) })


@app.route('/ip', methods=['POST'])
def add_ip():
    request_ip = request.remote_addr
    new_ip = IP(ip=request_ip)
    db.session.add(new_ip)
    db.session.commit()
    return ip_schema.jsonify(new_ip)

@app.route('/allips', methods=['GET'])
def get_allips():
    allips = IP.query.all()
    result = ips_schema.dump(allips)
    return jsonify(result)



# Run Server
if __name__ == '__main__':
    app.run(debug=True)