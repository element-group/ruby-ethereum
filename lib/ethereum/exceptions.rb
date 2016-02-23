# -*- encoding : ascii-8bit -*-

module Ethereum
  class ChecksumError < StandardError; end
  class FormatError < StandardError; end
  class ValidationError < StandardError; end

  class InvalidTransaction < ValidationError; end
  class InvalidPrivateKey < ValidationError; end
end
