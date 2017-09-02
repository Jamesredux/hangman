#this is where the game will be run from
#game workings are in main.rb

require "./main.rb"
require "./saveload.rb"


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
			puts "Save Number #{@save_id} #{file}"
				@save_id += 1
			end

		game_choice = get_load_choice(@save_id)
		load_game(@save_names, game_choice)
		
	end

	def get_load_choice(save_id)
	puts "Please choose which save you would like to load (number), or type \"n\" for a new game:"
		choice = gets.chomp
		
		if choice.downcase == "n"  #this is not working
			player1 = Game.new
			player1.play_game
		elsif choice.to_i.between?(1, @save_id)
			puts "Loading save number  #{choice} please wait:"
			puts ""
			return choice.to_i
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