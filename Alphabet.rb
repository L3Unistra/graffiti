#!/usr/bin/env ruby
require "./Letter"

class Alphabet
  attr_accessor :alphabet
  
  def initialize(t)
    @alphabet = t;
  end
  
  def to_s
  "Alphabet: #{alphabet}"
  end

  def to_hash
    {
      alphabet: alphabet.map(&:to_hash)
    }
  end

  def self.from_json string
    data = JSON.load string
    tab = []
    data['alphabet'].each do | al |
      tabPT = []
      al['points'].each do | pt |
        tabPT.push(Point.new(pt['x'], pt['y']))
      end
      tab.push(Letter.new(al['letter'],tabPT))
    end
    self.new tab
  end
end