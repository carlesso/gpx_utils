module GpxUtils
  class Track
    attr_accessor :segments, :node
    def initialize(track)
      self.segments = []
      self.node = track
      track.css('trkseg').each do |segment|
        segments << Segment.new(segment)
      end
    end

    def name
      node.xpath('name').first.content
    end

    def track_points
      segments.collect { |s| s.track_points }.flatten
    end

    def track_points_coordinates
      track_points.collect { |tp| [tp[:lat], tp[:lon]] }
    end

    def center
      lat_min, lat_max, lon_min, lon_max = nil
      track_points.each do |t|
        lat_min = lat_min.nil? ? t[:lat] : [lat_min, t[:lat]].min
        lon_min = lon_min.nil? ? t[:lon] : [lon_min, t[:lon]].min
        lat_max = lat_max.nil? ? t[:lat] : [lat_max, t[:lat]].max
        lon_max = lon_max.nil? ? t[:lon] : [lon_max, t[:lon]].max
      end
      {lat: (lat_max + lat_min) / 2, lon: (lon_max + lon_min) / 2}
    end
  end
end