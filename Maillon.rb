#!/usr/bin/env ruby
require './Point.rb'
require './Arc.rb'

class Maillon
	attr_accessor :p
	attr_accessor :arcs
	attr_accessor :char
	attr_accessor :poids_to_rac
	attr_accessor :puits

	def initialize(p)
		@p = p
		@arcs = []
		@char = '-'
		@poids_to_rac = 0
		@puits = []
	end

	def addArc(a)
		@arcs << a
	end

	def addPuits(m)
		@puits << m
	end

	def isPuits
		if arcs.length == 0
			true
		else
			false
		end
	end

	#Non utilisé
	def solve(trace)
		if isPuits
			char
		else
			point = trace.shift
			maillon = Maillon.new(point)
			min = 500 #distance max (entre 0-0 et 100-100) est de 141,...
			arcs.each do |a|
				tmp = a.m_arr.p.distPoints(point)
				if tmp < min
					min = tmp
					maillon = a.m_arr
				end
			end
			maillon.solve(trace)
		end
	end

	def findpuits(g)
		arcs.each do |a|
			m = a.m_arr
			m.poids_to_rac = @poids_to_rac + a.poids
			if !m.isPuits
				m.findpuits(g)
			else
				g.addPuits(m)
			end
		end
	end

	def pondere(trace, i)
		if i < trace.size
			point = trace[i]
			arcs.each do |a|
				a.poids = p.distPoints(point)
				a.m_arr.pondere(trace, i+1)
			end
		end
	end

	if __FILE__ == $0
		#Graphe temporaire

		g = Maillon.new(Point.new(-1,-1))
		m0 = Maillon.new(Point.new(0,100))
		m1 = Maillon.new(Point.new(100,0))
		m2 = Maillon.new(Point.new(50,50))
		m3 = Maillon.new(Point.new(100,100))
		m4 = Maillon.new(Point.new(0,0))
		m5 = Maillon.new(Point.new(50,50))


		m2.char = 'q'
		m3.char = 'u'
		m4.char = 'a'
		m5.char = 'c'

		g.addArc(Arc.new(g,m0,0))
		g.addArc(Arc.new(g,m1,0))
		m0.addArc(Arc.new(m0,m2,0))
		m0.addArc(Arc.new(m0,m3,0))
		m1.addArc(Arc.new(m1,m4,0))
		m1.addArc(Arc.new(m1,m5,0))

		#Fin définition graphe temporaire


		trace = [Point.new(0,100),Point.new(50,50)]
		g.pondere(trace,0)
		g.findpuits(g)
		g.puits.each do |p|
			print p.char
		end

	end
end