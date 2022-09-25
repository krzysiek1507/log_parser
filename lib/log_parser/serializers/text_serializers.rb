# frozen_string_literal: true

module LogParser
  module Serializers
    class TextSerializer
      PAGE_VIEWS_HEADER = 'Pages ordered descending by page views'
      UNIQUE_PAGE_VIEWS_HEADER = 'Pages ordered descending by unique page views'

      def initialize(aggregator)
        @aggregator = aggregator
      end

      def call
        PAGE_VIEWS_HEADER + "\n" + by_page_views +
          "\n\n#{UNIQUE_PAGE_VIEWS_HEADER}\n" + by_unique_page_views
      end

      private

      attr_reader :aggregator

      def by_page_views
        aggregator.ordered_by_page_views
                  .map { |page| "#{page.path} #{page.visit_count} visit(s)" }
                  .join("\n")
                  .then { |text| text.empty? ? 'No visits' : text }
      end

      def by_unique_page_views
        aggregator.ordered_by_unique_page_views
                  .map { |page| "#{page.path} #{page.unique_visit_count} unique view(s)" }
                  .join("\n")
                  .then { |text| text.empty? ? 'No visits' : text }
      end
    end
  end
end
