module Dotenv
  # This class inherits from Hash and represents the environment into which
  # Dotenv will load key value pairs from a file.
  class Environment < Hash
    attr_reader :filename, :parser

    def initialize(filename, is_load = false, parser = Parser)      
      @filename = filename
      @parser = parser
      load(is_load)
    end

    def load(is_load = false)
      update parser.call(read, is_load)
    end

    def read
      File.open(@filename, "rb:bom|utf-8", &:read)
    end

    def apply
      each { |k, v| ENV[k] ||= v }
    end

    def apply!
      each { |k, v| ENV[k] = v }
    end
  end
end
