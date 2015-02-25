# -*- coding: utf-8 -*-
require 'natto'

module RNlp
  class Tf
    # compatible with ja or en
    attr_reader :lang
    def initialize(lang)
      @lang = lang
      unless lang == 'ja' || lang == 'en'
        puts "lang #{@lang} is not compatible."
        exit
      end
    end
    def count(text)
      tf = Hash.new
      if @lang == 'ja'
        nm = Natto::MeCab.new
        text.split("\n").each do |line|
          nm.parse(line) do |word|
            next if word.stat == 3
            if tf[word.surface] == nil
              tf[word.surface] = 1
            else
              tf[word.surface] += 1
            end
          end
        end
      elsif @lang == 'en'
        text.split("\n").each do |line|
          line.split(" ").each do |word|
            if tf[word] == nil
              tf[word] = 1
            else
              tf[word] += 1
            end
          end
        end
      end
      return tf
    end
  end
end
