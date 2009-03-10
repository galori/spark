require 'test/unit'
require '../lib/spark'

class SparkTest < Test::Unit::TestCase
  
  include Spark::Mixins
  
  def test_this_plugin
    puts random_email
  end
end
