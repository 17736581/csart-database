# FOR DEVELOPMENT
# $env:FLASK_APP = "application.py"
# $env:FLASK_ENV = "development"

from ast import keyword
import string
from colorama import Cursor
from flask import Flask, render_template, request, jsonify, session, redirect
from flask_mysqldb import MySQL
from werkzeug.security import check_password_hash, generate_password_hash
from helpers import login_required, null_to_string, string_to_null
import markdown

app = Flask(__name__)

if __name__ == "__main__":
    app.run(host="0.0.0.0")

app.config["MYSQL_USER"] = "root"
app.config["MYSQL_PASSWORD"] = """"""
app.config["MYSQL_DB"] = "csart_db"
app.config["MYSQL_CURSORCLASS"] = "DictCursor"
app.config["JSON_AS_ASCII"] = False
app.config['JSON_SORT_KEYS'] = False
app.url_map.strict_slashes = False

#Set the secret key
app.secret_key = b'\x8a\x0f\x1c`n\xc8\xde\xc0\x04\x12\x82\x9b\xc4\xec\xe5C'

mysql = MySQL(app)

# home page
@app.route("/")
@login_required
def index():
    cursor = mysql.connection.cursor()
    project_query = """SELECT DISTINCT *, 
                        GROUP_CONCAT(DISTINCT a.author_name ORDER BY pa.author_order SEPARATOR ', ') AS author_names, 
                        GROUP_CONCAT(DISTINCT k.keyword_name SEPARATOR ', ') as keyword_names
                            FROM projects p
                            JOIN project_authors pa ON p.project_id = pa.project_id
                            JOIN authors a ON pa.author_id = a.author_id
                            LEFT JOIN project_keywords p_k ON p_k.project_id = p.project_id
                            LEFT JOIN keywords k ON k.keyword_id = p_k.keyword_id
                            GROUP BY p.project_name
                            ORDER BY p.project_id DESC LIMIT 3;
                            """
    cursor.execute(project_query)
    projects = cursor.fetchall()

    projects = null_to_string(projects)
        
    # Convert keyword names from concatenated string list to actual list
    for i in projects:
        i['keyword_names'] = i['keyword_names'].split(', ')

    return render_template("index.html", projects=projects)

# @app.route("/register", methods=["GET", "POST"])
# def register():
#     cursor = mysql.connection.cursor()

#     if request.method == "POST":
#         name = request.form.get("username")
#         password = request.form.get("password")
#         confirmation = request.form.get("confirmation")

#         if not name:
#             return "must provide username"
        
#         cursor.execute("SELECT * FROM users WHERE username = %s", [name])
#         if len(cursor.fetchall()) != 0:
#             return "username taken"

#         if password != confirmation or password == "" or confirmation == "":
#             return "please re-enter password"
        
#         hashed = generate_password_hash(password)

#         cursor.execute("INSERT INTO users (username, hash) VALUES (%s, %s)", [name, hashed])
#         mysql.connection.commit()
#         return render_template("login.html")
    
