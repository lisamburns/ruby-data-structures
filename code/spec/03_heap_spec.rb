require "03_heap"

describe BinaryMinHeap do
  it "has a store that starts empty" do
    heap = BinaryMinHeap.new
    expect(heap.send(:store)).to eq([])
  end

  it "calculates child indices correctly" do
    expect(BinaryMinHeap.child_indices(6, 0)).to eq([1, 2])
    expect(BinaryMinHeap.child_indices(6, 1)).to eq([3, 4])
    expect(BinaryMinHeap.child_indices(6, 2)).to eq([5])
  end

  it "calculates parent indices correctly" do
    expect(BinaryMinHeap.parent_index(5)).to eq(2)
    expect(BinaryMinHeap.parent_index(4)).to eq(1)
    expect(BinaryMinHeap.parent_index(3)).to eq(1)
    expect(BinaryMinHeap.parent_index(2)).to eq(0)
    expect(BinaryMinHeap.parent_index(1)).to eq(0)
    expect do
      BinaryMinHeap.parent_index(0)
    end.to raise_error("root has no parent")
  end

  it "heapify_downs correctly" do
    expect(BinaryMinHeap.heapify_down([7, 4, 5], 0)).to eq([4, 7, 5])
    expect(BinaryMinHeap.heapify_down([7, 4, 5, 6, 8], 0))
      .to eq([4, 6, 5, 7, 8])
  end

  it "heapify_ups correctly" do
    expect(BinaryMinHeap.heapify_up([4, 5, 1], 2)).to eq([1, 5, 4])
    expect(BinaryMinHeap.heapify_up([3, 4, 5, 1], 3))
      .to eq([1, 3, 5, 4])
  end

  it "pushes correctly" do
    heap = BinaryMinHeap.new
    heap.push(7)
    expect(heap.send(:store)).to eq([7])

    heap.push(5)
    expect(heap.send(:store)).to eq([5, 7])

    heap.push(6)
    expect(heap.send(:store)).to eq([5, 7, 6])

    heap.push(4)
    expect(heap.send(:store)).to eq([4, 5, 6, 7])
  end

  it "extracts correctly" do
    heap = BinaryMinHeap.new
    [7, 5, 6, 4].each { |el| heap.push(el) }

    expect(heap.extract).to eq(4)
    expect(heap.send(:store)).to eq([5, 7, 6])

    expect(heap.extract).to eq(5)
    expect(heap.send(:store)).to eq([6, 7])
  end
end
