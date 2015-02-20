# Hash set

## What is a Set?

* `Set#insert(el)`
* `Set#include?(el)`
* `Set#delete(el)`

## Two Sum Introduction

```ruby
def two_sum(numbers)
  s = Set.new
  numbers.each { |el| s.insert(el) }
  numbers.any? { |el| s.include?(-1 * el) }
end
```

We can write an `ArraySet` like so:

```ruby
class ArraySet
  def initialize
    @store = []
  end

  def include?(el)
    @store.any? { |el2| el2 == el }
  end

  # insert typically returns whether the item was newly added or
  # already added.
  def insert(el)
    return false if include?(el)
    @store << el
    true
  end

  # delete typically returns whether the item was there.
  def delete(el)
    @store.each_with_index do |el2, idx|
      # emphasizing how `Array#delete` works.
      if el2 == el
        @store.delete_at(idx)
        return true
      end
    end
    false
  end
end
```

Each operation of `ArraySet` is `O(n)`; therefore if we use it in our
`two_sum` solution, we have an `O(n**2)` algorithm.

A `HashSet` will have `O(1)` operations.

## `MaxIntSet`

Let's talk about a special case where we can avoid jumping. Imagine we
want to store a subset of the numbers `(0...4)`. Not all of them will
be in the set, but no numbers outside the range will appear. Then we
can represent the set `{1, 3}` like so:

```
# indices [    0,    1,     2,    3,     4]
   set =  [false, true, false, true, false]
```

At each index, we store `false` if the object isn't in the set;
otherwise we store `true`.

We can use this to write a new kind of set:

```ruby
class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
  end

  def include?(num)
    @store[num]
  end

  def insert(num)
    @store[num] = true
  end

  def delete(num)
    @store[num] = false
  end
end
```

All operations are `O(1)` here. However, we've added two very serious
restrictions:

* We can only store numbers.
* The range of numbers is limited.

Another problem: the memory usage does not depend on the number of
items stored in the set, but instead on the range of the values. So you
would use lots of memory if the range was huge, even if the number of
elements were small.

## `IntSet`

Let's remove the range limitation:

```ruby
class IntSet
  def initialize
    @buckets = Array.new(8) { [] }
  end

  def include?(num)
    bucket = @buckets[num % @buckets.length]
    bucket.include?(num)
  end

  def insert(num)
    return false if include?(num)
    bucket = @buckets[num % @buckets.length]
    bucket << num
    true
  end

  def delete(num)
    return false unless include?(num)
    bucket = @buckets[num % @buckets.length]
    bucket.delete(num)
    true
  end
end
```

Here, we are creating 8 **buckets**. Buckets store numbers in the set.
A number is assigned to the bucket by taking the value modulo 8. This
relatively evenly distributes the numbers across the buckets.

The operations here are `O(n)` again; even though we're breaking up
the elements of the set across many buckets, each bucket still
contains on average `n/8` elements. As `n` increases, the size of the
buckets increases linearly. And the `bucket.include?(num)` and
`bucket.delete(num)` operations will thus take time linear to the
number of overall elements.

The news isn't all bad: we did eliminate our space problem: memory
usage is back to `O(n)`.

## Resizing the number of buckets

Our problem is that the size of the buckets increases as the number of
overall elements increases. If instead the size of the buckets
remained constant even as the number of elements increased, then the
set operations would not slow down.

How is that possible? The solution is to increase the number of
buckets as we increase the number of elements. We want:

    number of elements / number of buckets < 1.0

at all times.

```ruby
class ResizingIntSet
  def initialize
    @buckets = Array.new(8) { [] }
    # New ivar!
    @num_elements = 0
  end

  def include?(num)
    bucket = @buckets[num % @buckets.length]
    bucket.include?(num)
  end

  def insert(num)
    return false if include?(num)
    bucket = @buckets[num % @buckets.length]
    bucket << num

    # maybe resize!
    @num_elements += 1
    resize! if @num_elements == @buckets.length
    true
  end

  def delete(num)
    return false unless include?(num)
    bucket = @buckets[num % @buckets.length]
    bucket.delete(num)
    @num_elements -= 1
    true
  end

  protected
  def resize!
    old_buckets = @buckets
    @buckets = Array.new(@buckets.length * 2) { [] }
    @num_elements = 0
    old_buckets.each do |bucket|
      bucket.each { |el| insert(el) }
    end
  end
end
```

Here we keep track of the `@num_elements` at all times. When this
grows so that `@num_elements == @buckets.length`, we run the `resize!`
method. This creates a new buckets array of twice as many buckets, and
then re-inserts everything into this new buckets array.

Re-adding items to the new buckets is called **rehashing**. Note that
the number `9` lives in bucket 1 when there are 8 buckets, but now
lives in bucket 9 when there are 16 buckets after a resize.

## Time Complexity Analysis

`resize!` is `O(n)` time, because this is how many items it needs to
re-insert. Note that it **is not** `O(n**2)` time even though there
are doubly-nested loops. This is a classic mistake students often make.

### `include?`

The `include?` method is `O(1)` **average time**. No matter how many
elements are added to the `ResizingIntSet`, the average bucket
contains less than one element. Some buckets may be large if there are
a lot of **collisions**; the worst case time complexity is `O(n)`. But
for some bucket to be larger, another needs to be smaller, so if you
call `insert?` for `k` different values, over time you expect the
running time to be `O(k)` (i.e., an average of `O(1)` per value),
regardless of the number of elements in the set.

Also: the worst-case becomes less and less likely as you add more and
more elements to the set. If you have 10 elements, it's possible that
8 end up in the same bucket. If you have 10k elements, it's
extraordinarily unlikely that 8k elements are mapped to the same
bucket.

### `insert`

The `insert` method uses `include?`, which we just said was `O(1)`
expected time. It also occasionally calls `resize!`.

It is true that `resize!` runs in `O(n)` time. But we call it less and
less frequently, because we keep doubling the number of buckets. The
same amortization argument we used for the dynamic array applies.

### `delete`

The analysis for `include?` applies again.
