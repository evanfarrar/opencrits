require 'lib/setup.rb'
Shoes.app :title => CONFIG['title'], :width => 800, :height => 600 do
  @racers = CONFIG['bikes'].map{|r| Racer.new(r, eval(r))}
  def racer(x, y, color)
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
      fill color
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
      stroke color
      oval(:top => 45,
              :left => 80,
              :radius => 20,
              :center => true)

    end

  end
  background black
  #first
    racer 100,10, red
  #second
    racer 70,140, blue
  #third
    racer 180,160, yellow
  #fourth
    racer 160,320, green
  #fifth
    racer 90,390, gray
  #sixth
    racer 180,460, cyan
  #seventh
    racer 20,470, black
  #seventh
    racer 90,580, maroon
  stack {
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
      stack(:width => 400) {
        @racers[4..7].each { |racer|
          flow(:width => 400, :padding => 20) {
            border racer.color, :strokewidth => 8
            fill white
            subtitle " ", racer.name, :stroke => white
          }
        }
      }
    }
  }
  button "start"
  button "stop"
  button "quit"
end
