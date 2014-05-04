#!/usr/bin/env ruby

require 'thread'
require 'Qt'
require './Graph'
require './Point'

class DrawBox < Qt::Widget
	def initialize(parent, mode)
		super parent

		@graph = mode == 1 ? Graph.new("alphabet.json") : Graph.new("numbers.json")

		@result

		@shift = false

		@pos1
		@pos2

		@parent = parent
		@r = @parent.getResult

		@image = Qt::Image.new 1000, 1000, 7
		@image.fill Qt::Color.new "#ffffff"
	end

	def paintEvent(e)
		painter = Qt::Painter.new
		painter.begin self
		painter.setRenderHint Qt::Painter::Antialiasing
		dirtyRect = e.rect
		painter.drawImage(dirtyRect, @image, dirtyRect)
		
		painter.end
	end

	def mouseMoveEvent(e)
		if (e.pos.x > 0 and e.pos.x < @image.width) and (e.pos.y > 0 and e.pos.y < @image.height)
			@pos2 = e.pos
			@result << Point.new(@pos2.x, @pos2.y)
			drawLineTo @pos1, @pos2
			#drawPoint @pos1
			@pos1 = @pos2
		end
	end

	def mousePressEvent(e)
		@result = Array.new 
		@pos1 = e.pos
		@result << Point.new(@pos1.x, @pos1.y)
	end

	def mouseReleaseEvent(e)
		@image.fill Qt::Color.new "#ffffff"

		if @result.length > 1
			char = @graph.solve(@result)
			if char == "shift"
				@shift = true
			elsif char == "back"
				@r.backspace
			else
				if @shift
					@r.insert(char.upcase)
					@shift = false
				else
					@r.insert(char)
				end
			end
		end

		# lignes pour la création du json

		# puts @result.length
		# tc = TraceConverter.new(@result)
		# tab = tc.resize

		# file = File.open('new.json', 'a')
		# str = '{"char":"a", "points":['
		# tab.each{|p| str+='{"x":'+p.x.to_s+', "y":'+p.y.to_s+'},'}
		# str = str[0..-2]
		# str+= ']},'

		# file.puts str 
		# file.close

		
		update 
	end

	def drawLineTo pos1, pos2
		p = Qt::Painter.new
		p.begin @image
		p.setRenderHint Qt::Painter::Antialiasing

		color = Qt::Color.new
		color.setNamedColor "#333333"

		pen = Qt::Pen.new color
		pen.setWidth 3
		p.setPen pen

		p.drawLine Qt::Line.new(pos1, pos2)
		rad = (3/2)+2;
		update(Qt::Rect.new(pos1, pos2).normalized().adjusted(-rad, -rad, +rad, +rad))
		p.end
	end

	# def drawPoint pos1
	# 	p = Qt::Painter.new
	# 	p.begin @image
	# 	p.setRenderHint Qt::Painter::Antialiasing

	# 	color = Qt::Color.new
	# 	color.setNamedColor "#333333"

	# 	pen = Qt::Pen.new color
	# 	pen.setWidth 3
	# 	p.setPen pen

	# 	p.drawPoint pos1.x, pos1.y
	# 	rad = (3/2)+2;
	# 	update
	# 	p.end
	# end

	def resize
		@image = Qt::Image.new @parent.width/2, @parent.width/2, 7
		@image.fill Qt::Color.new "#ffffff"
	end
end