class Wave < ActiveRecord::Base
	extend FriendlyId
  acts_as_mappable :default_units => :miles, :lat_column_name => :latitude, :lng_column_name => :longitude
  
  #before_validation :reverse_geocode
  friendly_id :slug_candidates, use: [:slugged, :scoped], :scope => :user


  belongs_to :user
  belongs_to :buoy
  has_many :sessions

 #  reverse_geocoded_by :latitude, :longitude do |obj,results|
	#   if geo = results.first
	#   	Rails.logger.info geo.inspect
	#     obj.city    = geo.city
	#     obj.state = geo.state
	#     obj.address = geo.address
	#   end
	# end

  def title_photo_url
    (self.sessions.count > 0) ? self.sessions.order('rating DESC').first.session_photo.url : ""
  end

  def map_photo_url
    (self.sessions.count > 0) ? self.sessions.order('rating DESC').first.session_photo.map.url : ""
  end

	
	def slug_candidates
    [
      [:city, "wave-1"],
      [:city, "wave-2"],
      [:city, "wave-3"],
      [:city, "wave-4"],
      [:city, "wave-5"],
      [:city, "wave-6"],
      [:city, "wave-7"],
      [:city, "wave-8"],
      [:city, "wave-9"],
    ]
  end

end
