require 'minitest/spec'
require 'minitest/autorun'
require 'madlibs'

describe Madlibs::Template do
  describe '#keys' do
    it 'should extract simple keys' do
      keys = Madlibs::Template.keys '<simple> <keys>'
      keys.size.must_equal 2
      keys.must_include 'simple'
      keys.must_include 'keys'
    end

    it 'should extract keys from more complex templates' do
      keys = Madlibs::Template.keys '<simple> (some|words) (<keys>)?'
      keys.size.must_equal 2
      keys.must_include 'simple'
      keys.must_include 'keys'
    end
  end

  describe '#process_key' do
    it 'should put a value in place of a key' do
      result = Madlibs::Template.process_key '<simple> <keys>', 'simple', 'hello'
      result.must_equal 'hello <keys>'
    end
  end

  describe '#process_word_lists' do
    it 'should choose random words from word lists included in a template' do
      result = Madlibs::Template.process_word_lists '(simple) (simple|word|lists)'
      [ 'simple simple',
        'simple word',
        'simple lists' ].must_include result
    end

    it 'should choose random words from word lists included in a complex template' do
      result = Madlibs::Template.process_word_lists '<simple> (some|words) (<keys>)? (to|extract)'
      [ '<simple> some (<keys>)? to',
        '<simple> some (<keys>)? extract',
        '<simple> words (<keys>)? to',
        '<simple> words (<keys>)? extract' ].must_include result
    end
  end

  describe '#process_optionals' do
    it 'should choose to randomly include optional elements' do
      result = Madlibs::Template.process_optionals 'this is( really)?( very)? silly'
      [ 'this is really very silly',
        'this is very silly',
        'this is really silly',
        'this is silly' ].must_include result
    end

    it 'should choose to randomly include optional elements in complex templates' do
      result = Madlibs::Template.process_optionals '<simple> (some|words)( <keys>)? (to|extract)'
      [ '<simple> (some|words) <keys> (to|extract)',
        '<simple> (some|words) (to|extract)' ].must_include result
    end

    it 'should support the nesting of optionals' do
      result = Madlibs::Template.process_optionals 'this is( very( freaking)?)? cool'
      [ 'this is cool',
        'this is very cool',
        'this is very freaking cool' ].must_include result
    end
  end
end
