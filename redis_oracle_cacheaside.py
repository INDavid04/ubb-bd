# pip install redis
# pip install oracledb --upgrade

import oracledb
import redis
import os
import json

userpwd = os.environ.get("PASSWORD")

#Oracle configuration
connection = oracledb.connect(user="C##grupa141", password="grupa141",
                              host="193.226.51.49", 
                              port=1521, 
                              service_name="free")
cursor = connection.cursor()

# Redis Configuration
redis_client = redis.Redis(host='localhost', port=6379, db=0, decode_responses=True)


# Fetch Products 
def get_products(order_id):
    cache_key = f"productlist:{order_id}"
    
    cached_productlist = redis_client.get(cache_key)
    
    if cached_productlist:
        print("Returning from cache")
        return json.loads(cached_productlist)
    
    print("Cache miss! Fetching from Oracle DB...")
    
    # Fetch from Oracle DB if not in cache
    query = "SELECT product_id FROM order_items WHERE order_id = :order_id"
    cursor.execute(query, {"order_id": order_id})
    productlist = [row[0] for row in cursor.fetchall()]
    
    # Store in Redis (Cache it for 10 minutes)
    redis_client.setex(cache_key, 600, json.dumps(productlist))
    
    return productlist

# Function to Add a Product to an Order
def add_to_order(order_id, product_id):
    query = "INSERT INTO order_items (order_id, product_id, unit_price, quantity, line_item_id) VALUES (:order_id, :product_id, 1, 1, 3)"
    cursor.execute(query, {"order_id": order_id, "product_id": product_id})
    connection.commit()
    
    # Invalidate cache
    cache_key = f"productlist:{order_id}"
    redis_client.delete(cache_key)
    print(f"Cache invalidated for {cache_key}")

# Test
order_id = 12
print(get_products(order_id))  
print(get_products(order_id)) 
add_to_order(order_id, 15)  