#     else:
#         return render_template("register.html")

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
        search = request.form.to_dict()

        project_name = search['project_name'].strip()
        keyword = search['keyword'].strip()
        author = search["author"].strip()
        tag = search["tag"].strip()

        # If keyword not included in search
        project_query = """SELECT DISTINCT *, 
                        GROUP_CONCAT(DISTINCT a.author_name ORDER BY pa.author_order SEPARATOR ', ') AS author_names, 
                        GROUP_CONCAT(DISTINCT k.keyword_name SEPARATOR ', ') as keyword_names
                            FROM projects p
                            JOIN project_authors pa ON p.project_id = pa.project_id
                            JOIN authors a ON pa.author_id = a.author_id
                            LEFT JOIN project_keywords p_k ON p_k.project_id = p.project_id
                            LEFT JOIN keywords k ON k.keyword_id = p_k.keyword_id
                            WHERE (
                                p.project_id IN (
                                    SELECT project_id
                                    FROM project_authors
                                    WHERE project_name LIKE %s
                                    AND project_authors.author_id IN (
                                        SELECT a.author_id
                                        FROM authors a
                                        LEFT JOIN other_names ON a.author_id = other_names.author_id
                                        WHERE a.author_name LIKE %s OR other_names.other_name LIKE %s
                                    )
                                )
                            )
                            AND (
                                (primary_tag LIKE %s AND primary_tag IS NOT NULL) OR (secondary_tag LIKE %s AND secondary_tag IS NOT NULL) OR %s = %s
                            )
                            AND (
                                p_k.keyword_id IN (
                                    SELECT keyword_id
                                    FROM keywords
                                    WHERE keyword_name LIKE %s
                                )
                                OR %s = %s
                            )
                            GROUP BY p.project_name
                            ORDER BY COALESCE(release_date, year, end_date, start_date) DESC;
                            """
        
        cursor.execute(project_query, ["%"+project_name+"%", "%"+author+"%", "%"+author+"%", "%"+tag+"%", "%"+tag+"%", "%"+tag+"%", "%"+"%", "%"+keyword+"%","%"+keyword+"%","%"+"%"])
        projects = cursor.fetchall()
        projects = null_to_string(projects)
        
        # Convert keyword names from concatenated string list to actual list
        for i in projects:
            i['keyword_names'] = i['keyword_names'].split(', ')
        
        return render_template("project_results.html", projects=projects, search=search)

@app.route("/author_autocomp", methods=["GET"])
def author_autocomp():
    cursor = mysql.connection.cursor()

    q = request.args['q']

    author_query = """SELECT DISTINCT author_name 
                FROM authors
                LEFT JOIN other_names ON other_names.author_id = authors.author_id
                WHERE author_name LIKE %s OR other_name LIKE %s
                ORDER BY author_name ASC"""

    cursor.execute(author_query, ["%"+q+"%", "%"+q+"%"])
    authors = cursor.fetchall()
    authors = [k['author_name'] for k in authors]
    cursor.close()
    
    return jsonify(authors)

@app.route("/keyword_autocomp", methods=["GET"])
def keyword_autocomp():
    cursor = mysql.connection.cursor()

    q = request.args['q']

    keyword_query = """SELECT DISTINCT keyword_name
                FROM keywords
                WHERE keyword_name LIKE %s
                ORDER BY keyword_name ASC"""

    cursor.execute(keyword_query, ["%"+q+"%"])
    keywords = cursor.fetchall()
    keywords = [k['keyword_name'] for k in keywords]
    cursor.close()
    
    return jsonify(keywords)

@app.route("/tag_autocomp", methods=["GET"])
def tag_autocomp():
    cursor = mysql.connection.cursor()

    q = request.args['q']

    tag_query = """SELECT tag_name
                    FROM (
                    SELECT primary_tag AS tag_name FROM projects
                    UNION
                    SELECT secondary_tag AS tag_name FROM projects
                    ) AS subquery
                    WHERE tag_name LIKE %s;
                    """

    cursor.execute(tag_query, ["%"+q+"%"])
    tags = cursor.fetchall()
    tags = [k['tag_name'] for k in tags]
    cursor.close()
    
    return jsonify(tags)

