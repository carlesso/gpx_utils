require 'spec_helper'

describe GpxUtils::TrackImporter do
  it 'should parse garmin etrex gpx passed as string' do
    g = GpxUtils::TrackImporter.new
    # raw_data = File.open(File.join('spec', 'fixtures', 'sample.gpx'), 'r').readlines.join
    raw_data = File.open(File.join('spec', 'fixtures', 'Marghera.gpx'), 'r').readlines.join
    g.add_data raw_data
    g.tracks.should be_kind_of(Array)

    g.tracks.size.should == 1
    g.tracks.first.segments.size.should == 1
    g.tracks.first.segments.first.track_points.size.should == 22
    g.tracks.first.segments.first.track_points.each do |coord|
      coord[:lat].should be_kind_of(Float)
      coord[:lon].should be_kind_of(Float)

      coord[:lat].should_not == 0.0
      coord[:lon].should_not == 0.0
    end
    #g.coords.each do |coord|
    #  coord[:lat].should be_kind_of(Float)
    #  coord[:lon].should be_kind_of(Float)
    #
    #  coord[:lat].should_not == 0.0
    #  coord[:lon].should_not == 0.0
    #end
  end
  it "should parse garmin etrex gpx file" do
    g = GpxUtils::TrackImporter.new
    g.add_file(File.join('spec', 'fixtures', 'sample.gpx'))
    g.coords.should be_kind_of(Array)
    g.coords.size.should == 602
    g.coords.each do |coord|
      coord[:lat].should be_kind_of(Float)
      coord[:lon].should be_kind_of(Float)

      coord[:lat].should_not == 0.0
      coord[:lon].should_not == 0.0
    end
  end
end
