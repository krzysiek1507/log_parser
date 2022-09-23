# frozen_string_literal: true

module LogParser
  class VisitLog
    attr_reader :ip_address, :path

    def initialize(path:, ip_address:)
      @ip_address = ip_address
      @path = path
    end

    def ==(other)
      @path == other.path && @ip_address == other.ip_address
    end
  end
end
