require '../position'

describe Position do
  it "should initialize position" do
    position = Position.new(1,2)
    position.x.should == 1
    position.y.should == 2
  end
end