@app.route("/projects/search/<project_name>" , defaults={"keyword": None})
@app.route("/projects/search/<project_name>/<keyword>")
@login_required
def projects_search(project_name, keyword):
    cursor = mysql.connection.cursor()

    cursor.execute("""CREATE TEMPORARY TABLE temp_authors
                        SELECT project_id, author_order, project_authors.author_id, author_name, email, website, affiliations, statement 
                        FROM `project_authors` 
                        JOIN authors on authors.author_id = project_authors.author_id
                        ORDER BY `project_authors`.`project_id` ASC, `project_authors`.`author_order`;""")
    
    cursor.execute("""CREATE TEMPORARY TABLE temp_projects 
                        SELECT projects.project_id, projects.project_name, GROUP_CONCAT(CONCAT(' ', temp_authors.author_name)) author_names, start_date, end_date, release_date, url, projects.statement, type_name, year, primary_tag, secondary_tag
                        FROM temp_authors
                        INNER JOIN projects ON projects.project_id = temp_authors.project_id
                        LEFT JOIN types ON types.type_id = projects.type_id
                        GROUP BY projects.project_id;""")
    cursor.execute("""CREATE TEMPORARY TABLE temp_keywords
                        SELECT projects.project_id AS k_project_id, GROUP_CONCAT(CONCAT(' ', keywords.keyword_name)) keyword_names
                        FROM project_keywords
                        INNER JOIN keywords ON keywords.keyword_id = project_keywords.keyword_id
                        INNER JOIN projects ON projects.project_id = project_keywords.project_id
                        GROUP BY projects.project_id;""")
    
    #Multiple possible searches based on whether project_name and keyword fields are used
    if project_name != None and keyword != None:            
        cursor.execute("""SELECT *
                        FROM temp_projects
                        LEFT JOIN temp_keywords ON temp_keywords.k_project_id = temp_projects.project_id
                        WHERE project_name LIKE %s AND keyword_names LIKE %s
                        ORDER BY COALESCE(release_date, end_date, start_date) DESC;""", ["%"+project_name+"%", "%"+keyword+"%"]
                        )
    elif project_name != None and keyword == None:
        cursor.execute("""SELECT *
                        FROM temp_projects
                        LEFT JOIN temp_keywords ON temp_keywords.k_project_id = temp_projects.project_id
                        WHERE project_name LIKE %s
                        ORDER BY COALESCE(release_date, end_date, start_date) DESC;""", ["%"+project_name+"%"])
    elif project_name == None and keyword != None:
        cursor.execute("""SELECT *
                        FROM temp_projects
                        LEFT JOIN temp_keywords ON temp_keywords.k_project_id = temp_projects.project_id
                        WHERE keyword_names LIKE %s
                        ORDER BY COALESCE(release_date, end_date, start_date) DESC;""", ["%"+keyword+"%"])
    else:
        cursor.execute("""SELECT *
                        FROM temp_projects
                        LEFT JOIN temp_keywords ON temp_keywords.k_project_id = temp_projects.project_id
                        ORDER BY COALESCE(release_date, end_date, start_date) DESC;""")

    projects = cursor.fetchall()
    projects = null_to_string(projects)

    #Get keywords as a list to create links for keywords
    cursor.execute("""SELECT projects.project_id, keywords.keyword_name
                    FROM project_keywords
                    INNER JOIN keywords ON keywords.keyword_id = project_keywords.keyword_id
                    INNER JOIN projects ON projects.project_id = project_keywords.project_id""")
    keywords = cursor.fetchall()

    return render_template("project_results.html", projects=projects, keywords=keywords)

@app.route("/projects/<id>")
@login_required
def projects_id(id):
    cursor = mysql.connection.cursor()
    project_query = """SELECT * FROM projects
                    LEFT JOIN types ON types.type_id = projects.type_id
                    WHERE projects.project_id = %s"""
    cursor.execute(project_query, [id])
    project_results = cursor.fetchone()
    project_results = null_to_string(project_results)

    author_query = """SELECT author_name, authors.author_id, author_order FROM project_authors
                    INNER JOIN projects ON projects.project_id = project_authors.project_id
                    INNER JOIN authors ON authors.author_id = project_authors.author_id
                    WHERE projects.project_id = %s
                    ORDER BY author_order ASC"""

    cursor.execute(author_query, [id])
    author_results = cursor.fetchall()

    keyword_query = """SELECT keyword_name FROM project_keywords 
                    INNER JOIN projects on projects.project_id = project_keywords.project_id 
                    INNER JOIN keywords on keywords.keyword_id = project_keywords.keyword_id
                    WHERE projects.project_id = %s;"""
    cursor.execute(keyword_query, [id])
    keyword_results = cursor.fetchall()

    html = get_html(id)

    return render_template("project_profile.html", project_results=project_results, author_results=author_results, keyword_results=keyword_results, html=html)

