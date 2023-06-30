require "yaml"
require_relative "../lib/typeid.rb"

filename = "invalid.yml"
filepath = File.expand_path(filename, __dir__)
examples = YAML.load_file(filepath)

RSpec.context "when testing against #{filename}" do
  examples.each do |example|
    context "when example '#{example["name"]}'" do
      subject(:type_id) { TypeID.from_string(example["typeid"]) }

      it example["description"] do
        expect { type_id }.to raise_error TypeID::Error
      end
    end
  end
end
