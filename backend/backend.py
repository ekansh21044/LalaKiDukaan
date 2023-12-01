import flask
import mysql.connector

def connectDB():
    db = mysql.connector.connect(host = 'localhost',
                        user = 'root',
                        passwd = '123456',
                        database = 'lalakidukaan')
    return db

app = flask.Flask(__name__)

@app.route('/authenticateAdmin/<string:loginID>/<string:email>/<string:passwd>', methods = ['GET'])
def authenticateAdmin(loginID, email, passwd):
    print(loginID + '\n' + email + '\n' + passwd)
    db = connectDB()
    cursor = db.cursor()
    cursor.execute(f'''select * from admin where Login_ID = {loginID}
                   and Admin_Email = "{str(email)}" and Password = "{str(passwd)}"''')
    data = cursor.fetchall()
    print(data)
    db.close()
    if len(data) > 0:
        print('valid')
        return 'valid'
    else:
        print('invalid')
        return 'invalid'
    
@app.route('/authenticateCustomer/<string:loginID>/<string:email>/<string:passwd>', methods = ['GET'])
def authenticateCustomer(loginID, email, passwd):
    print(loginID + '\n' + email + '\n' + passwd)
    db = connectDB()
    cursor = db.cursor()
    cursor.execute(f'''select * from customer where Customer_ID = {loginID}
                   and Customer_Email = "{str(email)}" and Password = "{str(passwd)}"''')
    data = cursor.fetchall()
    print(data)
    db.close()
    if len(data) > 0:
        print('valid')
        return 'valid'
    else:
        print('invalid')
        return 'invalid'
    
@app.route('/authenticateAgent/<string:loginID>/<string:email>/<string:passwd>', methods = ['GET'])
def authenticateAgent(loginID, email, passwd):
    print(loginID + '\n' + email + '\n' + passwd)
    db = connectDB()
    cursor = db.cursor()
    cursor.execute(f'''select * from Delivery_Agent where Agent_ID = {loginID}
                   and Agent_Email = "{str(email)}" and Password = "{str(passwd)}"''')
    data = cursor.fetchall()
    print(data)
    db.close()
    if len(data) > 0:
        print('valid')
        return 'valid'
    else:
        print('invalid')
        return 'invalid'
    
@app.route('/authenticateCare/<string:loginID>/<string:email>/<string:passwd>', methods = ['GET'])
def authenticateCare(loginID, email, passwd):
    print(loginID + '\n' + email + '\n' + passwd)
    db = connectDB()
    cursor = db.cursor()
    cursor.execute(f'''select * from Customer_Support where Customer_Support_ID = {loginID}
                   and Email = "{str(email)}" and Password = "{str(passwd)}"''')
    data = cursor.fetchall()
    print(data)
    db.close()
    if len(data) > 0:
        print('valid')
        return 'valid'
    else:
        print('invalid')
        return 'invalid'
    
if __name__ == '__main__':
    app.run(debug=True)