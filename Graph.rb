#!/usr/bin/env ruby
require "./Alphabet"

class Graph

	def buildGraph
		#choper les lettres

		#Construire le graphe depuis les lettres

		#renvoi le maillon de tete du graphe construit
	end

	def importJSON
    	fileJson = File.open("letters.txt", "r")
    	txtJson = file.read
    	Alphabet.from_json(txtJson)
  	end
end