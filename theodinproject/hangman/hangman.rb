require "./dictionary"
class Hangman
  def initialize
    @dictionary = Dictionary.new("./5desk.txt")
    @secret_word = @dictionary.secret_word
    
  end
end

new_game = Hangman.new