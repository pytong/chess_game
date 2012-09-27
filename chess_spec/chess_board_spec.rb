require '../chess_board'
require '../chess_piece'
require '../position'

describe ChessBoard do
  it "should initialize chess board" do
    chess_board = ChessBoard.new.chess_board
    
    chess_board.count.should == 8
    for i in 0..7 do
      chess_board[i].count.should == 8
    end
    
    for i in 0..7 do
      chess_piece = chess_board[i][1]
      chess_piece.color.should == :WHITE
      chess_piece.type.should == :PAWN
      
      chess_piece = chess_board[i][6]
      chess_piece.color.should == :BLACK
      chess_piece.type.should == :PAWN
    end
  end
  
  context "valid_move?" do
    before do
      @chess_board = ChessBoard.new
      @white_pawn = ChessPiece.new(:WHITE, :PAWN)
      @black_pawn = ChessPiece.new(:BLACK, :PAWN)
    end
    
    it "should return false the move if there is no chess piece at the from position" do
      position = Position.new(5,5)
      @chess_board.valid_move?(@white_pawn, position, :LEFT).should be_false
      @chess_board.valid_move?(@white_pawn, position, :RIGHT).should be_false
      @chess_board.valid_move?(@white_pawn, position, :FORWARD).should be_false
      @chess_board.valid_move?(@white_pawn, position, :BACKWARD).should be_false
      
      @chess_board.valid_move?(@black_pawn, position, :LEFT).should be_false
      @chess_board.valid_move?(@black_pawn, position, :RIGHT).should be_false
      @chess_board.valid_move?(@black_pawn, position, :FORWARD).should be_false
      @chess_board.valid_move?(@black_pawn, position, :BACKWARD).should be_false
    end
    
    it "should return false if the chess piece at the from position is not the same as the parameter chess piece" do
      position = Position.new(2,6)
      @chess_board.valid_move?(@white_pawn, position, :LEFT).should be_false
      @chess_board.valid_move?(@white_pawn, position, :RIGHT).should be_false
      @chess_board.valid_move?(@white_pawn, position, :FORWARD).should be_false
      @chess_board.valid_move?(@white_pawn, position, :BACKWARD).should be_false
      
      position = Position.new(3,1)
      @chess_board.valid_move?(@black_pawn, position, :LEFT).should be_false
      @chess_board.valid_move?(@black_pawn, position, :RIGHT).should be_false
      @chess_board.valid_move?(@black_pawn, position, :FORWARD).should be_false
      @chess_board.valid_move?(@black_pawn, position, :BACKWARD).should be_false
    end
    
    it "should return false if the target position is outside the chess board" do
      @chess_board.valid_move?(@white_pawn, position = Position.new(0,1), :LEFT).should be_false
      @chess_board.valid_move?(@white_pawn, position = Position.new(7,1), :RIGHT).should be_false
      @chess_board.valid_move?(@white_pawn, position = Position.new(1,7), :FORWARD).should be_false
      
      @chess_board.valid_move?(@black_pawn, position = Position.new(7,6), :LEFT).should be_false
      @chess_board.valid_move?(@black_pawn, position = Position.new(0,6), :RIGHT).should be_false
      @chess_board.valid_move?(@black_pawn, position = Position.new(1,0), :FORWARD).should be_false
    end
    
    it "should return false if the target position is already occupied by a chess piece of the same color" do
      @chess_board.valid_move?(@white_pawn, position = Position.new(3,1), :LEFT).should be_false
      @chess_board.valid_move?(@white_pawn, position = Position.new(3,1), :RIGHT).should be_false
      
      @chess_board.valid_move?(@black_pawn, position = Position.new(3,6), :LEFT).should be_false
      @chess_board.valid_move?(@black_pawn, position = Position.new(3,6), :RIGHT).should be_false
    end
    
    it "should return true if the target position is empty" do
      @chess_board.valid_move?(@white_pawn, Position.new(1,1), :FORWARD).should be_true
      @chess_board.valid_move?(@black_pawn, Position.new(3,6), :FORWARD).should be_true
    end
    
    it "should return true if the target position is not empty and it is occupied by an opponent chess piece" do
      position = Position.new(4,5)
      @chess_board.chess_board[position.x][position.y] = @white_pawn
      @chess_board.valid_move?(@white_pawn, position, :FORWARD).should be_true
      
      position = Position.new(5,2)
      @chess_board.chess_board[position.x][position.y] = @black_pawn
      @chess_board.valid_move?(@black_pawn, position, :FORWARD).should be_true
    end
  end
  
  context "move" do
    before do
      @chess_board = ChessBoard.new
      @white_pawn = ChessPiece.new(:WHITE, :PAWN)
      @black_pawn = ChessPiece.new(:BLACK, :PAWN)
    end
    
    it "should move the chess piece if it is a valid move (no capture)" do
      @chess_board.move(@white_pawn, Position.new(4,1), :FORWARD).should == [Position.new(4,2), nil]
      @chess_board.move(@white_pawn, Position.new(4,2), :LEFT).should == [Position.new(3,2), nil]
      @chess_board.move(@white_pawn, Position.new(3,2), :RIGHT).should == [Position.new(4,2), nil]
    end
    
    it "should move the white chess piece if it is a valid move (with capture)" do
      position = Position.new(4,5)
      @chess_board.chess_board[position.x][position.y] = @white_pawn
      to_position, captured_chess_piece = @chess_board.move(@white_pawn, Position.new(4,5), :FORWARD)
      to_position.should == Position.new(4,6)
      captured_chess_piece.color.should == :BLACK
      captured_chess_piece.type.should == :PAWN
      
      to_position, captured_chess_piece = @chess_board.move(@white_pawn, Position.new(4,6), :LEFT)
      to_position.should == Position.new(3,6)
      captured_chess_piece.color.should == :BLACK
      captured_chess_piece.type.should == :PAWN
      
      position = Position.new(2,2)
      @chess_board.chess_board[position.x][position.y] = @black_pawn
      to_position, captured_chess_piece = @chess_board.move(@black_pawn, Position.new(2,2), :FORWARD)
      to_position.should == Position.new(2,1)
      captured_chess_piece.color.should == :WHITE
      captured_chess_piece.type.should == :PAWN
      
      to_position, captured_chess_piece = @chess_board.move(@black_pawn, Position.new(2,1), :RIGHT)
      to_position.should == Position.new(1,1)
      captured_chess_piece.color.should == :WHITE
      captured_chess_piece.type.should == :PAWN
    end

    it "should not move the chess piece if it is not a valid move" do
      position = Position.new(7,4)
      @chess_board.chess_board[position.x][position.y] = @white_pawn
      to_position, captured_chess_piece = @chess_board.move(@white_pawn, position, :RIGHT)
      to_position.should be_nil
      captured_chess_piece.should be_nil
    end
  end
  
end