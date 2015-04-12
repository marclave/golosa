class Type
  attr_reader :type

  def initialize(mode, dictionary)
    @type = mode
    @dictionary = dictionary
    # Should I make this is a constant? There are too many strings...
    @modes = {"Word" => "words.txt", "Verb" => "verbs.txt",
      "Colloquial" => "colloquials.txt", "Note" => "notes.txt"}
    # Append the language name to the mode, so each language has distinct files
    @modes.each{|key, val| @modes[key] = @dictionary.language + val}
    @filename = @modes[@type]
    @hasFile = File.exist?(@filename)
  end

  # Returns a hash, easier to split up into columns
  def getList
    entries = {}
    if @hasFile
      File.foreach(@filename).sort
        .collect{|x| a = x.split(":"); entries[a[0]+"\n"] = a[1]}
    else
      File.new(@filename, "w")
      @hasFile = true
    end
    entries
  end

  def addEntry(entry)
    File.open(@filename, "a+") {|f| f.write(entry.to_file)}
  end

  def delete(toDelete)
    newLines = ""
    getList.each do |key, val|
      next if key.strip == toDelete  # Key has a newline part of it!!
      newLines += key.strip + ":" + val
    end
    File.open(@filename, "w") {|f| f.write(newLines)}
  end

end

# Should this possibly have two instance variables keys and values?
