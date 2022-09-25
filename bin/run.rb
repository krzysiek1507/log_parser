#!/usr/bin/ruby

# frozen_string_literal: true

require_relative '../lib/log_parser'

visit_logs = LogParser::Parsers::TextParser.new(File.read(ARGV.first)).call
aggregator = LogParser::Aggregators::PageVisitAggregator.new(visit_logs)

puts LogParser::Serializers::TextSerializer.new(aggregator).call
