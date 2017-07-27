require "spec_helper"

RSpec.describe RegexSample do
  describe :generate do

    let(:re) { described_class }
    subject { RegexSample.generate(re) }

    # Check these regexes.
    regexes = [
      /(foo){3,5}/,
      /\p{katakana}{2,4}/,
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
