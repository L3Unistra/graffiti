#!/usr/bin/env ruby
require './Point'

class TraceConverter
  attr_accessor :tab_point

  def initialize(args)
    @tab_point = args
  end
  
  #Change la zone de travail pour avoir la plus petite zone possible contenant la lettre
  #Puis remet les points à une échelle 100x100
  def resize
    min_x, min_y, max_x, max_y = max_min

    @tab_point = tab_point.map { | point | Point.new(point.x-min_x, point.y-min_y)}

    max_x-=min_x
    max_y-=min_y

    @tab_point = tab_point.map { | point | Point.new(point.x*100/max_x, point.y*100/max_y)}
  end



  #Retourne le min et max de x et y dans tab_point 
  def max_min
    tab_x = Array.new
    tab_y = Array.new 
    tab_point.each do |point|
      tab_x.push(point.x)
      tab_y.push(point.y)
    end
    [tab_x.min, tab_y.min, tab_x.max, tab_y.max]
  end

  def to_s
    "[ #{tab_point.map(&:to_s).join} ]"
  end

  if __FILE__ == $0
    p = [Point.new(1,2), Point.new(3,11), Point.new(10,10)]
    tc = TraceConverter.new(p)
    puts tc
    tab = tc.resize
    puts tc
  end
end