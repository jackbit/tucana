module Tucana
  class Memory
    def initialize
      @info = Hash(String, Int64).new
    end

    def info
      if @info.empty?
        if Tucana::OS.linux?
          linux_memory
        elsif Tucana::OS.macos?
          macos_memory
        end
      end
      @info
    end

    def macos_memory
      @info["memtotal"] = ((`sysctl -n hw.memsize`.strip).to_i64/1024).round.to_i64
      mac_meminfo = `vm_stat`.strip.split("\n")
      page_size = mac_meminfo.shift.gsub(/\W|[a-zA-Z]/, "").to_i64
      mac_meminfo.each do |item|
        key_value = item.split(":")
        if key_value.size > 1
          memory_size = key_value[1].match(/\d{1,}/)
          if memory_size
            @info[key_value[0].downcase.gsub(/pages /, "").gsub(/\W/, '_')] = ((memory_size[0].gsub(/\.$/, "").to_i64*page_size) / 1024).round
          end
        end
      end
      @info
    end

    def linux_memory(meminfo_file = "/proc/meminfo")
      proc_meminfo = File.read(meminfo_file)
      if proc_meminfo
        assign_memory(proc_meminfo)
      end
      @info
    end

    def assign_memory(proc_meminfo : String)
      proc_meminfo.split("\n").each do |item|
        key_value = item.split(":")
        if key_value.size > 1
          memory_size = key_value[1].match(/\d{1,}/)
          if memory_size
            @info[key_value[0].downcase] = memory_size[0].to_i64
          end
        end
      end
    end

    def active_percent
      Tucana::Util.percent(info["active"].to_f / info["memtotal"].to_f)
    end

    def free_percent
      Tucana::Util.percent(info["inactive"].to_f / info["memtotal"].to_f)
    end

    def used_percent
      active_percent + cached_percent
    end

    def cached_percent
      total_cached = buffers.to_f + cached.to_f
      Tucana::Util.percent(total_cached / info["memtotal"].to_f)
    end

    def cached
      if Tucana::OS.macos?
        info["speculative"].to_f + info["wired_down"].to_f
      elsif Tucana::OS.linux?
        info["cached"]
      end
    end

    def buffers
      if Tucana::OS.linux?
        info["buffers"]
      else
        0
      end
    end
  end
end

# each value is in KiloByte (kB)
# Example:
# {
# "MemTotal" => 2047032
# "MemFree" => 362612
# "MemAvailable" => 689868
# "Buffers" => 42320
# "Cached" => 558500
# "SwapCached" => 0
# "Active" => 1164100
# "Inactive" => 429904
# "Active(anon)" => 1058316
# "Inactive(anon)" => 103172
# "Active(file)" => 105784
# "Inactive(file)" => 326732
# "Unevictable" => 0
# "Mlocked" => 0
# "SwapTotal" => 1048572
# "SwapFree" => 1048572
# "Dirty" => 3180
# "Writeback" => 0
# "AnonPages" => 989252
# "Mapped" => 88416
# "Shmem" => 168316
# "Slab" => 69728
# "SReclaimable" => 52628
# "SUnreclaim" => 17100
# "KernelStack" => 3744
# "PageTables" => 3612
# "NFS_Unstable" => 0
# "Bounce" => 0
# "WritebackTmp" => 0
# "CommitLimit" => 2072088
# "Committed_AS" => 1921880
# "VmallocTotal" => 34359738367
# "VmallocUsed" => 0
# "VmallocChunk" => 0
# "AnonHugePages" => 0
# "ShmemHugePages" => 0
# "ShmemPmdMapped" => 0
# "HugePages_Total" => 0
# "HugePages_Free" => 0
# "HugePages_Rsvd" => 0
# "HugePages_Surp" => 0
# "Hugepagesize" => 2048
# "DirectMap4k" => 38912
# "DirectMap2M" => 2058240
# }
