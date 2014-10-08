# Topics

## Lec 1

* Time Complexity
* CatMatch
* Table of Time Complexities

## Lec 2-3

* Dynamic Array
* Memory, pointer arithmetic
* Amortized Time Complexity of DynArray push

## Lec 3-4

* Hash Set
    * ArrayIntSet (`O(MAX_VAL)` memory)
    * IntHashSet (only ints)
    * How to hash keys
    * Hashing Passwords: Salting, Blowfish
* HashMap

## Lec 5

* LinkedList
    * Not required for efficient `select`. `select!`.
    * Not required for dequeue (can use a ring buffer)
* Ex: LRUCache

## Lec 6

* Heaps and packed representation
    * Priority queue.
* Uses: work-queue, max k items, Dijkstra's Algorithm.

## Lec7-8

* Sorting
    * MergeSort
    * QuickSort
    * HeapSort
* RAM Caching
* CPU Architecture

## Lec 9-Lec 10

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

## Lec 11-Lec 12

* Graphs
    * Different versions of time complexity
    * Topological Sort
    * BFS shortest paths
    * Dijkstra's
    * Prim's Algorithm

## And Beyond!

* B-Trees
* Database Scalability, Transaction Processing
    * Locking, anomolies
    * MVCC, write skew
* Concurrency: threads and events
    * MapReduce

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
