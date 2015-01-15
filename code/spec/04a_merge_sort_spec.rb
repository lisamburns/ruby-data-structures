require "04a_merge_sort"

describe MergeSort do
  describe "::merge" do
    it "merges two sorted arrays" do
      expect(MergeSort.merge([1, 3, 5], [2, 4, 6])).to eq([1, 2, 3, 4, 5, 6])
    end

    it "doesn't use shift or pop" do
      arr1 = [1, 3, 5]
      arr2 = [2, 4, 6]

      expect(arr1).not_to receive(:shift)
      expect(arr1).not_to receive(:pop)
      expect(arr2).not_to receive(:shift)
      expect(arr2).not_to receive(:pop)
      MergeSort.merge(arr1, arr2)
    end

    it "makes an optimal number of comparisons" do
      arr1 = [1, 3, 5]
      arr2 = [2, 4, 6]

      num_comps = 0
      MergeSort.merge(arr1, arr2) do |el1, el2|
        num_comps += 1
        el1 <=> el2
      end

      expect(num_comps).to eq(5)
    end
  end
end
