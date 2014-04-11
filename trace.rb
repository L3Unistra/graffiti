#!/usr/bin/ruby

require 'thread'
require 'Qt'

WIDTH = 450
HEIGHT = 250

class DrawBox < Qt::GraphicsView
	def initialize(parent)
		super(parent)
		@parent = parent
		@scene = Qt::GraphicsScene.new @parent
		@view = Qt::GraphicsView.new @scene, @parent
		show
	end

	def mouseMoveEvent(e)
		mousePos = e.pos 
		puts "Pos : x : #{mousePos.x}, y : #{mousePos.y}"
		l = @parent.getLabel
		l.setText "Pos : x : #{mousePos.x}, y : #{mousePos.y}"
		@scene.addText "bordel", Qt::Font.new("Helvetica", 9)
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
		vbox = Qt::VBoxLayout.new self

		vbox1 = Qt::VBoxLayout.new
		vbox2 = Qt::VBoxLayout.new	
		vbox3 = Qt::VBoxLayout.new

		hbox = Qt::HBoxLayout.new

		windLabel = Qt::Label.new "Draw here :", self
		@label = Qt::Label.new "Pos : "
		@gv = DrawBox.new self


		quit = Qt::PushButton.new 'Quit', self
		
		vbox.addLayout vbox1
		vbox.addLayout vbox2
		vbox.addLayout vbox3

		vbox1.addWidget windLabel, 0, Qt::AlignLeft
		vbox2.addWidget @gv
		vbox3.addLayout hbox

		hbox.addWidget @label, 1, Qt::AlignLeft
		hbox.addWidget quit, 1, Qt::AlignRight

		connect quit, SIGNAL('clicked()'), $qApp, SLOT('quit()')
	end

	def getLabel
		return @label 
	end
end

app = Qt::Application.new ARGV
QtApp.new

app.exec
