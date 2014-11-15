# Linked list

* Differs from a dynamic array because a linked list is supposed to
  have gaps between items.
* Each item is stored in a *link* (or *node*) which contains an item
  and a reference to the next link in the sequence.
* A linked list only keeps track of the first link in the chain; the
  rest of the links are accessible from the first.
* In a *doubly linked list*, each link keeps track of both previous
  and next links.
    * Likewise, we keep track of both first and last links in the
      chain.
    * A doubly linked list makes it possible to go backward and forward
      through the list.
* **Indexing is typically slow**; the worst items to access are at the
  end. To get to the end, you need to follow link by link.
    * Even access items at the front is slower than an array access;
      nothing beats computing a memory address and loading an item
      directly.
* Once you are in the right position, **insertion can be fast**; you
  *just splice* in a new link.
    * To insert `c` between `a -> b`, you create a new link storing
      the item `c` and pointing to the `b` link as next. Then you
      modify the `a` link to point to the `c` link. So you end up with
      `a -> c -> b`.
    * Removal works similarly; **removal can also be fast**.
* But, when you take into account the time it takes to index to the
  right location, index and removal are no faster (in fact, slower)
  than a dynamic array.

## What are LL Good For?

Linked lists are slower to index into than an array, and also slower
to randomly insert into, too (because you need to index before you
insert). When are they ever useful?

* Dynamic arrays are much more common.
* End-to-end scans, removing/inserting elements along the way can be
  done competitively. But you can do this using a second array, though
  this requires `O(n)` extra memory. (the `select!` example)
* LinkedLists are sometimes used for queues. However, a ring buffer can
  do this, too. On the other hand, this has variable latency.
* Best use case is when you jump right into the middle, **LRUCache**.
