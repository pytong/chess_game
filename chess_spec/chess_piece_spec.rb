require '../chess_piece'

describe ChessPiece do
  it "should initialize chess piece" do
    pawn = ChessPiece.new(:WHITE, :PAWN)
    pawn.color.should == :WHITE
    pawn.type.should == :PAWN
  end
end