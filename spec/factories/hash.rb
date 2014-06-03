# encoding: utf-8

FactoryGirl.define do

  factory :condition_hash, class: Hash do
    skip_create
    initialize_with {
      {
          1 => {
              'a' => {
                  '0' => {
                      'name' => 'attribute'
                  }
              },
              'p' => 'eq',
              'v' => {
                  '0' => {
                      'value' => 'value'
                  }
              }
          }
      } }
  end

  factory :grouping_hash, class: Hash do
    skip_create
    initialize_with {
      {
          'ransack_group_1' => {
              1 => {
                  'm' => 'or',
                  'ransack_group_2' => {
                      2 => {
                          'm' => 'and',
                          'c' => {
                              2 => {
                                  'a' => {
                                      '0' => {
                                          'name' => 'first_name'
                                      }
                                  },
                                  'p' => 'eq',
                                  'v' => {
                                      '0' => {
                                          'value' => 'Bob'
                                      }
                                  }
                              },
                              3 => {
                                  'a' => {
                                      '0' => {
                                          'name' => 'last_name'
                                      }
                                  },
                                  'p' => 'eq',
                                  'v' => {
                                      '0' => {
                                          'value' => 'Smith'
                                      }
                                  }
                              }
                          }
                      }
                  },
                  'ransack_group_3' => {
                      3 => {
                          'm' => 'and',
                          'c' => {
                              2 => {
                                  'a' => {
                                      '0' => {
                                          'name' => 'first_name'
                                      }
                                  },
                                  'p' => 'eq',
                                  'v' => {
                                      '0' => {
                                          'value' => 'Bob'
                                      }
                                  }
                              },
                              3 => {
                                  'a' => {
                                      '0' => {
                                          'name' => 'last_name'
                                      }
                                  },
                                  'p' => 'eq',
                                  'v' => {
                                      '0' => {
                                          'value' => 'Smith'
                                      }
                                  }
                              }
                          }
                      }
                  }
              }
          }
      }
    }
  end

end