# swcraig

require 'dictionary'
require 'entry'

Shoes.app :width => 700, :height => 640 do

  dict = Dictionary.new

  # Displays title, different modes, and languages
  @leftPanel = stack :margin => 8, :width => "33%" do
    title(dict.language)
    para (link("Words").click do
      @wordStack.clear() {dict.mode = "Word"; para dict.getEntries}
    end)
    para (link("Verbs").click do
      @wordStack.clear() {dict.mode = "Verb"; para dict.getEntries}
    end)
    para (link("Colloquials").click do
      @wordStack.clear() {dict.mode = "Colloquial"; para dict.getEntries}
    end)

    @languages = stack :displace_top => 400 do
      tongues = list_box items: ["Russian", "New..."]
      tongues.choose("Russian")
      # Putting an alert here will cause a blank alert to show up?
      #tongues.change() {|lang| lang}
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

# ISSUES
# => Should be allowed to maximize but not resize
# => There are too many strings hardcoded everywhere!

# LESSONS
# => cannot access class variables with mixins
# => cannot create class methods in mixins
# => Prior two points both make sense...
