# Implemented by Word, Verb, and Colloquial Types

module Format

  def to_s
    @translation + " " + @english
  end

  def to_file
    @translation + ":" + @english + "\n"
  end

end
