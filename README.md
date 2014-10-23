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

## w12d5: LinkedList/LRUCache

* [LinkedList][linked-list]
* Ex: LRUCache

[linked-list]: ./lecture-07/linked-list.md

## Lecture 7

* Heaps and packed representation
    * Priority queue.
* Uses: work-queue, max k items, Dijkstra's Algorithm.

## Lecture 8-9

* Sorting
    * MergeSort
    * QuickSort
    * HeapSort
* RAM Caching
* CPU Architecture

## Lecture 9-10

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

## Lecture 11-12

* Graphs
    * Different versions of time complexity
    * Topological Sort
    * BFS shortest paths
    * Dijkstra's
    * Prim's Algorithm

## And Beyond!

* Old:
    * Binary Search
    * Linear Search
* Trie
* B-Trees
* Database Scalability, Transaction Processing
    * Locking, anomolies
    * MVCC, write skew
* Concurrency: threads and events
    * MapReduce
* TODO
    * static typing vs dynamic typing
    * interpretation
    * garbage collection
    * concurrency in Ruby

## Coursera Algorithms I

* Strassen's matrix mult.
* Closest pairs. <<<
* Counting inversions.
* Bloom filters
* Min cut?
* Strongly connected components.

## Coursera Algorithms II

* Scheduling
* Clustering
* Union-find, Path Compression.
* Bellman Ford
* Floyd-Warshall, Johnson's Algorithm (all pairs shortest path!)
* NP Complete, Knapsack, Vertex Cover, TSP
* Approximation Algorithms.
* Dynamic Programming.
