
module Rblearn

	class CountVectorizer

    # TODO: consider the access controll about all variables
		attr_accessor :feature_names, :doc_matrix, :token2index

		# tokenizer: lambda function :: string -> Array<string>
		# lowcase: whether if words are lowercases :: bool
		# stop_words: list of stop words :: Array<string>
		# max_features: limitation of feature size :: Float \in [0, 1]
		# TODO: by max_features, zero vectors are sometimes created.
		def initialize(tokenizer, lowercase=true, max_features=0.8)
			@tokenizer = tokenizer
			@lowercase = lowercase

			stop_words = Stopwords::STOP_WORDS
			stop_words.map! {|token| token.stem}
			stop_words.map! {|token| token.downcase} if @lowercase
			@stopwords = stop_words
			@max_feature = max_features
		end

		# features: Each documents' feature :: Array<String> -> NArray::Int64
		def fit_transform(features)
			all_vocaburaries = []
			word_frequency = Hash.new{|hash, key| hash[key] = 0}
      document_frequency = Hash.new{|hash, key| hash[key] = 0}
      word_tfidf_score = Hash.new{|hash, key| hash[key] = 0}
      document_size = features.size

			features.each do |feature|
        token_list = @tokenizer.call(feature)

        # compute tf-value
				token_list.each do |token|
					token.downcase! if @lowercase
					word_frequency[token] += 1
				end

        # compute df-value
        token_list.uniq.each do |token|
          document_frequency[token] += 1
					all_vocaburaries << token
        end
			end

			all_vocaburaries.uniq!
      all_vocaburaries.each do |token|
        tf = 1 + Math.log(word_frequency[token])
        idf = Math.log(1+(document_size/document_frequency[token]))
        word_tfidf_score[token] = tf * idf
      end

      word_tfidf_score = word_tfidf_score.sort{|(_, v1), (_, v2)| v2 <=> v1}
			feature_names = (0...(word_tfidf_score.size * @max_feature).to_i).map{|i| word_tfidf_score[i][0]}

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

			@doc_matrix = doc_matrix
			@feature_names = feature_names
			@token2index = token2index
			return @doc_matrix
		end
	end



	if __FILE__ == $0
		cv = CountVectorizer.new(lambda{|s| s.split.map{|token| token.stem}}, 1, 0.8)
		features = ['I am train man which automata and philosophy', 'numerical analysis young man', 'logic programmer']
		p cv.fit_transform(features)
		p cv.feature_names
		p cv.token2index
	end

end
