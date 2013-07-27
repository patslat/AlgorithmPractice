require 'rspec'
require 'trie'

describe Trie do
  subject { Trie.new }

  describe "#build" do
    it "accepts a string argument" do
      subject.build("cat")
    end

    it "accepts many string arguments" do
      ["socrates", "plato", "aristotle", "heraclitus", "diogenes"].each do |str|
        subject.build(str)
      end
    end
  end

  describe "#find" do
    it "finds a built string" do
      subject.build("cat")
      subject.find("cat").should == true
    end

    it "should find multiple strings" do
      subject.build("cat")
      subject.build("hello")
      subject.find("cat").should == true
      subject.find("hello").should == true
    end

    it "should take multiple strings and find them" do
      names = ["socrates", "plato", "aristotle", "heraclitus", "diogenes"]
      names.each do |str|
        subject.build(str)
      end
      names.each.all? do |str|
        subject.find(str)
      end.should == true
    end

    it "should not find strings that are not entered" do
      names = ["socrates", "plato", "aristotle", "heraclitus", "diogenes"]
      names.each do |str|
        subject.build(str)
      end
      subject.find("nietzsche").should == false
    end

    it "shouldn't find words that haven't been entered, even if common prefix" do
      subject.build("cat")
      subject.find("caterpillar").should == false
      subject.find("cats").should == false
    end
  end

  describe "#delete" do
    it "should remove an item" do
      subject.build("socrates")
      subject.delete("socrates")
      subject.find("socrates").should == false
    end

    it "should not remove items with shared prefix" do
      subject.build("platano")
      subject.build("plato")
      subject.delete("platano")
      subject.find("platano").should == false
      subject.find("plato").should == true
    end

    it "should not remove a larger word when removing a subword" do
      subject.build("cheese")
      subject.build("cheeseboard")
      subject.delete("cheese")
      subject.find("cheeseboard")
    end
  end
end
