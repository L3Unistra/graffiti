#!/usr/bin/env ruby
require "./Alphabet"

class Graph

  def self.importJSON
    fileJson = File.open("alphabet.json", "r")
    txtJson = fileJson.read
    Alphabet.from_json(txtJson)
  end

end