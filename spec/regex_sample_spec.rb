require "spec_helper"

RSpec.describe RegexSample do
  describe :generate do

    let(:re) { described_class }
    subject { RegexSample.generate(re) }

    # Check these regexes.
    regexes = [
      /(foo){3,5}/,
      /\p{katakana}{2,2}/,
      /[\p{katakana}]{2,2}/,
      /foo[abc]?\z/,
      /foo?/,
      /foo\?/,
      /bar+/,
      /bar\+/,
      /foo\?/,
      /foo\?\z/,
      /(a|b)/,
      /[1-9]+/,
      /\p{katakana}{3,10}/,
      /\p{hiragana}/,
      /\-/,
      /[\-]/,
      /\//,
      /[\/]/,
      /\+/,
      /\A(foo)[0-9]{1,4}[\-\/]{1}[a-z]{2}(baz)\z/,
      /\d{10}/,
      /\w{10}/,
    ]

    regexes.each do |regex|
      context regex do
        it do
          p RegexSample.generate(re)
          is_expected.to match(re)
        end
      end
    end

  end
end
