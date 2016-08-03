
module Rblearn

  class CountVectorizer
    # TODO: consider the access controll about all variables
    attr_accessor :token2index

    # tokenizer: lambda function :: string -> Array<string>
    # lowcase: whether if words are lowercases :: bool
    # stop_words: list of stop words :: Array<string>
    # max_features: limitation of feature size :: Float \in [0, 1]
    # TODO: by max_features, zero vectors are sometimes created.
    def initialize(tokenizer, lowercase=true, max_features=0.5)
      @tokenizer = tokenizer
      @lowercase = lowercase

      stop_words = Stopwords::STOP_WORDS + ['-', '--', '(', ')', "\\", "'", '"', '!', '?', ':', ';', '.', ',', 'i', 'me', 'my', 'myself', 'we', 'our', 'ours', 'ourselves', 'you', 'your', 'yours', 'yourself', 'yourselves', 'he', 'him', 'his', 'himself', 'she', 'her', 'hers', 'herself', 'it', 'its', 'itself', 'they', 'them', 'their', 'theirs', 'themselves', 'what', 'which', 'who', 'whom', 'this', 'that', 'these', 'those', 'am', 'is', 'are', 'was', 'were', 'be', 'been', 'being', 'have', 'has', 'had', 'having', 'do', 'does', 'did', 'doing', 'a', 'an', 'the', 'and', 'but', 'if', 'or', 'because', 'as', 'until', 'while', 'of', 'at', 'by', 'for', 'with', 'about', 'against', 'between', 'into', 'through', 'during', 'before', 'after', 'above', 'below', 'to', 'from', 'up', 'down', 'in', 'out', 'on', 'off', 'over', 'under', 'again', 'further', 'then', 'once', 'here', 'there', 'when', 'where', 'why', 'how', 'all', 'any', 'both', 'each', 'few', 'more', 'most', 'other', 'some', 'such', 'no', 'nor', 'not', 'only', 'own', 'same', 'so', 'than', 'too', 'very', 's', 't', 'can', 'will', 'just', 'don', 'should', 'now']
      stop_words.map! {|token| token.stem}
      stop_words.map! {|token| token.downcase} if @lowercase
      @stopwords = stop_words
      @max_feature = max_features
    end

    def get_feature_names
      @feature_names
    end

    # features: Each documents' feature :: Array<String> -> NArray::Int64
    def fit_transform(features)
      all_vocabularies = []
      tf = Hash.new{|hash, token| hash[token] = 0}
      df = Hash.new{|hash, token| hash[token] = 0}
      tfidf = Hash.new{|hash, token| hash[token] = 0}

      # features: Array<string>
      features.each do |feature|
        feature.downcase! if @lowercase
        token_list = @tokenizer.call(feature).reject{|token| @stopwords.include?(token)}
        all_vocabularies += token_list

        token_list.each do |token|
          tf[token] += 1
        end

        token_list.uniq.each do |token|
          df[token] += 1
        end
      end

      # to get the set of vocabulary
      all_vocabularies.uniq!

      tf.sort{|(_, v1), (_, v2)| v2 <=> v1}.first(20).each do |token, count|
        tf[token] = 0
      end

      all_vocabularies.each do |token|
        tfval = Math.log(tf[token])
        idfval = Math.log(all_vocabularies.size.to_f / df[token]) + 1
        tfidf[token] = tfval * idfval
      end

      tfidf = tfidf.sort{|(_, v1), (_, v2)| v2 <=> v1}

      feature_names = (0...(tfidf.size * @max_feature).to_i).map{|i| tfidf[i][0]}
      token2index = {}
      feature_names.each_with_index do |token, i|
        token2index[token] = i
      end

      doc_matrix = Numo::Int32.zeros([features.size, feature_names.size])
      features.each_with_index do |feature, doc_id|
        tokens = []
        @tokenizer.call(feature).each do |token|
          token.downcase! if @lowercase
          tokens << token unless @stopwords.include?(token)
        end

        # BoW representation
        counter = Hash.new{|hash, key| hash[key] = 0}
        tokens.each do |token|
          counter[token] += 1
        end

        counter.each do |token, freq|
          doc_matrix[doc_id, token2index[token]] = freq if token2index[token]
        end
      end

      @feature_names = feature_names
      @token2index = token2index
      return doc_matrix
    end
  end
end
