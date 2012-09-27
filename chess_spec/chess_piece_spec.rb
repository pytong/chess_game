require '../chess_piece'

describe ChessPiece do
  it "should initialize chess piece" do
    pawn = ChessPiece.new(:WHITE, :PAWN)
    pawn.color.should == :WHITE
    pawn.type.should == :PAWN
    
    pawn = ChessPiece.new(:BLACK, :PAWN)
    pawn.color.should == :BLACK
    pawn.type.should == :PAWN
  end
end