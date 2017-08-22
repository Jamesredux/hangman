#hangman game from odin project file i/o and serialization project.

#require "dict.txt"

class Game

	def initialize
		@word = get_word #get word will be a function to randomly pick word from dictionary
		@word_array = @word.chars
		@guess_count = 0
		@progress = Array.new(@word_array.size) {"-"}
		@past_letters = []
		@solved = false
		play_game		

	end

	def get_word
		words = File.readlines("dict3000.txt")   #there are 2 dics the one suggested has a lot of wierd words so i just used the 3000 most common english words
		word = words.select { |w| w.size > 4 && w.size <  13 }.sample
		word = word.downcase.chomp
	end	

	def play_game
		check_and_print(@word_array)  #method to print _ _ _ _ etc
		while @solved == false
		puts "Choose a letter or type 'save' to save, or 'solve' to solve."
		@guess = get_guess
		@past_letters<<@guess
		check_and_print(@word_array, @guess)
		end
	end


	def check_and_print(word_array, guess='$')
		x = 0
		word_array.each do |l|
			if guess.include? l
					@progress[x] = l
					x += 1				
				else	
					x += 1
				
				end

		end

		print @progress.join
		if @progress.include? "-"	
			@solved = false
		else
			@solved = true	
		end	
		puts ""	 		
	end

	def get_guess
	 choice = gets.downcase.chomp
	 	case choice
	 	when "save"
	 		save_game #method to save game, this could be outside class so I will have to watch this
	 	when /^[a-z]{1}$/	
	 		if @past_letters.include? choice
	 			puts "You have already picked that letter."
	 			get_guess
	 		else	
	 		return choice
	 		end
	 	else
	 	 puts "That was not a valid choice"
	 	 get_guess	
	 	end
	end	


	def end_game
		puts "Too bad, you died, the word was #{@word}"

	end

	


end

testgame = Game.new

	

