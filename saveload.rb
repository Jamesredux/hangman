

class Game

	def save_game
		save_number =  1
		puts YAML::dump(self)
		saved_data = YAML::dump(self)

		Dir.mkdir("saves") unless Dir.exists?("saves")

		puts "saving game.."
		filename = "saves/save#{save_number}_#{Time.now.strftime('%d%b')}.yaml"  # use this? Time.now.strftime('%d%b%y_%H:%M')

		File.open(filename, "w") do |file|
			file.puts YAML::dump(self)

		end  

	
		
	end	


	




end	