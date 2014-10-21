* Hash Set
    * How to hash keys
    * Hashing Passwords: Salting, Blowfish
* HashMap

Whenever we add an item that would push us past the load factor limit,
we allocate a new store with twice as many buckets, then go through
all the items in the old store and place them in their new
location. Note that some of the previous *colliding pairs* (different
numbers that were placed in the same bucket) may be broken up into
different buckets.

This keeps buckets small and fast to search through, but it also
doesn't use too much space. Because we only resize (double in size)
when load hits 90%, the load is never less than `.90 * .50 == .45`.

## Storing arbitrary objects

This worked for numbers, but what about other objects (e.g., strings)?
We used the number-item itself to compute the bucket number; we need a
new way to comute a bucket number.

To do this, we use a *hash function*. A hash function takes an object
and produces a random-looking, scrambled number from it. Essentially,
the computed hash value is stable; it is not actually random, so
`obj.hash` won't ever change (for the same object). Because the hash
value is stable, we can use it as a bucket id.