@app.route("/projects/<id>/edit", methods=["GET", "POST"])
@login_required
def projects_edit(id):
    cursor = mysql.connection.cursor()
    if request.method == "GET":
        #Query project data
        project_query = """SELECT * FROM projects
                        LEFT JOIN types ON types.type_id = projects.type_id
                        WHERE project_id = %s"""
        cursor.execute(project_query, [id])
        project_results = cursor.fetchone()
        project_results = null_to_string(project_results)
        
        #Query project's authors
        author_query = """SELECT author_name, authors.author_id FROM project_authors
                        INNER JOIN projects ON projects.project_id = project_authors.project_id
                        INNER JOIN authors ON authors.author_id = project_authors.author_id
                        WHERE projects.project_id = %s
                        ORDER BY author_order;"""
        cursor.execute(author_query, [id])
        author_results = cursor.fetchall()

        #Query all authors for author datalist
        cursor.execute("SELECT author_name FROM authors")
        author_list = cursor.fetchall()
        
        #Query keywords
        keyword_query = """SELECT keywords.keyword_id, keywords.keyword_name FROM `project_keywords`
                        INNER JOIN projects ON projects.project_id = project_keywords.project_id
                        INNER JOIN keywords ON keywords.keyword_id = project_keywords.keyword_id
                        WHERE projects.project_id = %s"""
        cursor.execute(keyword_query, [id])
        keyword_results = cursor.fetchall()
        
        #Query all keywords for keyword datalist
        cursor.execute("SELECT keyword_name FROM keywords")
        keyword_list = cursor.fetchall()
        cursor.execute("SELECT * FROM types")
        type_list = cursor.fetchall()
        return render_template("project_edit.html", project_results=project_results, author_results=author_results, author_list=author_list, keyword_results=keyword_results, keyword_list=keyword_list, type_list=type_list)
    
    if request.method == "POST":
        form_data = request.form.to_dict()
        #Strip form data of whitespace
        for i in form_data:
            form_data[i] = form_data[i].strip()

        #Find type_id from type_name
        cursor.execute("SELECT type_id FROM types WHERE type_name = %s", [form_data['type_name']])
        type_result = cursor.fetchone()
        if type_result != None:
            type_id = type_result
        else:
            type_id = {"type_id": ""}

        #add type_id to form_data dictionary
        form_data["type_id"] = type_id["type_id"]

        form_data = string_to_null(form_data)        

        #Update projects table
        project_query = """UPDATE projects
                            SET project_name = %s,
                                url = %s,
                                doi = %s,
                                statement = %s,
                                full_text = %s,
                                year = %s,
                                start_date = %s,
                                end_date = %s,
                                release_date = %s,
                                country = %s,
                                funding_org = %s,
                                funding_amount = %s,
                                type_id = %s,
                                cited_by = %s,
                                journal = %s,
                                volume = %s,
                                issue = %s, 
                                pages = %s,
                                publisher = %s,
                                project_lead = %s,
                                primary_tag = %s,
                                secondary_tag = %s
                            WHERE project_id = %s"""
        cursor.execute(project_query, [form_data['project_name'], 
                                       form_data['url'], 
                                       form_data['doi'],
                                       form_data['statement'], 
                                       form_data['full_text'],
                                       form_data['year'],
                                       form_data['start_date'], 
                                       form_data['end_date'], 
                                       form_data['release_date'],
                                       form_data['country'], 
                                       form_data['funding_org'], 
                                       form_data['funding_amount'], 
                                       form_data['type_id'],
                                       form_data['cited_by'],
                                       form_data['journal'],
                                       form_data['volume'],
                                       form_data['issue'],
                                       form_data['pages'],
                                       form_data['publisher'],
                                       form_data['project_lead'],
                                       form_data['primary_tag'],
                                       form_data['secondary_tag'],
                                       id])
        
        # #Retrieve all authors in the form
        form_authors = []
        for key, value in form_data.items():
            if "author" in key and value != None:
                form_authors.append(value)
        
        # Remove duplicates by converting to dictionary then converting back to list
        form_authors = list(dict.fromkeys(form_authors))
        
        #ALTERNATIVE: DELETE ALL PROJECT_AUTHORS ENTRIES, THEN ADD THEM BASED ON THE EDIT
        cursor.execute("DELETE FROM project_authors WHERE project_id = %s", [id])
        mysql.connection.commit()

        #Re-add authors to project_authors
        #Add new authors if they don't exist
        for i in form_authors:
            cursor.execute("""SELECT *, GROUP_CONCAT(CONCAT(' ', other_names.other_name)) other_names FROM authors 
                            LEFT JOIN other_names on other_names.author_id = authors.author_id
                            WHERE author_name = %s OR other_name = %s""", [i, i])
            author_fetch = cursor.fetchall()
            if len(author_fetch) == 1:
                #if author not in database: add new author row, add new project_author row
                if author_fetch[0]["author_id"] == None:
                    cursor.execute("""INSERT INTO authors(`author_name`) VALUES (%s)""", [i])
                    cursor.execute("""SELECT LAST_INSERT_ID()""")
                    cursor.execute("""INSERT INTO project_authors VALUES (%s, %s, %s)""", [id, cursor.fetchone()['LAST_INSERT_ID()'], form_authors.index(i)])
                #if author in database: add new project_author row
                elif author_fetch[0]["author_id"]:
                    cursor.execute("""INSERT INTO project_authors VALUES (%s, %s, %s)""", [id, author_fetch[0]["author_id"], form_authors.index(i)])
            else:
                #TODO create redirect for errors
                print("Duplicate Error: more than one author found")

        #---Update keywords and project_keywords tables---
        form_keywords = set()
        for key, value in form_data.items():
            if "keyword" in key and value != None:
                form_keywords.add(value)
        
        #Delete project_keyword entries for this project
        cursor.execute("DELETE FROM project_keywords WHERE project_id =%s", [id])
        mysql.connection.commit()

        #Re-add project_keyword entries
        for i in form_keywords:
            cursor.execute("""SELECT * FROM keywords WHERE keyword_name = %s""", [i])
            keyword_fetch = cursor.fetchall()
            #if keyword not in database: add new keyword, then add project_keyword row for this project
            if len(keyword_fetch) == 0:
                cursor.execute("""INSERT INTO keywords(`keyword_name`) VALUES (%s)""", [i])
                cursor.execute("""SELECT LAST_INSERT_ID()""")
                cursor.execute("""INSERT INTO project_keywords VALUES (%s, %s)""", [id, cursor.fetchone()['LAST_INSERT_ID()']])
            elif len(keyword_fetch) == 1:
                cursor.execute("""INSERT INTO project_keywords VALUES (%s, %s)""", [id, keyword_fetch[0]['keyword_id']])
            else:
                print("Duplicate Error: more than one keyword found")

        mysql.connection.commit()
        return redirect(f"/projects/{id}")
    
