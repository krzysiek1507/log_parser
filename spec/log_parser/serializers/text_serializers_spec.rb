# frozen_string_literal: true

describe LogParser::Serializers::TextSerializer do
  subject { described_class.new(aggregator).call }

  let(:aggregator) do
    double LogParser::Aggregators::PageVisitAggregator,
           ordered_by_page_views: ordered_by_page_views,
           ordered_by_unique_page_views: ordered_by_unique_page_views
  end

  let(:ordered_by_page_views) do
    [
      double(LogParser::Page, path: '/home', visit_count: 123),
      double(LogParser::Page, path: '/order', visit_count: 15)
    ]
  end

  let(:ordered_by_unique_page_views) do
    [
      double(LogParser::Page, path: '/home', unique_visit_count: 12),
      double(LogParser::Page, path: '/order', unique_visit_count: 7)
    ]
  end

  it 'returns the text with the stats' do
    expect(subject).to eq "Pages ordered descending by page views\n" \
                            "/home 123 visit(s)\n" \
                            "/order 15 visit(s)\n" \
                            "\n" \
                            "Pages ordered descending by unique page views\n" \
                            "/home 12 unique view(s)\n" \
                            '/order 7 unique view(s)'

  end

  context 'when stats are not present' do
    let(:ordered_by_page_views) { [] }
    let(:ordered_by_unique_page_views) { [] }

    it 'returns the text with info about no stats' do
      expect(subject).to eq "Pages ordered descending by page views\n" \
                            "No visits\n" \
                            "\n" \
                            "Pages ordered descending by unique page views\n" \
                            'No visits'

    end
  end
end
