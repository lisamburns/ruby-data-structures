# Topics

**[Code Demos](./code)**

## w10d3: Cat Match and Time Complexity

* [Time Complexity][time-complexity]
* [Interview Advice][interview-advice]

[time-complexity]: ./w10d3/time-complexity.md
[interview-advice]: ./w10d3/interview-advice.md

## w10d5: Big-Oh and Table of Time Complexities

* [Big O Notation][big-o-notation]
* [Table of Time Complexities][table-of-time-complexities]

[big-o-notation]: ./w10d5/big-o-notation.md
[table-of-time-complexities]: ./w10d5/table-of-time-complexities.md

## w11d1: Pointers and Static Arrays

* [Memory and Pointers][pointers]
* [Static Array][static-array]

[pointers]: ./w11d1/pointers.md
[static-array]: ./w11d1/static-array.md

## w11d3: Dynamic Arrays

* [Dynamic Array][dynamic-array]

[dynamic-array]: ./w11d3/dynamic-array.md

## w11d5

* Dynamic Array continued

## w12d1: Hash Set

* [HashSet][hash-set]

[hash-set]: ./w12d1/hash-set.md

## w12d3: Hashing + LinkedList

* [Hashing][hashing]
* HashSet => HashMap

[hashing]: ./w12d3/hashing.md

## w12d5: LinkedList

* [LinkedList][linked-list]

[linked-list]: ./w12d5/linked-list.md

## w13d1: LRUCache

* [LRUCache I][lru-cache-1]

[lru-cache-1]: ./w13d1/lru-cache-1.md

## w13d3: LRUCache with Linked List

* [LRUCache II][lru-cache-2]

[lru-cache-2]: ./w13d3/lru-cache-2.md

## w13d5: Heaps

* [Heap I][heap-1]

[heap-1]: ./w13d5/heap-1.md

## w14d1: Heaps Continued

* [Array Representation of Heap, Heapsort][heap-2]

[heap-2]: ./w14d1/heap-2.md

## w14d3: Sorting

* MergeSort
* QuickSort
* HeapSort

## w14d5: Sorting II

* Sorting performance
* RAM Caching
* CPU Architecture

## w15d1: Binary Search Tree

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

## w15d3: BST II

## w15d5+: Graphs

* Graphs
    * Different versions of time complexity
    * Topological Sort
    * BFS shortest paths
    * Dijkstra's
    * Prim's Algorithm
    * Floyd-Warshall Algorithm

## Bonus Topics

**Algorithms**

* Graph Searching
    * [Bidirectional search](http://en.wikipedia.org/wiki/Bidirectional_search)
    * [A\* search](http://en.wikipedia.org/wiki/A*_search_algorithm)
* Searching in Arrays
    * [Binary Search](http://en.wikipedia.org/wiki/Binary_search_algorithm)
    * [Linear Search](http://en.wikipedia.org/wiki/Linear_search)
* [Closest Pairs of Points](http://en.wikipedia.org/wiki/Closest_pair_of_points_problem)
* Trees
    * [Trie](http://en.wikipedia.org/wiki/Trie)
    * [B-Trees](http://en.wikipedia.org/wiki/B-tree)
* [External Sorting](http://en.wikipedia.org/wiki/External_sorting)
* [Bloom Filters](http://en.wikipedia.org/wiki/Bloom_filter)
* [Backtracking search](http://en.wikipedia.org/wiki/Backtracking)
* [Computational Complexity Theory](http://en.wikipedia.org/wiki/Computational_complexity_theory)
    * [NP-completeness](http://en.wikipedia.org/wiki/NP-complete)
    * [P vs NP](http://en.wikipedia.org/wiki/P_versus_NP_problem)
* [Dynamic Programming](http://en.wikipedia.org/wiki/Dynamic_programming)

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
