# The class responsible for all loading/everything that is remotely useful

require 'json'
require 'yaml'
require 'src/type'

class Dictionary
  attr_reader :language
  attr_reader :words
  attr_reader :languages
  attr_reader :sortedLang

  @@configPath = Dir.home + "/Golosa/config.yml"

  # Default mode is "Word"
  def initialize
    @path = File.open(@@configPath) { |f| YAML.load(f)['path'] }
    @languages = File.open(@@configPath) { |f| YAML.load(f)['languages'] }
    @language = languages[0]
    @mode = Type.new("Word", self, @path)
    @sortByEng = true
  end

  def toggleSort
    @sortByEng ? @sortByEng = false : @sortByEng = true
  end

  def language=(newLang)
    @language = newLang
    @mode = Type.new(@mode.type, self, @path)
  end

  # Also changes the dictionary language
  def addLanguage(newLang)
    File.open(@@configPath, "w") do |f|
      f.write({"languages" => @languages.push(newLang), "path" => @path}.to_json)
    end
    @language = newLang
  end

  def mode=(newMode)
    @mode = Type.new(newMode, self, @path)
  end

  def getWords
    words = @mode.getList.keys
    if !@sortByEng
      words = []
      rus = getTranslations
      match = @mode.getList
      # for each russian word, get corresponding english
      rus.each { |r| words.push(match.key(r)) }
    end
    words.map { |x| "#{x}\n"}
  end

  def getTranslations
    !@sortByEng ? @mode.getList.values.sort : @mode.getList.values
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
