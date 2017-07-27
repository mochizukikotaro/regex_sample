require "regex_sample/version"

module RegexSample

  Numbers   = Array(0..9)
  ULetters  = Array('A'..'Z')
  Letters   = ULetters + Array('a'..'z')
  Katakanas = Array('ア'..'ン')
  Kiraganas = Array('あ'..'ん')

  class << self

    def generate(re)
      re = re.source if re.respond_to?(:source) # Handle either a Regexp or a String that looks like a Regexp
      re
      .gsub(/\A\\A/, '')   # Remove \A
      .gsub(/\\z\z/, '')   # Remove \z
      .gsub(/^\/?\^?/, '') # Ditch the anchors
      .gsub(/\$?\/?$/, '') # Ditch the anchors
      .gsub(/\{(\d+)\}/, '{\1,\1}') # {2} become {2,2}
      .gsub(/(?<!\\)\?/, '{0,1}')    # ? become {0,1}
      .gsub(/(?<!\\)\+/, '{1,2}')    # Remove +, except \+
      .gsub(/\\\?/, '?')             # \\? become ?
      .gsub(/\\\+/, '+')             # \\+ become +
      .gsub(/(\[[^\]]+\])\{(\d+),(\d+)\}/){ |match| $1 * Array(Range.new($2.to_i, $3.to_i)).sample } # [12]{1,2} becomes [12] or [12][12]
      .gsub(/(\([^\)]+\))\{(\d+),(\d+)\}/){ |match| $1 * Array(Range.new($2.to_i, $3.to_i)).sample } # (12|34){1,2} becomes (12|34) or .(12|34)(12|34)
      .gsub(/(\\p\{katakana\})\{(\d+),(\d+)\}/) { |match| $1 * Array(Range.new($2.to_i, $3.to_i)).sample } # \p{katakana}{1,2} becomes .\p{katakana} or \p{katakana}\p{katakana}
      .gsub(/(\\?.)\{(\d+),(\d+)\}/){|match| $1 * Array(Range.new($2.to_i, $3.to_i)).sample } # A{1,2} becomes A or AA or \d{3} becomes .\d\d\d
      .gsub(/\((.*?)\)/){ |match| match.gsub(/[\(\)]/, '').split('|').sample } # (this|that) becomes 'this' or 'that'
      .gsub(/\[([^\]]+)\]/) {|match| match.gsub(/(\w\-\w)/) {|range| Array(Range.new(*range.split('-'))).sample } }  # All A-Z inside of [] become C (or X, or .whatever)
      .gsub('\p{katakana}'){ |match| Katakanas.sample }
      .gsub(/\[([^\]]+)\]/){ |match| $1.split('').sample }  # All [ABC] become B (or A or C)
      .gsub('\d'){ |match| Numbers.sample }
      .gsub('\w'){ |match| Letters.sample }
    end

  end

end
