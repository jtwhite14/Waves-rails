namespace :buoy do
  desc "import current observations for each buoy"
  task import_all: :environment do
  	Buoy.import_observations!
  end

  desc "import all history for each buoy"
  task import_all_history: :environment do
  	Buoy.import_observation_histories!
  end
end
