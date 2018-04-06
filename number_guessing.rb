#!/usr/bin/env ruby
################################################################################
#: Title       : Number_guessing
#: Author      : Anthony Tilelli
#: Description : Commandline game where user guesss a hidden number within a
#:             : range. Game provides hints telling user of their guess is
#:             : higher or lower to hidden number
################################################################################
require 'optparse'
require_relative 'lib/challenge_number.rb'

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

while game.win.nil?
  puts "Select a integer between #{game.min_num} and #{game.max_num}"
  input = $stdin.gets.chomp
  case input
  when 'Q!'
    puts "Game over, Answer was: #{game.tell}" # quit game
    exit
  when 'N!'
    puts 'New Game'
    game.new_game!(debug)
    next
  else
    input = game.guess(input)
    unless input
       puts "Try again: Invalid Input (base 10 integer only) or out of range"
       next
    end
  end

  hint = case input
         when -1 then "Try a lower number, attempt# #{game.tries}"
         when 0 then "You win, attempt# #{game.tries}"
         when 1 then "Try a higher number, attempt# #{game.tries}"
         else
           #this condition should never be invoked
           $stdout.puts "Invalid input after guess"
           exit 4
         end
  puts hint
end
exit
