import redis
r = redis.Redis(host='redis-server', port=6379)
message = r.get('message')
print("Message from Redis:", message.decode())
