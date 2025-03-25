import azure.functions as func
import logging
import time
import redis
import os

app = func.FunctionApp(http_auth_level=func.AuthLevel.FUNCTION)
redis_host = os.environ.get("redis_host")
redis_port = os.environ.get("redis_port")
redis_key  = os.environ.get("redis_key")



redis_client = redis.Redis(
        host=redis_host, 
        port=redis_port,
        password=redis_key,
        ssl=True,
        ssl_cert_reqs='required')


@app.route(route="http_test", methods=["GET"])
def http_test(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')
    name = req.params.get('name')
    if not name:
        try:
            req_body = req.get_json()
        except ValueError:
            pass
        else:
            name = req_body.get('name')

    if name:
        return func.HttpResponse(f"Hello, {name}. This HTTP triggered function executed successfully.")
    else:
        return func.HttpResponse(
             "This HTTP triggered function executed successfully. Pass a name in the query string or in the request body for a personalized response.",
             status_code=200
        )


# Simualte get    
def get_data_from_db(key):
    logging.info(f"Fetching data from DB for key: {key}")
    time.sleep(1)  # database get latency
    data = f"Data from DB for {key}"
    return data

# Simulate update 
def update_data_in_db(key, new_data):
    logging.info(f"Updating DB for key: {key}, new data: {new_data}")
    time.sleep(1) # database update latency.
    return True


#POST, PUT, PATCH creates, updates or partially modifies a resource
@app.route(route="db_update", methods = ["POST", "PUT", "PATCH"])
def db_update(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a redis set request.')

    req_body = req.get_json()
    key = req_body.get('key')
    value = req_body.get('value')
    
    if key:
        update_data_in_db(key, value)
        redis_client.set(key, value)
        return func.HttpResponse(f"Key updated to value, {value}.")
    else:
        return func.HttpResponse(
             "This HTTP triggered function executed successfully. Pass a key in the request.",
             status_code=200
        )
    

@app.route(route="db_get", methods=["GET"])
def db_get(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a redis get request.')

    key = req.params.get('key')
    if not key:
        try:
            req_body = req.get_json()
        except ValueError:
            pass
        else:
            key = req_body.get('key')

    if key:
        cached_data = redis_client.get(key)
        if cached_data:
            logging.info(f"Cache hit for key: {key}")
            return func.HttpResponse(cached_data.decode('utf-8'))
        else:
            logging.info(f"Cache miss for key: {key}")
            data_from_db = get_data_from_db(key)
            redis_client.set(key, data_from_db)
            return func.HttpResponse(data_from_db)
    else:
        return func.HttpResponse(
             "This HTTP triggered function executed successfully. Pass a key in the query string or in the request body.",
             status_code=200
        )



'''
Test wiht redis_cli
in docker: docker exec -it your-redis-container-name redis-cli

APPEND mykey "Hello"
APPEND mykey " World"
GET mykey
GETRANGE mykey 0 4

LPUSH reservations:guests guest:1
LPUSH reservations:guests guest:2

RPOP reservations:guests 



'''


