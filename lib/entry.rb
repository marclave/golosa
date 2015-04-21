# Class for Word, Verb, Colloquial types
require 'lib/support'

class Entry < Type
  include Format

  attr_reader :translation
  attr_reader :english

  def initialize(translation, english)
    @translation = translation
    @english = english
  end

end
