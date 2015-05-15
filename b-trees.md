* Disks involve seeks; disk blocks are the minimum amount read.
* B-Search in a sorted file involves many disk seeks.
* Can reduce by adding a sparse index; for instance the first record
  of each disk block in the file. You can keep adding layers of index
  until it fits in a single block. These also play nice with cache.
* But these indexes didn't play nice with insertions/deletion.
* B-Tree:
    * Nodes have at most m children.
    * Every node (except maybe root) has at least m/2 children.
    * Internal nodes have k-1 keys if they have k children.
    * All leaves occur at the same level.
* Search is trivial.
* Insertion:
    * Travel down to where element belongs. Either there is room here
      to add a value, or not.
    * If there is no room, split into two with median. Put smaller
      stuff in a new left node, and bigger stuff on a new
      right. Insert the median into the parent.
    * This may cause recursive merging.
    * If this goes all the way back to the root, fine. Then the new
      root has a single value, which is okay.
    * Note that this procedure ensures that all leaves are at the same
      depth. That is to say, the tree must be balanced. (???)
* Deletion:
    * If the value is in a leaf node, delete it. If underflow occurs:
        * If there's stuff to the right and it has > min # of nodes,
          rotate left.
        * If there's stuff to the left and it has > min # of nodes,
          rotate right.
        * Otherwise, merge with sibling (and pull partition value
          down). Eliminates need for the partition value in parent, so
          rebalancing proceeds upward.
    * If the value is in an internal node:
        * Choose a new separator (largest of the left or smallest of
          the right).
        * This removes an element in a leaf node. You may need to
          rebalance with the above procedure.
* B+ tree: all keys/values in leaves.
    * Higher branching factor acheivable.
    * Leaves typically linked in a list, for easy in-order
      iteration. But I don't see why in-order traversal of a tree is
      so hard...
