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
          'g' => {
              1 => {
                  'm' => 'or',
                  'g' => {
                      'id2' => {
                          'm' => 'and',
                          'c' => {
                              'id3' => {
                                  'a' => {
                                      '0' => {
                                          'name' => 'ItemNumber'
                                      }
                                  },
                                  'p' => 'eq',
                                  'v' => {
                                      '0' => {
                                          'value' => 'RC'
                                      }
                                  }
                              },
                              'id4' => {
                                  'a' => {
                                      '0' => {
                                          'name' => 'LocationCode'
                                      }
                                  },
                                  'p' => 'eq',
                                  'v' => {
                                      '0' => {
                                          'value' => '002'
                                      }
                                  }
                              }
                          }
                      }
                  }
              }
          }
      } }
  end

end