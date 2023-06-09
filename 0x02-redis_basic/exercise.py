#!/usr/bin/env python3.8
'''
File: exercise.py
'''
import redis
import uuid
from typing import Callable, Union
import json

def count_calls(method: Callable) -> Callable:
    '''
    Decorator that counts the number of times a method is called.
    '''
    @functools.wraps(method)
    def wrapper(self, *args, **kwargs):
        key = method.__qualname__
        self._redis.incr(key)
        return method(self, *args, **kwargs)
    return wrapper


def call_history(method: Callable) -> Callable:
    '''
    Decorator to store history of inputs and outputs in Redis
    '''
    @functools.wraps(method)
    def wrapper(self, *args, **kwargs):
        inputs_key = "{}:inputs".format(method.__qualname__)
        outputs_key = "{}:outputs".format(method.__qualname__)
        
        input_str = json.dumps(args)
        self._redis.rpush(inputs_key, input_str)
        
        output = method(self, *args, **kwargs)
        output_str = str(output)
        self._redis.rpush(outputs_key, output_str)
        
        return output
    
    return wrapper

class Cache:
    '''
    Cache class using Redis
    '''
    def __init__(self):
        '''
        Initialize Redis client and flush all data
        '''
        self._redis = redis.Redis()
        self._redis.flushdb()

    @call_history
    @count_calls
    def store(self, data: Union[str, bytes, int, float]) -> str:
        '''
        Store data in Redis and return key
        '''
        key = str(uuid.uuid4())
        self._redis.set(key, data)
        return key

    def get(self, key: str, fn: Callable = None) -> Union[str, bytes,
                                                          int, float]:
        '''
        Retrieve data from Redis by key and optionally apply a conversion funct
        '''
        if not self._redis.exists(key):
            return None

        data = self._redis.get(key)

        if fn is not None:
            data = fn(data)

        return data

    def get_str(self, key: str) -> Union[str, None]:
        '''
        parametrize cache.get to str
        '''
        return self.get(key, fn=lambda d: d.decode('utf-8')
                        if d is not None else None)

    def get_int(self, key: str) -> Union[int, None]:
        '''
        parametrize cache.get to str
        '''
        return self.get(key, fn=int) if self.get(key) is not None else None