# route to delete a project
@app.route("/projects/<id>", methods=["DELETE"])
@login_required
def projects_delete(id):
    cursor = mysql.connection.cursor()

    project_authors_del_query = """DELETE FROM project_authors WHERE project_id = %s"""
    cursor.execute(project_authors_del_query, [id])
    mysql.connection.commit()

    project_keywords_del_query = """DELETE FROM project_keywords WHERE project_id = %s"""
    cursor.execute(project_keywords_del_query, [id])
    mysql.connection.commit()

    project_del_query = """DELETE FROM projects WHERE project_id = %s"""
    cursor.execute(project_del_query, [id])
    mysql.connection.commit()

    cursor.close()
    return f"Deleted Record of ID: {id}"

def get_html(id):
    cursor = mysql.connection.cursor()

    markdown_query = "SELECT project_id, project_name, full_text FROM projects WHERE project_id = %s"
    cursor.execute(markdown_query, [id])
    result = cursor.fetchone()

    cursor.close()
    
    if result["full_text"]:
        html = markdown.markdown(result["full_text"])
        return html

@app.route("/projects/<id>/markdown")
@login_required
def convert_markdown(id):
    cursor = mysql.connection.cursor()

    markdown_query = "SELECT project_id, project_name, full_text FROM projects WHERE project_id = %s"
    cursor.execute(markdown_query, [id])
    result = cursor.fetchone()

    cursor.close()
    
    if result["full_text"]:
        html = markdown.markdown(result["full_text"])
        return render_template("project_text.html", project_id=result["project_id"], project_name=result["project_name"], html=html)
    else:
        return render_template("project_text.html", project_id=result["project_id"], project_name=result["project_name"], html="Full Text Not Found")

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
                WHERE author_name LIKE %s OR other_name LIKE %s
                GROUP BY author_name"""
        cursor.execute(query, ["%"+author+"%", "%"+author+"%"])
        author_results = cursor.fetchall()
        author_results = null_to_string(author_results)

        if len(author_results) == 1:
            return redirect(f"/authors/{author_results[0]['author_id']}")
        else:
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

    cursor.execute("""CREATE TEMPORARY TABLE temp_authors
                    SELECT project_id, author_order, project_authors.author_id, author_name, email, website, affiliations, statement 
                    FROM `project_authors` 
                    JOIN authors on authors.author_id = project_authors.author_id
                    ORDER BY `project_authors`.`project_id` ASC, `project_authors`.`author_order`;""")

    project_query = """ SELECT *, GROUP_CONCAT(CONCAT(' ', temp_authors.author_name)) authors
                FROM temp_authors
                INNER JOIN projects ON projects.project_id = temp_authors.project_id
                WHERE temp_authors.project_id IN
	            (SELECT project_authors.project_id FROM project_authors 
	            INNER JOIN authors ON authors.author_id = project_authors.author_id 
	            INNER JOIN projects ON projects.project_id = project_authors.project_id 
	            WHERE authors.author_id = %s)
                GROUP BY projects.project_id DESC
                ORDER BY projects.year DESC;"""

    # project_query = """SELECT * FROM `project_authors`
    #                 JOIN projects on projects.project_id = project_authors.project_id
    #                 WHERE author_id = %s
    #                 ORDER BY `author_id`  DESC"""
    cursor.execute(project_query, [id])
    project_results = cursor.fetchall()
    return render_template("author_profile.html", author_results=author_results, project_results=project_results)

