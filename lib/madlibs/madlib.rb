require 'active_support/inflector'
require 'madlibs/template'
require 'madlibs/dictionary'

module Madlibs
  class Madlib
    attr_accessor :template
    attr_reader   :dictionary

    def initialize template = '', dictionary_hash = {}
      self.template = template
      self.dictionary = dictionary_hash
    end

    def dictionary=(hash)
      @dictionary = Dictionary.new hash
    end

    def generate
      @dictionary.reload
      Template.process_word_lists(
        Template.process_optionals(
          Template.keys(@template).reduce(@template) do |temp, key|
            Template.process_key temp, key, @dictionary.retrieve(key.pluralize)
          end
        )
      )
    end
  end
end
