require_relative "../../lib/typeid.rb"

RSpec.describe TypeID do
  subject(:type_id) { TypeID.new(prefix, suffix: suffix) }

  let(:prefix) { "user" }
  let(:suffix) { "01h2xcejqtf2nbrexx3vqjhp41" }
  let(:string) { "#{prefix}_#{suffix}" }
  let(:uuid) { TypeID::UUID.new(bytes) }
  let(:bytes) { [1, 136, 186, 199, 74, 250, 120, 170, 188, 59, 189, 30, 239, 40, 216, 129] }

  describe ".from_string" do
    subject(:type_id) { TypeID.from_string(string) }

    it { is_expected.to eq string }
  end

  describe ".from_uuid" do
    subject(:type_id) { TypeID.from_uuid(prefix, uuid) }

    it { is_expected.to eq string }
  end

  describe ".from" do
    subject(:type_id) { TypeID.from(prefix, suffix) }

    it { is_expected.to eq string }
  end

  describe ".nil" do
    subject(:type_id) { TypeID.nil }

    it { is_expected.to eq "00000000000000000000000000" }
  end

  describe "#string" do
    it { is_expected.to eq "#{prefix}_#{suffix}" }
  end
end
