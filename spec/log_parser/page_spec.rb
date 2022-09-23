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

  describe '#==' do
    subject { super().== other }

    context 'when other page path is different' do
      let(:other) { described_class.new(path: '/other-site', visit_logs: []) }

      it 'returns false' do
        expect(subject).to eq false
      end
    end

    context 'when other page path is the same' do
      let(:other) { described_class.new(path: path, visit_logs: []) }

      it 'returns true' do
        expect(subject).to eq true
      end
    end
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
