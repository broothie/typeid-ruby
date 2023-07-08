# TypeID Ruby

### A Ruby implementation of [TypeIDs](https://github.com/jetpack-io/typeid)

[![Gem Version](https://badge.fury.io/rb/typeid.svg)](https://badge.fury.io/rb/typeid)
[![Main](https://github.com/broothie/typeid-ruby/actions/workflows/main.yml/badge.svg)](https://github.com/broothie/typeid-ruby/actions/workflows/main.yml)
[![codecov](https://codecov.io/gh/broothie/typeid-ruby/branch/main/graph/badge.svg?token=9XjyMNIb4z)](https://codecov.io/gh/broothie/typeid-ruby)
[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

TypeIDs are a modern, **type-safe**, globally unique identifier based on the upcoming
UUIDv7 standard. They provide a ton of nice properties that make them a great choice
as the primary identifiers for your data in a database, APIs, and distributed systems.
Read more about TypeIDs in their [spec](https://github.com/jetpack-io/typeid).

This particular implementation provides a Ruby library for generating and parsing TypeIDs.

## Installation

### If using bundler

```shell
bundle add typeid
```

### If not

```shell
gem install typeid
```

## Usage

```ruby
require "typeid"                        #=> true

id = TypeID.new("user")                 #=> #<TypeID user_01h46z1k2cf2av8mp4r7we4697>
id.to_s                                 #=> user_01h46z1k2cf2av8mp4r7we4697

other_id = TypeID.from_string(id.to_s)  #=> #<TypeID user_01h46z1k2cf2av8mp4r7we4697>
id == other_id                          #=> true
```

## Attributions

This gem depends on [uuid7](https://github.com/sprql/uuid7-ruby) by [sprql](https://github.com/sprql).
