# The class responsible for all loading/everything that is remotely useful

require 'json'
require 'yaml'
require 'src/type'

class Dictionary
  attr_reader :language
  attr_reader :words
  attr_reader :languages
  attr_reader :sortedLang

  attr_reader :bool

  @@configPath = Dir.home + "/Golosa/config.yml"

  # Default mode is "Word"
  def initialize
    @path = File.open(@@configPath) { |f| YAML.load(f)['path'] }
    @languages = File.open(@@configPath) { |f| YAML.load(f)['languages'] }
    @language = languages[0]
    @mode = Type.new("Word", self, @path)
    @sortByEng = true
  end

  # TODO This can be prettier!
  def toggleSort
    if @sortByEng
      @sortByEng = false
    else
      @sortByEng = true
    end
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

  # keys is actually never changed
  def getWords
    h = @mode.getList.keys
    if !@sortByEng
      #d = h.sort! { |k, v| h[v] <=> h[k] }
      #h.sort! { |k, v| h[v] <=> h[k] }
      rus = getTranslations
      final = []
      match = @mode.getList
      # for each russian word, get coresponding english
      rus.each { |r| final.push(match.key(r)) }

      final.map { |x| "#{x}\n"}
    else
      h.map { |x| "#{x}\n" }
    end
  end

  def getTranslations
    if !@sortByEng
      @mode.getList.values.sort
    else
      @mode.getList.values
    end
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
