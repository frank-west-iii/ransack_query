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
          1 => {
              'm' => 'or',
              'g' => {
                  2 => {
                      'm' => 'and',
                      'c' => {
                          2 => {
                              'a' => {
                                  '0' => {
                                      'name' => 'document_number'
                                  }
                              },
                              'p' => 'eq',
                              'v' => {
                                  '0' => {
                                      'value' => '111'
                                  }
                              }
                          },
                          3 => {
                              'a' => {
                                  '0' => {
                                      'name' => 'driver_name'
                                  }
                              },
                              'p' => 'eq',
                              'v' => {
                                  '0' => {
                                      'value' => '222'
                                  }
                              }
                          }
                      }
                  },
                  3 => {
                      'm' => 'and',
                      'c' => {
                          2 => {
                              'a' => {
                                  '0' => {
                                      'name' => 'document_number'
                                  }
                              },
                              'p' => 'eq',
                              'v' => {
                                  '0' => {
                                      'value' => '111'
                                  }
                              }
                          },
                          3 => {
                              'a' => {
                                  '0' => {
                                      'name' => 'driver_name'
                                  }
                              },
                              'p' => 'eq',
                              'v' => {
                                  '0' => {
                                      'value' => '222'
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