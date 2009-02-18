require 'lib/setup.rb'
Shoes.app :title => CONFIG['title'], :width => 800, :height => 600 do
  @racers = CONFIG['bikes'].map{|r| Racer.new(r, eval(r))}
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
    @racers.each_with_index {|r,i|
      racer RACER_POSITIONS[i][0], RACER_POSITIONS[i][1], r
    }

    subtitle CONFIG["title"], :stroke => white
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
    @animation = @refresh_area.animate(3) do
        clear
        background black
        @racers.sort_by{rand(2)-1}.each_with_index {|r,i|
          racer RACER_POSITIONS[i][0], RACER_POSITIONS[i][1], r
        }
        subtitle CONFIG["title"], :stroke => white
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
    end
  end
  button "stop" do
    @animation.stop
  end
  button "quit" do
    exit
  end
end
