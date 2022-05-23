#Set up environment variables
#$env:FLASK_APP = "application"
#$env:FLASK_ENV = "development"

from flask import Flask, render_template, request, jsonify, session, redirect
from flask_mysqldb import MySQL
from werkzeug.security import check_password_hash, generate_password_hash
from helpers import login_required, null_to_string, string_to_null
import csv, os

app = Flask(__name__)
app.config["TEMPLATES_AUTO_RELOAD"] = True
if __name__ == "__main__":
    app.run(debug=True)

app.config["MYSQL_USER"] = "root"
app.config["MYSQL_PASSWORD"] = ""
app.config["MYSQL_DB"] = "csart_db"
app.config["MYSQL_CURSORCLASS"] = "DictCursor"
app.config["JSON_AS_ASCII"] = False
app.config['JSON_SORT_KEYS'] = False

#Set the secret key
app.secret_key = os.urandom(16)

mysql = MySQL(app)

# home page
@app.route("/")
@login_required
def hello_world():
    cursor = mysql.connection.cursor()
    cursor.execute("""SELECT * FROM Authors""")
    authors = cursor.fetchall()
    return render_template("index.html", authors=authors)

@app.route("/register", methods=["GET", "POST"])
def register():
    cursor = mysql.connection.cursor()

    if request.method == "POST":
        name = request.form.get("username")
        password = request.form.get("password")
        confirmation = request.form.get("confirmation")

        if not name:
            return "must provide username"
        
        cursor.execute("SELECT * FROM users WHERE username = %s", [name])
        if len(cursor.fetchall()) != 0:
            return "username taken"

        if password != confirmation or password == "" or confirmation == "":
            return "please re-enter password"
        
        hashed = generate_password_hash(password)

        cursor.execute("INSERT INTO users (username, hash) VALUES (%s, %s)", [name, hashed])
        mysql.connection.commit()
        return render_template("login.html")
    
    else:
        return render_template("register.html")

@app.route("/login", methods=["GET", "POST"])
def login():
    cursor = mysql.connection.cursor()

    #forget any userid
    session.clear()

    if request.method == "POST":

        if not request.form.get("username"):
            return "must provide username"
        
        elif not request.form.get("password"):
            return "must provide password"

        cursor.execute("SELECT * FROM users WHERE username = %s", [request.form.get("username")])

        rows = cursor.fetchall()

        if len(rows) != 1 or not check_password_hash(rows[0]["hash"], request.form.get("password")):
            return "invalid username and/or password"
        
        session["user_id"] = rows[0]["user_id"]

        return redirect("/")
    
    else:
        return render_template("login.html")

@app.route("/logout")
def logout():
    session.clear()

    return redirect("/login")

# route to search projects
@app.route("/projects", methods=["GET", "POST"])
@login_required
def projects():
    if request.method == "GET":
        return render_template("project_search.html")
    
    if request.method == "POST":
        cursor = mysql.connection.cursor()
        project_name = request.form.get("project_name")
        query = """SELECT projects.project_id, projects.project_name, GROUP_CONCAT(CONCAT(' ', authors.author_name)) authors
                FROM project_authors
                INNER JOIN projects ON projects.project_id = project_authors.project_id
                INNER JOIN authors ON authors.author_id = project_authors.author_id
                WHERE project_authors.project_id IN
	            (SELECT project_authors.project_id FROM project_authors)
                AND projects.project_name LIKE %s
                GROUP BY projects.project_name"""
        cursor.execute(query, ["%"+project_name+"%"])
        projects = cursor.fetchall()
        return render_template("project_results.html", projects=projects)

@app.route("/projects/<id>")
@login_required
def projects_id(id):
    cursor = mysql.connection.cursor()
    project_query = """SELECT * FROM projects
            WHERE projects.project_id = %s"""
    cursor.execute(project_query, [id])
    project_results = cursor.fetchone()
    project_results = null_to_string(project_results)

    author_query = """SELECT author_name, authors.author_id FROM project_authors
                    INNER JOIN projects ON projects.project_id = project_authors.project_id
                    INNER JOIN authors ON authors.author_id = project_authors.author_id
                    WHERE projects.project_id = %s"""

    cursor.execute(author_query, [id])
    author_results = cursor.fetchall()
    return render_template("project_profile.html", project_results=project_results, author_results=author_results)


