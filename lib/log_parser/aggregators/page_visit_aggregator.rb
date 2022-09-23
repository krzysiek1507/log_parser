# frozen_string_literal: true

module LogParser
  module Aggregators
    class PageVisitAggregator
      def initialize(visit_logs)
        @visit_logs = visit_logs
      end

      def ordered_by_page_views
        @ordered_by_page_views ||= aggregate_pages.sort_by { |page| [-page.visit_count, page.path] }
      end

      def ordered_by_unique_page_views
        @ordered_by_unique_page_views ||= aggregate_pages.sort_by { |page| [-page.unique_visit_count, page.path] }
      end

      private

      def aggregate_pages
        @aggregate_pages ||= visit_logs
                               .group_by(&:path)
                               .map { |path, logs| ::LogParser::Page.new(path: path, visit_logs: logs) }
      end

      attr_reader :visit_logs
    end
  end
end
