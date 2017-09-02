#this is where the game will be run from
#game workings are in main.rb

require "./main.rb"



class Hangman
	def initialize
		@save_names = []
		@save_id = 1
		run_game
	end
	
	def run_game
		puts "Welcome to Hangman, please select 'N' for a new game or 'L' to load a previously saved game:"
		user_choice = gets.chomp.downcase
		if 
			user_choice == 'n'
			player1 = Game.new
			player1.play_game
		elsif 
			user_choice == 'l'
			list_saves   #perhaps create new class for loading and save management?
		else
		 puts "I did not understand that choice, please input 'N' or 'L'"
		 run_game
		end 
	end

	def list_saves
		puts "List of Saved Games:"
			Dir.glob("./saves/*").each do |file|
				@save_names<<file 
				file = file[8..-6]
			puts "Save Number #{@save_id} #{file}"
				@save_id += 1
			end

		game_choice = get_load_choice(@save_id)
		
	end

	def get_load_choice(save_id)
	puts "Please choose which game you would like to load (number), or type \"N\" for a new game or \"D\" to delete all your saved games:"
		choice = gets.chomp
		
		if choice.downcase == "n"  
			player1 = Game.new
			player1.play_game
		elsif choice.downcase == "d"	
			puts "Are you sure you want to delete all files, this can not be undone: Confirm 'Y' to delete \n or any other key to continue: "
			confirm_choice = gets.downcase.chomp
				if confirm_choice == "y"
					Dir.glob("./saves/*").each do |file|
					File.delete(file)
					end
				else
						choice = get_load_choice(@save_id)
						
				
				end
			puts ""	
		elsif choice.to_i.between?(1, @save_id)
			choice = choice.to_i
			puts "Loading save number  #{choice} please wait:"
			puts ""
			load_game(@save_names, choice)
			
		else
			puts "I did not understand that, please enter a number or 'n' for a new game:"
			choice = get_load_choice(@save_id)
		end				


		
	end


	def load_game(save_names, game_choice) 

		file_index = game_choice - 1
		file_name = find_file(save_names, file_index)

			puts "Welcome Back\n\n" 
			
			loaded_game = YAML::load(File.open(file_name))
		
			puts "You have had #{loaded_game.guess_count} guesses"
			puts loaded_game.progress.join
		
			loaded_game.play_game

	end

	def find_file(save_names, file_index)
		save_names.each_with_index do |value, index|
			if index == file_index
				return value
			end
		end
		
	end

	
end

trevor = Hangman.new

#it's new_game that has to be saved, not trevor