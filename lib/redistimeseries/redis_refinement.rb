# Redis Timeseries functions for the Redis gem
module Redistimeseries
  # refine the Redis class to add ts_* methods
  module RedisRefinement
    refine Redis do
      def ts_create(key:, retention: nil, uncompressed: false, labels: [])
        cmd = ['TS.CREATE', key]
        cmd += ['RETENTION', retention] if retention
        cmd += ['UNCOMPRESSED'] if uncompressed
        cmd += ['LABELS'] if labels.any?
        cmd += labels if labels.any?
        _ts_call(cmd)
      end

      def ts_add(key:, timestamp: "*", value:, retention: nil, labels: [])
        cmd = ['TS.ADD', key, timestamp, value]
        cmd += ['RETENTION', retention] if retention
        cmd += ['LABELS'] if labels.any?
        cmd += labels if labels.any?
        _ts_call(cmd)
      end

      def ts_madd(key:, timestamp: "*", value:) # TODO make multi
        cmd = ['TS.MADD', key, timestamp, value]
        _ts_call(cmd)
      end

      def ts_incrby; end

      def ts_decrby; end

      def ts_createrule; end

      def ts_deleterule; end

      def ts_range(key:, from: 0, to: nil, count: nil, aggtype: nil, timebucket: nil)
        to_time = to || (Time.now.to_f * 1000.0).to_i
        cmd = ['TS.RANGE', key, from, to_time]
        if count
          cmd += ['COUNT', count]
        else
          cmd += ['AGGREGATION', aggtype, timebucket]
        end
        _ts_call(cmd)
      end

      def ts_mrange; end
      def ts_get; end
      def ts_mget; end

      def ts_info(key:)
        cmd = ["TS.INFO", key]
        _ts_call(cmd)
      end

      def ts_queryindex(filter:)
        cmd = ["TS.QUERYINDEX", filter]
        _ts_call(cmd)
      end

      def _ts_call(cmd)
        # puts "CMD #{cmd.join(' ')}"
        call cmd
      end
    end
  end
end
