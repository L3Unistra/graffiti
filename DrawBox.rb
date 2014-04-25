#!/usr/bin/ruby

require 'thread'
require 'Qt'
require './Point.rb'

WIDTH = 550
HEIGHT = 350

class DrawBox < Qt::Widget
	def initialize(parent)
		super

		@isPressed = false
		@x = 0
		@y = 0

		@pos1
		@pos2

		@parent = parent

		@image = Qt::Image.new WIDTH, HEIGHT, 7
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
			puts "Pos : x : #{@pos1.x}, y : #{@pos1.y}"
			l = @parent.getLabel
			l.setText "Pos : x : #{@pos1.x}, y : #{@pos1.y}"
			drawLineTo @pos1, @pos2
			@pos1 = @pos2
		end
	end

	def mousePressEvent(e)
		@pos1 = e.pos
	end

	def mouseReleaseEvent(e)
		@image.fill Qt::Color.new "#ffffff"
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
end