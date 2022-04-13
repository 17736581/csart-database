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
    cursor.execute("""SELECT * FROM Authors""")
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
        query = """SELECT projects.project_name, GROUP_CONCAT(CONCAT(' ', authors.author_name)) authors
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
        return render_template("search_results.html", projects=projects)

# route to add projects
@app.route("/add", methods=["GET", "POST"])
def add():
    if request.method == "GET":
        return render_template("add.html")
    
    if request.method == "POST":
        cursor = mysql.connection.cursor()
        form_data = request.form.to_dict()
        
        #retrieve all the authors in the form and put them in a new dictionary
        #remember there is a variable number of authors per project
        form_authors = {}
        for i in form_data:
            if i[0:6] == "author":
                form_authors[i] = form_data[i]
        
        print(form_authors)
        
        author_keys = []
        #Add authors to author table (if they don't already exist)
        for i in form_authors:
            cursor.execute("SELECT * FROM authors WHERE author_name = %s", [form_authors[i]])
            author_fetch = cursor.fetchall()
            if len(author_fetch) == 0:
                cursor.execute("""INSERT INTO authors(`author_name`) VALUES (%s)""", [form_authors[i]])
                cursor.execute("""SELECT LAST_INSERT_ID()""")
                author_keys.append(cursor.fetchone()['LAST_INSERT_ID()'])
            elif len(author_fetch) == 1:
                author_keys.append(author_fetch[0]["author_name"])
            else:
                print("More than one author found")

        #Add project to projects table
        project_query = """INSERT INTO projects(project_name, url, start_date, end_date, release_date, country, funding_org, funding_amount) 
        VALUES (%s,%s,%s,%s,%s,%s,%s,%s)"""
        for k in form_data:
            if form_data[k] == '':
                form_data[k] = None
        cursor.execute(project_query, [form_data["project_name"], form_data["url"], form_data["start_date"], form_data["end_date"], form_data["release_date"], form_data["country"], form_data["funding_org"], form_data["funding_amount"]])
        #Get the project_id of the project using LAST_INSERT_ID()
        cursor.execute("""SELECT LAST_INSERT_ID()""")
        project_id = cursor.fetchone()['LAST_INSERT_ID()']

        #Add author and project ids to project_authors associative table
        #loop through all authors, getting their author_id and adding a new row to project_authors along with the project_id
        for i in form_authors:
            cursor.execute("""SELECT author_id FROM authors WHERE author_name = %s""", [form_authors[i]])
            author_id = cursor.fetchone()['author_id']
            cursor.execute("""INSERT INTO project_authors VALUES (%s, %s)""", [project_id, author_id])


#       mysql.connection.commit()
        return render_template("added.html", form_data=form_data)

    
    