# route to search authors
@app.route("/authors", methods=["GET", "POST"])
@login_required
def authors():
    if request.method == "GET":
        return render_template("author_search.html")

    if request.method == "POST":
        cursor = mysql.connection.cursor()
        author = request.form.get("author_name")
        query = """SELECT authors.author_id, author_name, website, affiliations, GROUP_CONCAT(CONCAT('\n', other_names.other_name)) other_name FROM authors 
                LEFT JOIN other_names ON other_names.author_id = authors.author_id
                WHERE author_name LIKE %s
                GROUP BY author_name"""
        cursor.execute(query, ["%"+author+"%"])
        author_results = cursor.fetchall()
        author_results = null_to_string(author_results)


        return render_template("author_results.html", author_results=author_results)
    
#author profile page by id
@app.route("/authors/<id>/")
@login_required
def author_profile(id):
    cursor = mysql.connection.cursor()
    author_query = """SELECT *, GROUP_CONCAT(CONCAT('\n', other_names.other_name)) other_names FROM authors 
               LEFT JOIN other_names ON other_names.author_id = authors.author_id
               WHERE authors.author_id = %s"""
    cursor.execute(author_query, [id])
    author_results = cursor.fetchone()
    author_results = null_to_string(author_results)

    project_query = """ SELECT *, GROUP_CONCAT(CONCAT(' ', authors.author_name)) authors
                FROM project_authors
                INNER JOIN projects ON projects.project_id = project_authors.project_id
                INNER JOIN authors ON authors.author_id = project_authors.author_id
                WHERE project_authors.project_id IN
	            (SELECT project_authors.project_id FROM project_authors 
	            INNER JOIN authors ON authors.author_id = project_authors.author_id 
	            INNER JOIN projects ON projects.project_id = project_authors.project_id 
	            WHERE authors.author_id = %s)
                GROUP BY projects.release_date DESC"""
    cursor.execute(project_query, [id])
    project_results = cursor.fetchall()
    return render_template("author_profile.html", author_results=author_results, project_results=project_results)

#route to edit author information
@app.route("/authors/<id>/edit", methods=["GET", "POST"])
@login_required
def author_edit(id):
    #first query the author data
    cursor = mysql.connection.cursor()
    author_query = """SELECT * FROM authors 
               LEFT JOIN other_names ON other_names.author_id = authors.author_id
               WHERE authors.author_id = %s"""
    cursor.execute(author_query, [id])
    author_results = cursor.fetchone()
    author_results = null_to_string(author_results)

    #then query author's other names
    othernames_query = """SELECT other_name_id, other_name FROM other_names
                        INNER JOIN authors ON authors.author_id = other_names.author_id
                        WHERE authors.author_id = %s"""
    cursor.execute(othernames_query, [id])
    othernames_results = cursor.fetchall()

    if request.method == "GET":
        return render_template("author_edit.html", author_results=author_results, othernames_results = othernames_results)
    
    if request.method == "POST":
        cursor = mysql.connection.cursor()
        #processing the updated author data comes in three parts:
        #updating author table, updating existing other_names, adding new other_names
        form_data = request.form.to_dict()
        form_data = string_to_null(form_data)

        #update author table
        author_query = """UPDATE authors
                        SET author_name = %s,
                        email = %s,
                        website = %s,
                        affiliations = %s,
                        statement = %s
                        WHERE author_id = %s"""
        cursor.execute(author_query, [form_data['author_name'], form_data['email'], form_data['website'], form_data['affiliations'], form_data['statement'], id])
        author_results = cursor.fetchall()
        print(author_results)
        mysql.connection.commit()

        #update existing other names
        othername_data = {}
        #put other names into separate dictionary with keys corresponding to database id
        for key in form_data:
            if key[0:3] == "old":
                othername_data[int(''.join(filter(str.isdigit, key)))] = form_data[key]
        print(othername_data)
        othername_query = """UPDATE other_names
                            SET other_name = %s 
                            WHERE other_name_id = %s"""
        for key in othername_data:
            cursor.execute(othername_query, [othername_data[key], key])
        
        
        #get the new other names in a list
        #loop through the list to check if the other name exists 
        #join authors and othernames, check othername and author_id
        #if other_name not exist, add other_name entry, add author_other_names entry
        #similar to adding projects and project_authors

        return form_data

