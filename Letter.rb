#!/usr/bin/env ruby

class Letter
  attr_accessor :letter
  attr_accessor :points

  def initialize(lt,pt)
    @letter = lt
    @points = pt
  end

  def to_s
    "#{lt}: #{pt}"
  end
end