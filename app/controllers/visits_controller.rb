class VisitsController < ApplicationController
  before_action :set_visit, only: [:show, :destroy]
  before_action :set_owner, only: [:create, :update]
  skip_before_action :verify_authenticity_token

  # GET /visits
  # GET /visits.json
  def index
    @visits = Visit.all
  end

  # GET /visits/1
  # GET /visits/1.json
  def show
  end

  # GET /visits/new
  def new
    @visit = Visit.new
  end

  # GET /visits/1/edit
  def edit
  end

  # PUT /visits/end/all
  def end_all
    end_all_open_visits = Visit.end_all_open_visits
    respond_to do |format|
      format.js { render json: { notice: "#{end_all_open_visits} visitors checked out" } }
    end
  end

  # POST /visits
  # POST /visits.json
  def create
    if @owner.nil?
      respond_to do |format|
        format.js { render json: { notice: { base: ['Pass Not Found'] } } }
      end

    else
      @visit = Visit.new(owner: @owner)

      respond_to do |format|
        if @visit.save
          format.js { render json: { notice: "#{@owner} successfully checked-in.", checked_in: true } }
        else
          format.js { render json: { notice: @visit.errors } }
        end
      end
    end
  end

  # PATCH/PUT /visits/1
  # PATCH/PUT /visits/1.json
  def update
    if @owner.nil?
      respond_to do |format|
        format.js { render json: { notice: 'Pass Not Found' } }
      end

    else

      @visit = @owner.visits.occupied.first

      if @visit.nil?
        respond_to do |format|
          format.js { render json: { notice: 'No corresponding visit to check-out found' } }
        end
      else
        @visit.end!
        respond_to do |format|
          format.js { render json: { notice: "#{@owner} successfully checked-out.", checked_out: true } }
        end
      end
    end
  end

  # DELETE /visits/1
  # DELETE /visits/1.json
  def destroy
    @visit.destroy
    respond_to do |format|
      format.html { redirect_to visits_url, notice: 'Visit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_visit
      @visit = Visit.find(params[:id])
    end

    def set_owner
      @owner = Owner.find_by_pass_id(visit_params[:owner_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def visit_params
      params.require(:visit).permit(:owner_id)
    end
end
