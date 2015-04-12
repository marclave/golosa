# The class responsible for all loading/everything that is remotely useful

require 'yaml'
require 'type'

class Dictionary
  attr_reader :language
  attr_reader :words
  attr_reader :languages
  # Don't need an accessor for mode because I am making a method?

  # Default mode is "Word"
  def initialize(language = "russian")
    @language = language
    # languages is an array
    @languages = File.open("config.yml") {|f| YAML.load(f)['languages']}
    @mode = Type.new("Word", self)
  end

  def language= newLang
    @language = newLang
    @mode = Type.new(@mode.type, self)
  end

  def mode= newMode
    @mode = Type.new(newMode, self)
  end

  def getWords
    @mode.getList.keys
  end

  def getTranslations
    @mode.getList.values
  end

  def deleteEntry(entry)
    @mode.delete(entry)
  end

  # Calls constructor for the type of entry (Word or Verb)
  # Then calls the insert method on that specific class
  def addEntry(translation, english)
    entry = Entry.new(translation, english)
    @mode.addEntry(entry)
  end

end
