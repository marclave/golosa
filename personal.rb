# swcraig

require 'dictionary'
require 'entry'

Shoes.app :width => 700, :height => 640, :title => "Golosa" do

  dict = Dictionary.new

  # Displays title, different modes, and languages
  @leftPanel = stack :margin => 8, :width => "33%" do
    @title = title(dict.language)

    ["Word", "Verb", "Colloquial"].each do |t|
      para (link(t).click do
        @wordStack.clear() {dict.mode = t; para dict.getEntries}
      end)
    end

    @languages = stack :displace_top => 370 do
      tongues = list_box items: dict.languages + "New...".split()
      tongues.choose(dict.language)
      @languageField = flow do
        edit_line.text = "Enter a new language"
        button 'Create' do
          alert("Creating a new language")
        end
      end
      # Handle changing the dictionary language
      tongues.change() do |lang|
        if lang.text == "New..."
          @languageField.toggle
        elsif lang.text != dict.language
          dict.language = lang.text
          @wordStack.clear() {para dict.getEntries}
          @title.text = dict.language
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

  # Add/Delete entries
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
        dict.deleteEntry(translation.text)
        translation.text, english.text = ""
        @wordStack.clear() {para dict.getEntries}
      end
    end
  end

end


# TODO
# => Make an "Add note" button? How would you view them?
# => Make two columns for the words
# => Highlight which mode we are currently using
# => Make function for "eng:tran"
# => Add and delete, redundant code

# ISSUES
# => Should be allowed to maximize but not resize
# => There are too many strings hardcoded everywhere!

# CODE SMELLS
# => delete in type.rb
# => changing dictionary languages in personal.rb


# LESSONS
# => cannot access class variables with mixins
# => cannot create class methods in mixins
# => Prior two points both make sense...
# => title behaves like an edit_line
