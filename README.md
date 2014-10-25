# Topics

## w10d3: Cat Match and Time Complexity

* [Time Complexity][time-complexity]
* [Interview Advice][interview-advice]

[time-complexity]: ./lecture-01/time-complexity.md
[interview-advice]: ./lecture-01/interview-advice.md

## w10d5: Big-Oh and Table of Time Complexities

* [Big O Notation][big-o-notation]
* [Table of Time Complexities][table-of-time-complexities]

[big-o-notation]: ./lecture-02/big-o-notation.md
[table-of-time-complexities]: ./lecture-02/table-of-time-complexities.md

## w11d1: Pointers and Static Arrays

* [Memory and Pointers][pointers]
* [Static Array][static-array]

[pointers]: ./lecture-03/pointers.md
[static-array]: ./lecture-03/static-array.md

## w11d3: Dynamic Arrays

* [Dynamic Array][dynamic-array]

[dynamic-array]: ./lecture-04/dynamic-array.md

## w11d5

* Dynamic Array continued

## w12d1: Hash Set

* [HashSet][hash-set]

[hash-set]: ./lecture-05/hash-set.md

## w12d3: Hashing + LinkedList

* [Hashing][hashing]
* HashSet => HashMap

[hashing]: ./lecture-06/hashing.md

## w12d5: LinkedList

* [LinkedList][linked-list]

[linked-list]: ./lecture-07/linked-list.md

## w13d1: LRUCache

* Ex: LRUCache

## w13d3: Heaps

* Priority Queue
* TreeHeap
* ArrayHeap
* Uses:
    * work-queue
    * max k items
    * Dijkstra's algorithm (later)

## w13d5: Heaps Continued

## w14d1: Sorting

* MergeSort
* QuickSort
* HeapSort

## w14d3: Sorting II

* Sorting performance
* RAM Caching
* CPU Architecture

## w14d5: Binary Search Tree

* BSTs; self-balancing tree
    * Balancing can't go wrong.
    * No O(n) worst case
    * In-order traversal
* Traversal algorithms.
    * Database index
    * Optimizes where using comparison, and order by.
    * What is the time complexity of pkey lookup? Seems like
      sort-merge join is O(nlog n) if it's O(log n) to look up an
      record by pkey. Same would apply for hash join??
    * Maybe duplicates of all columns are stored in the index?? Isn't
      that super wasteful?
    * Btree is more memory friendly than hashes, BTW.

## w15d1+: Graphs

* Graphs
    * Different versions of time complexity
    * Topological Sort
    * BFS shortest paths
    * Dijkstra's
    * Prim's Algorithm
    * Floyd-Warshall Algorithm

## Bonus Topics

**Algorithms**

* Bidirectional path-finding
* A\*
* Dynamic Programming
* Binary Search, Linear Search
* Closest-Pairs
* Trie
* B-Trees
* Bloom Filters
* Finding connected components
* P vs NP, NP-completeness

**Languages**

* Static Typing vs Dynamic Typing
* Interpretation vs Compilation
* Garbage Collection
* Concurrency in Ruby

**Databases**

* Scaling Databases
* ACID: 2PL vs MVCC

* Concurrency: threads and events
    * MapReduce