#route to edit author information
@app.route("/authors/<id>/edit", methods=["GET", "POST"])
@login_required
def author_edit(id):
    if request.method == "GET":
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

        return render_template("author_edit.html", author_results=author_results, othernames_results = othernames_results)
    
    if request.method == "POST":
        cursor = mysql.connection.cursor()
        #processing the updated author data comes in three parts:
        #updating author table, updating existing other_names, adding new other_names
        form_data = request.form.to_dict()

        #Strip whitespace from form data
        for i in form_data:
            form_data[i] = form_data[i].strip()

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

        #update existing other names
        othername_data = {}
        #put other names into separate dictionary with keys corresponding to database id
        for key in form_data:
            if key[0:3] == "old":
                othername_data[int(''.join(filter(str.isdigit, key)))] = form_data[key]
        othername_query = """UPDATE other_names
                            SET other_name = %s 
                            WHERE other_name_id = %s"""
        for key in othername_data:
            cursor.execute(othername_query, [othername_data[key], key])
        
        #!IMPORTANT
        #get the new other names in a set
        #insert othername and author_id
        new_othernames = set()
        for key in form_data:
            if key[0:3] == "new":
                new_othernames.add(form_data[key])
        new_othername_query = """INSERT INTO other_names (`other_name`, `author_id`)
                                VALUES (%s, %s) """
        for name in new_othernames:
            cursor.execute(new_othername_query, [name, id])

        mysql.connection.commit()
        return redirect(f"/authors/{id}")

