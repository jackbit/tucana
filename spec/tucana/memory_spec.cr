require "../spec_helper"

describe Tucana::Memory do
  describe "#linux" do
    context "#linux_memory" do
      it "should return Hash" do
        Tucana::Memory.new.linux_memory(File.expand_path("../../fixtures/meminfo", __FILE__)).class.should eq Hash(String, Int64)
      end

      it "should have inactive" do
        Tucana::Memory.new.linux_memory(File.expand_path("../../fixtures/meminfo", __FILE__)).keys.should contain "inactive"
      end

      it "should have memtotal" do
        Tucana::Memory.new.linux_memory(File.expand_path("../../fixtures/meminfo", __FILE__)).keys.should contain "memtotal"
      end

      it "should have memfree" do
        Tucana::Memory.new.linux_memory(File.expand_path("../../fixtures/meminfo", __FILE__)).keys.should contain "memfree"
      end
    end
  end

  describe "#macos" do
    context "#macos_memory" do
      it "should return Hash" do
        Tucana::Memory.new.macos_memory.class.should eq Hash(String, Int64)
      end

      it "should have inactive" do
        Tucana::Memory.new.macos_memory.keys.should contain "inactive"
      end

      it "should have memtotal" do
        Tucana::Memory.new.macos_memory.keys.should contain "memtotal"
      end

      it "should have free" do
        Tucana::Memory.new.macos_memory.keys.should contain "free"
      end

      context "#buffers" do
        it "should return buffers value" do
          memory = Tucana::Memory.new
          memory.buffers.should eq 0
        end
      end

      context "#cached" do
        it "should return cached value" do
          memory = Tucana::Memory.new
          cached = memory.info["speculative"].to_f + memory.info["wired_down"].to_f
          memory.cached.should eq cached
        end
      end
    end
  end
end
