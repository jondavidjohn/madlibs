require 'minitest/spec'
require 'minitest/autorun'
require 'madlibs'

describe Madlibs::Madlib do
  def assert_block(test_description, &block)
    assert test_description, yield
  end

  before do
    @mad = Madlibs::Madlib.new '', {
      "things" => [
        "thing_one",
        "thing_two",
        "thing_three",
      ],
      "items" => [
        "item_one",
        "item_two",
        "item_three",
      ]
    }
  end

  it "should accurately extract simple <keys>" do
    keys = @mad.extract_keys('<simple> <keys>')
    keys.size.must_equal 2
    assert_block "correct keys extracted" do
      keys.include? 'simple' and keys.include? 'keys'
    end
  end

  it "should accurately extract <keys> with other templating entities around" do
    keys = @mad.extract_keys('<simple> (some|words) (<keys>)?')
    keys.size.must_equal 2
    assert_block "correct keys extracted" do
      keys.include? 'simple' and keys.include? 'keys'
    end
  end

  it "should accurately extract simple (word|lists)" do
    keys = @mad.extract_word_lists('(simple) (simple|word|lists)')
    keys.size.must_equal 2
    assert_block "correct lists extracted" do
      keys.include? '(simple)' and keys.include? '(simple|word|lists)'
    end
  end

  it "should accurately extract (word|lists) with other templating entities around" do
    keys = @mad.extract_word_lists('<simple> (some|words) (<keys>)? (to|extract)')
    keys.size.must_equal 2
    assert_block "correct keys extracted" do
      keys.include? '(some|words)' and keys.include? '(to|extract)'
    end
  end

  it "should retrieve random dictionary items only once" do
    retrieved = []
    retrieved.push @mad.retrieve 'item'
    retrieved.push @mad.retrieve 'item'
    retrieved.push @mad.retrieve 'item'

    retrieved.size.must_be_same_as retrieved.uniq.size

    @mad.retrieve('item').must_be_nil
  end

end
