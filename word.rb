# TODO - Figure out the class variables

require 'support'

class Word
  include Format

  attr_reader :translation
  attr_reader :english

  def initialize(translation, english)
    @translation = translation
    @english = english
    @filename = "words.txt"
    @hasFile = File.exist?(@filename)
  end

end
