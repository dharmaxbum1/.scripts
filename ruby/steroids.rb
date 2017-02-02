#!/usr/bin/ruby -w

class String
def red;            "\e[31m#{self}\e[0m" end
def green;          "\e[32m#{self}\e[0m" end
def blue;           "\e[34m#{self}\e[0m" end
def magenta;        "\e[35m#{self}\e[0m" end
def cyan;           "\e[36m#{self}\e[0m" end

def bold;           "\e[1m#{self}\e[22m" end
def italic;         "\e[3m#{self}\e[23m" end
def underline;      "\e[4m#{self}\e[24m" end
end

def helpMsg()

  puts  " -h | --help )",
        "   Help".magenta ,
        " -p | --package-manager )",
        "   Accepted package managers: apt, aptitude, dnf, zypper, pacman, portage, rpm, yum".magenta
end

def init(manager, command)

  `hash '#{manager}' &> /dev/null || function value() { return 109; }; value &> /dev/null`
  if $?.exitstatus  == 109 then puts "#{manager} is not your package manager".cyan; exit(1) end
  puts "Start post installation? [y/n]".bold
  input = STDIN.gets.chomp
  case input
    when "y" , "Y"
      packages = "firefox gimp" # insert package names here
      exec "#{command} #{packages}"
    when "n" , "N" then puts "Aborting post installation".bold
    else
      puts "Invalid input. Aborting".red
      exit(1)
  end
end

def main(option, manager)

  abort("Must run as root".red.underline) unless Process.uid == 0

  case
    when (option.nil? or option.empty?) then helpMsg; exit(1)
    when (manager.nil? or manager.empty?) then helpMsg; exit(1)
    else nil
  end

  case option
    when "-h", "--help" then helpMsg; exit(0)
    when "-p" , "--package-manager"
      case manager
        when "apt" then init("apt", "apt-get install")
        when "aptitude" then init("aptitude", "aptitude install")
        when "dnf" then init("dnf", "dnf install")
        when "zypper" then init("zypper", "zypper in")
        when "pacman" then init("pacman", "pacman -S")
        when "portage" then init("emerge", "emerge -s")
        when "rpm" then init("rpm", "rpm -ivh")
        when "yum" then init("yum", "yum install")
        else puts "#{manager} package manager is not supported yet".blue.bold; exit(1)
      end
    else helpMsg; exit(1)
  end
end

# suppress interrupt exception messages by handling
begin
  main(ARGV[0], ARGV[1])
rescue Interrupt
  puts " Aborting".green.bold
end



