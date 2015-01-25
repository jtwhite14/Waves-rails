class BuoysController < AdminController
  before_action :set_buoy, only: [:show, :edit, :update, :destroy]

  # GET /buoys
  # GET /buoys.json
  def index
    @buoys = Buoy.all
  end

  # GET /buoys/1
  # GET /buoys/1.json
  def show
  end

  # GET /buoys/new
  def new
    @buoy = Buoy.new
  end

  # GET /buoys/1/edit
  def edit
  end

  # POST /buoys
  # POST /buoys.json
  def create
    @buoy = Buoy.new(buoy_params)

    respond_to do |format|
      if @buoy.save
        format.html { redirect_to @buoy, notice: 'Buoy was successfully created.' }
        format.json { render :show, status: :created, location: @buoy }
      else
        format.html { render :new }
        format.json { render json: @buoy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /buoys/1
  # PATCH/PUT /buoys/1.json
  def update
    respond_to do |format|
      if @buoy.update(buoy_params)
        format.html { redirect_to @buoy, notice: 'Buoy was successfully updated.' }
        format.json { render :show, status: :ok, location: @buoy }
      else
        format.html { render :edit }
        format.json { render json: @buoy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /buoys/1
  # DELETE /buoys/1.json
  def destroy
    @buoy.destroy
    respond_to do |format|
      format.html { redirect_to buoys_url, notice: 'Buoy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_buoy
      @buoy = Buoy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def buoy_params
      params[:buoy].permit(:description)
    end
end
