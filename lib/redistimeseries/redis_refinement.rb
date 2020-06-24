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

      # Usage:
      # ts_madd([key, timestamp, value, key, timestamp, value])
      # or ts_madd([[key, timestamp, value], [key, timestamp, value]])
      def ts_madd(key_timestamp_values)
        cmd = ['TS.MADD', *key_timestamp_values.flatten]
        _ts_call(cmd)
      end

      def ts_incrby; end

      def ts_decrby; end

      def ts_createrule(source_key:, dest_key:, aggregation_type:, timebucket:)
        cmd = ["TS.CREATERULE", source_key, dest_key]
        cmd += ["AGGREGATION", aggregation_type, timebucket]
        _ts_call(cmd)
      end

      def ts_deleterule; end

      def ts_range(key:, from: '-', to: '+', count: nil, aggtype: nil, timebucket: nil)
        cmd = ['TS.RANGE', key, from, to]
        cmd += ['COUNT', count] if count
        cmd += ['AGGREGATION', aggtype, timebucket] if aggtype && timebucket
        _ts_call(cmd)
      end

      def ts_mrange(from_timestamp:, to_timestamp:,
                    aggregation_type: nil, time_bucket: nil,
                    count: nil, with_labels: false, filters: [])

        cmd = ["TS.MRANGE", from_timestamp, to_timestamp]
        cmd += ["COUNT", count] if count

        if aggregation_type && time_bucket
          cmd += ["AGGREGATION", aggregation_type, time_bucket]
        end

        cmd += ["WITHLABELS"] if with_labels
        cmd += ["FILTER", *filters] if filters.length.positive?

        _ts_call(cmd)
      end

      def ts_get(key)
        cmd = ["TS.GET", key]
        _ts_call(cmd)
      end

      def ts_mget(filters:, withlabels: false)
        cmd = []
        cmd += ["WITHLABELS"] if withlabels
        cmd += ["FILTER", *filters]
        _ts_call(cmd)
      end

      def ts_info(key:)
        cmd = ["TS.INFO", key]
        _ts_call(cmd)
      end

      def ts_queryindex(filters:)
        cmd = ["TS.QUERYINDEX", *filters]
        _ts_call(cmd)
      end

      def _ts_call(args)
        # puts "CMD #{cmd.join(' ')}"
        synchronize do |client|
          res = client.call(args)
          raise res.first if res.is_a?(Array) && res.first.is_a?(Redis::CommandError)

          res
        end
      end
    end
  end
end
