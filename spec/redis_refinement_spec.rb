# Integration tests for now.
# That means, to run these tests you'll need
# a redis server with the redistimeseries.so
# module loaded.
using Redistimeseries::RedisRefinement

RSpec.describe Redistimeseries::RedisRefinement do
  let(:client) { Redis.new }
  let(:key) { (rand * 10**10).to_i.to_s(32) }
  # ts_create(key:, retention: nil, uncompressed: false, labels: [])
  describe "ts_create" do
    it "creates a timeseries" do
      client.ts_create(key: key)
      info = client.ts_info(key: key)
      expect(info.first).to eq("totalSamples")
    end
  end

  describe "ts_add" do
    before { client.ts_create(key: key) }
    it "adds to a timeseries" do
      client.ts_add(key: key, value: 1)
      # BUG
      sleep 0.01 # BUG IN redistimeseries.so or redis-rb
      # using * as timestamp, we shouldn't get the error:
      # TSDB: Timestamp cannot be older than the latest timestamp in the time series
      # but we do
      client.ts_add(key: key, value: 1)
      expect(client.ts_range(key: key, count: 2).size).to eq(2)
    end
  end
end
