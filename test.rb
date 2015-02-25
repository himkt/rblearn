require 'r_nlp'

a = RNlp::Tf.new('ja')
text = '私は誰だ'

p a.count(text)

b = RNlp::Tf.new('en')
text = 'who are you ?'

p b.count(text)

c = ['text 1 is hoge', 'text 2 is yeah', 'text 3 is hoge']

idf = RNlp::Idf.new('en')
p idf.calc_idf('hoge', c)

