#!/usr/bin/ruby

require 'thread'
require 'Qt'

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
		@pos2 = e.pos
		puts "Pos : x : #{@pos1.x}, y : #{@pos1.y}"
		l = @parent.getLabel
		l.setText "Pos : x : #{@pos1.x}, y : #{@pos1.y}"
		drawLineTo @pos1, @pos2
		@pos1 = @pos2
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

class QtApp < Qt::Widget
	def initialize
		super

		setWindowTitle "Draw Box"
		resize WIDTH, HEIGHT

		center
		init_ui
		show
	end

	def center

		qdw = Qt::DesktopWidget.new

		screenWidth = qdw.width 
		screenHeight = qdw.height 

		x = (screenWidth - WIDTH)/2
		y = (screenHeight - HEIGHT)/2

		move x,y
	end

	def init_ui
		grid = Qt::GridLayout.new self

		windLabel = Qt::Label.new "Draw here :", self
		@label = Qt::Label.new "Pos : ", self
		gv = DrawBox.new self
		quit = Qt::PushButton.new 'Quit', self
		
		grid.addWidget windLabel, 0, 0
		grid.addWidget gv, 1, 0, 2, 4
		grid.addWidget @label, 4, 0
		grid.addWidget quit, 4, 3

		connect quit, SIGNAL('clicked()'), $qApp, SLOT('quit()')
	end

	def getLabel
		return @label
	end
end

app = Qt::Application.new ARGV
QtApp.new

app.exec
