# frozen_string_literal: true

describe LogParser::Aggregators::PageVisitAggregator do
  subject { described_class.new visit_logs }

  let(:visit_logs) { home + menu + order }
  let(:home) do
    [
      LogParser::VisitLog.new(path: '/home', ip_address: '123.123.123.123'),
      LogParser::VisitLog.new(path: '/home', ip_address: '123.123.123.123'),
      LogParser::VisitLog.new(path: '/home', ip_address: '123.123.123.123'),
    ]
  end
  let(:menu) do
    [
      LogParser::VisitLog.new(path: '/menu', ip_address: '321.321.321.321'),
      LogParser::VisitLog.new(path: '/menu', ip_address: '321.321.321.321'),
    ]
  end
  let(:order) do
    [
      LogParser::VisitLog.new(path: '/order', ip_address: '321.321.321.301'),
      LogParser::VisitLog.new(path: '/order', ip_address: '321.321.321.302'),
      LogParser::VisitLog.new(path: '/order', ip_address: '321.321.321.302'),
      LogParser::VisitLog.new(path: '/order', ip_address: '321.321.321.304'),
      LogParser::VisitLog.new(path: '/order', ip_address: '321.321.321.305'),
    ]
  end

  describe '#ordered_by_page_views' do
    subject { super().ordered_by_page_views }

    it 'returns pages ordered by the page view count descending' do
      expect(subject).to eq [
                              LogParser::Page.new(path: '/order', visit_logs: order),
                              LogParser::Page.new(path: '/home', visit_logs: home),
                              LogParser::Page.new(path: '/menu', visit_logs: menu),
                            ]
    end

    context 'when multiple pages have the same page view count' do
      let(:visit_logs) { order + menu + home }

      let(:home) { [LogParser::VisitLog.new(path: '/home', ip_address: '123.123.123.123')] }
      let(:menu) { [LogParser::VisitLog.new(path: '/menu', ip_address: '321.321.321.321')] }
      let(:order) { [LogParser::VisitLog.new(path: '/order', ip_address: '321.321.321.301')] }

      it 'returns pages ordered by the page view count descending and then alphabetically' do
        expect(subject).to eq [
                                LogParser::Page.new(path: '/home', visit_logs: home),
                                LogParser::Page.new(path: '/menu', visit_logs: menu),
                                LogParser::Page.new(path: '/order', visit_logs: order),
                              ]
      end
    end
  end

  describe '#ordered_by_unique_page_views' do
    subject { super().ordered_by_unique_page_views }

    let(:home) do
      [
        LogParser::VisitLog.new(path: '/home', ip_address: '123.123.123.123'),
        LogParser::VisitLog.new(path: '/home', ip_address: '123.123.123.123'),
      ]
    end

    let(:menu) do
      [
        LogParser::VisitLog.new(path: '/menu', ip_address: '321.321.321.321'),
        LogParser::VisitLog.new(path: '/menu', ip_address: '321.321.321.322'),
      ]
    end

    it 'returns pages ordered by the unique page view count descending' do
      expect(subject).to eq [
                              LogParser::Page.new(path: '/order', visit_logs: order),
                              LogParser::Page.new(path: '/menu', visit_logs: menu),
                              LogParser::Page.new(path: '/home', visit_logs: home),
                            ]
    end

    context 'when multiple pages have the same page view count' do
      let(:visit_logs) { order + menu + home }

      let(:home) { [LogParser::VisitLog.new(path: '/home', ip_address: '123.123.123.123')] }
      let(:menu) { [LogParser::VisitLog.new(path: '/menu', ip_address: '321.321.321.321')] }
      let(:order) { [LogParser::VisitLog.new(path: '/order', ip_address: '321.321.321.301')] }

      it 'returns pages ordered by the unique page view count descending and then alphabetically' do
        expect(subject).to eq [
                                LogParser::Page.new(path: '/home', visit_logs: home),
                                LogParser::Page.new(path: '/menu', visit_logs: menu),
                                LogParser::Page.new(path: '/order', visit_logs: order),
                              ]
      end
    end
  end
end
