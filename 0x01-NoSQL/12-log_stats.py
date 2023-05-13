#!/usr/bin/env python3.8
'''
File: 12-log_stats.py
'''

def main():
    '''
    script that provides some stats about Nginx logs stored in MongoDB
    '''
    client = MongoClient()
    collection = client.logs.nginx
    logs_count = collection.count_documents({})
    print(f"{logs_count} logs")

    methods = ["GET", "POST", "PUT", "PATCH", "DELETE"]
    for method in methods:
        method_count = collection.count_documents({"method": method})
        print("    method {}: {}".format(method, method_count)

    status_check_count = collection.count_documents(
        {"method": "GET", "path": "/status"}
    )
    print("{} status check".format(status_check_count)


if __name__ == "__main__":
    main()
