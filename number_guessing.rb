################################################################################
#: Title       : Number_guessing
#: Author      : Anthony Tilelli
#: Description : Commandline game where user guesss a hidden number within a range
#:               Game provides hints if guess is higher/lower when hidden number
################################################################################
require 'optparse'
require_relative 'lib/challenge_number.rb'

#Defaults
lowest_number = 0
highest_number = 100
debug = nil

OptionParser.new do |parser|
  parser.banner = 'Usage: number_guessing [options]'
  parser.on("-m", '--min INTEGER', Integer ,'Set Minimum number') do |min|
    lowest_number = min
  end
  parser.on('-M', '--Max INTEGER', Integer, 'Set Maximum number') do |max|
    highest_number = max
  end
  parser.on('-D', '--Debug INTEGER', Integer, 'Debug mode: set number to be guessed') do |secret|
    debug = secret
  end
  parser.on('-h', '--help', 'Prints this help') do
   puts parser
   exit
  end
end.parse!

game = ChallengeNumber.new(lowest_number, highest_number, debug)
puts 'Do you want to play a game?'

until game.done
  puts "Select a integer between #{game.min_num} and #{game.max_num}"
  input = gets.strip
  input = case input
          when 'Q!'
            puts "Game over, Answer was: #{game.tell}" # quit game
            false
          when 'N!'
            puts 'New Game'
            game.new_game!(debug)
            false
          else
            Integer(input) rescue false
          end
          #input is false when user didn't provide number

  if input && input.between?(game.min_num, game.max_num)
    hint = case game.guess(input)
            when -1 then 'Lower'
            when 0 then 'Correct!'
            when 1 then 'Higher'
            end
    puts "#{input} is #{hint}, attempt# #{game.tries}"
  end
end
exit
