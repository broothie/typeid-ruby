# TypeID Ruby

A Ruby implementation of [TypeIDs](https://github.com/jetpack-io/typeid)

TypeIDs are a modern, **type-safe**, globally unique identifier based on the upcoming
UUIDv7 standard. They provide a ton of nice properties that make them a great choice
as the primary identifiers for your data in a database, APIs, and distributed systems.
Read more about TypeIDs in their [spec](https://github.com/jetpack-io/typeid).

This particular implementation provides a Ruby library for generating and parsing TypeIDs.

## Installation

```shell
gem install typeid-ruby
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