# route to add projects
@app.route("/add", methods=["GET", "POST"])
@login_required
def add():
    if request.method == "GET":
        cursor = mysql.connection.cursor()

        #Query all authors for author datalist
        cursor.execute("""SELECT author_name FROM authors""")
        authors = cursor.fetchall()

        #Query all keywords for keyword datalist
        cursor.execute("SELECT keyword_name FROM keywords")
        keyword_list = cursor.fetchall()

        #Query all types for type datalist
        cursor.execute("SELECT * FROM types")
        type_list = cursor.fetchall()
        return render_template("add.html", authors=authors, keyword_list=keyword_list, type_list=type_list)
    
    if request.method == "POST":
        cursor = mysql.connection.cursor()
        form_data = request.form.to_dict()
        
        #Strip form data of whitespace
        for i in form_data:
            form_data[i] = form_data[i].strip()

        #Find type_id from type_name
        cursor.execute("SELECT type_id FROM types WHERE type_name = %s", [form_data['type_name']])
        type_result = cursor.fetchone()
        if type_result != None:
            type_id = type_result
        else:
            type_id = {"type_id": ""}

        #add type_id to form_data dictionary
        form_data["type_id"] = type_id["type_id"]

        form_data = string_to_null(form_data)

        #Add project to projects table
        try:
            project_insert = """INSERT INTO projects(project_name, url, doi, statement, full_text, year, start_date, end_date, release_date, country, funding_org, funding_amount, type_id, cited_by, journal, volume, issue, pages, publisher, project_lead, primary_tag, secondary_tag) 
            VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"""
            cursor.execute(project_insert, [form_data['project_name'], 
                                       form_data['url'], 
                                       form_data['doi'],
                                       form_data['statement'],
                                       form_data['full_text'],
                                       form_data['year'],
                                       form_data['start_date'], 
                                       form_data['end_date'], 
                                       form_data['release_date'],
                                       form_data['country'], 
                                       form_data['funding_org'], 
                                       form_data['funding_amount'], 
                                       form_data['type_id'],
                                       form_data['cited_by'],
                                       form_data['journal'],
                                       form_data['volume'],
                                       form_data['issue'],
                                       form_data['pages'],
                                       form_data['publisher'],
                                       form_data['project_lead'],
                                       form_data['primary_tag'],
                                       form_data['secondary_tag']])
            mysql.connection.commit()
        except:
            print("Did not add project")
            pass
            
        #Get the project_id of the project using LAST_INSERT_ID()
        cursor.execute("""SELECT LAST_INSERT_ID()""")
        project_id = cursor.fetchone()['LAST_INSERT_ID()']

        #retrieve all the authors in the form and put them in a new list
        #remember there is a variable number of authors per project
        form_authors = []
        for key, value in form_data.items():
            if "author" in key and value != None:
                form_authors.append(value)
        
        # Remove duplicates by converting to dictionary then converting back to list
        form_authors = list(dict.fromkeys(form_authors))

        #Add authors to author table (if they don't already exist)
        #Also add new row to project_authors containing project_id and author_id for each author
        for i in form_authors:
            cursor.execute("""SELECT *, GROUP_CONCAT(CONCAT(' ', other_names.other_name)) other_names FROM authors 
                            LEFT JOIN other_names on other_names.author_id = authors.author_id
                            WHERE author_name = %s OR other_name = %s""", [i, i])
            author_fetch = cursor.fetchall()
            if len(author_fetch) == 1:
                #if author not in database: add new author row, add new project_author row
                if author_fetch[0]["author_id"] == None:
                    cursor.execute("""INSERT INTO authors(`author_name`) VALUES (%s)""", [i])
                    cursor.execute("""SELECT LAST_INSERT_ID()""")
                    cursor.execute("""INSERT INTO project_authors VALUES (%s, %s, %s)""", [project_id, cursor.fetchone()['LAST_INSERT_ID()'], form_authors.index(i)])
                #if author in database: add new project_author row
                elif author_fetch[0]["author_id"]:
                    cursor.execute("""INSERT INTO project_authors VALUES (%s, %s, %s)""", [project_id, author_fetch[0]["author_id"], form_authors.index(i)])
            else:
                #TODO create redirect for errors
                print("Duplicate Error: more than one author found")
        
        #Add keywords, project_keywords
        form_keywords = set()
        for key, value in form_data.items():
            if "keyword" in key and value != None:
                form_keywords.add(value)
        #Re-add project_keyword entries
        for i in form_keywords:
            cursor.execute("""SELECT * FROM keywords WHERE keyword_name = %s""", [i])
            keyword_fetch = cursor.fetchall()
            #if keyword not in database: add new keyword, then add project_keyword row for this project
            if len(keyword_fetch) == 0:
                cursor.execute("""INSERT INTO keywords(`keyword_name`) VALUES (%s)""", [i])
                cursor.execute("""SELECT LAST_INSERT_ID()""")
                cursor.execute("""INSERT INTO project_keywords VALUES (%s, %s)""", [project_id, cursor.fetchone()['LAST_INSERT_ID()']])
            elif len(keyword_fetch) == 1:
                cursor.execute("""INSERT INTO project_keywords VALUES (%s, %s)""", [project_id, keyword_fetch[0]['keyword_id']])
            else:
                print("Duplicate Error: more than one keyword found")

        mysql.connection.commit()
        return redirect("/projects/" + str(project_id))

