class Admin::MoralHazardsController < ApplicationController
  before_action :set_moral_hazard, only: [:show, :edit, :update, :destroy]

  # GET /moral_hazards
  # GET /moral_hazards.json
  def index
    @moral_hazards = MoralHazard.all
  end

  # GET /moral_hazards/1
  # GET /moral_hazards/1.json
  def show
  end

  # GET /moral_hazards/new
  def new
    @moral_hazard = MoralHazard.new
  end

  # GET /moral_hazards/1/edit
  def edit
  end

  # POST /moral_hazards
  # POST /moral_hazards.json
  def create
    @moral_hazard = MoralHazard.new(moral_hazard_params)

    respond_to do |format|
      if @moral_hazard.save
        format.html { redirect_to @moral_hazard, notice: 'Moral hazard was successfully created.' }
        format.json { render :show, status: :created, location: @moral_hazard }
      else
        format.html { render :new }
        format.json { render json: @moral_hazard.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /moral_hazards/1
  # PATCH/PUT /moral_hazards/1.json
  def update
    respond_to do |format|
      if @moral_hazard.update(moral_hazard_params)
        format.html { redirect_to @moral_hazard, notice: 'Moral hazard was successfully updated.' }
        format.json { render :show, status: :ok, location: @moral_hazard }
      else
        format.html { render :edit }
        format.json { render json: @moral_hazard.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /moral_hazards/1
  # DELETE /moral_hazards/1.json
  def destroy
    @moral_hazard.destroy
    respond_to do |format|
      format.html { redirect_to moral_hazards_url, notice: 'Moral hazard was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_moral_hazard
      @moral_hazard = MoralHazard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def moral_hazard_params
      params.fetch(:moral_hazard, {})
    end
end
