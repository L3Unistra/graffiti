#!/usr/bin/env ruby
require './Point.rb'
require './Arc.rb'

class Maillon
	attr_accessor :p
	attr_accessor :arcs
	attr_accessor :lettre

	def initialize(p)
		@p = p
		@arcs = []
	end

	def addArc(a)
		@arcs << a
	end

	def isPuits
		if arcs.length == 0
			true
		else
			false
		end
	end

	def solve(trace)
		if isPuits
			lettre
		else
			point = trace.shift
			min = 500 #distance max (entre 0-0 et 100-100) est de 141,...
			for arcs.each do |a|
				tmp = point.distPoints(p)
				puts tmp
				if tmp < min
					min = tmp
					maillon = a.m_arr
				end
			end
			maillon.solve(trace)
		end
	end


	if __FILE__ == $0
		#Graphe temporaire
		p0 = Point.new(0,100)
		p1 = Point.new(50,50)
		p2 = Point.new(100,100)
		p3 = Point.new(100,0)
		p4 = Point.new(0,0)
		p5 = Point.new(50,50)
		p6 = Point.new(-1,-1)	


		g = Maillon.new(p0)
		m1 = Maillon.new(p1)
		m2 = Maillon.new(p2)
		m3 = Maillon.new(p3)
		m4 = Maillon.new(p4)
		m5 = Maillon.new(p5)
		m6 = Maillon.new(p6)

		m3.lettre = 'q'
		m4.lettre = 'u'
		m5.lettre = 'a'
		m6.lettre = 'c'

		a1 = Arc.new(g,m1,0)
		a2 = Arc.new(g,m2,0)
		a3 = Arc.new(m1,m3,0)
		a4 = Arc.new(m1,m4,0)
		a5 = Arc.new(m2,m5,0)
		a6 = Arc.new(m2,m6,0)

		g.addArc(a1)
		g.addArc(a2)
		m1.addArc(a3)
		m1.addArc(a4)
		m2.addArc(a5)
		m2.addArc(a6)

		#Fin définition graphe temporaire


		trace = [Point.new(10,5),Point.new(24,57)]
		#puts g.solve(trace)
		trace = [Point.new(50,50),Point.new(75,75)]
		#puts g.solve(trace)
		trace = [Point.new(100,0),Point.new(0,0)]
		#puts g.solve(trace)
		#puts p0.distPoints(p2)
	end
end