#!/usr/bin/env ruby

require 'thread'
require 'Qt'
require './DrawBox'

WIDTH = 550
HEIGHT = 350

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

		@result = Qt::LineEdit.new self
		letters = DrawBox.new self, 1
		numbers = DrawBox.new self, 2
		quit = Qt::PushButton.new 'Quit', self
		
        grid.addWidget letters, 1, 0, 2, 2
        grid.addWidget numbers, 1, 2, 2, 2
		grid.addWidget @result, 4, 0, 1, 2
		grid.addWidget quit, 4, 3, 1, 1

		connect quit, SIGNAL('clicked()'), $qApp, SLOT('quit()')
	end

	def getResult
		return @result
	end
end

app = Qt::Application.new ARGV
QtApp.new

app.exec