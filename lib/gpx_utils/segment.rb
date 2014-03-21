module GpxUtils
  class Segment
    attr_accessor :track_points
    def initialize(segment)
      self.track_points = []
      segment.css('trkpt').each do |trackpoint|
        w = {
            :lat => trackpoint.xpath('@lat').to_s.to_f,
            :lon => trackpoint.xpath('@lon').to_s.to_f,
            :time => TrackImporter.proc_time(trackpoint.xpath('time').children.first.to_s),
            :alt => trackpoint.xpath('ele').children.first.to_s.to_f
        }
        if TrackImporter.coord_valid?(w[:lat], w[:lon], w[:alt], w[:time])
          track_points << w
        end
      end
    end
  end
end