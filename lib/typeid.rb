require_relative "./typeid/uuid.rb"

class TypeID < String
  SUFFIX_LENGTH = 26
  MAX_PREFIX_LENGTH = 63

  class Error < StandardError; end

  attr_reader :prefix
  attr_reader :suffix
  alias type prefix

  # @param string [String]
  # @return [TypeID]
  def self.from_string(string)
    case string.split("_")
    in [suffix] then from("", suffix)
    in [prefix, suffix]
      raise Error, "prefix cannot be empty when there's a separator" if prefix.empty?

      from(prefix, suffix)
    else raise Error, "invalid typeid: #{string}"
    end
  end

  # @param prefix [String]
  # @param uuid [String]
  # @return [TypeID]
  def self.from_uuid(prefix, uuid)
    from(prefix, TypeID::UUID.from_string(uuid).base32)
  end

  # @param prefix [String]
  # @param suffix [String]
  # @return [TypeID]
  def self.from(prefix, suffix)
    new(prefix, suffix: suffix)
  end

  # @return [TypeID]
  def self.nil
    from("", "0" * SUFFIX_LENGTH)
  end

  # @param prefix [String]
  # @param timestamp [Integer]
  # @param suffix [String]
  def initialize(
    prefix,
    timestamp: Process.clock_gettime(Process::CLOCK_REALTIME, :millisecond),
    suffix: TypeID::UUID.generate(timestamp: timestamp).base32
  )
    raise Error, "prefix length cannot be greater than #{MAX_PREFIX_LENGTH}" if prefix.length > MAX_PREFIX_LENGTH
    raise Error, "prefix must be lowercase ASCII characters" unless prefix.match?(/^[a-z]*$/)
    raise Error, "suffix must be #{SUFFIX_LENGTH} characters" unless suffix.length == SUFFIX_LENGTH
    raise Error, "suffix must only contain the letters in '#{TypeID::UUID::Base32::ALPHABET}'" unless suffix.chars.all? { |char| TypeID::UUID::Base32::ALPHABET.include?(char) }
    raise Error, "suffix must start with a 0-7 digit to avoid overflows" unless ("0".."7").cover?(suffix.chars.first)

    @prefix = prefix
    @suffix = suffix

    super(string)
  end

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
