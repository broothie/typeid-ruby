require_relative "./typeid/uuid.rb"

# Represents a TypeID.
# Provides accessors to the underlying prefix, suffix, and UUID.
# Can be treated as a string.
#
# To generate a new +TypeID+:
#   TypeID.new("foo") #=> #<TypeID foo_01h4vjdvzefw18zfwz5dxw5y8g>
#
# To parse a +TypeID+ from a string:
#   TypeID.from_string("foo_01h4vjdvzefw18zfwz5dxw5y8g") #=> #<TypeID foo_01h4vjdvzefw18zfwz5dxw5y8g>
#
# To parse a +TypeID+ from a UUID:
#   TypeID.from_uuid("foo", "01893726-efee-7f02-8fbf-9f2b7bc2f910") #=> #<TypeID foo_01h4vjdvzefw18zfwz5dxw5y8g>
#
# To create a +TypeID+ from a timestamp (in milliseconds since the Unix epoch):
#   TypeID.new("foo", timestamp: 1688847445998) #=> #<TypeID foo_01h4vjdvzefw18zfwz5dxw5y8g>
class TypeID < String
  MAX_PREFIX_LENGTH = 63

  class Error < StandardError; end

  # @return [String]
  attr_reader :prefix

  # @return [String]
  attr_reader :suffix
  alias type prefix

  # Parses a +TypeID+ from a string.
  #
  # @param string [String] string representation of a +TypeID+
  # @return [TypeID]
  def self.from_string(string)
    case string.split("_")
    in [suffix]
      from("", suffix)

    in [prefix, suffix]
      raise Error, "prefix cannot be empty when there's a separator" if prefix.empty?

      from(prefix, suffix)
    else
      raise Error, "invalid typeid: #{string}"
    end
  end

  # Parses a +TypeID+ given a prefix and a raw UUID string.
  #
  # @param prefix [String]
  # @param uuid [String]
  # @return [TypeID]
  def self.from_uuid(prefix, uuid)
    from(prefix, TypeID::UUID.from_string(uuid).base32)
  end

  # Creates a +TypeID+ given a prefix string and a suffix string.
  #
  # @param prefix [String]
  # @param suffix [String]
  # @return [TypeID]
  def self.from(prefix, suffix)
    new(prefix, suffix: suffix)
  end

  # Returns the +nil+ TypeID.
  #
  # @return [TypeID]
  def self.nil
    @nil ||= from("", "0" * TypeID::UUID::Base32::ENCODED_STRING_LENGTH)
  end

  # Creates a +TypeID+ given a prefix and an optional suffix or timestamp (in milliseconds since the Unix epoch).
  # When given only a prefix, generates a new +TypeID+.
  # When +suffix+ or +timestamp+ is provided, creates a +TypeID+ from the given value.
  #
  # @param prefix [String]
  # @param timestamp [Integer] milliseconds since the Unix epoch
  # @param suffix [String] base32-encoded UUID
  def initialize(
    prefix,
    timestamp: TypeID::UUID.timestamp,
    suffix: TypeID::UUID.generate(timestamp: timestamp).base32
  )
    raise Error, "prefix length cannot be greater than #{MAX_PREFIX_LENGTH}" if prefix.length > MAX_PREFIX_LENGTH
    raise Error, "prefix must be lowercase ASCII characters" unless prefix.match?(/^[a-z]*$/)
    raise Error, "suffix must be #{TypeID::UUID::Base32::ENCODED_STRING_LENGTH} characters" unless suffix.length == TypeID::UUID::Base32::ENCODED_STRING_LENGTH
    raise Error, "suffix must only contain the letters in '#{TypeID::UUID::Base32::ALPHABET}'" unless suffix.chars.all? { |char| TypeID::UUID::Base32::ALPHABET.include?(char) }
    raise Error, "suffix must start with a 0-7 digit to avoid overflows" unless ("0".."7").cover?(suffix.chars.first)

    @prefix = prefix
    @suffix = suffix

    super(string)
  end

  # Returns the UUID component of the +TypeID+, parsed from the suffix.
  #
  # @return [TypeID::UUID]
  def uuid
    TypeID::UUID.from_base32(suffix)
  end

  # @return [String]
  def inspect
    "#<#{self.class.name} #{self}>"
  end

  private

  # @return [String]
  def string
    return suffix if prefix.empty?

    "#{prefix}_#{suffix}"
  end
end
