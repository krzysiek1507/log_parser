# frozen_string_literal: true

describe LogParser::VisitLog do
  subject { described_class.new(path: path, ip_address: ip_address) }

  let(:path) { '/home' }
  let(:ip_address) { '123.123.123.123' }

  describe '#==' do
    subject { super() == other }

    let(:other) { described_class.new(path: other_path, ip_address: other_ip_address) }

    context 'when the path and ip_address are the same' do
      let(:other_path) { path }
      let(:other_ip_address) { ip_address }

      it 'returns true' do
        expect(subject).to eq true
      end
    end

    context 'when the paths are different' do
      let(:other_path) { '/menu' }
      let(:other_ip_address) { ip_address }

      it 'returns false' do
        expect(subject).to eq false
      end
    end

    context 'when the ip_addresses are different' do
      let(:other_path) { path }
      let(:other_ip_address) { '222.222.222.222' }

      it 'returns false' do
        expect(subject).to eq false
      end
    end
  end
end
