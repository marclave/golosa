# swcraig

require 'src/dictionary'
require 'src/soraka'
require 'src/entry'

Shoes.app :width => 1200, :height => 640, :resizable => false, :title => "Golosa" do

  dict = Dictionary.new
  soraka = Soraka.new

  # Displays title, different modes, and languages
  @leftPanel = stack :margin => 8, :width => "33%" do
    @title = title(dict.language)

    # Word is the default type
    @word = para (link("Word").click do
      soraka.changeType(@word, [@verb,@colloquial])
      dict.mode = "Word"
      soraka.reload(dict, @wordStack, @translationStack, @sortLangauge)
    end)
    @word.emphasis = "oblique"

    @verb = para (link("Verb").click do
      soraka.changeType(@verb, [@word,@colloquial])
      dict.mode = "Verb"
      soraka.reload(dict, @wordStack, @translationStack, @sortLangauge)
    end)

    @colloquial = para (link("Colloquial").click do
      soraka.changeType(@colloquial, [@word,@verb])
      dict.mode = "Colloquial"
      soraka.reload(dict, @wordStack, @translationStack, @sortLangauge)
    end)

    # Sorts by language
    # TODO put this on one line!
    flow { @sort = check; @sortLangauge = stack { para "Sort by #{dict.language}" } }
    @sort.click { |x| dict.toggleSort; soraka.reload(dict, @wordStack, @translationStack, @sortLangauge)}

    @languages = stack :displace_top => 370 do
      tongues = list_box items: dict.languages + "New...".split
      tongues.choose(dict.language)
      @languageField = flow do
        newLang = edit_line text: "Enter a new language"
        button 'Create' do
          dict.addLanguage(newLang.text)
          @title.text = dict.language
          tongues.items = dict.languages + "New...".split
          tongues.choose(@title.text)
          soraka.reload(dict, @wordStack, @translationStack, @sortLangauge, [newLang])
        end
      end
      tongues.change do |lang|
        if lang.text == "New..."
          @languageField.show
        elsif lang.text != dict.language
          dict.language = lang.text
          soraka.reload(dict, @wordStack, @translationStack, @sortLangauge)
          @title.text = dict.language
          @languageField.hide
        else
          @languageField.hide
        end
      end
    end
  end

  # List of all the entries
  flow :width => "33%", :height => "100%", :scroll => true do
    @wordStack = stack :width => "50%" do
      para dict.getWords
    end
    @translationStack = stack :width => "50%" do
      para dict.getTranslations
    end
  end

  # Add/Delete entries
  @addWord = stack :width => "25%" do
    #border black
    translation = edit_line :displace_left => 90
    english = edit_line :displace_left => 90, :displace_top => 5
    flow :displace_top => 8 do
      button "Add", :displace_left => 120 do
        if (!translation.text.empty? && !english.text.empty?)
          dict.addEntry(translation.text, english.text)
          soraka.reload(dict, @wordStack, @translationStack, @sortLangauge, [translation, english])
        end
      end
      button "Delete", :displace_left => 120 do
        dict.deleteEntry(translation.text)
        soraka.reload(dict, @wordStack, @translationStack, @sortLangauge, [translation, english])
      end
    end
  end

  # This is kind of ugly
  @legend = stack :width => "5%" do
    para "english"
    para "translation"
  end

end

# TODO
# => Disallow duplicate entries
# => Clean up the styling!
# => Make an "Add note" button? How would you view them?

# ISSUES
# => Should be allowed to maximize but not resize
# => There are too many strings hardcoded everywhere!
# => There are "\n" on some key values
# => Not a huge fan of the require statements

# CODE SMELLS
# => init in type (@path)
