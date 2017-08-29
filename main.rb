#hangman game from odin project file i/o and serialization project.

require "yaml"
require "./saveload.rb"

class Game

	attr_accessor :progress, :guess_count

	def initialize
		@word = get_word #get word will be a function to randomly pick word from dictionary
		@word_array = @word.chars
		@guess_count = 0 
		@progress = Array.new(@word_array.size) {"-"}
		@past_letters = []
		@game_over = false
		set_up_display
			

	end


		
	

	def get_word
		words = File.readlines("dict3000.txt")   #there are 2 dics the one suggested has a lot of wierd words so i just used the 3000 most common english words
		word = words.select { |w| w.size > 4 && w.size <  13 }.sample
		word = word.downcase.chomp
	end	

	def set_up_display
		puts  "Welcome to hangman - here is the word you have to guess.."
		puts ""
		puts @progress.join
		puts ""
		
	end

	def play_game
		while @game_over == false 
		puts "Choose a letter or type 'save' to save, or 'solve' to solve."
		@guess = get_guess
		
		end
	end


	def check_and_print(word_array, guess='$')
		puts "checking........"
		x = 0
		word_array.each do |l|
			if guess.include? l
					@progress[x] = l
					x += 1				
				else	
					x += 1
				
				end

		end

		puts @progress.join
		puts "That was guess number #{@guess_count}"
		if @progress.include? "-"	
			check_count
		else
			@game_over = true
			win_game	
		end	
		puts ""	 		
	end

	def get_guess
	 choice = gets.downcase.chomp
	 	case choice
	 	when "save"
	 		save_game #method to save game, this could be outside class so I will have to watch this
	 		#also need something for what to do after saved, exit or continue 
	 	when "solve"	

	 		solve_try
	 	when /^[a-z]{1}$/	
	 		if @past_letters.include? choice
	 			puts "You have already picked that letter."
	 			get_guess
	 		else	
	 			@guess_count += 1
	 			@past_letters<<choice
	 			check_and_print(@word_array, choice)
	 			
	 		end
	 	else
	 	 puts "That was not a valid choice"
	 	 get_guess	
	 	end
	end	

	def check_count
		if @guess_count > 10
			end_game
		end	
		
	end

	def end_game
		puts "Too bad, you died, the word was: \"#{@word}\""
		@game_over = true

	end

	def win_game
		puts "Congratulations you correctly guessed the word."
		@game_over = true
		
	end

	def solve_try
		
		puts "Please input your guess"
		user_guess = gets.chomp.downcase
		check_guess(user_guess)
		

	end

	def check_guess(user_guess)
		guess_array = user_guess.chars
		if guess_array == @word_array
			puts "That is right"
			win_game
		else
			puts "That is wrong"

			
			play_game
		end	
	end	

	


end



	

