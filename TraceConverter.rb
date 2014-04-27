#!/usr/bin/env ruby
require './Point'

NBPOINT = 20

class TraceConverter
  attr_accessor :tab_point

  def initialize(args)
    @tab_point = args
  end

  #Modifie l'attribut tab_point
  #Change la zone de travail pour avoir la plus petite zone possible contenant la lettre
  #Puis remet les points à une échelle 100*100
  def resize
    #Selection des NBPOINT à conserver
    gap = tab_point.size/NBPOINT
    j = 0
    tab_return = []
    for i in 0..tab_point.size-1
      if i % gap == 0 and j != NBPOINT
        tab_return.push(tab_point[i])
        j+=1
      end
    end
    @tab_point = tab_return

    min_x, min_y, max_x, max_y = max_min

    #Changement de la zone de travail
    @tab_point = tab_point.map { | point | Point.new(point.x-min_x, point.y-min_y)}

    max_x-=min_x
    max_y-=min_y

    #si min = max
    if max_y == 0
      max_y = 1
    end
    if max_x == 0
      max_x = 1
    end

    #Echelle 100*100
    @tab_point = tab_point.map { | point | Point.new(point.x*100/max_x, point.y*100/max_y)}
  end



  #Retourne le min et max de x et y dans tab_point 
  def max_min
    tab_x = Array.new
    tab_y = Array.new 
    @tab_point.each do |point|
      tab_x.push(point.x)
      tab_y.push(point.y)
    end

    [tab_x.min, tab_y.min, tab_x.max, tab_y.max]
  end

  def to_s
    "[ #{tab_point.map(&:to_s).join} ]"
  end

  #Test de la classe
  #Utilisation: ./TraceConverter.rb tailletableau
  if __FILE__ == $0
    p = []
    for i in 0..ARGV[0].to_i-1
      p.push(Point.new(rand(200).to_i,rand(200).to_i))
    end
    #p = [Point.new(1,2), Point.new(3,11),Point.new(1,2), Point.new(3,11),Point.new(1,2), Point.new(3,11),Point.new(1,2), Point.new(3,11),Point.new(1,2), Point.new(3,11)]
    tc = TraceConverter.new(p)

    tab = tc.resize
    
  end
end