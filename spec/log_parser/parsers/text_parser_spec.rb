# frozen_string_literal: true

describe LogParser::Parsers::TextParser do
  subject { described_class.new(log_text).call }

  let(:log_text) do
    "/home 123.123.123.123\n/menu 321.321.321.321"
  end

  it 'returns an array of visit logs' do
    expect(subject).to eq [
                            LogParser::VisitLog.new(path: '/home', ip_address: '123.123.123.123'),
                            LogParser::VisitLog.new(path: '/menu', ip_address: '321.321.321.321')
                          ]
  end

  context 'when the log is empty' do
    let(:log_text) { '' }

    it 'returns an empty array' do
      expect(subject).to eq []
    end
  end
end
