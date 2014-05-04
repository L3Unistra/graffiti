#!/usr/bin/env ruby
require "./Point"
require "json"

class Char
  attr_accessor :char
  attr_accessor :points

  def initialize(lt, pt)
  @char = lt
  @points = pt
  end

  def to_s
  "#{char}: #{points}"
  end

  def to_hash
    {
      char: char,
      points: points.map(&:to_hash)
    }
  end

  def self.from_json string
    data = JSON.load string

    tab = []
    data['points'].each do | pt |
      tab.push(Point.new(pt['x'], pt['y']))
    end
    self.new data['char'], pt
  end

  if __FILE__ == $0
    a = Point.new(rand(200).to_i,rand(200).to_i);
    b = Point.new(rand(200).to_i,rand(200).to_i)
    pt = Letter.new('a',[a,b])
    js = pt.to_hash.to_json
    lt =  Letter.from_json(js)
  end
end