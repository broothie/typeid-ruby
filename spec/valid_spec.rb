require "yaml"
require_relative "../lib/typeid.rb"

filename = "valid.yml"
filepath = File.expand_path(filename, __dir__)
examples = YAML.load_file(filepath)

RSpec.context "when testing against #{filename}" do
  examples.each do |example|
    context "when example '#{example["name"]}'" do
      describe "decoding" do
        let(:type_id) { TypeID.from_string(example["typeid"]) }

        describe "prefix" do
          subject(:prefix) { type_id.prefix }

          it { is_expected.to eq example["prefix"] }
        end

        describe "uuid" do
          subject(:uuid) { type_id.uuid }

          it { is_expected.to eq example["uuid"] }
        end
      end

      describe "encoding" do
        subject(:type_id) { TypeID.from_uuid(example["prefix"], example["uuid"]) }

        it { is_expected.to eq example["typeid"] }
      end
    end
  end
end
