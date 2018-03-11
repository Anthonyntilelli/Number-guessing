################################################################################
#: Title       : Number_guessing
#: Author      : Anthony Tilelli
#: Description : Commandline game where user guesss a hidden number within a
#:             : range. Game provides hints telling user of their guess is
#:             : higher or lower to hidden number
################################################################################
require 'optparse'
require_relative 'lib/challenge_number.rb'

# returns number or false (invalid)
def convert_integer(var)
  Integer(var, 10) # allow base 10 only
rescue ArgumentError
  puts "Invalid Input => #{var}"
  false
end

# Defaults
lowest_number = 0
highest_number = 100
debug = nil

begin
  OptionParser.new do |parser|
    parser.banner = 'Usage: number_guessing [options]'
    parser.on('-m', '--min INTEGER', Integer, 'Set Minimum number') do |min|
      lowest_number = min
    end
    parser.on('-M', '--Max INTEGER', Integer, 'Set Maximum number') do |max|
      highest_number = max
    end
    parser.on('-D', '--Debug INTEGER', Integer, 'Set hidden number') do |secret|
      debug = secret
    end
    parser.on('-h', '--help', 'Prints this help') do
      puts parser
      exit
    end
  end.parse!
  # catch all for non-switch inputs
  raise ArgumentError, "Invalid command Line options #{ARGV}" unless ARGV.empty?
rescue StandardError => e
  $stdout.puts e.message
  exit 3
end

game = ChallengeNumber.new(lowest_number, highest_number, debug)
puts 'Do you want to play a game?'

until game.done
  puts "Select a integer between #{game.min_num} and #{game.max_num}"
  input = $stdin.gets.chomp
  input = case input
          when 'Q!'
            puts "Game over, Answer was: #{game.tell}" # quit game
            false
          when 'N!'
            puts 'New Game'
            game.new_game!(debug)
            false
          else
            convert_integer(input)
          end

  # input is false when user didn't provide number
  next unless input
  hint = case game.guess(input)
         when -1 then "too High, attempt# #{game.tries}"
         when 0 then "Correct!, attempt# #{game.tries}"
         when 1 then "too Low, attempt# #{game.tries}"
         when false then 'Out of Range'
         end
  puts "#{input} is #{hint}"
end
exit
