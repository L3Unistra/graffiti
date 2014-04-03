#!/usr/bin/env ruby
class Point
  attr_accessor :x
  attr_accessor :y

  def initialize(x_p=0,y_p=0)
    @x = x_p
    @y = y_p
  end

  def to_s
    "[#{x},#{y}]"
  end
end