class Wave < ActiveRecord::Base
	acts_as_mappable :default_units => :miles, :lat_column_name => :latitude, :lng_column_name => :longitude
  
  belongs_to :user
  belongs_to :buoy
  has_many :sessions

 
  def title_photo_url
    (self.sessions.count > 0 && self.sessions.order('rating DESC').first.session_photo.url) ? self.sessions.order('rating DESC').first.session_photo.feed.url : ""
  end

  def map_photo_url
    (self.sessions.count > 0 && self.sessions.order('rating DESC').first.session_photo.url) ? self.sessions.order('rating DESC').first.session_photo.map.url : ""
  end

end
