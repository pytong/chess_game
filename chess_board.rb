class ChessBoard
  attr_reader :chess_board
  
  def initialize
    @chess_board = Array.new(8){Array.new(8)}
    initialize_pieces
  end
  
  def move(chess_piece, from_position, direction)
    if valid_move?(chess_piece, from_position, direction)
      to_position = target_position(chess_piece, from_position, direction)
      @chess_board[from_position.x][from_position.y] = nil
      captured_chess_piece = @chess_board[to_position.x][to_position.y] if @chess_board[to_position.x][to_position.y]
      @chess_board[to_position.x][to_position.y] = chess_piece
      return [to_position, captured_chess_piece]
    end
    [nil, nil]
  end
  
  def valid_move?(chess_piece, from_position, direction)
    chess_piece_at_from_position = @chess_board[from_position.x][from_position.y]
    return false if chess_piece_at_from_position.nil? || chess_piece_at_from_position.color != chess_piece.color || chess_piece_at_from_position.type != chess_piece.type
    targeted_position = target_position(chess_piece, from_position, direction)
    return false if (targeted_position.x < 0 || targeted_position.x > 7 || targeted_position.y < 0 || targeted_position.y > 7)
    return false if occupied?(targeted_position) && @chess_board[targeted_position.x][targeted_position.y].color == chess_piece.color
    
    return true
  end
  
  private
  def target_position(chess_piece, from_position, direction)
    case direction
    when :LEFT
      x = (chess_piece.color == :WHITE ? from_position.x - 1 : from_position.x + 1)
      Position.new(x, from_position.y)
    when :RIGHT
      x = (chess_piece.color == :WHITE ? from_position.x + 1 : from_position.x - 1)
      Position.new(x, from_position.y)
    when :FORWARD
      y = (chess_piece.color == :WHITE ? from_position.y + 1 : from_position.y - 1)
      Position.new(from_position.x, y)
    when :BACKWARD
      nil
    end
  end
  
  def occupied?(position)
    @chess_board[position.x][position.y] ? true : false
  end
  
  def initialize_pieces
    for i in 0..7 do
      @chess_board[i][1] = ChessPiece.new(:WHITE, :PAWN)
    end
    
    for i in 0..7 do
      @chess_board[i][6] = ChessPiece.new(:BLACK, :PAWN)
    end 
  end
  
end