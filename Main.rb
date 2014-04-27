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

		windLabel = Qt::Label.new "Draw here :", self
		@result = Qt::LineEdit.new self
		gv = DrawBox.new self
		quit = Qt::PushButton.new 'Quit', self
		
        grid.addWidget windLabel, 0, 0
        grid.addWidget gv, 1, 0, 2, 4
		grid.setColumnStretch 1, 1
		grid.addWidget @result, 4, 0, 1, 2
		grid.addWidget quit, 4, 2

		connect quit, SIGNAL('clicked()'), $qApp, SLOT('quit()')
	end

	def getResult
		return @result
	end
end

app = Qt::Application.new ARGV
QtApp.new

app.exec