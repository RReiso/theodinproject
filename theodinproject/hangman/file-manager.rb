module FileManager
  private

  def load_game
    if !Dir.exist?('./saved_games/')
      loop do
        puts "\nNo saved games!"
        break if user_input == '1'
      end
    else
      loaded_game =
        File.open("./saved_games/#{load_file_name}.yml", 'r') do |file|
          YAML.load(file)
        end
      loaded_game.play
    end
  end

  def load_file_name
    saved_games =
      Dir
        .glob('saved_games/*')
        .map { |game| game.split('/').last.split('.yml').first }
    file_count = saved_games.size
    loop do
      puts 'Enter a number of a game to load:'
      saved_games.each_with_index { |game, i| puts "#{i + 1}: #{game}" }
      file_nr = gets.chomp.strip
      if /\A[1-9]+\Z/.match?(file_nr) && file_nr.to_i <= file_count
        return saved_games[file_nr.to_i - 1]
      end
      puts "\nInvalid input.\n\n"
    end
  end

  def save_game
    Dir.mkdir('saved_games') unless Dir.exist?('saved_games')
    File.open("./saved_games/#{save_file_name}.yml", 'w') do |f|
      f.write(YAML.dump(self))
    end
    exit
  end

  def save_file_name
    saved_games = Dir.glob('saved_games/*')
    loop do
      puts 'Enter a name to save your game: '
      file_name = gets.chomp.strip
      if saved_games.include?("saved_games/#{file_name}.yml")
        puts "\nFile aready exists"
        next
      end
      return file_name unless /\s+|^$/.match?(file_name)
    end
  end
end
