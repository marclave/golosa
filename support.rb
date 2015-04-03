# Implemented by Word, Verb, and Colloquial Types

module Format

  #def self.included base
  #  base.extend ClassMethods
  #end

  def to_s
    @translation + " " + @english
  end

  def to_file
    @translation + ":" + @english + "\n"
  end

  #def insert
  #  File.open(@filename, "a+") { |f| f.write(self.to_file) }
  #end

  # TODO - Get access to the class variables.. Is that poor practice?
  #module ClassMethods
  #  def getList
  #    if File.exist?("words.txt")
  #      File.foreach("words.txt").sort
  #        .collect{|x| a = x.split(":"); a[0] + " " + a[1]}
  #    else
  #      File.new("words.txt", "w")
        # @hasFile = true
        # So that nothing is written to the application
  #      Array.empty
  #    end
  #  end
  #end

end
