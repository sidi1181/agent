class ContratsController < ApplicationController
  before_action :set_contrat, only: %i[show edit update destroy]
  def index
    @contrats = Contrat.all

    if params[:query].present?
      @contrats = @contrats.search_by_status(params[:query])
    end

    if params[:date_debut].present?
      @contrats = @contrats.search_by_date_debut(params[:date_debut])
    end
  end

  def show
    @contrat = Contrat.find(params[:id])
  end

  def new
    @contrat = Contrat.new
  end

  def create
    @contrat = Contrat.new(contrat_params)

    
    if @contrat.save
      redirect_to contrats_path
    else
      render :new
    end
    
  end

  def edit
    @contrat = Contrat.find(params[:id])
  end

  def update
    @contrat = Contrat.find(params[:id])

    
    if @contrat.update(contrat_params)
      redirect_to contrats_path
    else
      render :edit
    end
    
  end

  def destroy
    @contrat = Contrat.find(params[:id])
    @contrat.destroy
  end

  private
  def set_contrat
    @contrat = Contrat.find(params[:id])
  end

  def contrat_params
    params.require(:contrat).permit(:date_debut, :date_fin, :status, :agent_id)
  end

end
