# RansackQuery

This gem provides a semantic way of building advanced ransack queries outside of using the form.

This was built because we needed a quick way to build queries to pass to ransack using the console.

## Installation

Add this line to your application's Gemfile:

    gem 'ransack_query'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ransack_query

## Usage

Simple Usage:

    RansackQuery.build do |grouping|
      grouping.add_condition(Condition.new(attribute: 'first_name', value: 'Bob'))
      grouping.add_condition(Condition.new(attribute: 'last_name', value: 'Smith', predicate: :not_eq))
    end

Output:

    {"g":
        {"c86f8acf5e99b7faa46c6957cf1a976c":
            {"m":"and","c":
                {"54b696949fc4e144fce7f5a56610322a":
                    {"a":{"0":{"name":"first_name"}},"p":"eq","v":{"0":{"value":"Bob"}}},
                 "f83cf261b8c700bb3508909e37c79f1e":
                    {"a":{"0":{"name":"last_name"}},"p":"not_eq","v":{"0":{"value":"Smith"}}}
                 }
             }
         }
     }"
     


## Contributing

1. Fork it ( https://github.com/[my-github-username]/ransack_query/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
