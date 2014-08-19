module GitHub
  class Status
    def self.execute
       @status = GitHub::Status.new
       @status.update_color
    end

    def lights
      @lights ||= YAML.load_file('./config/lights.yaml')[:lights]
    end

    def hue
      @hue ||= Hue.new(ENV['HUE_BRIDGE_ID'], ENV['HUE_ACCESS_TOKEN'])
    end

    def update_color
      case get_status
      when 'minor'
        pulse_color(Hue::YELLOW)
      when 'major'
        pulse_color(Hue::RED)
      when 'good'
        pulse_color(Hue::GREEN)
      else
         # do not do anything
      end
    end

    def get_status
      # Only send updated status message for updates in the last minute
      rss         = RSS::Parser.parse(STATUS_RSS, false)
      status      = rss.items.first.title.match(/\[(\w+)\]/).captures.first
      update_time = rss.items.first.pubDate
      if (update_time + 60) > Time.now
        status
      else
        'no_change'
      end
    end

    def pulse_color(color)
      lights.each do |light|
        hue.pulse_color(light, color)
      end
    end
  end
end
