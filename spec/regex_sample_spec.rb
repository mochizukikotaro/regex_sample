require "spec_helper"

RSpec.describe RegexSample do
  describe :generate do
    context /(a|b)/ do
      it 'match' do
        re = RSpec.current_example.metadata[:described_class]
        expect(RegexSample.generate(re)).to match(re)
      end
    end
  end
end
