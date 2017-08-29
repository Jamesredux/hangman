#this is where the game will be run from
#game workings are in main.rb

require "./main.rb"
require "./saveload.rb"


class Hangman
	def initialize
		@saved = false
		run_game
	end
	
	def run_game
		puts "Welcome to Hangman, please select 'N' for a new game or 'L' to load a previously saved game."
		user_choice = gets.chomp.downcase
		if 
			user_choice == 'n'
			player1 = Game.new
			player1.play_game
		elsif 
			user_choice == 'l'
			save_choice = choose_save
			load_game(save_choice)
		else
		 puts "I did not understant that choice, please input 'N' or 'L'"
		 run_game
		end 
	end

	def load_game(save_choice)  
		
		puts "Welcome Back" 
		loaded_game = YAML::load(File.open(save_choice))
		puts "You have had #{loaded_game.guess_count} guesses"
		puts loaded_game.progress.join
		loaded_game.play_game

	end

	def choose_save
		puts "the modified time is"
		modtime = File.mtime("./saves/save1.yaml")
		puts modtime.strftime('%d-%m-%y %H:%M')
		#this is a method that goes to save log and returns the file name for the save that the user chooses.
		return "./saves/28Aug17_17:23.yaml" #this is just a placeholder to test ...
	end
	


	
end

trevor = Hangman.new

#it's new_game that has to be saved, not trevor