#!/usr/bin/env ruby
require "./Point"
require './Alphabet.rb'
require './Maillon.rb'

class Graph

	attr_accessor :g #tete du graphe de résolution

	def initialize
		@g = Graph.buildGraph
	end

	def self.buildGraph
		#choper les lettres
		al = Graph.importJSON
		tab = al.alphabet
		#puts tab
		#Construire le graphe depuis les lettres

		tete = Maillon.new(Point.new(-1,-1))
		for i in 0..tab.size #On parcours chaque lettre de l'alphabet

			tmp = tab[i].points#tableau des points d'une lettre
			current = tete #maillon actuel
			for j in 0..tmp.size
				m = maillon.new(tmp[j].x, tmp[j].y) #on créer le maillon associé au point courant
				current.addArc(Arc.new(current, m,0))
				current = m
				if j == tmp.size #dernier point de la lettre
					m.lettre = tab[i].lettre #on assigne la lettre au maillon
					current = tete #on remet le maillon courant à la tete
				end
			end
		end
		#renvoi le maillon de tete du graphe construit
		tete
	end

	def solve(tab)
		trace = TraceConverter.new(tab)
		tab_coup = trace.resize
		c = @g.solve(tab_coup)
		puts c
		c
	end

	def self.importJSON 
		fileJson = File.open("alphabet.json", "r")
		txtJson = fileJson.read
		Alphabet.from_json(txtJson)
	end

  	if __FILE__ == $0
  		Graph.buildGraph
  	end
end