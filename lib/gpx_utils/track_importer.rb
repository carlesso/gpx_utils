require 'rubygems'
require 'nokogiri'

#$:.unshift(File.dirname(__FILE__))

# Simple parsing GPX file
module GpxUtils
  class TrackImporter
    attr_accessor :tracks, :node

    def initialize
      self.tracks = Array.new
    end

    attr_reader :coords
    def add_data(raw_data)
      doc = Nokogiri::XML(raw_data)
      parse_doc(doc)
    end

    def add_file(path)
      f = File.new(path)
      doc = Nokogiri::XML(f)
      res = parse_doc(doc)
      f.close
      res
    end

    def parse_doc(doc)
      doc.remove_namespaces!
      self.node = doc
      a = Array.new
      error_count = 0

      _tracks = doc.css('gpx trk')
      _tracks.each do |track|
        tracks << Track.new(track)
      end

    end

    # Only import valid coords
    def self.coord_valid?(lat, lon, elevation, time)
      return true if lat and lon
      return false
    end

    def self.proc_time(ts)
      if ts =~ /(\d{4})-(\d{2})-(\d{2})T(\d{1,2}):(\d{2}):(\d{2})Z/
        return Time.gm($1.to_i, $2.to_i, $3.to_i, $4.to_i, $5.to_i, $6.to_i).localtime
      end
    end

    def proc_time(ts)
      self.class.proc_time(ts)
    end

  end
end