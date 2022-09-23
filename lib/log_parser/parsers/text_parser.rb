# frozen_string_literal: true

module LogParser
  module Parsers
    class TextParser
      def initialize(text)
        @text = text
      end

      def call
        text.split("\n").map do |line|
          path, ip_address = line.split

          ::LogParser::VisitLog.new path: path, ip_address: ip_address
        end
      end

      private

      attr_reader :text
    end
  end
end
