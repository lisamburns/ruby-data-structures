require "01_hash_set"

describe ArraySet do
  it "starts out empty" do
    set = ArraySet.new
    expect(set.count).to eq(0)
  end

  it "allows insertion/include?" do
    set = ArraySet.new
    20.times { |i| set.insert(i) }
    expect(set.count).to eq(20)
    20.times { |i| expect(set.include?(i)).to eq(true) }
  end

  it "allows removal" do
    set = ArraySet.new
    20.times { |i| set.insert(i) }
    (0...20).to_a.shuffle.each_with_index do |el, num_removed|
      expect(set.include?(el)).to eq(true)
      set.remove(el)
      expect(set.include?(el)).to eq(false)
      expect(set.count).to eq(20 - (num_removed + 1))
    end
  end
end

describe MaxIntSet do
  it "starts out empty" do
    set = MaxIntSet.new(8)
    expect(set.count).to eq(0)
  end

  it "allows insertion/include?" do
    set = MaxIntSet.new(8)
    5.times { |i| set.insert(i) }
    expect(set.count).to eq(5)
    5.times { |i| expect(set.include?(i)).to eq(true) }
  end

  it "allows removal" do
    set = MaxIntSet.new(8)
    5.times { |i| set.insert(i) }
    (0...5).to_a.shuffle.each_with_index do |el, num_removed|
      expect(set.include?(el)).to eq(true)
      set.remove(el)
      expect(set.include?(el)).to eq(false)
      expect(set.count).to eq(5 - (num_removed + 1))
    end
  end

  describe "internals" do
    it "provides O(1) include?" do
      set = MaxIntSet.new(8)
      allow(set.send(:store)).to receive(:[]).and_call_original
      set.include?(5)
      expect(set.send(:store)).to have_received(:[]).exactly(1).times
    end

    it "provides O(1) insert" do
      set = MaxIntSet.new(8)

      allow(set.send(:store)).to receive(:[]=).and_call_original
      5.times do |i|
        set.insert(i)
        expect(set.send(:store)).to have_received(:[]=).exactly(i + 1).times
      end
    end

    it "provides O(1) remove" do
      set = MaxIntSet.new(8)

      5.times { |i| set.insert(i) }

      allow(set.send(:store)).to receive(:[]=).and_call_original
      5.times do |i|
        set.remove(i)
        expect(set.send(:store)).to have_received(:[]=).exactly(i + 1).times
      end
    end
  end
end

describe IntHashSet do
  it "starts out empty" do
    set = IntHashSet.new
    expect(set.count).to eq(0)
  end

  it "allows insertion/include?" do
    set = IntHashSet.new
    20.times { |i| set.insert(i) }
    expect(set.count).to eq(20)
    20.times { |i| expect(set.include?(i)).to eq(true) }
  end

  it "allows removal" do
    set = IntHashSet.new
    20.times { |i| set.insert(i) }
    (0...5).to_a.shuffle.each_with_index do |el, num_removed|
      expect(set.include?(el)).to eq(true)
      set.remove(el)
      expect(set.include?(el)).to eq(false)
      expect(set.count).to eq(20 - (num_removed + 1))
    end
  end

  describe "internals" do
    it "starts with 8 empty buckets" do
      set = IntHashSet.new
      expect(set.send(:buckets)).to eq([[]] * 8)
    end

    it "places each item in a bucket" do
      set = IntHashSet.new
      buckets = set.send(:buckets)

      8.times do |i|
        val = (8 * i) + i
        set.insert(val)

        expect(buckets[i]).to eq([val])
      end
    end

    it "performs O(1) include?" do
      set = IntHashSet.new

      8.times { |i| val = (8 * i) + i; set.insert(val) }

      buckets = set.send(:buckets)
      allow(buckets).to receive(:[]).and_call_original
      8.times do |i|
        val = (8 * i) + i
        set.include?(i)
        expect(buckets).to have_received(:[]).exactly(i + 1).times
      end
    end

    it "performs O(1) insert" do
      set = IntHashSet.new

      buckets = set.send(:buckets)
      allow(buckets).to receive(:[]).and_call_original
      8.times do |i|
        val = (8 * i) + i
        set.insert(i)
        # I'm going to expect you to call this twice in your insert
        expect(buckets).to have_received(:[]).exactly(2 * (i + 1)).times
      end
    end

    it "doubles in size when fully loaded" do
      set = IntHashSet.new

      buckets = set.send(:buckets)
      8.times do |i|
        val = (8 * i) + i
        set.insert(val)

        expect(set.send(:buckets)).to eq(buckets)
      end

      9.upto(16) do |i|
        val = (8 * i) + i
        set.insert(val)
      end
      expect(set.send(:buckets).length).to eq(16)
    end
  end
end
