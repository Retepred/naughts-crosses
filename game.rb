class Game
  attr_accessor :player1, :player2
  attr_reader :moves

  WINNING_LINES = [ [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6] ]

  def initialize
    @moves =[]
  end

  def board
    empty_board.tap do |board|
      moves.each do |move|
        board[move.square] = move.symbol
      end
    end
  end

  def empty_board
    Array.new(9,nil)
  end

  def comparison(input)
    if (board[input] == "O") || (board[input] == "X")
      puts "square is taken"
      return false
    else
      return true
    end
  end

  def character_check?(input)
    if ((0..8).member? (input))
      comparison(input)
    else
     sleep 1
     puts "Invalid character" 
    end
  end
  
  def finished?
    winning_game? || drawn_game?
  end

  def make_move(player, square)
    if character_check?(square)
      @moves << Move.new(square, symbol_for_player(player), player)
    else
      sleep 1
      puts "That move isn't valid you moron."
    end
  end

  #def make_move(player, square, symbol)
  #  if Move.new(square, symbol_for_player(player), player) != " "
  #    puts "Invalid character dude!"
  #  else
  #    @moves << Move.new(square, symbol_for_player(player), player)
  #  end
  #end


  def whose_turn
    return player1 if moves.empty?
    moves.last.player == player1 ? player2 : player1
  end

  def result
    case
    when winning_game?
      "#{moves.last.player} has won the game! That means the other player sucks."
    when drawn_game?
      "It is a draw! You both suck."
    else
      "This pathetic attempt at a Game is still running, you fool."
    end
  end

  private
  def winning_game?
    !!WINNING_LINES.detect do |winning_line|
      %w(XXX OOO).include?(winning_line.map { |e| board[e] }.join)
    end
  end

  private
  def drawn_game?
    moves.size == 9
  end

  private
  def symbol_for_player(player)
    case player
    when player1
      "X"
    when player2
      "0"
    else
      raise "How the hell did you manage to break this? This isn't one of my players! Begone foul beastie!"
    end
  end
end