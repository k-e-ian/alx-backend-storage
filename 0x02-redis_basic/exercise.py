#!/usr/bin/env python3.8
'''
File: exercise.py
'''


import redis
import uuid
from typing import Union


class Cache:
    '''
    store instance of Redis cli as priv var named redis, flush instance flushdb
    '''
    def __init__(self):
        self._redis = redis.Redis()
        self._redis.flushdb()

    def store(self, data: Union[str, bytes, int, float]) -> str:
        key = str(uuid.uuid4())
        self._redis.set(key, data)
        return key
