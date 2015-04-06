# swcraig

require 'dictionary'
require 'entry'

Shoes.app :width => 700, :height => 640, :title => "Golosa" do

  dict = Dictionary.new

  # Displays title, different modes, and languages
  @leftPanel = stack :margin => 8, :width => "33%" do
    title(dict.language)
    # TODO - Make this an .each loop
    para (link("Words").click do
      @wordStack.clear() {dict.mode = "Word"; para dict.getEntries}
    end)
    para (link("Verbs").click do
      @wordStack.clear() {dict.mode = "Verb"; para dict.getEntries}
    end)
    para (link("Colloquials").click do
      @wordStack.clear() {dict.mode = "Colloquial"; para dict.getEntries}
    end)

    @languages = stack :displace_top => 370 do
      tongues = list_box items: dict.languages + "New...".split()
      tongues.choose(dict.language)
      @languageField = flow do
        edit_line.text = "Enter a new language"
        button 'Create' do
          alert("Creating a new language")
        end
      end
      # TODO - this is ugly and needs fixing
      # Need to update all the stacks and blocks
      tongues.change() do |lang|
        if lang.text == "New..."
          @languageField.toggle
        elsif lang.text != dict.language
          dict.language = lang.text
        else
          @languageField.toggle
        end
      end
    end
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
    flow do
      button "Add" do
        if (!translation.text.empty? && !english.text.empty?)
          dict.addEntry(translation.text, english.text)
          translation.text, english.text = ""
          @wordStack.clear() {para dict.getEntries}
        end
      end
      button "Delete" do
        alert("Feature not implemented")
      end
    end
  end

end


# TODO
# => Figure out why the wordStack needs to be cleared
# => Add delete functionality
# => Make an "Add note" button? How would you view them?
# => Better method of changing dictionary modes
# => Make two columns for the words

# ISSUES
# => Should be allowed to maximize but not resize
# => There are too many strings hardcoded everywhere!
# => If there are no text files, the first time this is run it won't work
# =>    I need to call getList directly after
# => Entry is put into wrong file immediately after a language change

# LESSONS
# => cannot access class variables with mixins
# => cannot create class methods in mixins
# => Prior two points both make sense...