# route to add projects
@app.route("/add", methods=["GET", "POST"])
@login_required
def add():
    if request.method == "GET":
        cursor = mysql.connection.cursor()
        cursor.execute("""SELECT author_name FROM authors""")
        authors = cursor.fetchall()
        return render_template("add.html", authors=authors)
    
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
            cursor.execute("""SELECT * FROM authors 
                            LEFT JOIN other_names on other_names.author_id = authors.author_id
                            WHERE author_name = %s OR other_name = %s""", [form_authors[i], form_authors[i]])
            author_fetch = cursor.fetchall()
            #if author not in database: add new author row, add new project_author row
            if len(author_fetch) == 0:
                cursor.execute("""INSERT INTO authors(`author_name`) VALUES (%s)""", [form_authors[i]])
                cursor.execute("""SELECT LAST_INSERT_ID()""")
                cursor.execute("""INSERT INTO project_authors VALUES (%s, %s)""", [project_id, cursor.fetchone()['LAST_INSERT_ID()']])
            #if author in database: add new project_author row
            elif len(author_fetch) >= 1:
                cursor.execute("""INSERT INTO project_authors VALUES (%s, %s)""", [project_id, author_fetch[0]["author_id"]])
            else:
                #TODO create redirect for errors
                print("More than one author found")

        mysql.connection.commit()
        return render_template("added.html", form_data=form_data)

# NAMES=["abc","abcd","abcde","abcdef"]

# @app.route('/_autocomplete')
# def autocomplete():

@app.route("/network")
def network():
    cursor = mysql.connection.cursor()
    cursor.execute("""SELECT author_name as id, 1 as 'group' from authors""")
    nodes = cursor.fetchall()
    cursor.execute("""Select x.author_name as 'source',
                        y.author_name as 'target',
                        count(pa.project_id) as value
                    From project_authors pa
                    Inner join project_authors pb
                    On pa.project_id = pb.project_id
                    Inner join authors x on x.author_id = pa.author_id
                    Inner join authors y on y.author_id = pb.author_id
                    WHERE pa.author_id < pb.author_id
                    Group by pa.author_id,pb.author_id;""")
    links = cursor.fetchall()
    return jsonify(nodes=nodes, links=links)

@app.route("/network/<id>")
def network_author(id):
    cursor = mysql.connection.cursor()
    cursor.execute("""Select y.author_name as 'target', 1 as 'group'
                    From project_authors pa
                    Inner join project_authors pb
                    On pa.project_id = pb.project_id
                    Inner join authors x on x.author_id = pa.author_id
                    Inner join authors y on y.author_id = pb.author_id
                    WHERE pa.author_id = %s
                    Group by pa.author_id,pb.author_id;""", [id])
    nodes = cursor.fetchall()
    cursor.execute("""Select x.author_name as 'source',
                        y.author_name as 'target',
                        count(pa.project_id) as value
                    From project_authors pa
                    Inner join project_authors pb
                    On pa.project_id = pb.project_id
                    Inner join authors x on x.author_id = pa.author_id
                    Inner join authors y on y.author_id = pb.author_id
                    WHERE pa.author_id < pb.author_id AND pa.author_id = %s
                    Group by pa.author_id,pb.author_id;""", [id])
    links = cursor.fetchall()
    return jsonify(nodes=nodes, links=links)