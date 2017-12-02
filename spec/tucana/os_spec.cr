require "../spec_helper"

describe Tucana::OS do
  describe "#type" do
    it "should not return unknown" do
      Tucana::OS.type.should_not eq "Unknown"
    end
  end

  context "when macos" do
    describe "#macos?" do
      it "should return Bool class" do
        Tucana::OS.macos?.class.should eq Bool
      end
    end

    describe "#sw_vers" do
      context "have sw_vers" do
        it "should return Mac OS X 10.12.6" do
          Tucana::OS.sw_vers(File.expand_path("../../fixtures/sw_vers", __FILE__)).should eq "Mac OS X 10.12.6"
        end
      end

      context "have not sw_vers" do
        it "should return value of uname -a" do
          Tucana::OS.sw_vers("/dev/unknown").should eq `uname -a`
        end
      end
    end
  end

  context "when Linux" do
    describe "#linux?" do
      it "should return Bool class" do
        Tucana::OS.linux?.class.should eq Bool
      end
    end

    describe "#linux_distrib" do
      context "with /etc/lsb-release" do
        it "should return Ubuntu 16.04.2 LTS xenial" do
          Tucana::OS.linux_distrib(File.expand_path("../../fixtures/lsb_release", __FILE__)).should eq "Ubuntu 16.04.2 LTS xenial"
        end
      end

      context "without /etc/lsb-release" do
        it "should return value of uname -a" do
          Tucana::OS.linux_distrib.should eq `uname -a`
        end
      end
    end
  end
end
