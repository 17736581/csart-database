def null_to_string(results):
    for dic in results:
        for key in dic:
            if dic.get(key) == None:
                dic[key] = ''
    return results