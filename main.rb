load "lib/setup.rb"


Shoes.app(:height => 120, :width => 200,
          :resizable => false, :title => "OpenCrits") do
  subtitle "OpenCrits"
  stack do
    button("Configuration", :width => 200) do
      load 'lib/config_window.rb'
    end

    button("Race", :width => 200) do
      load 'lib/race_window.rb'
    end
  end
end
