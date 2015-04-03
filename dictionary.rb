# The class responsible for all loading/everything that is remotely useful

require 'yaml'
require 'type'

class Dictionary
  attr_reader :words
  attr_reader :language

  # configs is a hash, default mode is 'Word'
  def initialize
    @language = "russian"
    #@configs = YAML.load(File.read("config.yml"))
    @mode = Type.new("Word")
  end

  def mode= newMode
    @mode = Type.new(newMode)
  end

  def getEntries
    @mode.getList
  end

  # Calls constructor for the type of entry (Word or Verb)
  # Then calls the insert method on that specific class
  def addEntry(translation, english)
    entry = Entry.new(translation, english)
    @mode.addEntry(entry)
  end

end
