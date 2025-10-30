# frozen_string_literal: true
require "nkf"

module CsvEncodingHelper
  class Decoder
    def self.decode(raw_bytes)
      text = nil

      if raw_bytes.start_with?("\xFF\xFE".b)
        text = raw_bytes.dup.force_encoding("UTF-16LE").encode("UTF-8", invalid: :replace, undef: :replace, replace: "")
      elsif raw_bytes.start_with?("\xFE\xFF".b)
        text = raw_bytes.dup.force_encoding("UTF-16BE").encode("UTF-8", invalid: :replace, undef: :replace, replace: "")
      end

      if text.nil? && utf16_without_bom?(raw_bytes)
        enc = likely_utf16_endianness(raw_bytes)
        text = raw_bytes.dup.force_encoding(enc).encode("UTF-8", invalid: :replace, undef: :replace, replace: "")
      end

      # --- Fallback for Shift_JIS, EUC-JP, ISO-2022-JP ---
      text ||= NKF.nkf("-w", raw_bytes)

      text
    end

    def self.utf16_without_bom?(bytes)
      sample = bytes.byteslice(0, 200)
      null_count = sample.count("\x00")
      null_count > 20
    end

    def self.likely_utf16_endianness(bytes)
      sample = bytes.byteslice(0, 200)
      even_nulls = sample.chars.each_slice(2).count { |a, _| a == "\x00" }
      odd_nulls  = sample.chars.each_slice(2).count { |_, b| b == "\x00" }
      even_nulls > odd_nulls ? "UTF-16BE" : "UTF-16LE"
    end
  end
end
