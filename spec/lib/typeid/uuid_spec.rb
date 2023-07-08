require_relative "../../../lib/typeid.rb"

RSpec.describe TypeID::UUID do
  subject(:uuid) { TypeID::UUID.new(bytes) }

  let(:bytes) { [1, 136, 186, 199, 74, 250, 120, 170, 188, 59, 189, 30, 239, 40, 216, 129] }
  let(:base32) { "01h2xcejqtf2nbrexx3vqjhp41" }
  let(:string) { "0188bac7-4afa-78aa-bc3b-bd1eef28d881" }

  describe ".from_base32" do
    subject(:uuid) { TypeID::UUID.from_base32(base32).bytes }

    it { is_expected.to eq bytes }
  end

  describe ".from_string" do
    subject(:uuid) { TypeID::UUID.from_string(string).bytes }

    it { is_expected.to eq bytes }
  end

  describe "#string" do
    it { is_expected.to eq string }
  end

  describe "#base32" do
    subject(:base32) { uuid.base32 }

    it { is_expected.to eq base32 }
  end

  describe "#timestamp" do
    subject(:timestamp) { uuid.timestamp }

    it { is_expected.to eq 1686760803066 }
  end
end
