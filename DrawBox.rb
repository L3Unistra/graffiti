#!/usr/bin/env ruby

require 'thread'
require 'Qt'
require './Graph'
require './Point'
#require './TraceConverter'

class DrawBox < Qt::Widget
	def initialize(parent)
		super

		@g = Graph.new

		@result

		@pos1
		@pos2

		@parent = parent

		@image = Qt::Image.new @parent.width, @parent.height/2, 7
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
			#puts "Pos : x : #{@pos1.x}, y : #{@pos1.y}"
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
		# @result.each{|p| puts p}

		puts @result.length

		r = @parent.getResult
		r.insert(@g.solve(@result))

		# tc = TraceConverter.new(@result)
    	# tab = tc.resize

		# file = File.open('alphabet.json', 'a')
		# str = '{"letter":"a", "points":['
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

	def drawPoint pos1
		p = Qt::Painter.new
		p.begin @image
		p.setRenderHint Qt::Painter::Antialiasing

        color = Qt::Color.new
        color.setNamedColor "#333333"

        pen = Qt::Pen.new color
        pen.setWidth 3
        p.setPen pen

        p.drawPoint pos1.x, pos1.y
        rad = (3/2)+2;
        update
        p.end
	end
end