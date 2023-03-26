#!/usr/bin/env python
"""Django's command-line utility for administrative tasks."""
import os
import sys

import pymongo


def main():
    """Run administrative tasks."""
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'mysite.settings')
    try:
        from django.core.management import execute_from_command_line
    except ImportError as exc:
        raise ImportError(
            "Couldn't import Django. Are you sure it's installed and "
            "available on your PYTHONPATH environment variable? Did you "
            "forget to activate a virtual environment?"
        ) from exc
    execute_from_command_line(sys.argv)


if __name__ == '__main__':
    # main()
    myclient = pymongo.MongoClient("mongodb+srv://yuqirao9903:admin@cluster0.ylscfqf.mongodb.net/"
                                   "?retryWrites=true&w=majority")
    mydb = myclient["script_list"]
    mycol = mydb["name_background_NPC"]
    myquery = {"name": "Murder on the Orient Express"}
    mydb1 = myclient["game_info"]
    mycol1 = mydb1["NPCs"]

    mydoc = {"NPCs": [{"name": "Bouc", "conv": []}]}

    x = mycol1.insert_one(mydoc)

    print(x.inserted_id)


    for x in mycol.find(myquery, {"_id": 0, "name": 1, "author": 1}):
         print(x)
