# CsvEncodingHelper

A Ruby gem that automatically detects and converts CSV file encodings
(UTF-8, UTF-16LE/BE, Shift_JIS, EUC-JP, ISO-2022-JP) into UTF-8.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "csv_encoding_helper"
```

And then execute:

```
bundle install
```

Or install it yourself:

```
gem install csv_encoding_helper
```

## Usage

```
require "csv_encoding_helper"

file = File.binread("sjis.csv")
uft8_text = CsvEncodingHelper::Decoder.decode(file)
CSV.parse(utf8_text, headers: true)
```
