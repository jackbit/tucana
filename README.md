![tucana](https://www.wpclipart.com/space/constellations/charts/charts_5/tucana.png)

## {WIP} Tucana

Simple monitoring system with database series to monitor multiple servers in one dashboard and written by Crystal-lang.org

#### Code Usage

##### Operation System

```
# Linux
Tucana::OS.name
=> Ubuntu 16.04.2 LTS xenial

Tucana::OS.linux?
=> true

# MacOS
Tucana::OS.name
=> Mac OS X 10.12.6

Tucana::OS.macos?
=> true

# Else
Tucana::OS.name
=> Unknown
```

##### Memory

```
# Linux
memory = Tucana::Memory.new
memory.info
=> {"MemTotal" => 2047032, "MemFree" => 362612, "MemAvailable" => 689868, "Buffers" => 42320, "Cached" => 558500, "SwapCached" => 0, "Active" => 1164100, "Inactive" => 429904, "Active(anon)" => 1058316, "Inactive(anon)" => 103172, "Active(file)" => 105784, "Inactive(file)" => 326732, "Unevictable" => 0, "Mlocked" => 0, "SwapTotal" => 1048572, "SwapFree" => 1048572, "Dirty" => 3180, "Writeback" => 0, "AnonPages" => 989252, "Mapped" => 88416, "Shmem" => 168316, "Slab" => 69728, "SReclaimable" => 52628, "SUnreclaim" => 17100, "KernelStack" => 3744, "PageTables" => 3612, "NFS_Unstable" => 0, "Bounce" => 0, "WritebackTmp" => 0, "CommitLimit" => 2072088, "Committed_AS" => 1921880, "VmallocTotal" => 34359738367, "VmallocUsed" => 0, "VmallocChunk" => 0, "AnonHugePages" => 0, "ShmemHugePages" => 0, "ShmemPmdMapped" => 0, "HugePages_Total" => 0, "HugePages_Free" => 0, "HugePages_Rsvd" => 0, "HugePages_Surp" => 0, "Hugepagesize" => 2048, "DirectMap4k" => 38912, "DirectMap2M" => 2058240}

# MacOs
memory = Tucana::Memory.new
memory.info
=> {"memtotal" => 16777216, "free" => 2754544, "active" => 7787696, "inactive" => 1317404, "speculative" => 2786288, "throttled" => 0, "wired_down" => 2129844, "purgeable" => 213564, "_translation_faults_" => 603700552, "copy_on_write" => 73546040, "zero_filled" => 164142488, "reactivated" => 26240, "purged" => 1512, "file_backed_pages" => 4707880, "anonymous_pages" => 7183508, "stored_in_compressor" => 0, "occupied_by_compressor" => 0, "decompressions" => 0, "compressions" => 0, "pageins" => 3231076, "pageouts" => 0, "swapins" => 0, "swapouts" => 0}

# Linux & MacOs
memory.active_percent
=> 60
memory.used_percent
=> 85
memory.free_percent
=> 15
memory.cached_percent
=> 25
```

##### GOAL

Helpers (App) ==> Agents (Shipper) ==> Spooler (Receiver) ==> (Influx?) ==> Dashboard
