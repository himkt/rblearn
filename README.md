# Rblearn

[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE)
[![Website](https://img.shields.io/website-up-down-green-red/http/shields.io.svg?maxAge=2592000)](https://rubygems.org/gems/rblearn)
[![GitHub issues](https://img.shields.io/github/issues/himkt/rblearn.svg)](https://github.com/himkt/rblearn/issues)
[![GitHub stars](https://img.shields.io/github/stars/himkt/rblearn.svg)](https://github.com/himkt/rblearn/stargazers) 
[![GitHub release](https://img.shields.io/github/release/qubyte/rubidium.svg?maxAge=2592000)](https://github.com/himkt/rblearn) 
[![GitHub commits](https://img.shields.io/github/commits-since/SubtitleEdit/subtitleedit/3.4.7.svg?maxAge=2592000)](https://github.com/himkt/rblearn)

ruby-learn is a library for machine learning.

Now, we support cross-validation and feature extraction.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rblearn'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rblearn

## Usage

### Cross Validation

CrossValidation provides two features for cross-validation and train_test_split.

1. train_test_split

  This method splits your dataset into train\_set and test\_set.

  ```ruby
  x\_train, y\_train, x\_test, y\_test = Rblearn::CrossValidation.train_test_split(x, y, 0.7).map(&:dup)
  ```

2. K-Fold

  This method is for k-fold cross-validation.

  three parameters are required.

  1. n :: integer

    n indicates the size of dataset.

  2. n_folds :: integer

    we specify the k by n_folds.

  3. shuffle :: boolean

    if shuffle is true, dataset are shuffled.

  ```ruby
  kf = Rblearn::CrossValidation::KFold.new(100, 10, true)
  kf.create #=> list<list<train_set_indices, test_set_indices>>
  ```

### Count Vectorizer

CountVectorizer is the feature extractor from texts.

Constructor needs three parameters.

1. tokenizer :: function

2. lowercase :: boolean

3. max_features :: integer


for example, 

```ruby
cv = Rblearn::CountVectorizer.new(lambda{|feature| feature.split.map(&:stem)}, 1, 0.7)
cv.fit_transform(features)
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/rblearn. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

