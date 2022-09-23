# frozen_string_literal: true

describe LogParser::Page do
  subject { described_class.new(path: path, visit_logs: visit_logs) }

  let(:path) { '/home' }
  let(:visit_logs) do
    [
      LogParser::VisitLog.new(path: '/home', ip_address: '123.123.123.123'),
      LogParser::VisitLog.new(path: '/home', ip_address: '111.111.111.111'),
      LogParser::VisitLog.new(path: '/home', ip_address: '111.111.111.111'),
    ]
  end

  describe '#unique_visit_count' do
    subject { super().unique_visit_count }

    it 'returns the number of visit counts' do
      expect(subject).to eq 2
    end
  end

  describe '#visit_count' do
    subject { super().visit_count }

    it 'returns the number of all visits' do
      expect(subject).to eq 3
    end
  end
end
