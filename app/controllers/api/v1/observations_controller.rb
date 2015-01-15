class Api::V1::ObservationsController < APIController

	def show
		@observation = Observation.find(params[:id])
		respond_with @observation
	end
end
