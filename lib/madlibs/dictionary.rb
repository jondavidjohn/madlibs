module Madlibs
  class Dictionary

    def initialize hash
      # deep clone to prevent side-effects
      @hash = Marshal.load(Marshal.dump(hash))
      @hash_clone = Marshal.load(Marshal.dump(hash))
    end

    def retrieve type
      return '' if @hash[type].nil? or @hash[type].empty?
      @hash[type].delete @hash[type].sample
    end

    def reload
      @hash = Marshal.load(Marshal.dump(@hash_clone))
    end
  end
end
