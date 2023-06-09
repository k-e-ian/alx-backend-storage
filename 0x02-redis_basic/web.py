#!/usr/bin/env/ python3.8

import redis
import uuid
from typing import Callable, Union


class Cache:
    def __init__(self):
        self._redis = redis.Redis()
        self._redis.flushdb()

    def store(self, data: Union[str, bytes, int, float]) -> str:
        key = str(uuid.uuid4())
        self._redis.set(key, data)
        return key

    def get(self, key: str, fn: Callable = None) -> Union[str, bytes, int, float]:
        if not self._redis.exists(key):
            return None

        data = self._redis.get(key)

        if fn is not None:
            data = fn(data)

        return data

    def get_str(self, key: str) -> Union[str, None]:
        return self.get(key, fn=lambda d: d.decode('utf-8') if d is not None else None)

    def get_int(self, key: str) -> Union[int, None]:
        return self.get(key, fn=int) if self.get(key) is not None else None
