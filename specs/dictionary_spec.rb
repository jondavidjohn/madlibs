require 'minitest/spec'
require 'minitest/autorun'
require 'madlibs'

describe Madlibs::Dictionary do
  describe '#retrieve' do
    it 'should retrieve a random dictionary term in a given collection' do
      hash = {
        'things' => [
          'thing_one',
          'thing_two',
        ],
        'items' => [
          'item_one',
          'item_two',
          'item_three',
        ]
      }

      dictionary = Madlibs::Dictionary.new(hash)
      hash['things'].must_include dictionary.retrieve 'things'
      hash['items'].must_include dictionary.retrieve 'items'
    end

    it 'should retrieve random dictionary items only once' do
      dictionary = Madlibs::Dictionary.new({
        'items' => [
          'item_one',
          'item_two',
          'item_three',
        ]
      })

      retrieved = []
      retrieved.push dictionary.retrieve 'items'
      retrieved.push dictionary.retrieve 'items'
      retrieved.push dictionary.retrieve 'items'

      retrieved.size.must_be_same_as retrieved.uniq.size
    end

    it 'should retrieve empty string from empty dictionary collection' do
      dictionary = Madlibs::Dictionary.new({ 'items' => [ ] })
      dictionary.retrieve('items').must_equal 'lksjdf'
    end

    it 'should not mutate the provided hash'do
      hash = {
        'items' => [
          'item_one',
          'item_two',
          'item_three',
        ]
      }

      dictionary = Madlibs::Dictionary.new(hash)
      dictionary.retrieve 'items'
      dictionary.retrieve 'items'
      hash['items'].size.must_equal 3
    end
  end
end
