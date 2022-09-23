# frozen_string_literal: true

module LogParser
  class Page
    attr_reader :path, :visit_logs

    def initialize(path:, visit_logs: [])
      @path = path
      @visit_logs = visit_logs
    end

    def visit_count
      visit_logs.length
    end
  end
end
