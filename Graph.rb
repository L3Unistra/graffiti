#!/usr/bin/env ruby
require './Alphabet.rb'
require './Maillon.rb'

class Graph

	def self.buildGraph
		#choper les lettres
		al = Graph.importJSON
		tab = Alphabet.letters

		#Construire le graphe depuis les lettres

		tete= maillon.new(-1,-1)
		for i in 0..tab.lenght #On parcours chaque lettre de l'alphabet

			tmp = tab[i].points#tableau des points d'une lettre
			current = tete #maillon actuel
			for j in 0..tmp.lenght
				m = maillon.new(tmp[j].x, tmp[j].y) #on créer le maillon associé au point courant
				current.addArc(Arc.new(current, m,0))
				current = m
				if j == tmp.lenght #dernier point de la lettre
					m.lettre = tab[i].lettre #on assigne la lettre au maillon
					current = tete #on remet le maillon courant à la tete
				end
			end
		end
		#renvoi le maillon de tete du graphe construit
		tete
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