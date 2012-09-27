require '../position'

describe Position do
  it "should initialize position" do
    position = Position.new(1,2)
    position.x.should == 1
    position.y.should == 2
  end
  
  it "should compare position based on location" do
    position_1 = Position.new(1,2)
    position_2 = Position.new(1,2)
    position_1.should == position_2
  end
end