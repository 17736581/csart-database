from flask import redirect, session
from functools import wraps

def login_required(f):
    """
    Decorate routes to require login.

    https://flask.palletsprojects.com/en/1.1.x/patterns/viewdecorators/
    """
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if session.get("user_id") is None:
            return redirect("/login")
        return f(*args, **kwargs)
    return decorated_function


def null_to_string(results):
    if type(results) != dict:
        for dic in results:
            for key in dic:
                if dic.get(key) == None:
                    dic[key] = ''
    else:
        for key in results:
                if results.get(key) == None:
                    results[key] = ''
    return results

def string_to_null(form_data):
    if type(form_data) != dict:
        for dic in form_data:
            for key in dic:
                if dic.get(key) == '':
                    dic[key] = None
    else:
        for key in form_data:
                if form_data.get(key) == '':
                    form_data[key] = None
    return form_data