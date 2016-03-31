# -*- encoding : ascii-8bit -*-

module Ethereum
  module Guardian

    class Bet

      class <<self
        def deserialize(betdata)
          params = ABI.decode_abi Casper.contract.function_data['submitBet']['encode_types'], betdata[4..-1]
          new(
            params[0], params[1],
            params[2].map {|p| Guardian.decode_prob(p) },
            params[3], params[4],
            params[5].map {|p| Guardian.decode_prob(p) },
            params[6], params[7], params[8]
          )
        end
      end

      attr_accessor :sig

      def initialize(index, max_height, probs, blockhashes, stateroots, stateroot_probs, prevhash, seq, sig)
        @index = index
        @max_height = max_height

        @probs = probs
        @blockhashes = blockhashes
        @stateroots = stateroots
        @stateroot_probs = stateroot_probs

        @prevhash = prevhash
        @seq = seq
        @sig = sig

        @hash = nil
      end

      def serialize
        o = Casper.contract.encode('submitBet', [
          @index, @max_height,
          @probs.map {|p| Guardian.encode_prob(p) }.join,
          @blockhashes, @stateroots,
          @stateroot_probs.map {|p| Guardian.encode_prob(p) }.join,
          @prevhash, @seq, @sig
        ])
        @hash = Utils.keccak256 o
        o
      end

      def full_hash(recompute: false)
        if !@hash || recompute
          serialize
        end
        @hash
      end

    end

  end
end