#Keyword Search
@app.route("/keywords", methods=["GET", "POST"])
@login_required
def keywords():
    cursor = mysql.connection.cursor()
    if request.method == "GET":
        cursor.execute("SELECT * FROM keywords")
        keyword_list = cursor.fetchall()
        return render_template("keyword_search.html", keyword_list=keyword_list)

    elif request.method == "POST":
        keyword_name = request.form.get("keyword_name")
        keyword_query = """SELECT keywords.keyword_id, keywords.keyword_name, COUNT(*) as project_count FROM keywords
                        INNER JOIN project_keywords ON project_keywords.keyword_id = keywords.keyword_id
                        WHERE keyword_name LIKE %s
                        GROUP BY keywords.keyword_name
                        ORDER BY project_count DESC"""
        cursor.execute(keyword_query, ["%"+keyword_name+"%"])
        keyword_results = cursor.fetchall()

        if len(keyword_results) == 1:
            return redirect(f"/keywords/{keyword_results[0]['keyword_name']}")
        
        return render_template("keyword_results.html", keyword_results=keyword_results)


#Keyword Profile
@app.route("/keywords/<keyword>")
@login_required
def keyword_profile(keyword):
    cursor = mysql.connection.cursor()
    keyword_query = """SELECT DISTINCT authors.author_id, authors.author_name, COUNT(*) AS count FROM project_authors
                    INNER JOIN projects ON projects.project_id = project_authors.project_id
                    INNER JOIN authors ON authors.author_id = project_authors.author_id
                    WHERE project_authors.project_id IN
                        (SELECT projects.project_id FROM `project_keywords`
                        INNER JOIN projects on projects.project_id = project_keywords.project_id
                        INNER JOIN keywords on keywords.keyword_id = project_keywords.keyword_id
                        WHERE keywords.keyword_name = %s)
                    GROUP BY authors.author_id
                    ORDER BY count DESC;"""
    cursor.execute(keyword_query, [keyword])
    keyword_results = cursor.fetchall()
    
    project_query = """SELECT projects.project_id, projects.project_name, GROUP_CONCAT(CONCAT(' ', authors.author_name)) author_names FROM project_authors
                    INNER JOIN projects ON projects.project_id = project_authors.project_id
                    INNER JOIN authors ON authors.author_id = project_authors.author_id
                    WHERE project_authors.project_id IN
                        (SELECT project_id FROM project_keywords
                        INNER JOIN keywords ON keywords.keyword_id = project_keywords.keyword_id
                        WHERE keyword_name = %s)
                    GROUP BY projects.project_id"""
    cursor.execute(project_query, [keyword])
    project_results = cursor.fetchall()
    return render_template("keyword_profile.html", keyword_results=keyword_results, keyword=string.capwords(keyword), project_results=project_results)

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