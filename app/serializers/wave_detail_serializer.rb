class WaveDetailSerializer < WaveSerializer
  
  has_many :sessions

  def sessions
  	object.sessions.where(finalized: true)
  end
end
