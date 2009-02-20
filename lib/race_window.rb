require 'lib/setup.rb'
Shoes.app :title => CONFIG['title'], :width => 800, :height => 600 do
  @racers = CONFIG['bikes'].map{|r| Racer.new(r, eval(r))}
  def format_seconds(seconds)
    ("%02d" % (seconds / 60))+":"+("%02d" % (seconds % 60))
  end
  def racer(x, y, racer)
    image 180, 90, :top => x, :left => y do
      strokewidth 3
      stroke white
      fill black
      rect :width => 170,
            :height => 10,
            :curve => 5,
            :top => 45,
            :center => true,
            :left => 90
      fill racer.color
      shape {
        move_to(80,5)
        line_to(100,5)
        line_to(130,20)
        line_to(130,70)
        line_to(100,85)
        line_to(80,85)
        line_to(80,5)
      }
      fill white
      stroke racer.color
      oval(:top => 45,
              :left => 80,
              :radius => 20,
              :center => true)

    end
    para racer.name, :top => x, :left => y,:stroke => white

  end



  RACER_POSITIONS = [[100,10],
                     [70,140],
                     [180,160],
                     [160,320],
                     [90,390],
                     [180,460],
                     [20,470],
                     [90,580]]

  background black
  @refresh_area = stack {
    background black
    subtitle CONFIG["title"], :stroke => white
    @racers.each_with_index {|r,i|
      racer RACER_POSITIONS[i][0], RACER_POSITIONS[i][1], r
    }

    flow(:top => 300) {
      stack(:width => 400) {

        @racers[0..3].each { |racer|
          flow(:width => 400, :padding => 20) {
            border racer.color, :strokewidth => 8
            fill white
            subtitle " ", racer.name, :stroke => white
          }
        }
      }
      if @racers.length > 4
        stack(:width => 400) {
          @racers[4..7].each { |racer|
            flow(:width => 400, :padding => 20) {
              border racer.color, :strokewidth => 8
              fill white
              subtitle " ", racer.name, :stroke => white
            }
          }
        }
      end
    }
  }
  button "start" do
    s = Sensor.new(CONFIG['device'])
    s.start
    @animation = @refresh_area.animate(8) do
        clear
        background black
        @racers.each_with_index{ |r,i| r.ticks = s.racers[i][1] }
        @racers.sort_by{|r|r.distance}.reverse.each_with_index {|r,i|
          racer RACER_POSITIONS[i][0], RACER_POSITIONS[i][1], r
        }
        leader = @racers.max{|r1,r2| r1.distance <=> r1.distance}

        flow(:top => 300) {
          stack(:width => 400) {

            @racers[0..3].each { |racer|
              flow(:width => 400, :padding => 20) {
                border racer.color, :strokewidth => 8
                fill white
                subtitle " ", racer.stats(leader), :stroke => white
              }
            }
          }
          if @racers.length > 4
            stack(:width => 400) {
              @racers[4..7].each { |racer|
                flow(:width => 400, :padding => 20) {
                  border racer.color, :strokewidth => 8
                  fill white
                  subtitle " ", racer.stats(leader), :stroke => white
                }
              }
            }
          end
          subtitle CONFIG["title"], :top => 0, :left => 0,:stroke => white
          secs = (s.time / 1000).round
          secs_left = CONFIG['race_length']*60 - secs
          caption "elapsed: #{format_seconds(secs)}", :top => 260,
            :stroke => white, :left => 20
          caption "remaining: #{format_seconds(secs_left)}",
            :top => 260, :left => 200, :stroke => white
        }
        
    end
  end
  button "quit" do
    exit
  end
end
