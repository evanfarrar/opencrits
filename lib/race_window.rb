Shoes.app :title => 'title', :width => 800, :height => 600 do
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
    subtitle "opencrits", :stroke => white
    flow(:top => 300) {
      stack(:width => 400) {
        flow(:width => 400, :padding => 20) {
          border red, :strokewidth => 8
          fill white
          subtitle " ", "racer 1:", :stroke => white
        }
        flow(:width => 400, :padding => 20) {
          border blue, :strokewidth => 8
          fill white
          subtitle " ", "racer 2:", :stroke => white
        }
        flow(:width => 400, :padding => 20) {
          border yellow, :strokewidth => 8
          fill white
          subtitle " ", "racer 3:", :stroke => white
        }
        flow(:width => 400, :padding => 20) {
          border green, :strokewidth => 8
          fill white
          subtitle " ", "racer 4:", :stroke => white
        }
    }
    stack(:width => 400) {
        flow(:width => 400, :padding => 20) {
          border gray, :strokewidth => 8
          fill white
          subtitle " ", "racer 5:", :stroke => white
        }
        flow(:width => 400, :padding => 20) {
          border cyan, :strokewidth => 8
          fill white
          subtitle " ", "racer 6:", :stroke => white
        }
        flow(:width => 400, :padding => 20) {
          border black, :strokewidth => 8
          fill white
          subtitle " ", "racer 7:", :stroke => white
        }
        flow(:width => 400, :padding => 20) {
          border maroon, :strokewidth => 8
          fill white
          subtitle " ", "racer 8:", :stroke => white
        }
      }
    }
  }

end
