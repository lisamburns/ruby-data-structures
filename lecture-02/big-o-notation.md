## Basic complexity classes

Most of the time, when you have twice as much work to do, it takes you
twice as long to do the work. Take, for instance, adding up a list of
numbers. Twice as many numbers means twice as many numbers to add; it
should take twice as long to add them all. That seems fair; this is
called a **linear** problem.

Some tasks get harder and harder. Imagine a set of 5 switches where
only one combination of settings (on/off) will activate a
circuit. There are `2**5` settings. Each time we add an additional
switch, there are twice as many settings to check. This problem
becomes harder and harder as we add additional switches. This is
called an **exponential** problem; these are some of the worst kind of
problems.

Other problems have economies of scale where we can solve much bigger
problems with just a little more work. Consider a problem where we
would like to implement a spell-checker; we need to store a dictionary
set, but we also need to balance the comprehensiveness of the
dictionary with the time it will take to lookup a word.

Let's use a tree set. If we want to limit ourselves to making 10
comparisons, we can store a dictionary of `2**10 = 1024` words. At the
cost of one additional comparison, we could double the size of the
dictionary (1024 new words). And an additional comparison after that
doubles the size again (another 2048 words). The cost of adding a new
word to the dictionary is going down as the dictionary gets bigger.

This is a very desirable kind of problem; it is called
**logarithmic**.

These are our first three *complexity classes*: logarithmic, linear,
and exponential. We'll see a few others soon.

## Run-time

Just because two algorithms belong to the same complexity class
doesn't mean they will take the same amount of time to solve the same
size of problem. For instance, here's an algorithm to find the
smallest number in an array:

```ruby
def min(nums)
  min = nums.first
  nums.each { |n| min = n if n < min }

  min
end
```

This does one comparison per element, for `n` comparisons total. The
algorithm is linear in the number of elements. Here's a second
algorithm, which finds the two smallest numbers:

```ruby
def two_min(nums)
  min1, min2 = nums[0], nums[1]

  nums.each do |n|
    if n < min1
      min1, min2 = n, min1
    elsif n < min2
      min2 = n
    end
  end

  return [min1, min2]
end
```

This does two comparisons for each element in the array, for `2n`
comparisons total. This is again linear in the number of elements, but
we expect it to be about twice as slow.
