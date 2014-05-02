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
    @tab_point = self.select_n

    min_x, min_y, max_x, max_y = max_min
    #Changement de la zone de travail
    @tab_point = tab_point.map { | point | Point.new(point.x-min_x, point.y-min_y)}

    diff_x = max_x-min_x
    diff_y = max_y-min_y
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
    #Si min_x/max_x trop petit alors on ajoute juste 50 au points (gestion cas I)
    if diff_x < 10
      @tab_point = tab_point.map { | point | Point.new(point.x+50, point.y*100/max_y)}
    elsif diff_y < 10
      @tab_point = tab_point.map { | point | Point.new(point.x*100/max_x, point.y+50)}
    else
      @tab_point = tab_point.map { | point | Point.new(point.x*100/max_x, point.y*100/max_y)}
    end
  end

  #selectionne NBPOINT dans tab_point
  def select_n
    tab_return = []
    tab_dist = []

    dist = 0
    p = tab_point[0]
    for point in tab_point
      dist+=point.distPoints(p)
      tab_dist.push(dist)
      p = point
    end

    q = tab_dist.last/(NBPOINT-1)
    tab_return.push(tab_point[0])
    c=q
    for i in 0..NBPOINT-2

      j = find_elt(tab_dist,c)

      a = tab_point[j]
      b = tab_point[j+1]

      ac = c-tab_dist[j]
      ab = a.distPoints(b)

      aby = b.y-a.y
      acy = aby*(ac/ab)

      abx = b.x-a.x
      acx = abx*(ac/ab)

      cx = acx + a.x
      cy = acy + a.y
      tab_return.push(Point.new(cx.to_i, cy.to_i))
      c+=q
    end
    tab_return
  end

  def find_elt(tab, elt)
    res = -1
    old_e_t = -1
    for e_t in tab
      if res == -1 and e_t >= elt
        res = tab.index(old_e_t)
      end
      old_e_t = e_t
    end
    res
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
      p.push(Point.new(rand(500).to_i,rand(500).to_i))
    end
    #p = [Point.new(1,2), Point.new(3,11),Point.new(1,2), Point.new(3,11),Point.new(1,2), Point.new(3,11),Point.new(1,2), Point.new(3,11),Point.new(1,2), Point.new(3,11)]
    tc = TraceConverter.new(p)

    tab = tc.resize
    puts tc.tab_point
  end
end