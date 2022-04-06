#Set up environment variables
#$env:FLASK_APP = "application"
#$env:FLASK_ENV = "development"

from flask import Flask, render_template, request
from flask_mysqldb import MySQL

app = Flask(__name__)
app.config["TEMPLATES_AUTO_RELOAD"] = True
if __name__ == "__main__":
    app.run(debug=True)

app.config["MYSQL_USER"] = "root"
app.config["MYSQL_PASSWORD"] = ""
app.config["MYSQL_DB"] = "csart_db"
app.config["MYSQL_CURSORCLASS"] = "DictCursor"

mysql = MySQL(app)

# home page
@app.route("/")
def hello_world():
    cursor = mysql.connection.cursor()
    cursor.execute("""SELECT first_name, last_name FROM Authors""")
    authors = cursor.fetchall()
    return render_template("index.html", authors=authors)

# route to search projects
# todo: finalise query to input form data
@app.route("/search", methods=["GET", "POST"])
def search():
    if request.method == "GET":
        return render_template("search.html")
    
    if request.method == "POST":
        cursor = mysql.connection.cursor()
        author = request.form.get("author")
        query = """SELECT projects.project_name, GROUP_CONCAT(CONCAT(' ', authors.first_name, ' ', authors.last_name)) authors
                FROM project_authors
                INNER JOIN projects ON projects.project_id = project_authors.project_id
                INNER JOIN authors ON authors.author_id = project_authors.author_id
                WHERE project_authors.project_id IN
	            (SELECT project_authors.project_id FROM project_authors 
	            INNER JOIN authors ON authors.author_id = project_authors.author_id 
	            INNER JOIN projects ON projects.project_id = project_authors.project_id 
	            WHERE first_name = 'Ante' AND last_name = 'Prodan')
                GROUP BY projects.project_name"""
        cursor.execute(query)
        projects = cursor.fetchall()
        return render_template("search_results.html", projects=projects)

# route to add projects
@app.route("/add", methods=["GET", "POST"])
def add():
    if request.method == "GET":
        return render_template("add.html")
    
    if request.method == "POST":
        form_data = request.form.to_dict()
        cursor = mysql.connection.cursor()
        print(form_data)
        query = """INSERT INTO projects(project_name, url, start_date, end_date, release_date, country, funding_org, funding_amount) 
        VALUES (%s,%s,%s,%s,%s,%s,%s,%s)"""
        for k in form_data:
            if form_data[k] == '':
                form_data[k] = None
        print(form_data)
        cursor.execute(query, [form_data["project_name"], form_data["url"], form_data["start_date"], form_data["end_date"], form_data["release_date"], form_data["country"], form_data["funding_org"], form_data["funding_amount"]])
        mysql.connection.commit()
        return render_template("added.html", form_data=form_data)

    
    