module Tucana
  class OS
    def self.name
      if linux?
        self.linux_distrib
      elsif macos?
        self.sw_vers
      else
        "Unknown"
      end
    end

    def self.sw_vers(sw_file = "/usr/bin/sw_vers")
      if File.exists?(sw_file)
        sw = `sw_vers`
        sw_info = Hash(String, String).new
        sw.split("\n").each do |item|
          key_value = item.split(":")
          if key_value.size > 1
            sw_info[key_value[0]] = key_value[1].strip
          end
        end
        [sw_info["ProductName"].gsub(/\"/, ""), sw_info["ProductVersion"]].join(" ")
      else
        `uname -a`
      end
    end

    def self.linux_distrib(lsb_file = "/etc/lsb-release")
      if File.exists?(lsb_file)
        lsb = File.read(lsb_file)
        lsb_info = Hash(String, String).new
        lsb.split("\n").each do |item|
          key_value = item.split("=")
          if key_value.size > 1
            lsb_info[key_value[0]] = key_value[1]
          end
        end
        [lsb_info["DISTRIB_DESCRIPTION"].gsub(/\"/, ""), lsb_info["DISTRIB_CODENAME"]].join(" ")
      else
        `uname -a`
      end
    end

    def self.linux?
      self.type.downcase == "linux"
    end

    def self.macos?
      self.type.downcase == "darwin"
    end

    def self.type
      `uname -s`
    end
  end
end
