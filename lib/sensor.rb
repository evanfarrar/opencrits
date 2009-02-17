#Arduino: a sensor written for the arduino open source hardware.
class Sensor
  attr_accessor :queue
  def initialize(filename=nil)
    raise 'File Not Writable!' unless File.writable?(filename)
    #HACK oogity boogity magic happens here:
    `stty -F #{filename} cs8 115200 ignbrk -brkint -icrnl -imaxbel -opost -onlcr -isig -icanon -iexten -echo -echoe -echok -echoctl -echoke -noflsh -ixon -crtscts`
    @f = File.open(filename, 'w+')
  end

  def start
    @t.kill if @t
    @t = Thread.new do
      @f.putc 'g'
      Thread.current["racers"] = [[],[],[],[]]
      Thread.current["finish_times"] = []
      @f.flush
      while true do
        l = @f.readline
        if l=~/:/
          if l =~ /1:/
            Thread.current["racers"][0] =  [1] * l.gsub(/1: /,'').to_i
          end
          if l =~ /2:/
            Thread.current["racers"][1] =  [2] * l.gsub(/2: /,'').to_i
          end
          if l =~ /3:/
            Thread.current["racers"][2] =  [3] * l.gsub(/3: /,'').to_i
          end
          if l =~ /4:/
            Thread.current["racers"][3] =  [4] * l.gsub(/4: /,'').to_i
          end
          if l =~ /5:/
            Thread.current["racers"][4] =  [1] * l.gsub(/1: /,'').to_i
          end
          if l =~ /6:/
            Thread.current["racers"][5] =  [2] * l.gsub(/2: /,'').to_i
          end
          if l =~ /7:/
            Thread.current["racers"][6] =  [3] * l.gsub(/3: /,'').to_i
          end
          if l =~ /8:/
            Thread.current["racers"][7] =  [4] * l.gsub(/4: /,'').to_i
          end
          if l =~ /t:/
            Thread.current["time"] = l.gsub(/t: /,'').to_i
          end
        end
        puts l
      end
    end
  end

  def values
    {:red => @t["red"], :blue => @t["blue"],
     :red_finish => @t["red_finish"], :blue_finish => @t["blue_finish"]}
  end

  def racers
    @t['racers'] || [[],[],[],[]]
  end

  def time
    @t['time'] || 0
  end

  def stop
    @f.puts 's'
    @f.flush
    @t.kill
  end
end
