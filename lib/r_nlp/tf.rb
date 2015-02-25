# -*- coding: utf-8 -*-
require 'natto'

module RNlp
  class Tf
    # compatible with ja or en
    attr_reader :lang
    def initialize(lang)
      @lang = lang
    end
    def count(text)
      tf = Hash.new
      if @lang == 'ja'
        nm = Natto::MeCab.new
        text.each do |line|
          nm.parse(title).each do |word|
            tf[word.surface] = 1 if tf[word.surface] == nil
            tf[word.surface] += 1
          end
        end
      elsif @lang == 'en'
        text.each do |line|
          line.split(" ").each do |word|
            tf[word] = 1 if tf[word] == nil
            tf[word] += 1
          end
        end
      else
        puts "lang #{@lang} is not compatible."
        exit
      end
      return tf
    end
  end
end
