# Implemented by Word, Verb, and Colloquial Types
# This might not be needed

module Format

  def to_s
    @translation + " " + @english
  end

  def to_file
    @translation + ":" + @english + "\n"
  end

end
