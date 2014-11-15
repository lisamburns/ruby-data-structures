* Take `fibonacci` function. Repeats a lot of work.
* We can **memoize** it to improve its performance
* What if there is limited space?
* We want to use a cache with limited size.
* Optimal caching:
    * Always have the stuff in the cache that is most likely to be used
      next.
    * However, it's difficult to say what that is.
    * Therefore we use a heuristic: **least recently used** eviction.
* Write an `LRUCache` that takes `O(n)` time to find the item to evict.
* This is bad, because it means that, if more cache entries has
  declining marginal value, then there's some threshold whereby it
  doesn't make sense to cache more stuff.
* Therefore, we need `O(1)` cache eviction. That's covered in the next
  lecture.
