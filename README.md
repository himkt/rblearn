# RNlp

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/r_nlp`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'r_nlp'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install r_nlp

## Usage

### Term Frequency(tf)

```ruby
a = RNlp::Tf.new('ja')
text = '私は誰だ'

p a.count(text)

b = RNlp::Tf.new('en')
text = 'who are you ?'

p b.count(text)
```

### Inverse Document Frequency(idf)

```ruby
c = ['text 1 is hoge', 'text 2 is yeah', 'text 3 is hoge']

idf = RNlp::Idf.new('en')
p idf.calc_idf('hoge', c)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/r_nlp/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
