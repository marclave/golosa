# Support class for handling code redundancies in personal.rb

class Soraka

  def reload(dict, eng, trans, sort, opts = nil)
    eng.app do
      eng.clear { para dict.getWords }
    end
    trans.app do
      trans.clear { para dict.getTranslations }
    end
    #sort.clear { para "Sd" }
    sort.app do
      sort.clear { para "Sort by #{dict.language}" }
    end
    # Clear out the edit_lines
    if opts
      opts.each do |x|
        x.app { x.text = "" }
      end
    end
  end

  def changeType(type, all)
    type.app do
      type.emphasis = "oblique"
    end
    all.each do |x|
      x.app do
        x.emphasis = "normal"
      end
    end
  end

end
