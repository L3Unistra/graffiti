#!/usr/bin/env ruby
require "./Alphabet"

class Graph

  def importJSON
    fileJson = File.open("letters.txt", "r")
    txtJson = file.read
    Alphabet.from_json(txtJson)
  end

end