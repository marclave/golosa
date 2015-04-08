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

  def getList
    if @hasFile
      File.foreach(@filename).sort
        .collect{|x| a = x.split(":"); a[0] + " " + a[1]}
    else
      File.new(@filename, "w")
      @hasFile = true
      # HACK
      ""
    end
  end

  def addEntry(entry)
    File.open(@filename, "a+") {|f| f.write(entry.to_file)}
  end

  def delete(toDelete)
    newLines = ""
    getList.map do |line|
      next if line.split(" ")[0] == toDelete
      newLines += line.split(" ")[0] + ":" + line.split(" ")[1] + "\n"
    end
    File.open(@filename, "w") {|f| f.write(newLines)}
  end

end
