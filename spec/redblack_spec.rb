require 'rspec'
require 'redblack'

describe RBTree do
  subject { RBTree.new }

  describe "#insert" do
    it "inserts a single element and is the black root" do
      subject.insert(1)
      subject.root.key.should == 1
      subject.root.color.should == :black
    end

    it "inserts a red child onto a black node" do
      subject.insert(1)
      subject.insert(2)
      subject.root.key.should == 1
      subject.root.right.key.should == 2
      subject.root.right.color.should == :red
    end

    it "insertes red child onto inside of red parent nil uncle and adjusts" do
      [1, 7, 3].each { |n| subject.insert(n) }
      subject.root.key.should == 3
      subject.root.color.should == :black
      subject.root.left.key.should == 1
      subject.root.right.key.should == 7
      subject.root.left.color.should == :red
      subject.root.right.color.should == :red
    end

   it "insertes red child onto outside of red parent nil uncle and adjusts" do
      subject.insert(1)
      subject.insert(7)
      subject.insert(8)
      subject.root.key.should == 7
      subject.root.color.should == :black
      subject.root.left.key.should == 1
      subject.root.right.key.should == 8
      subject.root.left.color.should == :red
      subject.root.right.color.should == :red
    end

    it "insertes red child to red parent on opposite side of red uncle" do
      subject.insert(3)
      subject.insert(1)
      subject.insert(7)
      subject.root.key.should == 3
      subject.root.color.should == :black
      subject.root.left.key.should == 1
      subject.root.right.key.should == 7

      subject.insert(8)
      subject.root.key.should == 3
      subject.root.right.color.should == :black
      subject.root.left.color.should == :black
      subject.root.right.right.color.should == :red
      subject.root.right.right.key.should == 8
    end

    it "insertes red child to red parent on same side of red uncle" do
      subject.insert(3)
      subject.insert(1)
      subject.insert(7)
      subject.insert(4)
      subject.root.key.should == 3
      subject.root.right.color.should == :black
      subject.root.right.key.should == 7
      subject.root.right.left.color.should == :red
      subject.root.right.left.key.should == 4
      subject.root.left.color.should == :black
      subject.root.left.key.should == 1
    end

    it "insertes red child to red parent with black uncle and adjusts" do
      subject.insert(3)
      subject.insert(1)
      subject.insert(7)
      subject.insert(8)
      subject.insert(9)

      subject.root.key.should == 3
      subject.root.left.color.should == :black
      subject.root.left.key.should == 1
      subject.root.right.key.should == 8
      subject.root.right.color.should == :black
      subject.root.right.left.key.should == 7
      subject.root.right.left.color.should == :red
      subject.root.right.right.key.should == 9
      subject.root.right.right.color.should == :red
    end

    it "insertes red child to red parent with red uncle on outside of uncle" do
      subject.insert(3)
      subject.insert(1)
      subject.insert(7)
      subject.insert(8)
      subject.insert(9)
      subject.insert(10)

      subject.root.key.should == 3
      subject.root.right.color.should == :red
      subject.root.right.key.should == 8
      subject.root.left.color.should == :black
      subject.root.left.key.should == 1
      subject.root.right.left.key.should == 7
      subject.root.right.right.key.should == 9
      subject.root.right.right.right.key.should == 10
      subject.root.right.right.right.color.should == :red
    end

    it "insertes a red child at the bottom of a tree and rotates about root" do
      subject.insert(3)
      subject.insert(1)
      subject.insert(7)
      subject.insert(8)
      subject.insert(9)
      subject.insert(10)
      subject.insert(11)
      subject.insert(12)

      #check left sub tree
      subject.root.key.should == 8
      subject.root.color.should == :black
      subject.root.left.key.should == 3
      subject.root.left.color.should == :red
      subject.root.left.left.key.should == 1
      subject.root.left.right.key.should == 7
      subject.root.left.left.color.should == :black
      subject.root.left.right.color.should == :black

      #check right sub tree
      subject.root.right.key.should == 10
      subject.root.right.color.should == :red
      subject.root.right.left.key.should == 9
      subject.root.right.left.color.should == :black
      subject.root.right.right.key.should == 11
      subject.root.right.right.color.should == :black
      subject.root.right.right.right.key.should == 12
      subject.root.right.right.right.color.should == :red
    end

    it "spot check for left side of the tree adding" do
      subject.insert(12)
      subject.insert(11)
      subject.insert(10)
      subject.insert(9)
      subject.insert(8)
      subject.insert(7)
      subject.insert(3)
      subject.insert(1)

      #this is mostly a sanity check
      subject.root.left.left.left.key.should == 1
      subject.root.key.should == 9
      subject.root.right.right.key.should == 12
    end
  end
end
