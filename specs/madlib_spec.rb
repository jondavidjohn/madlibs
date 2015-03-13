require 'minitest/spec'
require 'minitest/autorun'
require 'madlibs'

describe Madlibs::Madlib do
  describe 'generate' do
    it 'should work' do
      madlib = Madlibs::Madlib.new(
        '(wow, )?such <noun>,( very <adjective>,)? so <verb>',
        {
          'nouns' => [
            'desk',
            'lamp',
          ],
          'adjectives' => [
            'neat',
            'fun',
          ],
          'verbs' => [
            'commit',
            'scare',
          ]
        }
      )

      [ 'such lamp, very neat, so commit',
        'wow, such lamp, very fun, so commit',
        'wow, such desk, very neat, so scare',
        'such desk, so scare',
        'wow, such lamp, so scare',
        'wow, such desk, very neat, so commit',
        'wow, such desk, very fun, so commit',
        'such desk, very neat, so commit',
        'wow, such desk, very fun, so scare',
        'such lamp, very fun, so commit',
        'wow, such desk, so commit',
        'such lamp, so commit',
        'such desk, so commit',
        'such lamp, very fun, so scare',
        'wow, such desk, so scare',
        'wow, such lamp, so commit',
        'such lamp, very neat, so scare',
        'wow, such lamp, very fun, so scare',
        'such lamp, so scare',
        'wow, such lamp, very neat, so scare',
        'such desk, very fun, so scare',
        'such desk, very neat, so scare',
        'wow, such lamp, very neat, so commit',
        'such desk, very fun, so commit' ].must_include madlib.generate
    end
  end
end
