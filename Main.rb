#!/usr/bin/env ruby

require 'thread'
require 'Qt'
require './DrawBox'

WIDTH = 600
HEIGHT = 400

class QtApp < Qt::Widget
	def initialize
		super

		setWindowTitle "Graffiti"
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

		labelLetters = Qt::Label.new "Letters", self
		labelNumbers = Qt::Label.new "Numbers", self
		@result = Qt::LineEdit.new self
		@chars = DrawBox.new self, 1
		@numbers = DrawBox.new self, 2
		quit = Qt::PushButton.new 'Quit', self

		grid.addWidget labelLetters, 0, 0
		grid.addWidget labelNumbers, 0, 2
		grid.setRowStretch 1, 1
        grid.addWidget @chars, 1, 0, 2, 2
        grid.addWidget @numbers, 1, 2, 2, 2
		grid.addWidget @result, 4, 0, 1, 2
		grid.addWidget quit, 4, 3, 1, 1

		connect quit, SIGNAL('clicked()'), $qApp, SLOT('quit()')
	end

	def getResult
		return @result
	end

	def resizeEvent(e)
		@chars.resize
		@numbers.resize
	end
end

app = Qt::Application.new ARGV
QtApp.new

app.exec