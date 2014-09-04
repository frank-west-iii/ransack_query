require 'coveralls'
Coveralls.wear!

require 'pry'
require 'ransack_query'
require 'factory_girl'

Dir[('./spec/factories/**/*.rb')].each { |factory| require factory }

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end
