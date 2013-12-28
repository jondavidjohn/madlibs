require 'active_support/inflector'

module Madlibs
  class Madlib

    def initialize template, dictionary = nil
      @template = template
      unless dictionary.nil?
        @dictionary = dictionary.clone
        @original_dictionary = dictionary.clone
      end
    end

    def load dictionary
      @original_dictionary = dictionary.clone
      @dictionary = dictionary.clone
    end

    def reload
      @dictionary = @original_dictionary.clone
    end

    def retrieve type
      types = type.pluralize
      @dictionary[types].delete @dictionary[types].sample
    end

    def extract_keys template
      template.scan(/<([^>]*?)>/).flatten
    end

    def extract_word_lists template
      template.scan(/\([|a-zA-Z]*\)/)
    end

    def generate
      reload

      product = @template.clone

      extract_word_lists(product).each do |words|
        product.gsub! words, words.gsub(/[()]/, '').split('|').sample
      end

      loop do
        optionals = product.scan(/\([^\(]*?\)(?=\?)/)
        break unless optionals.any?
        optionals.each do |o|
          if [true, false].sample
            used_string = o.gsub(/[()]/, '')
            product.sub! "#{o}?", used_string
          else
            product.sub! "#{o}?", ''
          end
        end
      end

      extract_keys(product).each do |key|
        product.sub! "<#{key}>", retrieve(key)
      end

      product
    end
  end
end
