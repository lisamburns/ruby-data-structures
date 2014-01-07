require_relative 'linked-list'

ll = LinkedList.new
ll.push(2)
ll.push(3)
ll.unshift(1)

puts "Before removing"
ll.each { |i| puts i }

link = ll[1]
link.remove
puts "After removing"
ll.each { |i| puts i }

link = ll[0]
link.insert_after(2)
link.insert_before(0)
puts "After re-adding"
ll.each { |i| puts i }
