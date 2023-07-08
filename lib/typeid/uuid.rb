require "uuid7"
require_relative "./uuid/base32.rb"

class TypeID < String
  # Represents a UUID. Can be treated as a string.
  class UUID < String
    # @return [Array<Integer>]
    attr_reader :bytes

    # Utility method to generate a timestamp as milliseconds since the Unix epoch.
    #
    # @return [Integer]
    def self.timestamp
      Process.clock_gettime(Process::CLOCK_REALTIME, :millisecond)
    end

    # Generates a new +UUID+, using UUID7.
    #
    # @param timestamp [Integer] milliseconds since the Unix epoch
    # @return [TypeID::UUID]
    def self.generate(timestamp: self.class.timestamp)
      from_string(UUID7.generate(timestamp: timestamp))
    end

    # Parses a +UUID+ from a base32 string.
    #
    # @param string [String]
    # @return [TypeID::UUID]
    def self.from_base32(string)
      new(TypeID::UUID::Base32.decode(string))
    end

    # @param string [String]
    # @return [TypeID::UUID]
    def self.from_string(string)
      bytes = string
        .tr("-", "")
        .chars
        .each_slice(2)
        .map { |pair| pair.join.to_i(16) }

      new(bytes)
    end

    # @param bytes [Array<Integer>]
    def initialize(bytes)
      @bytes = bytes

      super(string)
    end

    # @return [String]
    def base32
      TypeID::UUID::Base32.encode(bytes)
    end

    # @return [String]
    def inspect
      "#<#{self.class.name} #{to_s}>"
    end

    private

    # @return [String]
    def string
      bytes
        .map
        .with_index { |byte, index| ([4, 6, 8, 10].include?(index) ? "-%02x" : "%02x") % byte }
        .join
    end
  end
end
