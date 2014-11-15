# Hashing

We saw how to store integers in a `HashSet`. The key was finding a
bucket to put the integer in. For other types of objects, like
`String`s, `Array`s, etc, we need to be able to find a way to
"convert" the object to an integer, which is then used to find a
bucket.

**Array**

```ruby
class Array
  def hash
    h = 0
    self.each { |obj| h = h ^ obj.hash }
  end
end
```

**String**

```ruby
class String
  def hash
    h = 0
    # convert each character to a number, hashing each.
    self.each_char { |chr| h = h ^ chr.ord.hash }
  end
end
```

**Hash**

```ruby
class Hash
  def hash
    h = 0
    # turns Hash into an array of key-value pairs, then calls hash on
    # the array.
    self.to_a.hash
  end
end
```

**Custom classes**

```ruby
class Cat
  attr_reader :name, :age

  def initialize(name, age)
    @name, @age = name, age
  end

  def ==(other_cat)
    return false unless other_cat.is_a?(Cat)
    [name, age] == [other_cat.name, other_cat.age]
  end

  def hash
    [name, age].hash
  end
end
```

## `#hash` and `#==`

It's important to have the property that if `obj1 == obj2`, then
`obj1.hash == obj2.hash`. For instance:

```ruby
# two different string objects, but compare ==
str1 = "abc"
str2 = "abc"

hs = HashSet.new
hs.insert(str1)
hs.include?(str2) # expect to return true
```

Here's why it's important that `str1.hash == str2.hash`. When we
insert `str1`, we use the hash to pick the bucket to add `str1` to.
When we later call `hs.include?(str2)`, we use `str2.hash` to pick the
bucket that we'll search for `str2` in. We'll then iterate through the
contents of the bucket, for each item in the bucket, we'll check if
`el == str2`.

If `str1.hash == str2.hash`, when we call `hs.include?(str2)` we'll be
looking the same bucket we placed `str1` in. `str1` is in this bucket,
so as we iterate through the bucket, we eventually compare it to
`str2`. This is true, so we return true for `hs.include?(str2)`.

If `str1.hash != str2.hash`, then when we look for `str2`, we may look
in a different bucket from where we put `str1`. In that case, we would
mistakenly return false for `hs.include?(str2)`.

Whenever you define `#==`, always write `#hash`. Verify that my
definitions of hash functions for the basic classes will ensure that
for these classes, when two objects which are equal will hash to the
same value.

## Hash Collisions

We know that if `obj1 == obj2`, we need `obj1.hash == obj2.hash`. So
is a hash function that always returns zero a good hash function?

If `obj1.hash == obj2.hash`, but `obj1.hash != obj2.hash`, this is
called a **hash collision**. For the purpose of hash sets, collisions
are not the end of the world. We've seen that two different objects
can end up in the same bucket if `obj1.hash % @buckets.length ==
obj2.hash % @buckets.length`. This is why when we run `include?(el)`,
we look at each item in the bucket and see if it is `== el`.

Normally, when `obj1.hash != obj2.hash`, even though the two objects
may be placed in the same bucket for now, as the number of buckets
grows, eventually the objects will tend to be placed in separate
buckets. In the case that `obj1.hash == obj2.hash`, these two will
always be placed in the same bucket, no matter the number of buckets.

This is bad, because that means a bucket will tend to be a little
overfilled. In the worst case, if everything hashes to zero, our
HashSet will still work, but the data won't be properly distributed
across the buckets. Every `include?` query will hit the same bucket,
which will have all the elements in it. Therefore, every query will
take `O(n)` time.

Hash collisions don't cause the HashSet to return the wrong answer,
they just negatively affect performance.

## xor

**TODO**: explain why xor is a natural choice for combining hashes.

## Bonus

* Passwords, salting, blowfish.
