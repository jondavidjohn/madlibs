module Madlibs
  module Template

    def self.keys template
      template.scan(/<([^>]*?)>/).map do |key|
        key.first
      end
    end

    def self.process_key template, key, value
      template.sub "<#{key}>", value
    end

    def self.process_word_lists template
      template.scan(/\([|a-zA-Z]*\)/).reduce(template) do |temp, words|
        temp.sub words, words.gsub(/[()]/, '').split('|').sample
      end
    end

    def self.process_optionals template
      loop do
        optionals = template.scan(/\([^\(]*?\)(?=\?)/)
        break if optionals.empty?
        template = optionals.reduce(template) do |temp, opt|
          temp.sub(
            "#{opt}?",
            if [true, false].sample then opt.gsub(/[()]/, '') else '' end
          )
        end
      end
      template
    end
  end
end
