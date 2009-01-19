Shoes.app do
  if File.exists?('conf.yml')
    @prefs = YAML::load_file('conf.yml')
  else
    @prefs = YAML::load_file('conf-sample.yml')
  end
  stack do
    flow do
      para 'Title (e.g. RockySprints):'
      edit_line(@prefs['title']) do |edit|
        @prefs['title'] = edit.text
      end
    end

    flow do
      para 'Race length (MINUTES):'
      edit_line(@prefs['race_distance']) do |edit|
        @prefs['race_distance'] = edit.text.to_f
      end
      para '(MINUTES)'
    end

    flow do
      para 'Roller circumference:'
      edit_line(@prefs['roller_circumference']) do |edit|
        @prefs['roller_circumference'] = edit.text.to_f
      end
      para '(METERS)'
    end

    flow do
      para "Display speed/distance in:"
      stack do
        metric = nil; standard = nil;
        flow do
          standard = radio(:units){ @prefs['units'] = 'standard'}
          para 'standard'
        end
        flow do
          metric = radio(:units){ @prefs['units'] = 'metric'}
          para 'metric'
        end
        if @prefs['units'] == 'metric'
          metric.checked = true
        else
          standard.checked = true
        end
      end
    end

    flow do
      para 'Sensor location:' 
      edit_line(@prefs['device']) do |edit|
        @prefs['device'] = edit.text
      end
    end

    para "e.g. Linux: /dev/ttyUSB0"

    para 'Bikes:'
    @prefs['bikes']||=[]
    @r = 8.times do |i|
      flow do
        para "Bike #{i+1} racer name:"
        color_edit = edit_line(@prefs['bikes'][i]) do |edit|
          @prefs['bikes'][i] = edit.text
        end
        button "no bike" do
          color_edit.text = ''
        end
      end
    end
    
    
  end
  

  button "Save!" do
    File.open('conf.yml', 'w+') do |f|
      f << @prefs.to_yaml
    end
    load "lib/setup.rb"
    alert('Preferences saved!')
    close
  end
end
