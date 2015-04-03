class Type
  attr_reader :type

  @@modes = {"Word" => "words.txt",
    "Verb" => "verbs.txt",
    "Colloquial" => "colloquials.txt",
    "Note" => "notes.txt"}

  # is passed a symbol
  def initialize(mode)
    @type = mode
    @filename = @@modes[mode]
    @hasFile = File.exist?(@filename)
  end

  def getList
    if @hasFile
      File.foreach(@filename).sort
        .collect{|x| a = x.split(":"); a[0] + " " + a[1]}
    else
      File.new(@filename, "w")
      @hasFile = true
      Array.empty
    end
  end

  def addEntry(entry)
    File.open(@filename, "a+") {|f| f.write(entry.to_file)}
  end



end
