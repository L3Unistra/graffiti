#!/usr/bin/env ruby

require './Maillon.rb'

class Arc

	attr_accessor :m_dep
	attr_accessor :m_arr
	attr_accessor :poids

	def initialize(m_dep, m_arr, poids)
		@m_dep = m_dep
		@m_arr = m_arr
		@poids = poids
	end
end

