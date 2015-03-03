# -*- encoding: utf-8 -*-

require 'natto'

module RNlp
  # it copes only with Japanese
  class Tokenize
    def tokenize(input)
      natto = Natto::MeCab.new
      # array for token
      token = Array.new
      # make morphological analysis
      natto.parse(input) do |n|
        # word surface and word speech tag
        surface = n.surface
        tag = n.feature.split(',')[0]
        # 単語が(.||。)の場合は['。', '記号']をpush, それ以外の場合は単語の表出系と品詞タグをpush
        if tag == '助動詞'
          token[token.size-1][0] += surface
        else
          (surface != nil) ? token.push([surface, tag]) : token.push(['。', '記号']) if(surface != '。' && surface != '.')
        end
      end
      if token[token.size-1][0] == '。'
        token.pop
      end
      return token
    end
  end
end
