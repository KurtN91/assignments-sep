include RSpec

require_relative 'min_binary_heap'

RSpec.describe MinBinaryHeap, type: Class do
  let (:root) { Node.new("The Matrix", 87) }

  let (:tree) { MinBinaryHeap.new(root) }
  let (:pacific_rim) { Node.new("Pacific Rim", 72) }
  let (:braveheart) { Node.new("Braveheart", 78) }
  let (:jedi) { Node.new("Star Wars: Return of the Jedi", 80) }
  let (:donnie) { Node.new("Donnie Darko", 85) }
  let (:inception) { Node.new("Inception", 86) }
  let (:district) { Node.new("District 9", 90) }
  let (:shawshank) { Node.new("The Shawshank Redemption", 91) }
  let (:martian) { Node.new("The Martian", 92) }
  let (:hope) { Node.new("Star Wars: A New Hope", 93) }
  let (:empire) { Node.new("Star Wars: The Empire Strikes Back", 94) }
  let (:mad_max_2) { Node.new("Mad Max 2: The Road Warrior", 98) }

  describe "#initialize" do
    it "sets @root to passed node" do
      tree = MinBinaryHeap.new(root)
      expect(tree.items[0]).to eq root
    end
  end

  describe "#insert" do
    it "replaces the root if lower rating" do
      tree.insert(braveheart)
      expect(tree.items[0]).to eq braveheart
    end

    it "adds everything properly" do
      tree.insert(pacific_rim)
      tree.insert(mad_max_2)
      tree.insert(braveheart)
      tree.insert(empire)
      tree.insert(jedi)
      tree.insert(hope)
      tree.insert(donnie)
      tree.insert(inception)
      tree.insert(district)
      tree.insert(shawshank)
      tree.insert(martian)

      expect(tree.items[0]).to eq pacific_rim
      expect(tree.items[tree.items.size - 1]).to eq mad_max_2
    end
  end

  describe "#find" do
    it "returns correct node" do
      tree.insert(pacific_rim)
      tree.insert(mad_max_2)
      tree.insert(braveheart)

      expect(tree.find("Braveheart")).to eq braveheart
    end

    it "returns nil if not added" do
      tree.insert(district)
      tree.insert(shawshank)
      tree.insert(martian)

      expect(tree.find("Braveheart")).to be_nil
    end
  end

  describe "#print" do
     specify {
       expected_output = "Pacific Rim: 72\nBraveheart: 78\nStar Wars: Return of the Jedi: 80\nThe Matrix: 87\nDistrict 9: 90\nStar Wars: The Empire Strikes Back: 94\nInception: 86\nStar Wars: A New Hope: 93\nThe Shawshank Redemption: 91\nThe Martian: 92\nMad Max 2: The Road Warrior: 98\n"
       tree.insert(hope)
       tree.insert(empire)
       tree.insert(jedi)
       tree.insert(martian)
       tree.insert(pacific_rim)
       tree.insert(inception)
       tree.insert(braveheart)
       tree.insert(shawshank)
       tree.insert(district)
       tree.insert(mad_max_2)
       expect { tree.print }.to output(expected_output).to_stdout
     }
  end

  describe "#parent" do
    it "returns 6 for 13 or 14" do
      expect(tree.parent(13)).to eq 6
      expect(tree.parent(14)).to eq 6
    end

    it "returns 0 for 1 or 2" do
      expect(tree.parent(1)).to eq 0
      expect(tree.parent(2)).to eq 0
    end
  end

  describe "#find_index" do
    it "returns correct index" do
      tree.insert(martian)
      expect(tree.find_index("The Martian")).to eq 1
    end
  end

  describe "#left and #right" do
    it "returns left and right indices" do
      tree.insert(hope)
      tree.insert(empire)
      expect(tree.left_or_right_index(0, "left")).to eq 1
      expect(tree.left_or_right_index(0, "right")).to eq 2

      tree.insert(jedi)
      tree.insert(donnie)
      expect(tree.left_or_right_index(1, "left")).to eq 3
      expect(tree.left_or_right_index(1, "right")).to eq 4
    end

    it "returns nil if no left or right" do
      expect(tree.left_or_right_index(0, "left")).to eq nil
      expect(tree.left_or_right_index(0, "right")).to eq nil
    end
  end

  describe "#delete" do
    it "deletes correct node" do
      tree.insert(braveheart)
      expect(tree.items[0]).to eq braveheart
      tree.delete("Braveheart")
      expect(tree.items[0]).to eq root

      tree.insert(braveheart)
      tree.delete("The Matrix")
      expect(tree.items[0]).to eq braveheart
    end

    it "reorganizes correctly" do
      tree.insert(inception)
      tree.insert(donnie)
      tree.insert(braveheart)
      tree.insert(empire)
      tree.insert(mad_max_2)

      expect(tree.items[1]).to eq donnie

      tree.delete("Donnie Darko")

      expect(tree.find("Donnie Darko")).to be_nil
      expect(tree.items[1]).to eq root
      expect(tree.items[tree.left_or_right_index(1, "left")]).to eq mad_max_2
      expect(tree.items[tree.left_or_right_index(1, "right")]).to eq empire

      tree.delete("Inception")

      expect(tree.items[2]).to eq empire
    end
  end
end
