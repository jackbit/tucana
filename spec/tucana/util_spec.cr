require "../spec_helper"

describe Tucana::Util do
  describe "#percent" do
    context "when input is integer" do
      it "should return Int32" do
        Tucana::Util.percent(5).class.should eq Int32
      end
    end

    context "when input is float" do
      it "should return Float64" do
        Tucana::Util.percent(0.5).class.should eq Float64
      end
    end

    context "when input is 0.5" do
      it "should be 50 percent" do
        Tucana::Util.percent(0.5).should eq 50
      end
    end

    context "rounded" do
      it "should round 53.1 to 53" do
        Tucana::Util.percent(0.531).should eq 53
      end
    end
  end
end
