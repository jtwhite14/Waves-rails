class ApplicationSerializer < ActiveModel::Serializer
	# cached
 #  delegate :cache_key, to: :object
  
	def id
		object.id.to_s
	end
end