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
      @chess_board.valid_move?(@white_pawn, position, :FORWARD).should be_false
    end
    
    it "should return false if the chess piece at the from position is not the same as the parameter chess piece" do
      position = Position.new(6,2)
      @chess_board.valid_move?(@white_pawn, position, :FORWARD).should be_false
    end
    
    it "should return false if the target position is outside the chess board" do
      position = Position.new(6,7)
      @chess_board.valid_move?(@white_pawn, position, :RIGHT).should be_false
    end
    
    it "should return false if the target position is already occupied by a chess piece of the same color" do
      position = Position.new(1,5)
      @chess_board.valid_move?(@white_pawn, position, :RIGHT).should be_false
    end
    
    it "should return true if it is a valid move" do
      position = Position.new(1,4)
      @chess_board.valid_move?(@white_pawn, position, :LEFT).should be_false
    end
  end
  
end