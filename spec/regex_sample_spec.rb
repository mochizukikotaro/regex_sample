require "spec_helper"

RSpec.describe RegexSample do
  describe :generate do

    # context /(a|b)/ do
    #   it 'match' do
    #     re = RSpec.current_example.metadata[:described_class]
    #     expect(RegexSample.generate(re)).to match(re)
    #   end
    # end
    #
    # context /\p{katakana}/ do
    #   it 'match' do
    #     re = RSpec.current_example.metadata[:described_class]
    #     expect(RegexSample.generate(re)).to match(re)
    #   end
    # end
    #
    # context /\p{hiragana}/ do
    #   it 'match' do
    #     re = RSpec.current_example.metadata[:described_class]
    #     expect(RegexSample.generate(re)).to match(re)
    #   end
    # end

    let(:re) { RSpec.current_example.metadata[:described_class] }
    subject { RegexSample.generate(re) }

    context /(a|b)/ do
      it { is_expected.to match(re)  }
    end

    context /\p{katakana}/ do
      it { is_expected.to match(re)  }
    end

    context /\p{hiragana}/ do
      it { is_expected.to match(re)  }
    end

  end
end
