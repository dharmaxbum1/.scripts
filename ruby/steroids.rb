#!/usr/bin/ruby -w
# -w : more warnings

#raise "Must run as root" unless Process.uid == 0

def helpMsg()

  puts  " -h | --help )",
        "   Help",
        " -d | --distro | --distribution )",
        "   Accepted distros: arch, debian, manjaro, ubuntu"
  exit
end

def installation(packageManager)

  puts "Start post installation? [y/n]"
  input = STDIN.gets.chomp
  case input
    when "y" , "Y"
      packages = "firefox gimp" # insert package names here
      exec "sudo #{packageManager} #{packages}"
    when "n" , "N" then puts "Aborting post installation"
    else
      puts "Invalid input. Aborting"
      exit
  end
end

def main(arg1, arg2)

  case
    when (arg1.nil? or arg1.empty?) then helpMsg
    when (arg2.nil? or arg2.empty?) then helpMsg
    else nil
  end

  case arg1
    when "-h", "--help" then helpMsg
    when "-d" , "--distro" , "--distribution"
    case arg2
      when "debian" , "ubuntu" then installation("apt-get install")
      when "arch" , "manjaro" then installation("pacman -S")
      else puts "'#{arg2}' is not supported yet"
    end
    else helpMsg
  end
end

main(ARGV[0], ARGV[1])

