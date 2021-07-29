class Dictionary
  def initialize(word_file)
    @word_file = word_file
    @eligible_words = eligible_words
  end

  def secret_word
    @eligible_words.sample
  end


private

  def eligible_words
    eligible_words = []
    File.readlines(@word_file).each do |word|
     word.gsub!(/\r\n?/, "")
     eligible_words << word if word.size > 4 && word.size < 13
    end
    eligible_words
  end
end