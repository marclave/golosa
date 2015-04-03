# The class responsible for all loading/everything that is remotely useful

require 'yaml'

class Dictionary
  attr_reader :words
  attr_reader :language

  # TODO - these shouldn't be strings?
  @@states = ["Word", "Verb"]

  # configs is a hash, default mode is 'Word'
  def initialize
    @language = "russian"
    @configs = YAML.load(File.read("config.yml"))
    @mode = @@states[0]
  end

  def getEntries
    entry = Object.const_get(@mode)
    entry.getList
  end

  # Calls constructor for the type of entry (Word or Verb)
  # Then calls the insert method on that specific class
  def addEntry(translation, english)
    entry = Object.const_get(@mode).new(translation, english)
    entry.insert
  end

end
