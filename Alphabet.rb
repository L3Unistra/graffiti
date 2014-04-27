#!/usr/bin/env ruby
require "./Letter"

class Alphabet
  attr_accessor :letters
  
  def initialize(t)
    @letters = t;
  end
  
  def to_s
  "Alphabet: #{letters}"
  end

  def to_hash
    {
      letters: letters.map(&:to_hash)
    }
  end

  def self.from_json string
    data = JSON.load string
    self.new data['letters']
  end
end