

class Game

	def save_game
		save_number =  1
		prog_string = @progress.join
		puts YAML::dump(self)
		saved_data = YAML::dump(self)

		Dir.mkdir("saves") unless Dir.exists?("saves")

		puts "saving game.."
		filename = "saves/<>#{prog_string}<>#{Time.now.strftime('%d-%m-%y_%H:%M')}.yaml"  # use this? Time.now.strftime('%d%b%y_%H:%M')
		#_#{Time.now.strftime('%d%b')}
		File.open(filename, "w") do |file|
			file.puts YAML::dump(self)

		end  

	
		
	end	


	




end	

=begin

below is something I found in someoneelses solution, there is stuff in there i should understand.

def load_game()
    if File.exists?("../save") && Dir.glob("../save/*").length > 0
      saves = Dir.glob("../save/*")
      puts "", "Please enter a number:", "0. cancel"
      saves.each_with_index do |save, index|
        puts "#{index + 1}. #{File.basename(save).split(".")[0]}"
      end
      loop do
        user_input = gets.chomp
        user_input_san = sanitize_load_input(user_input, saves)
        if user_input_san == :no_good
          puts "Please enter a number corresponding to a saved game, or 0 to cancel and go back."
        elsif user_input_san == 0
          return
        else
          yaml = File.read(saves[user_input_san - 1])
          game = YAML::load(yaml)
          puts "", "Game loaded!"
          game.game_start()
          return
        end
      end
    else
      puts "", "No save game files found!"

=end
  


