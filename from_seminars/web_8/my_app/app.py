from flask import Flask, render_template_string
import psycopg2

app = Flask(__name__)

@app.route('/')
def index():
    conn = psycopg2.connect(
        host='db',
        database='mydb',
        user='postgres',
        password='mysecretpassword'
    )
    cursor = conn.cursor()
    cursor.execute("SELECT name FROM users;")
    users = cursor.fetchall()
    conn.close()
    return render_template_string(
        "<h1>Users</h1><ul>{% for user in users %}<li>{{ user[0] }}</li>{% endfor %}</ul>",
        users=users
    )

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001)
