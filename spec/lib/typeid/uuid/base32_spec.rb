require_relative "../../../../lib/typeid.rb"

RSpec.describe TypeID::UUID::Base32 do
  let(:decoded) { [1, 136, 186, 199, 74, 250, 120, 170, 188, 59, 189, 30, 239, 40, 216, 129] }
  let(:encoded) { "01h2xcejqtf2nbrexx3vqjhp41" }

  describe ".encode" do
    subject(:encode) { TypeID::UUID::Base32.encode(decoded) }

    it { is_expected.to eq encoded }
  end

  describe ".decode" do
    subject(:decode) { TypeID::UUID::Base32.decode(encoded) }

    it { is_expected.to eq decoded }
  end
end
