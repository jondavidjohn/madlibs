# Madlibs

This gem simply takes a template, does some randomizing, applies a dictionary,
and produces a string.  Depending on the dictionary, it can be quite humorous.

## Usage

### The Dictionary

The dictionary is a simple ruby hash with keyed arrays of words, but there are
a few rules.

  1. Make sure your keys are plural

Ok, so maybe there is just that one.

### The Template

The template has 3 main syntax entities

#### Keys

Very simply, `<key>` signifies it to do a random replace from the correlated
dictionary, the name of the key is arbitrary as long as it is singular in the
template and plural in the dictionary.

For example `<key>` would match the `keys` dictionary hash key.

You are ensured that you won't get the same word twice in a single generation.

#### Optionals

Wrapping any segment of text in parenthesis immediately followed by a `?` will
make the generation randomly include or exclude the inner text.  And yes, they
can be nested.

```rb
"This is a(n example)? template."
```

Will result in either

```rb
"This is a template."
```

or

```rb
"This is an example template."
```

#### Word Lists

Lastly, for another element of randomness, you can provide a word list that it
will choose from at random.

```rb
"This is a (great|terrible) example."
```

Will result in either

```rb
"This is a great example."
```

or

```rb
"This is a terrible example."
```

This can be useful for creating more entropy from a set of common small
interchangeable words.

```rb
"(the|a|some|one)"
```

### Full Example

```rb
require 'madlibs'

# Create a new Madlib object, passing a template and a dictionary.  You can also
# pass nothing and assign them after the fact with `.dictionary` and `.template`
madlib = Madlibs::Madlib.new(
  'I will <verb> (the|another)( <adjective>)? <noun>',
  {
    "nouns" => [
      "proxy",
      "cache",
      "architecture",
      "fragmentation",
    ],
    "verbs" => [
      "refactor",
      "implement",
      "replicate",
      "debug",
    ],
    "adjectives" => [
      "distributed",
      "imperative",
      "virtualized",
    ]
  }
)

# Generate your string(s)

madlib.generate
# => "I will debug the architecture"

madlib.generate
# => "I will implement another imperative cache"

madlib.generate
# => "I will refactor another virtualized proxy"
```

## Installation

Add this line to your application's Gemfile:

    gem 'madlibs'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install madlibs

## Development

    rake test
    rake build
    rake install


