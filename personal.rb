# swcraig

require 'dictionary'
require 'entry'

Shoes.app :width => 700, :height => 640 do

  dict = Dictionary.new

  # Displays title, and the different modes
  @leftPanel = stack :margin => 8, :width => "33%" do
    title(dict.language)
    para (link("Words").click do
      @wordStack.clear() {para dict.getEntries}
    end)
    para (link("Verbs").click do
      @wordStack.clear() {para dict.getEntries}
    end)
  end

  # List of all the entries
  @wordStack = stack :width => "33%", :height => "100%", :scroll => true do
    para dict.getEntries
  end

  # Add more entries
  @addWord = stack :width => "33%" do
    border black
    translation = edit_line
    english = edit_line
    button "Add" do
      if (!translation.text.empty? && !english.text.empty?)
        dict.addEntry(translation.text, english.text)
        translation.text, english.text = ""
        @wordStack.clear() {para dict.getEntries}
      end
    end
  end

end


# TODO
# => Make a class 'Control' that keeps the state of the program?
# => Clean up the Verb and Word links
# => Figure out why the wordStack needs to be cleared

# ISSUES
# =>

# LESSONS
# => cannot access class variables with mixins
# => cannot create class methods in mixins
# => Prior two points both make sense...
