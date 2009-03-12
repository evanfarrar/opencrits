class Racer
  attr_accessor :name, :color, :way_points, :stat_para, :image, :name_para

  def initialize(name, color)
    @name, @color = name, color
    @way_points = []
    @ticks = 0
  end

  def seconds_back(leader)
    # get this racers last waypoint.
    # get the index of their last waypoint.
    # get the leader's waypoint at the same index
    # return the leader time minus this racer's time.
    rand(20)
  end

  def distance
    (@ticks||0 * CONFIG['roller_circumference'])
  end

  def ticks=(ticks)
    @ticks = ticks
  end


  def stats(leader)
    " #{name}: #{distance}m -#{seconds_back(leader)}s"
  end
end
