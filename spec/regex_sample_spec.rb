require "spec_helper"

RSpec.describe RegexSample do
  describe :generate do

    # Check these regexes.
    regexes = [

      # Start and End
      /\Afoo/,
      /^foo/,
      /foo\z/,
      /foo$/,

      # {x,y}
      /(foo){3,8}/,
      /foo{3,8}/,
      /foo{3}/,

      # ?, +, etc.
      /foo?/,
      /bar+/,

      # (x|y)
      /(a|b)/,
      /(a|b)+/,
      /(a|b){3,8}/,

      # [x-y]
      /[1-9]/,
      /[1-9]+/,
      /[1-9]{3,8}/,

      # Backslash escapes a metacharacters
      /\?/,
      /\+/,
      /\-/,
      /\//,
      /[\?]/,
      /[\+]/,
      /[\-]/,
      /[\/]/,

      # \d, \w, etc.
      /\d/,
      /\w/,
      /\d{3,8}/,
      /\w{3,8}/,

      # katakana, hiragana
      /\p{katakana}/,
      /\p{katakana}{3,8}/,
      /[\p{katakana}]{3,8}/,
      /\p{hiragana}{3,8}/,
      /(\p{katakana}|\p{hiragana}){3,8}/,

      # complex
      /\A(foo)[0-9]{1,4}[\-\/]{1}[a-z]{2}(baz)\z/,
    ]

    let(:re) { described_class }
    subject { RegexSample.generate(re) }

    regexes.each do |regex|
      context regex do
        it do
          print "\n" + RegexSample.generate(re)
          is_expected.to match(re)
        end
      end
    end

  end
end
