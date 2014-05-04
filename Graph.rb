#!/usr/bin/env ruby
require "./Point"
require './Alphabet.rb'
require './Maillon.rb'
require './TraceConverter'

class Graph

	attr_accessor :g #tete du graphe de résolution

	def initialize(filename)
		@g = Graph.buildGraph(filename)
	end

	def self.buildGraph(filename)
		al = Graph.importJSON(filename)
		tab = al.alphabet
		#Construire le graphe depuis les chars

		tete = Maillon.new(Point.new(-1,-1))
		for i in 0..tab.size-1 #On parcours chaque char de l'alphabet
			tmp = tab[i].points#tableau des points d'un char
			current = tete #maillon actuel
			for j in 0..tmp.size-1
				p=Point.new(tmp[j].x, tmp[j].y)
				m = Maillon.new(p) #on créer le maillon associé au point courant
				current.arcs.each do |a|
					if a.m_arr.p.equals(p)
						m = a.m_arr
						break
					end
				end
				if j == tmp.size-1 #dernier point de char
					m.char = tab[i].char #on assigne le char au maillon
					current.addArc(Arc.new(current, m,0))
					current = tete #on remet le maillon courant à la tete
				else
					current.addArc(Arc.new(current, m,0))
					current = m
				end
			end
		end
		#renvoi le maillon de tete du graphe construit
		tete
	end

	def solve(tab)
		trace = TraceConverter.new(tab)
		tab_coup = trace.resize
		@g.pondere(tab_coup, 0)
		@g.findpuits(g)

		min = @g.puits[0].poids_to_rac
		res = @g.puits[0].char
		@g.puits.each do |p|
			if min > p.poids_to_rac
				min = p.poids_to_rac
				res = p.char
			end
		end
		res
	end

	def pondere(tab)
		@g.pondere(tab)
	end

	def self.importJSON(filename)
		fileJson = File.open(filename, "r")
		txtJson = fileJson.read
		Alphabet.from_json(txtJson)
	end

  	if __FILE__ == $0
  		Graph.buildGraph("alphabet.json")
  	end
end