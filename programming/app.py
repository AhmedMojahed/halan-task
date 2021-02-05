from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy 
from flask_marshmallow import Marshmallow 
from flask_script import Manager, Server
import os 

# Enviroment variables
MASTERDB_PRIVATE_IP=os.getenv('MASTERDB_PRIVATE_IP', '192.168.44.11')
DB_USER_NAME=os.getenv('DB_USER_NAME', 'devops')
DB_NAME=os.getenv('DB_NAME', 'devops')
DB_USER_PASS=os.getenv('DB_USER_PASS', 'devops')

# Init app
app = Flask(__name__)

# DataBase

# connection with database container with compose
# app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://devops:mypasswd@psql:5432/devops'

# connection with local data base or remote db server
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://{username}:{passwd}@{dbm_ip}/{db_name}'.format(username=DB_USER_NAME,passwd=DB_USER_PASS,dbm_ip=MASTERDB_PRIVATE_IP,db_name=DB_NAME)

app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

# Init DB
db = SQLAlchemy(app)

# Init ma
ma = Marshmallow(app)

# IP Class/Model
class IP(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    ip = db.Column(db.String(15))

    def __init__(self,ip):
        self.ip = ip


db.create_all()

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


@app.route('/ip')
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
    app.run(host='0.0.0.0', port=5050, debug=True)
