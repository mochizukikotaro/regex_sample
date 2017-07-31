require "regex_sample/version"

module RegexSample

  Numbers   = Array(0..9)
  ULetters  = Array('A'..'Z')
  Letters   = ULetters + Array('a'..'z')
  Katakanas = Array('ア'..'ン')
  Hiraganas = Array('あ'..'ん')

  class << self

    def generate(re)
      times = Proc.new{ $1 * Array(Range.new($2.to_i, $3.to_i)).sample }

      # Do not handle either a Regexp or a String that looks like a Regexp
      # Only regexp
      return false unless re.respond_to?(:source)

      re = re.source
      re
      .gsub(/\A\\A/, '')             # Remove \A
      .gsub(/\\z\z/, '')             # Remove \z
      .gsub(/\A\^/, '')              # Remove ^
      .gsub(/\$\z/, '')              # Remove $
      .gsub(/\{(\d+)\}/, '{\1,\1}')  # {2} become {2,2}
      .gsub(/(?<!\\)\?/, '{0,1}')    # ? become {0,1}
      .gsub(/(?<!\\)\+/, '{1,2}')    # + become {1,2}
      .gsub(/(?<!\\)\*/, '{0,2}')    # * become {0,2}
      .gsub(/\\\?/, '?')             # \\? become ?
      .gsub(/\\\+/, '+')             # \\+ become +
      .gsub(/\\\*/, '*')             # \\* become *
      .gsub(/(\[[^\]]+\])\{(\d+),(\d+)\}/)      { times.call } # [12]{1,2} becomes [12] or [12][12]
      .gsub(/(\([^\)]+\))\{(\d+),(\d+)\}/)      { times.call } # (12|34){1,2} becomes (12|34) or .(12|34)(12|34)
      .gsub(/(\\p\{katakana\})\{(\d+),(\d+)\}/) { times.call } # \p{katakana}{1,2} becomes .\p{katakana} or \p{katakana}\p{katakana}
      .gsub(/(\\p\{hiragana\})\{(\d+),(\d+)\}/) { times.call } # \p{hiragana}{1,2} becomes .\p{hiragana} or \p{hiragana}\p{hiragana}
      .gsub(/(\\?.)\{(\d+),(\d+)\}/)            { times.call } # A{1,2} becomes A or AA or \d{3} becomes .\d\d\d
      .gsub(/\((.*?)\)/){ |match| match.gsub(/[\(\)]/, '').split('|').sample } # (this|that) becomes 'this' or 'that'
      .gsub(/\[([^\]]+)\]/){ |match| match.gsub(/(\w\-\w)/) {|range| Array(Range.new(*range.split('-'))).sample } }  # All A-Z inside of [] become C (or X, or .whatever)
      .gsub('\p{katakana}'){ Katakanas.sample }
      .gsub('\p{hiragana}'){ Hiraganas.sample }
      .gsub(/(?<!\\)\\-/, '-')                      # \- become -, except \\-
      .gsub(/\[([^\]]+)\]/){ $1.split('').sample }  # All [ABC] become B (or A or C)
      .gsub('\d'){ Numbers.sample }
      .gsub('\w'){ Letters.sample }
    end

  end
end
