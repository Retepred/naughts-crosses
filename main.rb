require "pry-byebug"

require_relative 'game'
require_relative 'move'

puts `clear`
puts "Welcome to Peter's wonderful awesome Noughts & Crosses experience!"
binding.pry

def expect(thing, other_thing)
  raise "YOU IDIOT #{thing} did not equal #{other_thing}" unless thing == other_thing
end

def print_board(g)
  puts(g.board.each_slice(3).map do |row|
        row.map { |e| e || ' ' }.join(' | ')
      end.join("\n---------\n"))
end

g = Game.new

g.player1 = "Michael"
g.player2 = "Neil"

expect g.class.name, "Game"
expect g.moves, []

expect g.player1, "Michael"
expect g.player2, "Neil"

g.make_move "Michael", 4

expect g.moves.last.class.name, "Move"

expect g.moves.last.square, 4
expect g.moves.last.symbol, "X"
expect g.moves.last.player, "Michael"

g.make_move 'Neil', 2

expect g.moves.last.square, 2
expect g.moves.last.symbol, '0'
expect g.moves.last.player, "Neil"

expect g.finished?, false

g.make_move "Michael", 0
g.make_move "Neil", 1
g.make_move "Michael", 8

expect g.finished?, true
g = Game.new
puts "What is player 1's name?"
g.player1 = gets.chomp
puts "What is player 2's name?"
g.player2 = gets.chomp

until g.finished?
puts `clear`
puts "Use these numbers to correspond to the places. It isn't hard but I am sure you will end up breaking it.
0 | 1 | 2
---------
3 | 4 | 5
---------
6 | 7 | 8
\n
".center(80)
puts print_board(g)
puts "OI, idiot. Where is #{g.whose_turn}'s' move?"
g.make_move g.whose_turn, input = gets.to_i
#if input =~ /[[:digit:]]/
 # input.to_i
#else
 # puts "Please type in a number"
#end

puts `clear`
puts print_board(g)
puts g.result
end