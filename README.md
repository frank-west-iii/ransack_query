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
and chainable
    
    RansackQuery.build do |grouping|
      grouping.add_condition(Condition.new(attribute: 'first_name', value: 'Bob')).
        add_condition(Condition.new(attribute: 'last_name', value: 'Smith', predicate: :not_eq))
    end
and with arrays
    
    RansackQuery.build do |grouping|
      conditions = []
      conditions << Condition.new(attribute: 'first_name', value: 'Bob')
      conditions << Condition.new(attribute: 'last_name', value: 'Smith', predicate: :not_eq)
      grouping.add_conditions(conditions)
    end
and with blocks

    RansackQuery.build do |grouping|
      grouping.add_condition do |condition|
        condition.attribute = 'first_name'
        condition.value = 'Bob'
        condition.predicate = :eq
      end
      grouping.add_condition do |condition|
        condition.attribute = 'last_name'
        condition.value = 'Smith'
        condition.predicate = :not_eq
      end
    end


All Produce the following output in json (with different ids):

    {
        "g" => {
            "90eb39b79709822408ca45f551532893" => {
                "m" => "and",
                "c" => {
                    "2bd58799fb5e609164d9a9fa674075e9" => {
                        "a" => {
                            "0" => {
                                "name" => "first_name"
                            }
                        },
                        "p" => "eq",
                        "v" => {
                            "0" => {
                                "value" => "Bob"
                            }
                        }
                    },
                    "7a6d5f805afbfeccf51be1f6eaaadecb" => {
                        "a" => {
                            "0" => {
                                "name" => "last_name"
                            }
                        },
                        "p" => "not_eq",
                        "v" => {
                            "0" => {
                                "value" => "Smith"
                            }
                        }
                    }
                }
            }
        }
    }
             
     
and passing the following options hash to build
    
    RansackQuery.build(prefix: 'q')
    
will produce the following in json 

    {
        "q" => {
            "g" => {
                "8b489d7ae7573fca7bb7ee9762dfb254" => {
                    "m" => "and",
                    "c" => {
                        "9a8c44777d17ba6bea0f9257415fb1aa" => {
                            "a" => {
                                "0" => {
                                    "name" => "first_name"
                                }
                            },
                            "p" => "eq",
                            "v" => {
                                "0" => {
                                    "value" => "Bob"
                                }
                            }
                        },
                        "7d0cee690a16e90db20318070f0841f6" => {
                            "a" => {
                                "0" => {
                                    "name" => "last_name"
                                }
                            },
                            "p" => "not_eq",
                            "v" => {
                                "0" => {
                                    "value" => "Smith"
                                }
                            }
                        }
                    }
                }
            }
        }
    }    
     
A more complex example with arrays and subgroups

    RansackQuery.build do |grouping|
      grouping.combinator = :or
      grouping.add_condition do |condition|
        condition.attribute = 'first_name'
        condition.value = 'Bob'
      end

      grouping.add_grouping do |new_grouping|
        new_grouping.add_condition do |condition|
          condition.attribute = 'last_name'
          condition.value = 'Smith'
        end
        new_grouping.add_condition do |condition|
          condition.attribute = 'state'
          condition.value = %w(CA TX NY)
        end
      end
    end
Will produce:    

    {
        "g" => {
            "05fdf6e8a730331872050faf8856501e" => {
                "m" => "or",
                "c" => {
                    "bbd1916d8afe8c6def686041ad5ab167" => {
                        "a" => {
                            "0" => {
                                "name" => "first_name"
                            }
                        },
                        "p" => "eq",
                        "v" => {
                            "0" => {
                                "value" => "Bob"
                            }
                        }
                    }
                },
                "g" => {
                    "4e3e3095f1caf8f3479b49f394fe42d6" => {
                        "m" => "and",
                        "c" => {
                            "023e5b5ff8384f474372c3f3ee8e666d" => {
                                "a" => {
                                    "0" => {
                                        "name" => "last_name"
                                    }
                                },
                                "p" => "eq",
                                "v" => {
                                    "0" => {
                                        "value" => "Smith"
                                    }
                                }
                            },
                            "df4731b72af62b2788c4428a59aef4d3" => {
                                "a" => {
                                    "0" => {
                                        "name" => "state"
                                    }
                                },
                                "p" => "eq",
                                "v" => {
                                    "0" => {
                                        "value" => "CA"
                                    },
                                    "1" => {
                                        "value" => "TX"
                                    },
                                    "2" => {
                                        "value" => "NY"
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

## Contributing

1. Fork it ( https://github.com/frank-west-iii/ransack_query/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
