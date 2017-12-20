include RSpec

require_relative 'graph'
require_relative 'node'

RSpec.describe Graph, type: Class do

  let(:line) { Line.new }
  let(:graph) { Graph.new }
  let(:kevin_bacon) { Node.new("Kevin Bacon") }

  let(:lori_singer)  { Node.new("Lori Singer") }
  let(:john_lithgow)  { Node.new("John Lithgow") }
  let(:dianne_west)  { Node.new("Dianne West") }
  let(:chris_penn)  { Node.new("Chris Penn") }
  let(:sara_jessica_parker)  { Node.new("Sara Jessica Parker") }
  let(:matthew_mcconaughey)  { Node.new("Matthew McConaughey") }
  let(:leonardo_dicaprio)  { Node.new("Leonardo DiCaprio") }
  let(:gene_hackman)  { Node.new("Gene Hackman") }
  let(:clint_eastwood)  { Node.new("Clint Eastwood") }
  let(:hilary_swank)  { Node.new("Hilary Swank") }
  let(:robert_deniro)  { Node.new("Robert De Niro") }
  let(:jodie_foster)  { Node.new("Jodie Foster") }
  let(:kim_cattrall)  { Node.new("Kim Cattrall") }
  let(:fake)  { Node.new("Fake") }

  let(:film_hash) { Hash.new }

  before do
    film_hash["Footloose"] = [kevin_bacon, lori_singer, john_lithgow, dianne_west, chris_penn, sara_jessica_parker]
    film_hash["Interstellar"] = [john_lithgow, matthew_mcconaughey]
    film_hash["The Wolf Of Wall Street"] = [matthew_mcconaughey, leonardo_dicaprio]
    film_hash["The Birdcage"] = [dianne_west, gene_hackman]
    film_hash["Absolute Power"] = [gene_hackman, clint_eastwood]
    film_hash["Million Dollar Baby"] = [clint_eastwood, hilary_swank]
    film_hash["Taxi Driver"] = [robert_deniro, jodie_foster]
    film_hash["Sleepers"] = [kevin_bacon, robert_deniro]
    film_hash["Sex And The City"] = [sara_jessica_parker, kim_cattrall]

    kevin_bacon.set_films(film_hash)
    lori_singer.set_films(film_hash)
    john_lithgow.set_films(film_hash)
    dianne_west.set_films(film_hash)
    chris_penn.set_films(film_hash)
    sara_jessica_parker.set_films(film_hash)
    matthew_mcconaughey.set_films(film_hash)
    leonardo_dicaprio.set_films(film_hash)
    gene_hackman.set_films(film_hash)
    clint_eastwood.set_films(film_hash)
    hilary_swank.set_films(film_hash)
    robert_deniro.set_films(film_hash)
    jodie_foster.set_films(film_hash)
    kim_cattrall.set_films(film_hash)
    fake.set_films(film_hash)
  end


  describe "successfully finds matches" do
    it "finds Leonardo DiCaprio" do
      find_bacon_leonardo_dicaprio = ["The Wolf Of Wall Street", "Interstellar", "Footloose"]
      expect(graph.find_kevin_bacon(leonardo_dicaprio)).to eq(find_bacon_leonardo_dicaprio)
    end

    it "finds Kim Cattrall" do
      find_bacon_kim_catrall = ["Sex And The City", "Footloose"]
      expect(graph.find_kevin_bacon(kim_cattrall)).to eq(find_bacon_kim_catrall)
    end

    it "finds Hilary Swank" do
      find_bacon_hilary_swank = ["Million Dollar Baby", "Absolute Power", "The Birdcage", "Footloose"]
      expect(graph.find_kevin_bacon(hilary_swank)).to eq(find_bacon_hilary_swank)
    end
  end

  describe "successfully finds no match" do
    it "doesn't find a fake node match" do
      expected_output = "Not Connected to Kevin Bacon"
      find_bacon_fake_node = graph.find_kevin_bacon(fake)
      expect(find_bacon_fake_node).to eq(expected_output)
    end
  end
end
