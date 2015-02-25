# -*- coding: utf-8 -*-

module RNlp
  class Idf
    # compatible with ja or en
    attr_reader :lang
    def initialize(lang)
      @lang = lang
      unless lang == 'ja' || lang == 'en'
        puts "#{@lang} is not compatible language\nlang should be 'ja' or 'en'"
        exit
      end
    end
    # documents should be array of string
    def calc_idf(word, documents)
      @word = word
      @documents = documents
      n = @documents.size
      df = 0.0
      @documents.each do |document|
        df += 1 if document =~ /#{@word}/
      end
      idf = Math.log2(n/df) + 1
      return idf
    end
  end
end
