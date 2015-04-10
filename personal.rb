# swcraig

require 'dictionary'
require 'entry'


Shoes.app :width => 700, :height => 640, :title => "Golosa" do

  dict = Dictionary.new
  soraka = Soraka.new

  # Displays title, different modes, and languages
  @leftPanel = stack :margin => 8, :width => "33%" do
    @title = title(dict.language)

    ["Word", "Verb", "Colloquial"].each do |t|
      para (link(t).click do
        dict.mode = t
        soraka.reload(dict, @wordStack, @translationStack)
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
      tongues.change() do |lang|
        if lang.text == "New..."
          @languageField.toggle
        elsif lang.text != dict.language
          dict.language = lang.text
          soraka.reload(dict, @wordStack, @translationStack)
          @title.text = dict.language
        else
          @languageField.toggle
        end
      end
    end
  end

  # List of all the entries
  flow :width => "33%", :height => "100%", :scroll => true do
    @wordStack = stack :width => "50%" do
      para dict.getEntries.keys
    end
    @translationStack = stack :width => "50%" do
      para dict.getEntries.values
    end
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
          soraka.reload(dict, @wordStack, @translationStack, [translation, english])
        end
      end
      button "Delete" do
        dict.deleteEntry(translation.text)
        soraka.reload(dict, @wordStack, @translationStack, [translation, english])
      end
    end
  end

end

# Support class for handling code redundancies
class Soraka
  def reload(dict, eng, trans, opts = nil)
    eng.app do
      eng.clear() {para dict.getEntries.keys}
    end
    trans.app do
      trans.clear() {para dict.getEntries.values}
    end
    # Clear out the edit_lines
    opts.each do |x|
      x.app { x.text = ""}
    end
  end
end


# TODO
# => Make an "Add note" button? How would you view them?
# => Highlight which mode we are currently using
# => Make function for "eng:tran"
# => Put Soraka class in seperate file?
# => Disallow duplicate entries

# ISSUES
# => Should be allowed to maximize but not resize
# => There are too many strings hardcoded everywhere!
# => There are "\n" on some key values

# CODE SMELLS
# => delete in type.rb
# => changing dictionary languages in personal.rb

# LESSONS
# => cannot access class variables with mixins
# => cannot create class methods in mixins
# => title behaves like an edit_line
# => Can't start variable with number
