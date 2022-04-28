#Set up environment variables
#$env:FLASK_APP = "application"
#$env:FLASK_ENV = "development"

from flask import Flask, render_template, request, jsonify
from flask_mysqldb import MySQL
from helpers import null_to_string

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
    cursor.execute("""SELECT * FROM Authors""")
    authors = cursor.fetchall()
    return render_template("index.html", authors=authors)

# route to search projects
@app.route("/projects", methods=["GET", "POST"])
def projects():
    if request.method == "GET":
        return render_template("project_search.html")
    
    if request.method == "POST":
        cursor = mysql.connection.cursor()
        author = request.form.get("author")
        query = """SELECT projects.project_id, projects.project_name, GROUP_CONCAT(CONCAT(' ', authors.author_name)) authors
                FROM project_authors
                INNER JOIN projects ON projects.project_id = project_authors.project_id
                INNER JOIN authors ON authors.author_id = project_authors.author_id
                WHERE project_authors.project_id IN
	            (SELECT project_authors.project_id FROM project_authors 
	            INNER JOIN authors ON authors.author_id = project_authors.author_id 
	            INNER JOIN projects ON projects.project_id = project_authors.project_id 
	            WHERE author_name LIKE %s)
                GROUP BY projects.project_name"""
        cursor.execute(query, ["%"+author+"%"])
        projects = cursor.fetchall()
        return render_template("project_results.html", projects=projects)

@app.route("/projects/<id>")
def projects_id(id):
    cursor = mysql.connection.cursor()
    query = """SELECT * FROM projects
            WHERE projects.project_id = %s"""
    cursor.execute(query, [id])
    project_results = cursor.fetchone()
    return render_template("project_profile.html", project_results=project_results)


# route to search authors
@app.route("/authors", methods=["GET", "POST"])
def authors():
    if request.method == "GET":
        return render_template("author_search.html")

    if request.method == "POST":
        cursor = mysql.connection.cursor()
        author = request.form.get("author_name")
        query = """SELECT * FROM authors 
                LEFT JOIN other_names ON other_names.author_id = authors.author_id
                WHERE author_name LIKE %s
                GROUP BY author_name"""
        cursor.execute(query, ["%"+author+"%"])
        author_results = cursor.fetchall()
        print(type(author_results))
        author_results = null_to_string(author_results)
        print(author_results)
        return render_template("author_results.html", author_results=author_results)
    

@app.route("/authors/<id>/")
def users(id):
    cursor = mysql.connection.cursor()
    auth_query = """SELECT * FROM authors 
               LEFT JOIN other_names ON other_names.author_id = authors.author_id
               WHERE authors.author_id = %s"""
    cursor.execute(auth_query, [id])
    author_results = cursor.fetchall()

    proj_query = """ SELECT *, GROUP_CONCAT(CONCAT(' ', authors.author_name)) authors
                FROM project_authors
                INNER JOIN projects ON projects.project_id = project_authors.project_id
                INNER JOIN authors ON authors.author_id = project_authors.author_id
                WHERE project_authors.project_id IN
	            (SELECT project_authors.project_id FROM project_authors 
	            INNER JOIN authors ON authors.author_id = project_authors.author_id 
	            INNER JOIN projects ON projects.project_id = project_authors.project_id 
	            WHERE authors.author_id = %s)
                GROUP BY projects.release_date DESC"""
    cursor.execute(proj_query, [id])
    project_results = cursor.fetchall()
    return render_template("author_profile.html", author_results=author_results, project_results=project_results)


# route to add projects
@app.route("/add", methods=["GET", "POST"])
def add():
    if request.method == "GET":
        return render_template("add.html")
    
    if request.method == "POST":
        cursor = mysql.connection.cursor()
        form_data = request.form.to_dict()
        
        #Add project to projects table
        project_insert = """INSERT INTO projects(project_name, url, start_date, end_date, release_date, country, funding_org, funding_amount) 
        VALUES (%s,%s,%s,%s,%s,%s,%s,%s)"""
        for k in form_data:
            if form_data[k] == '':
                form_data[k] = None
        cursor.execute(project_insert, [form_data["project_name"], form_data["url"], form_data["start_date"], form_data["end_date"], form_data["release_date"], form_data["country"], form_data["funding_org"], form_data["funding_amount"]])
        #Get the project_id of the project using LAST_INSERT_ID()
        cursor.execute("""SELECT LAST_INSERT_ID()""")
        project_id = cursor.fetchone()['LAST_INSERT_ID()']

        #retrieve all the authors in the form and put them in a new dictionary
        #remember there is a variable number of authors per project
        form_authors = {}
        for i in form_data:
            if i[0:6] == "author":
                form_authors[i] = form_data[i]
        
        #Add authors to author table (if they don't already exist)
        #Also add new row to project_authors containing project_id and author_id for each author
        for i in form_authors:
            cursor.execute("SELECT * FROM authors WHERE author_name = %s OR other_name = %s", [form_authors[i], form_authors[i]])
            author_fetch = cursor.fetchall()
            #if author not in database: add new author row, add new project_author row
            if len(author_fetch) == 0:
                cursor.execute("""INSERT INTO authors(`author_name`) VALUES (%s)""", [form_authors[i]])
                cursor.execute("""SELECT LAST_INSERT_ID()""")
                cursor.execute("""INSERT INTO project_authors VALUES (%s, %s)""", [project_id, cursor.fetchone()['LAST_INSERT_ID()']])
            #if author in database: add new project_author row
            elif len(author_fetch) == 1:
                cursor.execute("""INSERT INTO project_authors VALUES (%s, %s)""", [project_id, author_fetch[0]["author_id"]])
            else:
                #TODO create redirect for errors
                print("More than one author found")

        mysql.connection.commit()
        return render_template("added.html", form_data=form_data)

# NAMES=["abc","abcd","abcde","abcdef"]

# @app.route('/_autocomplete')
# def autocomplete():
    