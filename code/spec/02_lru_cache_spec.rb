require '02_lru_cache'

describe Link do
  it "allows insertion to the left" do
    link1 = Link.new(1)
    link2 = Link.new(2)

    link2.insert_left(link1)
    expect(link1.next).to eq(link2)
    expect(link1.prev).to eq(nil)
    expect(link2.next).to eq(nil)
    expect(link2.prev).to eq(link1)

    link3 = Link.new(3)
    link2.insert_left(link3)
    expect(link1.next).to eq(link3)
    expect(link1.prev).to eq(nil)
    expect(link3.next).to eq(link2)
    expect(link3.prev).to eq(link1)
    expect(link2.next).to eq(nil)
    expect(link2.prev).to eq(link3)
  end

  it "allows insertion to the right" do
    link1 = Link.new(1)
    link2 = Link.new(2)

    link1.insert_right(link2)
    expect(link1.next).to eq(link2)
    expect(link1.prev).to eq(nil)
    expect(link2.next).to eq(nil)
    expect(link2.prev).to eq(link1)

    link3 = Link.new(3)
    link1.insert_right(link3)
    expect(link1.next).to eq(link3)
    expect(link1.prev).to eq(nil)
    expect(link3.next).to eq(link2)
    expect(link3.prev).to eq(link1)
    expect(link2.next).to eq(nil)
    expect(link2.prev).to eq(link3)
  end

  it "allows removal" do
    link1 = Link.new(1)
    link2 = Link.new(2)
    link3 = Link.new(3)

    link1.insert_right(link2)
    link2.insert_right(link3)

    link2.remove

    expect(link1.next).to eq(link3)
    expect(link1.prev).to eq(nil)
    expect(link3.next).to eq(nil)
    expect(link3.prev).to eq(link1)

    expect(link2.next).to eq(nil)
    expect(link2.prev).to eq(nil)
  end
end

describe LinkedList do
  it "pushes links into the list" do
    list = LinkedList.new
    list.push_link(link1 = Link.new(1))
    list.push_link(link2 = Link.new(2))
    list.push_link(link3 = Link.new(3))

    expect(list[0]).to eq(link1)
    expect(list[1]).to eq(link2)
    expect(list[2]).to eq(link3)
  end

  it "pushes values into the list" do
    list = LinkedList.new
    link1 = list.push(1)
    link2 = list.push(2)
    link3 = list.push(3)

    expect(list[0]).to eq(link1)
    expect(list[1]).to eq(link2)
    expect(list[2]).to eq(link3)
  end

  it "raises error on out of bounds access" do
    list = LinkedList.new
    link1 = list.push(1)
    link2 = list.push(2)

    expect do
      list[2]
    end.to raise_error("index out of bounds")
  end

  it "pops links from the list" do
    list = LinkedList.new
    link1 = list.push(1)
    link2 = list.push(2)
    link3 = list.push(3)

    expect(list.pop_link).to eq(link3)

    expect(list[0]).to eq(link1)
    expect(list[1]).to eq(link2)

    expect do
      list[2]
    end.to raise_error("index out of bounds")
  end

  it "pops values from the list" do
    list = LinkedList.new
    link1 = list.push(1)
    link2 = list.push(2)
    link3 = list.push(3)

    expect(list.pop).to eq(3)
    expect(list[0]).to eq(link1)
    expect(list[1]).to eq(link2)

    expect do
      list[2]
    end.to raise_error("index out of bounds")
  end

  it "unshifts links into the list" do
    list = LinkedList.new
    list.unshift_link(link1 = Link.new(1))
    list.unshift_link(link2 = Link.new(2))
    list.unshift_link(link3 = Link.new(3))

    expect(list[0]).to eq(link3)
    expect(list[1]).to eq(link2)
    expect(list[2]).to eq(link1)
  end

  it "unshifts values into the list" do
    list = LinkedList.new
    link1 = list.unshift(1)
    link2 = list.unshift(2)
    link3 = list.unshift(3)

    expect(list[0]).to eq(link3)
    expect(list[1]).to eq(link2)
    expect(list[2]).to eq(link1)
  end

  it "shifts links out of the list" do
    list = LinkedList.new
    link1 = list.push(1)
    link2 = list.push(2)
    link3 = list.push(3)

    expect(list.shift_link).to eq(link1)

    expect(list[0]).to eq(link2)
    expect(list[1]).to eq(link3)

    expect do
      list[2]
    end.to raise_error("index out of bounds")
  end

  it "shift values out of the list" do
    list = LinkedList.new
    link1 = list.push(1)
    link2 = list.push(2)
    link3 = list.push(3)

    expect(list.shift).to eq(1)

    expect(list[0]).to eq(link2)
    expect(list[1]).to eq(link3)
  end
end
